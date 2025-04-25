//השאילתא מחפשת טיולים שאין להם לקוחות מוזמנים ושכבר עברו את תאריך ההתחלה, ומציגה את כל הנתונים עליהם.
DELETE FROM trip
WHERE tripID NOT IN (
    SELECT DISTINCT tripID FROM invite
)
AND startDate < CURRENT_DATE;
