-- בשביל להתחיל לעבוד על 2 בסיסי הנתונים ביחד, שיניתי את השם של הישות hotel בבסיס הנתונים של חברת הטיולים לhotels כך:
ALTER TABLE hotel RENAME TO hotels;

--התאמת ישויות Person בין בסיסי הנתונים של המלון וחברת הטיולים. נעשה איחוד בין ישויות guest, customer, employee, ו־guide תחת הישות העל person.

-- התאמת שמות עמודות בטבלה person
ALTER TABLE person RENAME COLUMN "pid" TO id;
ALTER TABLE person RENAME COLUMN "pname" TO fullname;
ALTER TABLE person RENAME COLUMN "phone" TO phonenumber;

-- התאמת עמודות id בטבלאות נוספות
ALTER TABLE employee RENAME COLUMN "pid" TO id;
ALTER TABLE guest RENAME COLUMN "pid" TO id;
ALTER TABLE reservation RENAME COLUMN "guestid" TO id;
ALTER TABLE responsible RENAME COLUMN "pid" TO id;


-- הסרת קשרים בין טבלאות לזמן קצר לשם שינוי טיפוסים
ALTER TABLE responsible DROP CONSTRAINT IF EXISTS responsible_pid_fkey;
ALTER TABLE employee DROP CONSTRAINT IF EXISTS employee_pid_fkey;
ALTER TABLE guest DROP CONSTRAINT IF EXISTS guest_pid_fkey;
ALTER TABLE reservation DROP CONSTRAINT reservation_guestid_fkey;
ALTER TABLE includes DROP CONSTRAINT includes_roomid_fkey;
ALTER TABLE responsible DROP CONSTRAINT responsible_roomid_fkey;
ALTER TABLE includes DROP CONSTRAINT includes_rid_fkey;
ALTER TABLE settles DROP CONSTRAINT settles_rid_fkey;
ALTER TABLE settles DROP CONSTRAINT settles_payid_fkey;


-- המרה של מזהים ל-VARCHAR כדי לאפשר אינטגרציה בין מערכות
ALTER TABLE employee ALTER COLUMN ID TYPE VARCHAR(100);
ALTER TABLE responsible ALTER COLUMN ID TYPE VARCHAR(100);
ALTER TABLE person ALTER COLUMN id TYPE VARCHAR(100);
ALTER TABLE reservation ALTER COLUMN id TYPE VARCHAR(100);
ALTER TABLE hotel ALTER COLUMN hotelid TYPE VARCHAR(100);
ALTER TABLE room ALTER COLUMN roomid TYPE VARCHAR(100);
ALTER TABLE room ALTER COLUMN hotelid TYPE VARCHAR(100);
ALTER TABLE includes ALTER COLUMN roomid TYPE VARCHAR(100);
ALTER TABLE includes ALTER COLUMN rid TYPE VARCHAR(100);
ALTER TABLE responsible ALTER COLUMN roomid TYPE VARCHAR(100);
ALTER TABLE reservation ALTER COLUMN rid TYPE VARCHAR(100);
ALTER TABLE settles ALTER COLUMN rid TYPE VARCHAR(100);
ALTER TABLE settles ALTER COLUMN payid TYPE VARCHAR(100);
ALTER TABLE payment ALTER COLUMN payid TYPE VARCHAR(100);


-- הוספת קשרים חזרה בין טבלאות לאחר התאמת טיפוסים
ALTER TABLE employee ADD CONSTRAINT fk_employee_person FOREIGN KEY (ID) REFERENCES person(ID);
ALTER TABLE responsible ADD CONSTRAINT fk_responsible_person FOREIGN KEY (ID) REFERENCES person(ID);
ALTER TABLE guest ADD CONSTRAINT guest_pid_fkey FOREIGN KEY (ID) REFERENCES person(ID);
ALTER TABLE reservation ADD CONSTRAINT reservation_guestid_fkey FOREIGN KEY (id) REFERENCES person(id);
ALTER TABLE includes ADD CONSTRAINT includes_rid_fkey FOREIGN KEY (rid) REFERENCES reservation(rid);
ALTER TABLE settles ADD CONSTRAINT settles_payid_fkey FOREIGN KEY (payid) REFERENCES payment(payid);
ALTER TABLE settles ADD CONSTRAINT settles_rid_fkey FOREIGN KEY (rid) REFERENCES reservation(rid);
ALTER TABLE includes ADD CONSTRAINT fk_includes_room FOREIGN KEY (roomID) REFERENCES room(roomID);
ALTER TABLE responsible ADD CONSTRAINT fk_responsible_room FOREIGN KEY (roomID) REFERENCES room(roomID);


-- הפיכת customer ו־guide ליורשים של person. העברת נתונים מהטבלאות ל־person והסרת שדות כפולים.
DELETE FROM customer WHERE ID IN (SELECT ID FROM person);
INSERT INTO person (ID, fullName, Email, Phonenumber)
SELECT ID, fullName, Email, Phonenumber
FROM customer WHERE ID NOT IN (SELECT ID FROM person);

-- הסרת שדות שכבר עברו ל-person
ALTER TABLE customer DROP COLUMN fullName;
ALTER TABLE customer DROP COLUMN Email;
ALTER TABLE customer DROP COLUMN Phonenumber;

