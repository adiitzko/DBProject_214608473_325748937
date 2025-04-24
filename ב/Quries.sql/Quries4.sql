#image
//לקוחות שהשתתפו ביותר מ-3 טיולים שונים, ושהם הביאו יותר מ-5 לקוחות בכל טיול
SELECT c.fullName, i.customerID, COUNT(DISTINCT t.tripID) AS num_of_trips, SUM(i.totalCustomer) AS total_customers_brought
FROM customer c
JOIN invite i ON c.ID = i.customerID
JOIN trip t ON i.tripID = t.tripID
WHERE i.customerID IN (
    SELECT i.customerID
    FROM invite i
    JOIN trip t ON i.tripID = t.tripID
    GROUP BY i.customerID
    HAVING COUNT(DISTINCT t.tripID) > 3 AND SUM(i.totalCustomer) > 5
)
GROUP BY c.fullName, i.customerID;
