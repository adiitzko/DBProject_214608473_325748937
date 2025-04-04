//נוודא ששטח החדרים (שדה totalRooms בטבלת hotel) יהיה תמיד ערך חיובי

ALTER TABLE hotel
ADD CONSTRAINT check_totalRooms CHECK (totalRooms > 0);


//אילוץ NOT NULL למפתח זר בטבלת trip
ALTER TABLE trip
ALTER COLUMN destinationZip SET NOT NULL,
ALTER COLUMN hotelID SET NOT NULL,
ALTER COLUMN guideID SET NOT NULL;


//אילוץ UNIQUE: נוודא שכתובת ה-email בטבלת customer תהיה ייחודית
ALTER TABLE customer
ADD CONSTRAINT unique_email UNIQUE (email);
