//עבור כל מלון את היעד שבו הוא נמצא
SELECT h.hotelID, h.hotelName, d.country, d.address
FROM hotel h
JOIN trip t ON h.hotelID = t.hotelID
JOIN destination d ON t.destinationZip = d.zipCode;
