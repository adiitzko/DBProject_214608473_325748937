#image
// מדריכים שפנוים באוגוסט והמדינות שבהן הם הדריכו בשאר השנה
SELECT g.guideID, g.guideName, g.phoneNumber,
    (SELECT string_agg(DISTINCT d.country, ', ')
     FROM trip t
     JOIN destination d ON t.destinationZip = d.zipCode
     WHERE t.guideID = g.guideID AND EXTRACT(MONTH FROM t.startDate) <> 8) 
	 AS other_countries_guided
FROM guide g
LEFT JOIN trip t_aug ON g.guideID = t_aug.guideID AND 
EXTRACT(MONTH FROM t_aug.startDate) = 8
WHERE t_aug.tripID IS NULL
  AND EXISTS (SELECT 1
              FROM trip t_other
              WHERE t_other.guideID = g.guideID
                AND EXTRACT(MONTH FROM t_other.startDate) <> 8);
