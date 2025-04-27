// מחיקת הזמנות טיולים שהסתיימו לפני 15 חודשים
DELETE FROM invite
WHERE tripID IN (SELECT tripID FROM trip WHERE endDate < CURRENT_DATE - INTERVAL '15 months');
