//יעד עם כמות הלקוחות המינימלית ביותר
SELECT destinationZip, country
FROM destination
WHERE zipCode IN (
    SELECT destinationZip
    FROM trip
    JOIN invite USING(tripID)
    GROUP BY destinationZip
    HAVING COUNT(DISTINCT customerID) < 10
);
