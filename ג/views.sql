--המבט HotelReservations מאחד נתונים מטבלאות המלונות, החדרים, ההזמנות והקשרים ביניהם.
--הוא כולל רק הזמנות שהסתיימו (שהסטטוס שלהן הוא 'Completed') ומציג את כל המידע הקשור אליהן.
CREATE VIEW HotelReservations AS
SELECT * from 
FROM Hotel h
JOIN Room r ON h.HotelID = r.HotelID
JOIN Includes i ON r.RoomID = i.RoomID
JOIN Reservation res ON i.RID = res.RID
WHERE res.RID IN (SELECT RID FROM Reservation WHERE Rstatus = 'Completed');

--  הצגת כל ההזמנות שבוצעו לחדרים מסוג "Double"
SELECT * 
FROM HotelReservations 
WHERE Type = 'Double';

--רשימה של כל ההזמנות שהסתיימו ומחיר הלילה של החדר גבוה מ־200.
SELECT * 
FROM HotelReservations 
WHERE costpernight > 200;

--טיולים שהוזמנו למלונות עם יותר מ-200 חדרים
CREATE VIEW TripDetails AS
SELECT 
    t.tripID,
    t.startDate,
    t.endDate,
    t.destinationZip,
    t.hotelID,
    h.totalRooms
FROM trip t
JOIN hotel h ON t.hotelID = h.hotelID
WHERE t.hotelID IN (
    SELECT hotelID
    FROM hotel
    WHERE totalRooms > 200
);

--כל הטיולים מתוך TripDetails למלונות שיש בהם פחות מ-250 חדרים
SELECT * 
FROM TripDetails 
WHERE totalrooms< 250;

-- כל הטיולים מתוך TripDetails שהתחילו לפני 1 באוקטובר 2024 והסתיימו אחרי 1 באוגוסט 2024
SELECT * 
FROM TripDetails 
WHERE startDate < '2024-10-01' 
  AND endDate > '2024-08-01';

