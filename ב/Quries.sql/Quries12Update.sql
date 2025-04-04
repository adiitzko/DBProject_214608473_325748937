//מחפש מלון אחר לטיול שאין לו מספיק חדרים ומעדכן את הטיול שיהיה עם המלון החדש

WITH OverbookedHotels AS (
    SELECT t.hotelID, SUM(i.totalCustomer) AS totalGuests, h.totalRooms
    FROM trip t
    JOIN invite i ON t.tripID = i.tripID
    JOIN hotel h ON t.hotelID = h.hotelID
    GROUP BY t.hotelID, h.totalRooms
    HAVING SUM(i.totalCustomer) >= h.totalRooms * 2
),
AvailableHotels AS (
    SELECT h.hotelID
    FROM hotel h
    WHERE h.totalRooms >= (
        SELECT SUM(i.totalCustomer) / 2
        FROM invite i
        JOIN trip t ON i.tripID = t.tripID
        WHERE t.hotelID = h.hotelID
    )
)
UPDATE trip
SET hotelID = (
    SELECT hotelID
    FROM AvailableHotels
    LIMIT 1 -- assuming only one hotel with capacity
)
WHERE hotelID IN (SELECT hotelID FROM OverbookedHotels);
