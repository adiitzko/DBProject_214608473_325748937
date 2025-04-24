#TO DO
// החודש עם הכי הרבה טיולים 

SELECT 
    EXTRACT(YEAR FROM startDate) AS year, 
    EXTRACT(MONTH FROM startDate) AS month, 
    COUNT(tripID) AS totalTrips
FROM trip
GROUP BY year, month
ORDER BY totalTrips DESC
LIMIT 1;
