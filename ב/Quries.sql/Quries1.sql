//רשימת הטיולים שהמדריך שלהם ליווה שלוש טיולים ומעלה
SELECT t.tripID, g.guideName, COUNT(t.tripID) OVER (PARTITION BY t.guideID) AS guideTripCount
FROM trip t
JOIN guide g ON t.guideID = g.guideID
WHERE (SELECT COUNT(*) FROM trip WHERE guideID = t.guideID) >= 3
ORDER BY guideTripCount DESC;
