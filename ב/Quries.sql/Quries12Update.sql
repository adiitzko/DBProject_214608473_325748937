#3image
//מעדכנת מלון שאין בו מקום למלון אחר שיש בו מקום לכל הלקוחות באותה מדינה
WITH OverbookedTrips AS (
    SELECT t.tripID, t.hotelID, SUM(i.totalCustomer) AS totalGuests, h.totalRooms, h.location AS country
    FROM trip t
    JOIN invite i ON t.tripID = i.tripID
    JOIN hotel h ON t.hotelID = h.hotelID
    GROUP BY t.tripID, t.hotelID, h.totalRooms, h.location
    HAVING SUM(i.totalCustomer) >= h.totalRooms * 2
),
AvailableHotels AS (
    SELECT h.hotelID, h.location AS country, h.totalRooms
    FROM hotel h
)
UPDATE trip
SET hotelID = (
    SELECT ah.hotelID
    FROM OverbookedTrips ot
    JOIN AvailableHotels ah 
      ON ah.country = ot.country AND ah.totalRooms >= ot.totalGuests / 2
    WHERE ot.tripID = trip.tripID
    LIMIT 1
)
WHERE tripID IN (SELECT tripID FROM OverbookedTrips);
