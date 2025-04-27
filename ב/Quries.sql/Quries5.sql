//טיסות בין ראשון לחמישי ליעדים שביקרו בהם פחות מ 100 לקוחות
SELECT f.flightID, f.airline, f.departureDate, f.returnDate,
       d.country
FROM flight f
JOIN trip t ON f.flightID = t.flightID
JOIN destination d ON t.destinationZip = d.zipCode
WHERE EXTRACT(DOW FROM f.departureDate) BETWEEN 0 AND 4
  AND EXTRACT(DOW FROM f.returnDate) BETWEEN 0 AND 4
  AND d.zipCode IN (
    SELECT destinationZip
    FROM trip
    JOIN invite USING(tripID)
    GROUP BY destinationZip
    HAVING SUM(totalCustomer) < 100
  );
