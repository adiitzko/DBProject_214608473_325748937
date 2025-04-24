#TO DO
//רשימת כל הטיסות ופרטי היעד שלהם 
SELECT f.airline, f.departureDate, f.returnDate, d.country, h.hotelName, t.startDate, t.endDate
FROM flight f
--JOIN include inc ON f.flightID = inc.flightID
JOIN trip t ON inc.tripID = t.tripID
JOIN destination d ON t.destinationZip = d.zipCode
JOIN hotel h ON t.hotelID = h.hotelID;
