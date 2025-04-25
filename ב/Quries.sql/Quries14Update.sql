#3image
    // מעדכנת את תאריך ההתחלה של טיולים שמתחילים בשבת בארה"ב ליום ראשון
UPDATE trip
SET startDate = startDate + INTERVAL '1 day'
WHERE EXTRACT(DOW FROM startDate) = 6
  AND destinationZip IN (SELECT zipCode FROM destination WHERE "country" = 'USA');
