  // מעדכנת את המדריך של טיולים המשובצים למדריכים עמוסים (להם 2 טיולים או יותר), ומחליפה אותם במדריך אחר שיש לו פחות מ-2 טיולים בסך הכל
WITH BusyGuidesAllTime AS (
    SELECT
        t.guideID
    FROM trip t
    GROUP BY t.guideID
    HAVING COUNT(*) >= 2
),
LessBusyGuidesAllTime AS (
    SELECT
        g.guideID
    FROM guide g
    LEFT JOIN trip t ON g.guideID = t.guideID
    WHERE g.guideID NOT IN (SELECT guideID FROM BusyGuidesAllTime)
    GROUP BY g.guideID
    HAVING COUNT(t.tripID) < 2 OR COUNT(t.tripID) IS NULL
    ORDER BY RAND()
    LIMIT 1
),
TripsToUpdateAllTime AS (
    SELECT
        t.tripID,
        t.guideID AS currentGuideID
    FROM trip t
    WHERE t.guideID IN (SELECT guideID FROM BusyGuidesAllTime)
)
UPDATE trip
SET guideID = (SELECT guideID FROM LessBusyGuidesAllTime)
WHERE tripID IN (SELECT tripID FROM TripsToUpdateAllTime)
  AND EXISTS (SELECT 1 FROM LessBusyGuidesAllTime)
  AND guideID <> (SELECT guideID FROM LessBusyGuidesAllTime);
