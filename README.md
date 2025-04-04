

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





## Phase 2: Integration 
#### Quries
📜[View `AllQuries.sql`](ב/Quries.sql)
#### Select quries:
-1. השאילתא מחזירה את רשימת הטיולים שהמדריך היה מעורב בהם, יחד עם שם המדריך ומספר הטיולים שהוא הוביל (רק עבור מדריכים שהיו מעורבים בשלושה טיולים ומעלה). התוצאות ממוין לפי מספר הטיולים שהמדריך הוביל, מהכי הרבה לפחות📜[View `select1.sql`](ב/Quries.sql/Quries1.sql)

![image](ב/QuriesPicture/Select1Quries.png)

-2.השאילתא מציגה את כל המלונות ואת היעד שבו כל אחד מהם נמצא, כולל פרטי היעד כמו המדינה והכתובת 📜[View `select2.sql`](ב/Quries.sql/Quries2.sql) 
![image](ב/QuriesPicture/Select2Quries.png) 




-3. השאילתא מציגה את פרטי כל הלקוחות (שם, טלפון, ודוא"ל) יחד עם פרטי הטיול שבו הם השתתפו, כולל היעד, המלון והמדריך, ותאריכי התחלה וסיום של כל טיול📜[View `select3.sql`](ב/Quries.sql/Quries3.sql)

![image](ב/QuriesPicture/Select3Quries.png)

-4. השאילתא מציגה את כל הטיסות, כולל חברת התעופה, תאריכי היציאה והחזרה, לצד המידע על היעד שבו מתרחש הטיול, שם המלון שבו שהו הנוסעים, ותאריכי תחילת וסיום הטיול📜[View `select4.sql`](ב/Quries.sql/Quries4.sql)

![image](ב/QuriesPicture/Select4Quries.png)


-5. השאילתא מציגה את רשימת המדריכים עם מספר הטיולים שהם הובילו, תאריך תחילת הטיול הראשון שהם הובילו ותאריך סיום הטיול האחרון📜[View `select5.sql`](ב/Quries.sql/Quries5.sql)

![image](ב/QuriesPicture/Select5Image.png)

-6. השאילתא מציגה את כל הלקוחות שהשתתפו בטיולים בעונת הקיץ (יוני, יולי, אוגוסט), כולל פרטי הלקוח, תאריכים של הטיול שבו הם השתתפו, ומזהה הטיול📜[View `select6.sql`](ב/Quries.sql/Quries6.sql)

![image](ב/QuriesPicture/Select6Quries.png)


-7. השאילתא מציגה את רשימת המלונות שבהם מספר הלקוחות המשתתפים בטיולים הוא לפחות כפול ממספר החדרים במלון, כלומר מלונות עם תפוסה מלאה או גבוהה יותר(החדרים במלון זוגיים)📜[View `select7.sql`](ב/Quries.sql/Quries7.sql)

![image](ב/QuriesPicture/Select7Quries.png)


-8. השאילתא מציגה את השנה והחודש שבהם היו הכי הרבה טיולים, יחד עם מספר הטיולים שהתרחשו בחודש זה📜[View `select8.sql`](ב/Quries.sql/Quries8.sql)

![image](ב/QuriesPicture/Select8Quries.png)

#### Delete quries:
-1.השאילתא מוחקת את כל הטיולים שהחלו לפני יותר מ-5 שנים ולא הוזמנו על ידי אף לקוח. היא עושה זאת על ידי בחירת טיולים שהיו לא פעילים במשך זמן ארוך ולא היו להם הזמנות📜[View `Delete1.sql`](ב/Quries.sql/Quries9Delete.sql)

#### Before
![image](ב/QuriesPicture/Before1Del.png)

#### After
![image](ב/QuriesPicture/After1Del.png)


-2. השאילתא מוחקת את כל המדריכים שלא הנחו טיול בשלוש השנים האחרונות. היא עושה זאת על ידי חיפוש המדריכים שהיו קשורים לטיול בתקופה הזו, ומחיקת כל שאר המדריכים 📜[View `Delete2.sql`](ב/Quries.sql/Quries10Delete.sql)

#### Before
![image](ב/QuriesPicture/Before2Del.png)
#### After
![image](ב/QuriesPicture/After2Del.png)



-3.השאילתא מוחקת את כל הטיולים שלא התקבלו בהם הזמנות, כלומר טיולים שאין להם לקוחות שהוזמנו אליהם📜[View `Delete3.sql`](ב/Quries.sql/Quries11Delete.sql)


#### Before

![image](ב/QuriesPicture/Before3Del.png)

#### After
![image](ב/QuriesPicture/After3Del.png)


#### Update quries:
-1.השאילתא מחפשת טיולים שבהם המלון שלהם מלא מדי ומבצע עדכון כך שכל טיול כזה יקבל מלון אחר, שיש לו מספיק חדרים עבור כל הלקוחות שהוזמנו.📜[View `Update1.sql`](ב/Quries.sql/Quries12Update.sql)


![image](ב/QuriesPicture/Sucsses1Up.png)

#### Before
![image](ב/QuriesPicture/Before1Up.png)

#### After
![image](ב/QuriesPicture/After1Up.png)


-2.הפונקציה update_flight_prices מעדכנת את מחירי הטיסות בטבלה flight על ידי העלאת המחיר ב-10%.📜[View `Update2.sql`](ב/Quries.sql/Quries13Update.sql)


![image](ב/QuriesPicture/Sucsses2Up.png)

#### Before
![image](ב/QuriesPicture/Before2Up.png)

#### After
![image](ב/QuriesPicture/After2Up.png)


-3.השאילתא מעדכנת את שמות המדריכים שלא היו פעילים בשנה האחרונה על ידי הוספת המילים " (Inactive)" לשם המדריך.📜[View `Update3.sql`](ב/Quries.sql/Quries14Update.sql)


![image](ב/QuriesPicture/Sucsses3Up.png)


#### Before
![image](ב/QuriesPicture/Before3Del.png)

#### After
![image](ב/QuriesPicture/before3Up.png)




