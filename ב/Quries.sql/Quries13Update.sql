// שינוי שם חברות תעופה למבצעי קיץ
UPDATE flight 
SET airline = CONCAT(airline, ' - Summer Promo')
WHERE EXTRACT(MONTH FROM departureDate) IN (6, 7, 8);
