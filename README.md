

# Organized Trips Management System

Adi Itzkovich
Gili Shechter

## Table of Contents  
- [Phase 1: Design and Build the Database](#phase-1-design-an+6d-build-the-database)  
  - [Introduction](#introduction)  
  - [ERD (Entity-Relationship Diagram)](#erd-entity-relationship-diagram)  
  - [DSD (Data Structure Diagram)](#dsd-data-structure-diagram)  
  - [SQL Scripts](#sql-scripts)  
  - [Data](#data)
  - [Backup](#backup)  
- [Phase 2: Integration](#phase-2-integration)
  - [Quries](#Quries)  
  - [Constraint](#Constraints)  
  - [Backup](#Backupfile)
 - [Phase 3: Programming](#phase-3-Programming)
    - [Functions](#Functions)  
    - [Procedure ](#Procedure )
    - [Trigger ](#Trigger )
    -  [Programes ](#Programes )
    - [Backup](#Backupfile)
- [Phase 4: App](#phase-4-App)
    - [Instructions](#Instructions)
    - [Explnation](#Explnation)
    - [AppShow](#AppShow)  
   
## Phase 1: Design and Build the Database  

### Introduction

The **Organized Trips Managemen**t System is designed to efficiently manage all aspects of organized trips, including participants, tour guides, hotels, destinations, flights, and schedules. This system ensures seamless organization and tracking of essential trip details, such as participant information, travel logistics, accommodations, and assigned guides.

#### Purpose of the Database

This database serves as a structured and reliable solution for organizing trips by:

- **Managing trip participants**, including registration, contact information, and trip history.

- **Tracking tour guides**, assigning them to specific trips.

- **Storing hotel details**, including availability and trip allocations.

- **Recording flight information**, linking flights to trips and participants.

- **Managing trip destinations**, tracking locations visited per trip.

- **Ensuring smooth coordination**, with an integrated system for all travel elements.

#### Potential Use Cases

- **Trip Administrators** can use this database to organize trip schedules, manage participant lists, and assign guides.

- **Participants** can register for trips, track their itinerary, and receive notifications.

- **Tour Guides** can view their assigned trips and access participant details.

- **Hotels & Airlines** can coordinate with the system for room reservations and flight schedules.

- **Management & Staff** can use the database for planning, record-keeping, and customer support.

This structured database helps improve organization, communication, and efficiency in managing organized trips.
###  ERD (Entity-Relationship Diagram)    
![ERD Diagram](א/קובץERD.png)  

###  DSD (Data Structure Diagram)   
![DSD Diagram](א/קובץDFD.png)  

###  SQL Scripts  
Provide the following SQL scripts:  
- **Create Tables Script** - The SQL script for creating the database tables is available in the repository:  

📜 **[View `create_tables.sql`](א/createTable.sql)**  

- **Insert Data Script** - The SQL script for insert data to the database tables is available in the repository:  

📜 **[View `insert_tables.sql`](א/insertTables.sql)**  
 
- **Drop Tables Script** - The SQL script for droping all tables is available in the repository:  

📜 **[View `drop_tables.sql`](א/dropTables.sql)**  

- **Select All Data Script**  - The SQL script for selectAll tables is available in the repository:  

📜 **[View `selectAll_tables.sql`](א/selectAll.sql)**  
  
###  Data  
####  First tool: using [mockaro](א/mockarooFiles) to create csv file
#####  Entering a data to customer table
-  customer id scope 1-400
📜[View `customerMock_data.csv`](א/mockarooFiles/customer.csv)
#####  Entering a data to destination table
-  destination zipcode scope 1-400
📜[View `destinationMock_data.csv`](א/mockarooFiles/destination.csv)
#####  Entering a data to flight table
-  flight flightid scope 1-400
📜[View `flightMock_data.csv`](א/mockarooFiles/flight.csv)
#####  Entering a data to guide table
-  guide guideid scope 1-400
📜[View `guideMock_data.csv`](א/mockarooFiles/guide.csv)
#####  Entering a data to hotel table
-  hotel hotelid scope 1-400
📜[View `hotelMock_data.csv`](א/mockarooFiles/hotel.csv)
#####  Entering a data to include table
-  include
📜[View `includeMock_data.csv`](א/mockarooFiles/include.csv)
#####  Entering a data to invite table
-  invite
📜[View `inviteMock_data.csv`](א/mockarooFiles/invite.csv)
#####  Entering a data to trip table
-  trip tripid scope 1-400
📜[View `tripMock_data.csv`](א/mockarooFiles/trip.csv)


#####   Entering a data to guide table
-  guide guideid scope 1-400
-  Formula of guide
![image](א/picture/guideImage.jpg)

📜 [View `costumerMock_data.csv`](א/mockarooFiles/customer.csv)
![image](א/picture/customerCsvImage.png)
![image](א/picture/success.png)

results for  the command `SELECT COUNT(*) FROM guide;`:
<br>

![image](א/picture/guideCsvImage.png)

####  Second tool: using [python](א/Programing). 
#####  Entering a data to customer
-  Group Number  scope 700-1200
📜[View `insertDat.py`](א/Programing/insert.py)
-  Data
📜[View `insertDat.sal`](א/insertTables.sql)


![image](א/picture/pyImage.png)



####  Third tool:[excel File](א/excel)
- Excel file customer table 200 record
📜[View `insertDat.py`](א/excel/travel_database.xlsx)

- Convert to csv file
📜[View `insertDat.py`](א/excel/customer1.csv)




### Backup 
-   backups files are kept with the date and hour of the backup:  

[backupFile](א/backup_3.29.25.backup)

![image](א/picture/backupImage.png)
![image](א/picture/restoreImage.png)




## Phase 2: Quries
📜[View `AllQuries.sql`](ב/Quries.sql)
#### Select quries:
-1. קיימים לקוחות שדורשים מדריך עם ניסיון. השאילתה מחזירה את רשימת המדריכים שליוו לפחות 3 טיולים שונים ולפחות שניים מהם ליעדים שונים. התוצאה כוללת את מזהה המדריך, שם המדריך, מספר הטיולים שהדריך ומספר היעדים השונים, ממוינת לפי כמות הטיולים שהדריך, מהגבוה לנמוך.📜[View `select1.sql`](ב/Quries.sql/Quries1.sql)

![image](ב/QuriesPicture/Select1Quries.png)

-2.חברת הטיולים רוצה לארגן טיולים למדינות שבהם כמות הלקוחות שהגיעו היתה גבוהה. השאילתה מחזירה את היעדים שבהם סך הלקוחות היה מעל 130, כולל את מזהה היעד, המדינה, כתובת היעד וסך כל הלקוחות, ממוינת לפי סך הלקוחות, מהגבוה לנמוך. 📜[View `select2.sql`](ב/Quries.sql/Quries2.sql) 
![image](ב/QuriesPicture/Select2Quries.png) 




-3.חברת הטיולים רוצה למיין את התאריכים של החודשים שהיו בהם הכי הרבה טיולים ולקוחות- זאת אומרת הכי הרבה הכנסות כדי לנסות לשחזר את ההצלחה.השאילתה מחזירה את החודשים שבהם היו גם הכי הרבה טיולים וגם הכי הרבה לקוחות בסדר יורד. השאילתה מחזירה את החודש, השנה, כמות הלקוחות וכמות הטיולים.📜[View `select3.sql`](ב/Quries.sql/Quries3.sql)

![image](ב/QuriesPicture/Select3Quries.png)

-4.חברת הטיולים רוצה למצוא לקוחות חוזרים שהביאו איתם מספר גבוה של אנשים כדי להתקשר אליהם לגבי עוד טיולים.השאילתה מחזירה את שמות הלקוחות, מזהי הלקוחות, מספר הטיולים שהם השתתפו בהם, ואת מספר הלקוחות שהם הביאו, עבור לקוחות שהשתתפו ביותר מ-3 טיולים שונים והביאו יותר מ-5 לקוחות בכל טיול.📜[View `select4.sql`](ב/Quries.sql/Quries4.sql)

![image](ב/QuriesPicture/Select4Quries.png)


-5.חברת הטיולים מעוניינת לזהות יעדים פחות מבוקשים כדי לתכנן עבורם חבילות אטרקטיביות יותר. השאילתה מאתרת את המיקודים והמדינות של אותם יעדים שאליהם הוזמנו פחות מ-10 לקוחות ייחודיים בסך הכל.📜[View `select5.sql`](ב/Quries.sql/Quries5.sql)

![image](ב/QuriesPicture/Select5Image.png)

-6. חברת הטיולים רוצה לבדוק איזה מדריך פנוי באוגוסט ובאיזה מדינות הוא כבר הדריך כדי לשבץ אותו לטיולים במדינות האלה באוגוסט. השאילתה מחזירה רשימה של מדריכים שלא הובילו טיולים באוגוסט, כולל מזהה, שם ומספר טלפון שלהם, וכן את רשימת המדינות בהן הם כן הובילו טיולים בחודשים אחרים.📜[View `select6.sql`](ב/Quries.sql/Quries6.sql)

![image](ב/QuriesPicture/Select6Quries.png)


-7. חברת הטיולים רוצה את רשימת המלונות שלא היתה בהתם תפוסה מלאה ברבעון הראשון של 2024.השאילתה מחזירה שמות ומספר חדרים של בתי מלון שהיו פעילים ברבעון הראשון של 2024. היא מסננת רק את אותם בתי מלון שלא היתה בהם תפוסה מלאה כאשר בכל חדר יש 2 לקוחות.📜[View `select7.sql`](ב/Quries.sql/Quries7.sql)

![image](ב/QuriesPicture/Select7Quries.png)


-8. חברת הטיולים רוצה לזהות יעדים אהובים אצל לקוחות מסוימים כדי להציע להם הצעות טיול ליעדים אלו. השאילתא  מחזירה רשימה של לקוחות והמדינות אליהן הם טסו לפחות פעמיים📜[View `select8.sql`](ב/Quries.sql/Quries8.sql)

![image](ב/QuriesPicture/Select8Quries.png)

#### Delete quries:
-1.השאילתה מוחקת את כל הטיולים שהתאריך חזרה מהם היה לפני יותר מ15 חודשים.📜[View `Delete1.sql`](ב/Quries.sql/Quries9Delete.sql)

#### Before
![image](ב/QuriesPicture/Before1Del.png)

#### After
![image](ב/QuriesPicture/After1Del.png)


-2. השאילתא מוחקת את כל המדריכים שלא הנחו טיול בשלוש השנים האחרונות. היא עושה זאת על ידי חיפוש המדריכים שהיו קשורים לטיול בתקופה הזו, ומחיקת כל שאר המדריכים 📜[View `Delete2.sql`](ב/Quries.sql/Quries10Delete.sql)

#### Before
![image](ב/QuriesPicture/Before2Del.png)
#### After
![image](ב/QuriesPicture/After2Del.png)



-3.השאילתא מחפשת את כל הטיולים שאין להם שום לקוח שנירשם לטיול ובנוסף שתאריך ההתחלה עבר- החברה רוצה לדעת איזה טיולים הם רלוונטים ולכן טיולים שכבר עבר זמנם ולא נרשמו אליהם לקוחות הם לא רלוונטים לעומת טיולים שעבר זמנם ונרשמו אליהם לקוחות כיון שהפרטים עוד חשובים
📜[View `Delete3.sql`](ב/Quries.sql/Quries11Delete.sql)


#### Before

![image](ב/QuriesPicture/Before3Del.png)

#### After
![image](ב/QuriesPicture/After3Del.png)


#### Update quries:
-1.השאילתא מחפשת טיולים שבהם המלון שלהם מלא מדי ומבצע עדכון כך שכל טיול כזה יקבל מלון אחר באותה מדינה, שיש לו מספיק חדרים עבור כל הלקוחות שהוזמנו.📜[View `Update1.sql`](ב/Quries.sql/Quries12Update.sql)


![image](ב/QuriesPicture/Sucsses1Up.png)

#### Before
![image](ב/QuriesPicture/Before1Up.png)

#### After
![image](ב/QuriesPicture/After1Up.png)


-2.השאילתה  מעדכנת את המדריך של טיולים המשובצים למדריכים עמוסים (להם 2 טיולים או יותר), ומחליפה אותם במדריך אחר שיש לו פחות מ-2 טיולים בסך הכל. העדכון מתבצע רק אם קיים מדריך פחות עמוס זמין.📜[View `Update2.sql`](ב/Quries.sql/Quries13Update.sql)


![image](ב/QuriesPicture/Sucsses2Up.png)

#### Before
![image](ב/QuriesPicture/Before2Up.png)

#### After
![image](ב/QuriesPicture/After2Up.png)


-3.החברת הטיולים החליטה שטיולים בארה"ב לא יתחילו בשבת. השאילתה  מעדכנת את תאריך ההתחלה של טיולים. אם תאריך ההתחלה הוא יום שבת והיעד של הטיול הוא בארה"ב , תאריך ההתחלה יוזז ליום ראשון.📜[View `Update3.sql`](ב/Quries.sql/Quries14Update.sql)


![image](ב/QuriesPicture/Sucsses3Up.png)


#### Before
![image](ב/QuriesPicture/before3Up.png)

#### After
![image](ב/QuriesPicture/After3Up.png)

### Rollback  
-עדכון בסיס הנתונים

![image](ב/QuriesPicture/CommitUpdate.png)

-לפני Rollback

![image](ב/QuriesPicture/RollbackBefore.png)

-אחרי Rollback 

![image](ב/QuriesPicture/RollbackAfter.png)

### Commit  
-עדכון בסיס הנתונים

![image](ב/QuriesPicture/RollbackUpdate.png.png)

-לפני Commit

![image](ב/QuriesPicture/CommitBefore.png)

-אחרי Commit 

![image](ב/QuriesPicture/CommitAfter.png)




### Constraints 
-האילוצים:

![image](ב/QuriesPicture/אילוצים.png)

-1.תיאור השינוי: נוסיף אילוץ Default כך שבעת הוספת שורה חדשה לטבלת invite ללא ציון ערך עבור totalCustomer, העמודה תקבל אוטומטית את הערך 1.

![image](ב/QuriesPicture/אילוץ1.png)

![image](ב/QuriesPicture/אילוץ1ב.png)


-2.תיאור השינוי: נוסיף אילוץ CHECK עבור העמודות startDate ו-endDate בטבלת trip. אילוץ זה מוודא שתאריך ההתחלה של הטיול תמיד יהיה מוקדם או שווה לתאריך הסיום שלו. זה מבטיח שלטיול יש משך זמן חיובי או אפס, ולא שהסיום יתרחש לפני ההתחלה.
![image](ב/QuriesPicture/אילוץ2.png)

-3.תיאור השינוי: נוסיף אילוץ UNIQUE עבור העמודה email בטבלת customer כדי לוודא שכל כתובת דוא"ל בטבלה תהיה ייחודית.

![image](ב/QuriesPicture/אילוץ3.png)


### Backupfile

📜[View `Backup2.sql`](ב/backup2.backup)




## Phase 2: Integration 

- בשלב באינטגרציה נדרשנו לבצע אינטגרציה של הנושא שלנו חברת טיולים עם נושא אחר שקיבלנו מלון.

###  DSD של האגף החדש
![image](ג/HotelNewDSD.png)

###  ERD אגף חדש
![image](ג/HotelNewERD.png)

###    ERD משותף
![image](ג/ERDIntegration.png)

### DSD לאחר אינטגרציה
![image](ג/DSDIntegration.png)

Integration Report: Hotel and Travel Agency Databases
During the integration process between the hotel database and the travel agency database, the schema was unified to eliminate redundancy, maintain data integrity, and more accurately reflect real-world semantics. Here is a detailed summary of the changes:

# Defining Person as a Supertype
To unify entities related to Person, it was decided that:
-Person will be used as a supertype (superclass) from which Customer, Employee, and Guide will inherit.
-The Guest entity from the hotel database is aligned with Customer from the travel agency, and is therefore merged into Customer. The decision to retain Customer rather than Guest was based on the fact that the concept of "Customer" is broader and better fits the semantics of both systems.
-Person will retain the attributes id, fullname, email, and phonenumber, and its descendants will only have id.

# Renaming Columns for Consistency
-The following changes have been made across multiple tables to maintain consistent naming conventions:
In Person, the columns have been renamed:
pid → id
pname → fullname
phone → phonenumber
The pid column in Employee, Guest, and Responsible has been renamed to id.
The guestid column in Reservation has been renamed to id.
Converting Identifier Types to VARCHAR
-To support consistent formatting across systems, all identifier-related columns have been updated from INT to VARCHAR(100):
This includes the id, roomid, hotelid, rid, and payid fields in all relevant tables (Employee, Reservation, Responsible, Room, Hotel, Payment, Includes, and Settles).

# Dropping Foreign Keys Before Type Updates
-To allow for changes to column types, foreign keys were temporarily dropped from:
Employee, Guest, Reservation, Responsible, Includes, and Settles.
They were restored after the changes.

# Re-create Foreign Keys After Changes
-After all column names and types were updated, the foreign key constraints were redefined to ensure relational integrity:
employee.id → person.id
responsible.id → person.id
guest.id → person.id
reservation.id → person.id
includes.rid → reservation.rid
settles.payid → payment.payid
settles.rid → reservation.rid
includes.roomid → room.roomid
responsible.roomid → room.roomid

# Merge Guide and Customer into Person
To fully integrate all entities related to Person:
Data from Customer and Guide was inserted into the Person table (excluding duplicates).
After the migration, the columns fullname, email, and phonenumber were removed from Customer and Guide.

# Modify Guide Table
The guideName field was renamed to fullname.
An email field was added to match the Person structure.
# Change the Employee Table
The column names were changed to id, fullname, and phonenumber to match the Person structure.

# Update Hotel-Trip Relationships
The name of the Hotel entity in the travel agency was changed to Hotels to avoid name clashes.
The previous relationship between Trip and Hotel was reorganized:
Instead of directly relating Trip to Hotel, a many-to-many relationship was created between Trip and Reservation, allowing room reservations for a person per trip.
As a result of this restructuring, the previous relationship makes between Guest/Customer and Reservation was not retained. This is because in the integrated model, the trip, rather than the individual customer, is responsible for the reservation, which better reflects the business logic of a group booking.

# Merge Reservation with Trip
A new many-to-many relationship was created between Trip and Reservation.
The existing many-to-many includes (between Reservation and Room) and one-to-many belongs_to (between Room and Hotel) relationships were preserved.

# Merge Owner Relationships
The Responsible relationship (between Employee and Room) from the hotel database was incorporated into the unified schema.

# Change Payment Relationships
To reflect that payment is made per trip and not per booking:
The existing settles relationship (between Reservation and Payment) has been preserved.
Two new relationships have been added:
tripPay: Many-to-many between Trip and Payment
paid: One-to-many from Customer to Payment
This structure allows for trip-based payments that depend on room type, number of beds, and number of people.

# Add starRating to Hotel
The new starRating attribute has been added to the Hotel table, which was missing in the travel agency schema.
Data was consolidated from hotel to hotels accordingly.

# Unchanged Relationships from Travel Agency
All other existing relationships in the travel agency schema, such as Trip with Guide, Destination, Customer, and Flight, were not affected by the integration. They remain unchanged as they were not impacted by the unification process.

## Intgrate SQL 

You can find the SQL queries in the file [integrate.sql](ג/integrate.sql).

# Views
--המבט HotelReservations מאחד נתונים מטבלאות המלונות, החדרים, ההזמנות והקשרים ביניהם.
--הוא כולל רק הזמנות שהסתיימו (שהסטטוס שלהן הוא 'Completed') ומציג את כל המידע הקשור אליהן.
![image](ג/Views/hotelVIEW.png)

![image](ג/Views/selectHotelVIEW.png)

--  הצגת כל ההזמנות שבוצעו לחדרים מסוג "Double"

![image](ג/Views/select1HotelVIEW.png)

--רשימה של כל ההזמנות שהסתיימו ומחיר הלילה של החדר גבוה מ־200.

![image](ג/Views/select2HotelVIEW.png)

--יצירת View בשם TripDetails 
--מאחד טיולים עם פרטי המלון שאליו הם שויכו. כולל רק טיולים למלונות עם יותר מ־200 חדרים.
![image](ג/Views/tripVIEW.png)

![image](ג/Views/selectTripVIEW.png)

-- שאילתה שמחזירה את כל הטיולים מתוך TripDetails למלונות שיש בהם פחות מ-250 חדרים

![image](ג/Views/select1TripVIEW.png)

-- שאילתה שמחזירה את כל הטיולים מתוך TripDetails שהתחילו לפני 1 באוקטובר 2024 והסתיימו אחרי 1 באוגוסט 2024

![image](ג/Views/select2TripVIEW.png)

## Backupfile

📜[View `Backup3.sql`](ג/backup3.backup)




## Phase 3: Programming
### Functions

📜 **[View `funtctions.sql`](ד/functions)**   

- פונקציה 1 – get_total_paid_by_customer
- פונקציה זו מקבלת מזהה של לקוח (customer ID) ומחזירה את סכום כל התשלומים שביצע הלקוח, כפי שמופיע בטבלת payment. הפונקציה בודקת האם הלקוח קיים, ומטפלת בשגיאות. אם הלקוח לא קיים – נזרקת חריגה. אם מתרחשת שגיאה אחרת – מוחזר הערך -1.

  
📜 **[View `funtction1.sql`](ד/functions/function1.sql)**   



-יצירת הפונקציה

![image](ד/views/function1complete.png)

-פלט הפונקציה

![image](ד/views/function1output.png)



- מרכיבים תכנותיים:
- IF – לבדיקה האם הלקוח קיים
- DML – שימוש ב־SELECT INTO
- EXCEPTION – טיפול בשגיאות
- COALESCE – למניעת NULL בסכום
- CURSOR - הכרזה, פתיחה, קריאה וסגירה
- לולאות - LOOP לקריאת הרשומות מה־CURSOR
- רשומות - pay_rec RECORD לשמירת שורת תשלום



-פונקציה 2 – get_available_trips_for_customer
-פונקציה זו מקבלת מזהה לקוח (customerID) ומחזירה REF CURSOR עם רשימת טיולים עתידיים שהלקוח לא רשום אליהם, ושהם עדיין פתוחים להצטרפות (כלומר, לא בתפוסה מלאה לפי מספר חדרים במלון). לכל טיול מחושב תג זמינות מילולי: "Very Available", "Medium Availability" או "Almost Full" – לפי כמות המשתתפים מול מספר החדרים.


📜 **[View `funtction2.sql`](ד/functions/function2.sql)**   

- מרכיבים תכנותיים:
- REF CURSOR – החזרת תוצאה בפורמט דינמי
- CASE – לקביעת רמת זמינות
- JOINs – חיבורים בין טבלאות: trip, destination, hotel, invite
- GROUP BY + HAVING – כדי לחשב סך משתתפים לטיול
- DML – פתיחת קורסור עם OPEN ... FOR

  
-יצירת הפונקציה

![image](ד/views/function2complete.png)

-פלט הפונקציה

![image](ד/views/fuction2output.png)





### Procedure


📜 **[View `Procedures.sql`](ד/procedures)**   

-פרוצדורה ראשונה: merge_small_trips
-הפרוצדורה merge_small_trips נועדה לבצע אינטגרציה חכמה בין טיולים דומים בעלי תפוסה נמוכה. היא מזהה זוגות של טיולים:
-שמתקיימים באותו יעד
-בטווח של עד 3 ימים זה מזה
-וכל אחד מהם כולל פחות מ־5 משתתפים

-במקרה כזה, המשתתפים בטיול השני מועברים לראשון.
-אם לקוח כבר רשום בשני הטיולים — מספר המשתתפים שלו מאוחד (totalCustomer).
-בסיום, הטיול השני נמחק, ונשמרת טבלה נקייה ומאוחדת.




📜 **[View `Procedure1.sql`](ד/procedures/procedure1.sql)**  


-יצירת הפרוצדורה

![image](ד/views/procedure1complete.png)


-לפני ההרצה

![image](ד/views/procedure1before.png)


-קריאה לפרוצדורה

![image](ד/views/procedure1call.png)



-אחרי ההרצה


![image](ד/views/procedure1after.png)








- פרוצדורה שנייה: reassign_overloaded_guides
-הפרוצדורה זו נועדה לטפל במדריכים שמופעלים בעומס יתר.
-היא סורקת את טבלת trip ומזהה מדריכים שיש להם לפחות 3 טיולים עתידיים בתוך טווח של 40 ימים.
-כאשר נמצאת דוגמה כזו:
-המערכת מחפשת מדריך חלופי שאין לו שום טיול אחר באותו חלון זמן.
-אם מדריך כזה קיים, הפרוצדורה מעדכנת את הטיול השלישי ברצף כך שהוא ישובץ למדריך הפנוי.
-פעולה זו נועדה לפזר את העומס ולאפשר תכנון נכון..




📜 **[View `Procedure2.sql`](ד/procedures/procedure2.sql)**  


-יצירת הפרוצדורה

![image](ד/views/procedure1complete.png)


-לפני ההרצה

![image](ד/views/procedure2before.png)



-קריאה לפרוצדורה


![image](ד/views/procedure2call.png)


-אחרי ההרצה


![image](ד/views/procedure2call.png)



### Trigger

📜 **[View `Triggers.sql`](ד/triggers)**   

- טריגר 1: מניעת שיבוץ כפול של מדריך
- טריגר זה נועד למנוע מצב בו אותו מדריך (guideID) משובץ ליותר מטיול אחד שמתחיל באותו תאריך.
-הטריגר מופעל לפני הכנסת טיול חדש (BEFORE INSERT) לטבלת trip.
-אם המדריך כבר משובץ בטיול אחר באותו תאריך – הפעולה נחסמת באמצעות RAISE EXCEPTION


📜 **[View `TriggerFunction1.sql`](ד/triggers/triggerFunction1.sql)**  
📜 **[View `Trigger1.sql`](ד/triggers/trigger1.sql)**  


-יצירת הפונקציה והטריגר



![image](ד/views/createFunctiomTrigger1.png)
![image](ד/views/createtrigger1.png)

-הפעלת הטריגר 


![image](ד/views/triggeractive1.png)



-טריגר 2: מניעת טיול עם תאריכים שגויים
-טריגר זה מונע הכנסת טיול שבו תאריך הסיום מוקדם מתאריך ההתחלה.
-הטריגר מופעל אוטומטית לפני הכנסת טיול חדש (BEFORE INSERT ON trip).
-אם התאריכים אינם תקינים – הפעולה תיחסם עם הודעת שגיאה.





📜 **[View `TriggerFunction1.sql`](ד/triggers/triggerFunction2.sql)**  
📜 **[View `Trigger1.sql`](ד/triggers/trigger2.sql)**  




-יצירת הפונקציה והטריגר



![image](ד/views/createFunctiomTrigger2.png)
![image](ד/views/createtrigger2.png)

-הפעלת הטריגר 


![image](ד/views/triggeractive2.png)



### Programes


- תוכנית ראשית 1: main_program_1

- תוכנית זו בודקת את סך התשלומים של לקוח מסוים, ולאחר מכן מפעילה את הפרוצדורה שמאחדת טיולים קטנים ודומים (merge_small_trips).
- שלבים שהתוכנית מבצעת:
-קריאה לפונקציה get_total_paid_by_customer('C001')
-מחשבת את סך כל התשלומים של לקוח לפי payment.totalpay
-הערך מוחזר למשתנה ומודפס כהודעה
-הרצת הפרוצדורה merge_small_trips()
-מאחדת טיולים בעלי תפוסה נמוכה (פחות מ־5 משתתפים כל אחד)
-בתנאי שמתקיימים באותו יעד ובהפרש של עד 3 ימים
-הדפסת הודעת סיום הפעולה.





📜 **[View `programe1.sql`](ד/programe/programe1.sql)**



-יצירת התוכנית


![image](ד/views/createmain1.png)


-הפעלת התוכנית




![image](ד/views/runmain1.png)





- תוכנית ראשית 2: main_program_2

- תוכנית זו מאתרת אילו טיולים פתוחים קיימים ללקוח מסוים (שהוא עוד לא רשום אליהם), ואם אין אף טיול זמין – היא זורקת חריגה.
-לאחר מכן, היא מפעילה את הפרוצדורה שמעבירה טיול ממדריך עמוס למדריך פנוי (reassign_overloaded_guides).

-שלבים שהתוכנית מבצעת:
-קריאה לפונקציה get_available_trips_for_customer('C001')
-הפונקציה מחזירה refcursor עם כל הטיולים ש־C001 עדיין לא הוזמן אליהם
-בלולאה, נשלפים הטיולים ומודפסים אחד־אחד
-אם לא נמצאו טיולים – נזרקת חריגה עם הודעה מותאמת
-הרצת הפרוצדורה reassign_overloaded_guides()
-מאתרת מדריכים עם עומס (3 טיולים עתידיים בתוך 40 יום)
-מעבירה את הטיול האחרון למדריך אחר פנוי
-הודעה לסיום הפעולה






📜 **[View `programe2.sql`](ד/programe/programe2.sql)**



-יצירת התוכנית


![image](ד/views/createmain2.png)


-הפעלת התוכנית




![image](ד/views/runmain2.png)


### Backup

📜[View `Backup4.sql`](ד/backup4.backup)


## Phase 4: App
### Instructions

📜 **[View `Instractions`](ה/instraction)**

-הפעלת האפליקציה:
-הרצת השרת- uvicorn main:app --reload

### Explnation

-הסבר על דרך העבודה והכלים בהם השתמשנו
 מטרת הפרויקט
הפרויקט נועד לבנות מערכת אינטרנטית לניהול טיולים מאורגנים עבור סוכנות נסיעות. המערכת מאפשרת ניהול של לקוחות, עובדים, מדריכים וטיולים, כולל הפעלת פרוצדורות מתקדמות בבסיס הנתונים – הכל דרך ממשק גרפי נוח וברור.

 הכלים בהם השתמשנו
🔧 Backend:
Python 3.11 – שפת התכנות הראשית של הפרויקט.

FastAPI – מסגרת פיתוח (framework) מודרנית ל־Python שמאפשרת לבנות APIs בצורה פשוטה, מהירה ואסינכרונית. דרכה יצרנו את כל הנתיבים (routes) של האפליקציה, קיבלנו בקשות מהטפסים, ושלחנו תגובות (HTML או JSON).

uvicorn – שרת ASGI להרצת אפליקציית ה־FastAPI בצורה מקומית.

 בסיס נתונים:
PostgreSQL – בסיס הנתונים בו נשמרים כל הישויות של המערכת (לקוחות, טיולים, מדריכים וכו'). בנינו את בסיס הנתונים בעצמנו עם טבלאות, קשרים בין טבלאות, טריגרים, פרוצדורות ו־stored functions.

PL/pgSQL – שפת סקריפטים של PostgreSQL שאיתה כתבנו פונקציות ופרוצדורות עבור פעולות מורכבות כמו חישוב תשלומים, מיזוג טיולים קטנים, הקצאות מדריכים ועוד.

🖼️ Frontend:
HTML – תבניות בסיסיות להצגת דפי מערכת (טבלאות, טפסים וכו').

CSS – לעיצוב הדפים והכפתורים. הגדרנו עיצוב רספונסיבי עם כפתורים בצבעים שונים לפי פעולה (אדום למחיקה, כחול לעריכה וכו').

Jinja2 – מנוע תבניות של Python, דרכו שילבנו נתונים דינמיים (למשל רשימת מדריכים, טיולים וכו') בתוך קבצי ה־HTML.

JavaScript (Vanilla) – שימש להצגת תוצאות של פעולות AJAX (כמו שליפת טיולים זמינים או סכומי תשלומים ללקוח), והצגת toast הודעות באופן אוטומטי או ידני עם אפשרות לסגירה.

🐳 DevOps וכלי עזר:
Docker – השתמשנו כדי להריץ את PostgreSQL ולשמור על סביבת עבודה עקבית בין מחשבים.

Git & GitHub – לניהול גרסאות, שמירת התקדמות והגשת הפרויקט באמצעות git tag.

 אופן העבודה – שלב אחר שלב
אפיון ראשוני של המערכת
הגדרנו אילו ישויות צריכות להופיע (כמו מדריכים, טיולים, לקוחות), אילו טפסים יהיו, ואילו פעולות יתבצעו (CRUD – יצירה, קריאה, עדכון, מחיקה

בניית צד השרת (Backend)

כל נתיב FastAPI מתייחס לפעולה – לדוגמה: /persons/new מציג טופס, /persons שומר את הלקוח.

מימשנו את כל הפעולות על כל הישויות בצורה מלאה.

בנינו קוד נפרד לטיפול בכל טבלה בקובץ db.py, שמכיל מחלקות כמו GuideDB, TripDB, PersonDB.

בניית צד הלקוח (Frontend)

עיצבנו טפסים עם Jinja2 המחליף ערכים בהתאם להקשר (למשל {{ person.fullname }}).

כל פעולה (הוספה, עריכה, מחיקה) מחזירה הודעת הצלחה בעזרת Toast (כולל סגירה אוטומטית/ידנית).

ממשק אחיד, בשפה ברורה, כפתורים והכוונה.

טיפול בשגיאות וחוויית משתמש

הוספנו try-except בכל Route.

כל שגיאה מדווחת עם הודעת logger.error.

הודעות הצלחה מוצגות למשתמש בצורה נעימה ואינטראקטיבית.

שילוב AJAX להצגת תוצאות פרוצדורות בזמן אמת

תוצאה של חישוב תשלומים או שליפת טיולים מופיעה מיד, בלי לרענן את הדף.

שיפור משמעותי לחוויית המשתמש.


### AppShow

# מסך התחברות לעובד 
-בעת הכנסת עובד ניתן להיכנס למערכת 
מתרחשת שגיה כעת המשתמש אינו עובד

![image](ה/views/login.png)


# מסך ראשי

![image](ה/views/מסך_כניסה.png)

-מכיל ארבעה כפתורים 

# כפתור ניהול אנשים 
-מוצגת רשימה של כל הלקוחות הקיימים 
![image](ה/views/person_list.png)
ניתן למחוק להוסיף ולערוך 
![image](ה/views/addPerson.png)
![image](ה/views/updaetPerson.png)
בנוסף ניתן להפעיל עבור לקוח מסויים את סך תשלומיו או את הטיולים שזמינים עבורו 
![image](ה/views/payment.png)
![image](ה/views/tripes.png)
# כפתור הצגת טיולים 
-מוצגת רשימה של כל הטיולים הקיימים ניתן לעדכן טיול להוסיף ומלחוק טיול 
![image](ה/views/טיוליםרשימה.png)

![image](ה/views/הוספתטיול.png)
![image](ה/views/הוספתטיולמדריכיםפנויים.png)

![image](ה/views/עריכתטיול.png)




עבור עידכון טיול נוסף עמוד חדש של עידכון שבו יש אופציה לפי תאריכים לראות את המדריכים הפנויים עבור אותו טיול 

# כפתור שאילתות ופרוצדורות 

ניתנת אפשרות למזג טיולים קטנים מידי שנמצאים באותו אזור לטיול אחד 
ובנוסף עבור מדריכים עמוסים לעביר את אחד הטיולים למדריך אחר על מנת להוריד עומס
![image](ה/views/שאילתןת.png)
![image](ה/views/שאילתות1.png)
![image](ה/views/שאילתות2.png)
# כפתור ניהול מדריכים 
-מוצגת רשימת כל המדריכים הקיימים עם אופציה למחוק לעדכן ולהוסיף מדריך 
![image](ה/views/ניהולמדריכים.png)
![image](ה/views/הוספתמדריך.png)






