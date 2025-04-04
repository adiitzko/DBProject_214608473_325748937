//בתי מלון עם תפוסה מלאה

SELECT DISTINCT h.hotelName, h.totalRooms
FROM hotel h
JOIN trip t ON h.hotelID = t.hotelID
JOIN invite i ON t.tripID = i.tripID
GROUP BY h.hotelName, h.totalRooms
HAVING SUM(i.totalCustomer) >= h.totalRooms * 2;
