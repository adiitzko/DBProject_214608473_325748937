//יעד עם כמות הלקוחות המינימלית ביותר
SELECT d.zipCode, d.country, t.tripID
FROM destination d
JOIN trip t ON t.destinationZip = d.zipCode
WHERE d.zipCode IN (
    SELECT t2.destinationZip
    FROM trip t2
    JOIN invite i ON t2.tripID = i.tripID
    GROUP BY t2.destinationZip
    HAVING COUNT(DISTINCT i.customerID) < 10
);

