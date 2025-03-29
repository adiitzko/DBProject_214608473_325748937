import psycopg2
import random
from datetime import datetime, timedelta

# התחברות למסד הנתונים
conn = psycopg2.connect(
    dbname="postgres",
    user="gilis",
    password="gili12",
    host="172.17.0.2",
    port="5432"
)
cursor = conn.cursor()

# פונקציה ליצירת מספר טלפון רנדומלי
def random_phone():
    return f"{random.randint(100, 999)}-{random.randint(1000, 9999)}-{random.randint(1000, 9999)}"

# רשימות נתונים
guide_names = ["John", "Emily", "Michael", "Sarah", "Daniel", "Laura"]
airlines = ["El Al", "Delta", "United", "Turkish Airlines", "Emirates"]
countries = ["USA", "France", "Italy", "Spain", "Germany"]
hotel_names = ["Hilton", "Marriott", "Holiday Inn", "Sheraton", "Ibis"]
addresses = ["Main St", "Central Ave", "Park Lane", "Ocean Dr", "Broadway"]

# הכנסת נתונים ל-guide
guides = []
for i in range(4, 104):
    guides.append((i, random.choice(guide_names) + f"_{i}", random_phone()))
cursor.executemany("INSERT INTO guide (guideID, guideName, phoneNumber) VALUES (%s, %s, %s)", guides)

# הכנסת נתונים ל-flight
flights = []
start_date = datetime(2025, 1, 1)
for i in range(4, 104):
    departure = start_date + timedelta(days=random.randint(1, 100))
    return_date = departure + timedelta(days=random.randint(3, 14))
    flights.append((i, random.choice(airlines), departure.date(), return_date.date()))
cursor.executemany("INSERT INTO flight (flightID, airline, departureDate, returnDate) VALUES (%s, %s, %s, %s)", flights)

# הכנסת נתונים ל-destination
destinations = []
for i in range(4, 104):
    destinations.append((i, random.choice(countries), f"{random.choice(addresses)} {i}"))
cursor.executemany("INSERT INTO destination (zipCode, country, address) VALUES (%s, %s, %s)", destinations)

# הכנסת נתונים ל-hotel
hotels = []
for i in range(4, 104):
    hotels.append((i, random.choice(hotel_names), f"{random.choice(addresses)} {i}", random.randint(50, 500)))
cursor.executemany("INSERT INTO hotel (hotelID, hotelName, location, totalRooms) VALUES (%s, %s, %s, %s)", hotels)

# הכנסת נתונים ל-trip
trips = []
for i in range(4, 104):
    trips.append((i, start_date.date(), (start_date + timedelta(days=random.randint(5, 20))).date(), i, i, i))
cursor.executemany("INSERT INTO trip (tripID, startDate, endDate, destinationZip, hotelID, guideID) VALUES (%s, %s, %s, %s, %s, %s)", trips)

# הכנסת נתונים ל-customer
customers = []
names = ["Alice", "Bob", "Charlie", "David", "Emma", "Sophia", "Liam", "Olivia", "Noah", "Ava"]
domains = ["example.com", "mail.com", "test.org", "demo.net"]
for i in range(4, 104):
    full_name = random.choice(names) + f"_{i}"
    email = f"{full_name.lower()}@{random.choice(domains)}"
    phone = random_phone()
    customers.append((i, full_name, phone, email))
cursor.executemany("INSERT INTO customer (ID, fullName, phoneNumber, email) VALUES (%s, %s, %s, %s)", customers)

# הכנסת נתונים ל-invite
invites = []
for i in range(4, 104):
    invites.append((i, i, random.randint(1, 5)))
cursor.executemany("INSERT INTO invite (tripID, customerID, totalCustomer) VALUES (%s, %s, %s)", invites)

# הכנסת נתונים ל-include
includes = []
for i in range(4, 104):
    includes.append((i, i))
cursor.executemany("INSERT INTO include (tripID, flightID) VALUES (%s, %s)", includes)

# ביצוע השינויים וסגירת החיבור
conn.commit()
cursor.close()
conn.close()
print("✅ 100 רשומות הוכנסו בהצלחה לכל הטבלאות!")
