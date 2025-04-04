// הלקוחות שהשתתפו בטיולים בעונת הקיץ (יוני-אוגוסט)

SELECT c.fullName, c.phoneNumber, t.tripID, t.startDate, t.endDate
FROM customer c
JOIN invite i ON c.ID = i.customerID
JOIN trip t ON i.tripID = t.tripID
WHERE EXTRACT(MONTH FROM t.startDate) IN (6, 7, 8);
