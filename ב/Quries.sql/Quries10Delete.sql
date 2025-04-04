// מחיקת מדריכים שלא הנחו אף טיול בשלוש השנים האחרונות
DELETE FROM guide 
WHERE guideID NOT IN (
    SELECT DISTINCT guideID 
    FROM trip 
    WHERE startDate >= CURRENT_DATE - INTERVAL '3 years'
);
