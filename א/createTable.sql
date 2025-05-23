CREATE TABLE customer (
    ID VARCHAR(10) PRIMARY KEY,
    fullName VARCHAR(100),
    phoneNumber VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE guide (
    guideID VARCHAR(10) PRIMARY KEY,
    guideName VARCHAR(100),
    phoneNumber VARCHAR(20)
);

CREATE TABLE flight (
    flightID VARCHAR(100) PRIMARY KEY,
    airline VARCHAR(100),
    departureDate DATE,
    returnDate DATE
);

CREATE TABLE destination (
    zipCode VARCHAR(100) PRIMARY KEY,
    country VARCHAR(100),
    address VARCHAR(255)
);

CREATE TABLE hotel (
    hotelID VARCHAR(100) PRIMARY KEY,
    hotelName VARCHAR(100),
    location VARCHAR(255),
    totalRooms INT
);

CREATE TABLE trip (
    tripID VARCHAR(100) PRIMARY KEY,
    startDate DATE,
    endDate DATE,
    destinationZip VARCHAR(100),
    hotelID VARCHAR(100),
    guideID VARCHAR(10),
    FOREIGN KEY (destinationZip) REFERENCES destination(zipCode),
    FOREIGN KEY (hotelID) REFERENCES hotel(hotelID),
    FOREIGN KEY (guideID) REFERENCES guide(guideID),
    FOREIGN KEY (flightID) REFERENCES flight(flightID)
);

CREATE TABLE invite (
    tripID VARCHAR(100),
    customerID VARCHAR(10),
    totalCustomer INT,
    PRIMARY KEY (tripID, customerID),
    FOREIGN KEY (tripID) REFERENCES trip(tripID),
    FOREIGN KEY (customerID) REFERENCES customer(ID)
);


