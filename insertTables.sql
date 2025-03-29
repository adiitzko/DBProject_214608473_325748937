INSERT INTO customer (ID, fullName, phoneNumber, email) VALUES 
(1, 'Gili Shechter', '0505730018', 'gshechter2022@gmail.com'),
(2, 'Roni Levi', '0521234567', 'roni.levi@example.com'),
(3, 'David Cohen', '0537654321', 'david.cohen@example.com');

-- Inserting data into the guide table
INSERT INTO guide (guideID, guideName, phoneNumber) VALUES 
(1, 'Israel Cohen', '0542345678'),
(2, 'Noa Mizrahi', '0538765432'),
(3, 'Yossi Katz', '0509876543');

-- Inserting data into the flight table
INSERT INTO flight (flightID, airline, departureDate, returnDate) VALUES 
(1, 'El Al', '2025-06-01', '2025-06-10'),
(2, 'Israir', '2025-07-15', '2025-07-22'),
(3, 'Arkia', '2025-08-01', '2025-08-10');

-- Inserting data into the destination table
INSERT INTO destination (zipCode, country, address) VALUES 
(12345, 'Israel', 'Tel Aviv, Allenby St. 1'),
(67890, 'France', 'Paris, Rue de Rivoli 10'),
(54321, 'Italy', 'Rome, Via del Corso 5');

-- Inserting data into the hotel table
INSERT INTO hotel (hotelID, hotelName, location, totalRooms) VALUES 
(1, 'Dan Tel Aviv Hotel', 'Tel Aviv', 100),
(2, 'Hilton Paris Hotel', 'Paris', 150),
(3, 'Grand Roma Hotel', 'Rome', 120);

-- Inserting data into the trip table
INSERT INTO trip (tripID, startDate, endDate, destinationZip, hotelID, guideID) VALUES 
(1, '2025-06-01', '2025-06-10', 12345, 1, 1),
(2, '2025-07-15', '2025-07-22', 67890, 2, 2),
(3, '2025-08-01', '2025-08-10', 54321, 3, 3);

-- Inserting data into the invite table
INSERT INTO invite (tripID, customerID, totalCustomer) VALUES 
(1, 1, 2),
(2, 2, 3),
(3, 3, 4);

-- Inserting data into the include table
INSERT INTO include (tripID, flightID) VALUES 
(1, 1),
(2, 2),
(3, 3);