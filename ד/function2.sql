-- This function returns a REF CURSOR with a list of future trips 
-- that a given customer is NOT already registered for,
-- and that still have available capacity based on the hotel's total rooms.
-- Each trip is labeled with an availability level: 
-- 'Very Available', 'Medium Availability', or 'Almost Full',
-- depending on how full the trip currently is.
-- The function uses a LEFT JOIN with the 'invite' table to sum existing participants,
-- and uses a CASE expression to classify availability.

CREATE OR REPLACE FUNCTION get_available_trips_for_customer(customer_id_input VARCHAR, cursor_name refcursor)
RETURNS refcursor AS $$
BEGIN
    OPEN cursor_name FOR
    SELECT 
        t.tripID,
        t.startDate,
        t.endDate,
        d.country,
        h.hotelName,
        h.totalRooms,
        COALESCE(SUM(i.totalCustomer), 0) AS current_total,

        -- Calculate a label indicating how full the trip is
        CASE 
            WHEN COALESCE(SUM(i.totalCustomer), 0) < h.totalRooms * 0.3 THEN 'Very Available'
            WHEN COALESCE(SUM(i.totalCustomer), 0) < h.totalRooms * 0.7 THEN 'Medium Availability'
            ELSE 'Almost Full'
        END AS availability_level

    FROM trip t
    JOIN destination d ON t.destinationZip = d.zipCode
    JOIN hotel h ON t.hotelID = h.hotelID
    LEFT JOIN invite i ON t.tripID = i.tripID
    WHERE t.startDate > CURRENT_DATE
      AND t.tripID NOT IN (
          SELECT tripID FROM invite WHERE customerID = customer_id_input
      )
    GROUP BY t.tripID, t.startDate, t.endDate, d.country, h.hotelName, h.totalRooms
    HAVING COALESCE(SUM(i.totalCustomer), 0) < h.totalRooms * 2;

    RETURN cursor_name;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error: %', SQLERRM;
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
