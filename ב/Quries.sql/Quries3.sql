#check
//רשימת כל הלקוחות ופרטי הטיול שלהם 
SELECT c.fullName, c.phoneNumber, c.email, d.country, h.hotelName, g.guideName, t.startDate, t.endDate
FROM customer c
JOIN invite i ON c.ID = i.customerID
JOIN trip t ON i.tripID = t.tripID
JOIN destination d ON t.destinationZip = d.zipCode
JOIN hotel h ON t.hotelID = h.hotelID
JOIN guide g ON t.guideID = g.guideID;
