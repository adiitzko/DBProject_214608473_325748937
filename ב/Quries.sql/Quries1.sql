// רשימת מדריכים שהדריכו לפחות 5 טיולים בלפחות 2 יעדים שונים
SELECT 
    g.guideID,
    g.guideName,
    COUNT(DISTINCT t.tripID) AS totalTrips,
    COUNT(DISTINCT t.destinationZip) AS differentDestinations
FROM guide g
JOIN trip t ON g.guideID = t.guideID
GROUP BY g.guideID, g.guideName
HAVING COUNT(DISTINCT t.tripID) >= 5
   AND COUNT(DISTINCT t.destinationZip) >= 2
ORDER BY totalTrips DESC;
