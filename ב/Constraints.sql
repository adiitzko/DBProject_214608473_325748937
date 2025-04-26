// אילוץ שבהזמנה ברירת המחדשל בבחירת כמות האנשים תהיה 1
ALTER TABLE invite
ALTER COLUMN totalCustomer SET DEFAULT 1;

//אילוץ כך שתחילת הטיול יהיה לפני סוף הטיול
ALTER TABLE trip
ADD CONSTRAINT CK_TripDates CHECK (startDate <= endDate);

//אילוץ UNIQUE: נוודא שכתובת ה-email בטבלת customer תהיה ייחודית
ALTER TABLE customer
ADD CONSTRAINT unique_email UNIQUE (email);
