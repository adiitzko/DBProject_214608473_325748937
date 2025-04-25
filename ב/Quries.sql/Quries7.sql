//בתי מלון שהתפוסה שלהם לא היתה מלאה ברבעון הראשון של 2024
SELECT DISTINCT h.hotelName, h.totalRooms
FROM hotel h
JOIN trip t ON h.hotelID = t.hotelID
JOIN invite i ON t.tripID = i.tripID
WHERE h.hotelID IN (SELECT hotelID FROM trip WHERE startDate >= '2024-01-01' AND endDate <= '2024-03-31') 
GROUP BY h.hotelName, h.totalRooms
HAVING SUM(i.totalCustomer) <= h.totalRooms * 2;
