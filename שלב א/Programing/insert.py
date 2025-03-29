import random
import datetime

# פונקציות ליצירת נתונים רנדומליים
def random_date():
    start_date = datetime.date(2024, 1, 1)
    random_days = random.randint(1, 365)
    return (start_date + datetime.timedelta(days=random_days)).strftime("%Y-%m-%d")

def random_phone():
    return f"{random.randint(100, 999)}-{random.randint(1000, 9999)}-{random.randint(1000, 9999)}"

names = ["Alice", "Bob", "Charlie", "David", "Emma", "Sophia", "Liam", "Olivia", "Noah", "Ava"]
domains = ["example.com", "mail.com", "test.org", "demo.net"]
countries = ["USA", "France", "Japan", "Germany", "Canada"]
addresses = ["Main St 123", "Baker St 221B", "Sunset Blvd 100", "5th Avenue 987", "High St 456"]

# מילון לשמירת המידע
customers = []
guides = []
flights = []
destinations = []
hotels = []
trips = []
invites = []
includes = []

# יצירת נתונים
for i in range(4, 204):
    # לקוחות
    full_name = random.choice(names) + f"_{i}"
    email = f"{full_name.lower()}@{random.choice(domains)}"
    phone = random_phone()
    customers.append((i, full_name, phone, email))

    # מדריכים
    guide_name = f"Guide_{i}"
    guide_phone = random_phone()
    guides.append((i, guide_name, guide_phone))

    # יעדים
    zip_code = 1000 + i  # מוודאים zip ייחודי
    country = random.choice(countries)
    address = random.choice(addresses)
    destinations.append((zip_code, country, address))

    # מלונות
    hotel_name = f"Hotel_{i}"
    location = random.choice(addresses)
    total_rooms = random.randint(20, 200)
    hotels.append((i, hotel_name, location, total_rooms))

    # טיסות
    airline = f"Airline_{i}"
    departure_date = random_date()
    return_date = random_date()
    flights.append((i, airline, departure_date, return_date))

    # טיולים
    trip_start = random_date()
    trip_end = random_date()
    guide_id = random.randint(4, 203)
    hotel_id = random.randint(4, 203)
    destination_zip = random.choice(destinations)[0]
    trips.append((i, trip_start, trip_end, destination_zip, hotel_id, guide_id))

    # הזמנות
    customer_id = random.randint(4, 203)
    total_customer = random.randint(1, 5)
    invites.append((i, customer_id, total_customer))

    # שילובים
    flight_id = random.randint(4, 203)
    includes.append((i, flight_id))

# כתיבת הנתונים לקובץ SQL
with open("insert_data2.sql", "w", encoding="utf-8") as f:
    f.write("-- Inserting data into customer\n")
    for row in customers:
        f.write(f"INSERT INTO customer (ID, fullName, phoneNumber, email) VALUES {row};\n")

    f.write("\n-- Inserting data into guide\n")
    for row in guides:
        f.write(f"INSERT INTO guide (guideID, guideName, phoneNumber) VALUES {row};\n")

    f.write("\n-- Inserting data into destination\n")
    for row in destinations:
        f.write(f"INSERT INTO destination (zipCode, country, address) VALUES {row};\n")

    f.write("\n-- Inserting data into hotel\n")
    for row in hotels:
        f.write(f"INSERT INTO hotel (hotelID, hotelName, location, totalRooms) VALUES {row};\n")

    f.write("\n-- Inserting data into flight\n")
    for row in flights:
        f.write(f"INSERT INTO flight (flightID, airline, departureDate, returnDate) VALUES {row};\n")

    f.write("\n-- Inserting data into trip\n")
    for row in trips:
        f.write(f"INSERT INTO trip (tripID, startDate, endDate, destinationZip, hotelID, guideID) VALUES {row};\n")

    f.write("\n-- Inserting data into invite\n")
    for row in invites:
        f.write(f"INSERT INTO invite (tripID, customerID, totalCustomer) VALUES {row};\n")

    f.write("\n-- Inserting data into include\n")
    for row in includes:
        f.write(f"INSERT INTO include (tripID, flightID) VALUES {row};\n")

print("✅ הקובץ insert_data.sql נוצר עם 200 רשומות לכל טבלה החל ממספר 4!")
