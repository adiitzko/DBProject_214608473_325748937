//היעד או היעדים עם הכי הרבה לקוחות
WITH destination_totals AS (
    SELECT d.zipCode, d.country, d.address, SUM(i.totalCustomer) AS total_customers
    FROM destination d
    JOIN trip t ON d.zipCode = t.destinationZip
    JOIN invite i ON t.tripID = i.tripID
    GROUP BY d.zipCode, d.country, d.address
)
SELECT *
FROM destination_totals
WHERE total_customers = (
    SELECT MAX(total_customers) FROM destination_totals
);
