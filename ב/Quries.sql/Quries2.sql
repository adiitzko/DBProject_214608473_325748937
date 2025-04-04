//כל המלונות ביעד מסוים 
SELECT h.hotelID, h.hotelName, h.location, h.totalRooms
FROM hotel h
JOIN trip t ON h.hotelID = t.hotelID
JOIN destination d ON t.destinationZip = d.zipCode
WHERE d.country = 'Israel';  
