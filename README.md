

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
#####  Entering a data to costumer table
-  person id scope 1-800// בכל אלה אתיודעת מה הנתונים??
📜[View `personMock_data.csv`](א/mockarooFiles/customer.csv)
#####  Entering a data to destination table
-  person id scope 1-400
📜[View `nannyMock_data.csv`](א/mockarooFiles/destination.csv)
#####  Entering a data to flight table
-  person id scope 1-400
📜[View `nannyMock_data.csv`](א/mockarooFiles/flight.csv)
#####  Entering a data to guide table
-  person id scope 1-400
📜[View `nannyMock_data.csv`](א/mockarooFiles/guide.csv)
#####  Entering a data to hotel table
-  person id scope 1-400
📜[View `nannyMock_data.csv`](א/mockarooFiles/hotel.csv)
#####  Entering a data to include table
-  person id scope 1-400
📜[View `nannyMock_data.csv`](א/mockarooFiles/include.csv)
#####  Entering a data to invite table
-  person id scope 1-400
📜[View `nannyMock_data.csv`](א/mockarooFiles/invite.csv)
#####  Entering a data to trip table
-  person id scope 1-400
📜[View `nannyMock_data.csv`](א/mockarooFiles/trip.csv)


#####   Entering a data to guide table
-  person id scope 401-800\\ גם כאן אותו בעיה
-  Formula of Person ID: `this + 400`\\וכאן
![image](א/picture/guideImage.jpg)

📜 **[View `costumerMock_data.csv`](Phase1/mockData/apotropusMOCK_DATA.csv)**\\ פה את יודעת מה צריך?
![image](א/picture/customerCsvImage.png)
![image](https://github.com/user-attachments/assets/6833ecf1-90e6-454d-8396-9dddf415e323)
results for  the command `SELECT COUNT(*) FROM guide;`:
<br>
![image](א/picture/guideCsvImage.png)

####  Second tool: using [python](א/Programing). t 
#####  Entering a data to babyGroup table
-  Group Number  scope 1-400 \\כאן
📜[View `insertDat.csv`](א/Programing/insert.py)

![image](א/Programing/insert_data2.sql)\\קישור לא תמונה

![image](https://github.com/user-attachments/assets/046ee01c-599b-4858-886f-7c9809c60bfa)// תמונה של הקובץ שנוצר 



####  Third tool: using python to create csv file

### Backup 
-   backups files are kept with the date and hour of the backup:  

[עבור לתיקיית הגיבויים](א/backup 3.29.25.backup)



## Phase 2: Integration 


