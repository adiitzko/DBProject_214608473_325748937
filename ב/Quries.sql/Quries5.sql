#image
//טיסות בין ראשון לחמישי ליעדים שביקרו בהם לפחות 100 לקוחות
SELECT f.flightID, f.airline, f.departureDate, f.returnDate, t.tripID
FROM flight f
JOIN trip t ON f.departureDate BETWEEN t.startDate AND t.endDate
WHERE EXTRACT(DOW FROM f.departureDate) BETWEEN 0 AND 4
  AND EXTRACT(DOW FROM f.returnDate) BETWEEN 0 AND 4
  AND EXISTS (
      SELECT 1
      FROM trip t2
      JOIN invite i ON t2.tripID = i.tripID
      WHERE t2.destinationZip IN (
          SELECT destinationZip
          FROM trip
          JOIN invite USING(tripID)
          GROUP BY destinationZip
          HAVING SUM(totalCustomer) > 100) );

