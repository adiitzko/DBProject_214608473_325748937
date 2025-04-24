#image
//טיסות בין ראשון לחמישי ליעדים שביקרו בהם לפחות 100 לקוחות
SELECT f.flightID, t.tripID, f.airline, f.departureDate, f.returnDate
FROM flight f
JOIN trip t ON f.departureDate = t.startDate AND f.returnDate = t.endDate
WHERE EXTRACT(DOW FROM f.departureDate) BETWEEN 0 AND 4
  AND EXTRACT(DOW FROM f.returnDate) BETWEEN 0 AND 4
  AND t.destinationZip IN (
      SELECT destinationZip
      FROM trip
      JOIN invite USING(tripID)
      GROUP BY destinationZip
      HAVING SUM(totalCustomer) > 100
  );
