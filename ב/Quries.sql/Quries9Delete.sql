
//מחיקת טיולים שהתחילו לפני יותר מ-5 שנים ולא הוזמנו על ידי אף לקוח
DELETE FROM trip 
WHERE startDate < CURRENT_DATE - INTERVAL '5 years' 
AND tripID NOT IN (SELECT DISTINCT tripID FROM invite);
