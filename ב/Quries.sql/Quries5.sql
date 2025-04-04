//רשימה של המדריכים ומספר הטיולים שהם מנחים לפי תאריכים

SELECT g.guideName, COUNT(t.tripID) AS totalTrips, MIN(t.startDate) AS firstTripDate, MAX(t.endDate) AS lastTripDate
FROM guide g
JOIN trip t ON g.guideID = t.guideID
GROUP BY g.guideName;
