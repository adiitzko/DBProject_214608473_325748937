// עדכון מדריכים שלא היו פעילים בשנה האחרונה
UPDATE guide g
SET guideName = CONCAT(guideName, ' (Inactive)')
WHERE g.guideID NOT IN (
    SELECT DISTINCT guideID 
    FROM trip t
    WHERE t.startDate > CURRENT_DATE - INTERVAL '1 year'
);