-- העברת נתונים מטבלת guide ל-person
DELETE FROM invite WHERE tripID IN (SELECT tripID FROM trip WHERE guideID IN (SELECT ID FROM person));
DELETE FROM guide WHERE ID IN (SELECT ID FROM person);
--איחוד אורחים עם לקוחות:
INSERT INTO person (ID, fullName, Email, Phonenumber)
SELECT ID, fullName, Email, Phonenumber
FROM guide WHERE ID NOT IN (SELECT ID FROM person);

-- הסרת עמודות שכבר קיימות ב-person
ALTER TABLE guide DROP COLUMN fullName;
ALTER TABLE guide DROP COLUMN Email;
ALTER TABLE guide DROP COLUMN Phonenumber;


--אורח הוא לקוח ולכן העברנו את הנתונים שבאורח ללקוח ומחקנו את טבלת אורח. הקשר בין אורח לבין reservation לא נפגע כי העברנו את הנתונים.
INSERT INTO customer 
SELECT ID
FROM guest
WHERE ID NOT IN (SELECT ID FROM customer);

-- מחיקת טבלת guest לאחר המיזוג
DROP TABLE guest;

--איחוד טבלאות Hotel ו־Hotels. העברת נתונים מ־Hotels ל־Hotel ושילוב מידע.
-- הוספת שדה totalRooms ל-Hotel
ALTER TABLE Hotel ADD COLUMN totalRooms INT;

-- עדכון כמות חדרים ממלונות קיימים
UPDATE Hotel
SET totalRooms = h.totalRooms
FROM Hotels h
WHERE Hotel.hotelID = h.hotelID
AND Hotel.hotelID::INT BETWEEN 201 AND 400;

--מחיקת המלונות עם מזהה בין 1 ל200 כדי להכניס את המלונות מ1 ל200 מhotels
DELETE FROM Hotel WHERE hotelID::INT BETWEEN 1 AND 200;

-- הכנסת המלונות מטבלת Hotels
INSERT INTO Hotel (hotelID, hotelName, location, totalRooms)
SELECT hotelID, hotelName, location, totalRooms
FROM Hotels
WHERE hotelID::INT BETWEEN 1 AND 200;

-- הסרת טבלת Hotels
DROP TABLE IF EXISTS hotels CASCADE;

--יצירת קשרים חדשים בין Trip ל־Reservation ו־Room. החלפת הקשר הישיר בין Trip ל־Hotel בקשרים עקיפים דרך הזמנות וחדרים.
--ניצור טבלה has לקשר בין trip ל reservation. נדאג לקחת את הנתונים שהיו לנו ולעדכן אותם בקשר:
CREATE TABLE has (
    rid VARCHAR(100),
    tripid VARCHAR(100),
    PRIMARY KEY (rid, tripid),
    FOREIGN KEY (rid) REFERENCES reservation(rid),
    FOREIGN KEY (tripid) REFERENCES trip(tripid)
);

--הכנסת הנתונים לטבלה החדשה על פי הקשר העקיף דרך המלון
INSERT INTO has (rid, tripid)
SELECT DISTINCT reservation.rid, trip.tripid
FROM includes
JOIN reservation ON includes.rid = reservation.rid
JOIN room ON includes.roomid = room.roomid
JOIN hotel ON room.hotelid = hotel.hotelid
JOIN trip ON hotel.hotelid = trip.hotelid;

---התאמת תשלומים ללקוחות ולטיולים. שמירה על קשר בין לקוחות, תשלומים והזמנות טיול.
-- הוספת id ל-payment (לקישור ללקוח)
ALTER TABLE payment ADD COLUMN id VARCHAR(100);

-- עדכון מזהה הלקוח ששילם עבור טיול
UPDATE payment
SET id = customer.ID
FROM settles
JOIN reservation ON settles.rid = reservation.rid
JOIN has ON reservation.rid = has.rid
JOIN invite ON has.tripID = invite.tripID
JOIN customer ON invite.customerID = customer.ID
WHERE payment.payid = settles.payid;

--יצירת טבלת trippay לקשר בין תשלום לטיול:
CREATE TABLE trippay (
    tripID VARCHAR(100),
    payID VARCHAR(100)
);

--הכנסת נתונים לטבלה על פי הזמנות ותשלומים קיימים
INSERT INTO trippay (tripID, payID)
SELECT invite.tripID, payment.payID
FROM invite
JOIN has ON invite.tripID = has.tripID
JOIN reservation ON has.rid = reservation.rid
JOIN settles ON reservation.rid = settles.rid
JOIN payment ON settles.payid = payment.payid;

--העברת אחראי חדרים (responsible) לשדה ישיר ב־room. 
--במקום טבלה נפרדת, נוסיף את השדה id לטבלת room.
ALTER TABLE room ADD COLUMN id VARCHAR(100);

-- עדכון מזהה עובד בחדר
UPDATE room
SET id = r.id
FROM responsible r
WHERE room.roomID = r.roomID;

-- מחיקת טבלת responsible
DROP TABLE responsible;


--הוספת מזהה תשלום להזמנה וסגירת הקשר. הפיכת הקשר בין reservation ל־payment לישיר.
-- הוספת עמודת תשלום ל-reservation
ALTER TABLE reservation ADD COLUMN payid VARCHAR(100);

-- עדכון מזהה תשלום לפי settles
UPDATE reservation
SET payid = s.payid
FROM settles s
WHERE reservation.rid = s.rid;

-- מחיקת טבלת settles לאחר השילוב
DROP TABLE settles;
