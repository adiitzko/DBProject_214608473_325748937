#TO DO
//מחיקת טיולים שלא התקבלו בהם הזמנות (ללא לקוחות)
DELETE FROM trip
WHERE tripID NOT IN (
    SELECT DISTINCT tripID
    FROM invite
);
