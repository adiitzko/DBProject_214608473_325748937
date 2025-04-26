//מיון החודשים שבהם היו גם הכי הרבה טיולים וגם הכי הרבה לקוחות
WITH trip_counts AS (
    SELECT 
        EXTRACT(YEAR FROM t.startDate) AS year, 
        EXTRACT(MONTH FROM t.startDate) AS month,
        COUNT(t.tripID) AS totalTrips
    FROM trip t
    GROUP BY year, month
),
customer_counts AS (
    SELECT 
        EXTRACT(YEAR FROM t.startDate) AS year, 
        EXTRACT(MONTH FROM t.startDate) AS month,
        SUM(i.totalCustomer) AS totalCustomers
    FROM trip t
    JOIN invite i ON t.tripID = i.tripID
    GROUP BY year, month
)
SELECT 
    tc.year,
    tc.month,
    tc.totalTrips,
    cc.totalCustomers
FROM trip_counts tc
JOIN customer_counts cc ON tc.year = cc.year AND tc.month = cc.month
ORDER BY tc.totalTrips DESC, cc.totalCustomers DESC;

