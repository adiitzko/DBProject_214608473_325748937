-- Procedure: merge_small_trips
-- Description:
-- This procedure scans the 'trip' table and identifies pairs of trips 
-- that share the same destination and occur within 3 days of each other.
-- If both trips have fewer than 5 participants each, the procedure merges them:
--   - All participants from the second trip are moved to the first trip.
--   - If a participant is already registered to both trips, their totalCustomer value is summed.
--   - The second trip is then deleted.
-- This avoids running multiple low-capacity trips and ensures optimal utilization.
CREATE OR REPLACE PROCEDURE merge_small_trips()
LANGUAGE plpgsql
AS $$
DECLARE
    trip1 RECORD;
    trip2 RECORD;
    count1 INT;
    count2 INT;
    rec RECORD;
BEGIN
    FOR trip1 IN
        SELECT * FROM trip t1
        WHERE EXISTS (
            SELECT 1 FROM invite i1 WHERE i1.tripID = t1.tripID
        )
    LOOP
        FOR trip2 IN
            SELECT * FROM trip t2
            WHERE t2.tripID <> trip1.tripID
              AND t2.destinationZip = trip1.destinationZip
              AND ABS(t2.startDate - trip1.startDate) <= 3
        LOOP
            -- Count participants
            SELECT COALESCE(SUM(totalCustomer), 0)
            INTO count1 FROM invite WHERE tripID = trip1.tripID;

            SELECT COALESCE(SUM(totalCustomer), 0)
            INTO count2 FROM invite WHERE tripID = trip2.tripID;

            -- If both trips have less than 5 participants
            IF count1 < 5 AND count2 < 5 THEN

                -- Merge invites: handle duplicates
                FOR rec IN SELECT * FROM invite WHERE tripID = trip2.tripID
                LOOP
                    IF EXISTS (
                        SELECT 1 FROM invite
                        WHERE tripID = trip1.tripID AND customerid = rec.customerid
                    ) THEN
                        -- Add to existing
                        UPDATE invite
                        SET totalCustomer = totalCustomer + rec.totalCustomer
                        WHERE tripID = trip1.tripID AND customerid = rec.customerid;

                        -- Remove duplicate
                        DELETE FROM invite
                        WHERE tripID = trip2.tripID AND customerid = rec.customerid;
                    ELSE
                        -- Transfer invite
                        UPDATE invite
                        SET tripID = trip1.tripID
                        WHERE tripID = trip2.tripID AND customerid = rec.customerid;
                    END IF;
                END LOOP;

                -- Delete trip2
                DELETE FROM trip WHERE tripID = trip2.tripID;

                RAISE NOTICE 'Merged trip % into trip %', trip2.tripID, trip1.tripID;
            END IF;
        END LOOP;
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error: %', SQLERRM;
END;
$$;
