import psycopg2
from psycopg2.extras import RealDictCursor
from contextlib import contextmanager
import logging
import uuid
import psycopg2.extras


logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "database": "hotel",
    "user": "myuser",
    "password": "mypassword",
}


@contextmanager
def get_db_connection():

    conn = None
    try:
        conn = psycopg2.connect(**DB_CONFIG, cursor_factory=RealDictCursor)
        yield conn
    except Exception as e:
        if conn:
            conn.rollback()
        logger.error(f"Database error: {e}")
        raise
    finally:
        if conn:
            conn.close()


class PersonDB:

    @staticmethod
    def get_all():
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT * FROM person ORDER BY id")
                return cur.fetchall()

    @staticmethod
    def get_customers_only():
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    """
                    SELECT * FROM person
                    WHERE id NOT IN (SELECT id FROM employee)
                    AND id NOT IN (SELECT id FROM guide)
                    ORDER BY id
                """
                )
                return cur.fetchall()

    @staticmethod
    def get_by_id(person_id):
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT * FROM person WHERE id = %s", (str(person_id),))
                return cur.fetchone()

    @staticmethod
    def create(fullname, email, phonenumber):
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "INSERT INTO person (fullname, email, phonenumber) VALUES (%s, %s, %s) RETURNING id",
                    (fullname, email, phonenumber),
                )
                person_id = cur.fetchone()["id"]

                cur.execute("INSERT INTO customer (id) VALUES (%s)", (person_id,))

                conn.commit()
                return str(person_id)

    @staticmethod
    def update(person_id, fullname, email, phonenumber):
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "UPDATE person SET fullname = %s, email = %s, phonenumber = %s WHERE id = %s",
                    (fullname, email, phonenumber, str(person_id)),  # ← המרה ל־str
                )
                conn.commit()
                return cur.rowcount > 0

    @staticmethod
    def delete(person_id):
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute("DELETE FROM person WHERE id = %s", (str(person_id),))
                conn.commit()
                return cur.rowcount > 0


class EmployeeDB:
    """מחלקה לניהול טבלת Employee"""

    @staticmethod
    def get_by_credentials(fullname: str, national_id: str):
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    """
                    SELECT e.id, p.fullName, p.email, p.phoneNumber, e.tenure, e.salary, e.role
                    FROM employee e
                    JOIN person p ON e.id = p.id
                    WHERE p.fullName = %s
                      AND e.id::text = %s
                    """,
                    (fullname, national_id),
                )
                return cur.fetchone()

    @staticmethod
    def get_all():
        """קבלת כל העובדים עם פרטי Person"""
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    """
                    SELECT e.id, p.fullname, p.email, p.phonenumber, 
                           e.tenure, e.salary, e.role
                    FROM employee e
                    JOIN person p ON e.id = p.id
                    ORDER BY e.id
                """
                )
                return cur.fetchall()

    @staticmethod
    def get_by_id(employee_id):
        """קבלת עובד ספציפי לפי ID"""
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    """
                    SELECT e.id, p.fullname, p.email, p.phonenumber, 
                           e.tenure, e.salary, e.role
                    FROM employee e
                    JOIN person p ON e.id = p.id
                    WHERE e.id = %s
                """,
                    (employee_id,),
                )
                return cur.fetchone()

    @staticmethod
    def create(fullname, email, phonenumber, tenure, salary, role):
        """יצירת עובד חדש"""
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                # יצירת Person תחילה
                cur.execute(
                    "INSERT INTO person (fullname, email, phonenumber) VALUES (%s, %s, %s) RETURNING id",
                    (fullname, email, phonenumber),
                )
                person_id = cur.fetchone()["id"]

                # יצירת Employee
                cur.execute(
                    "INSERT INTO employee (id, tenure, salary, role) VALUES (%s, %s, %s, %s)",
                    (person_id, tenure, salary, role),
                )
                conn.commit()
                return person_id

    @staticmethod
    def update(employee_id, fullname, email, phonenumber, tenure, salary, role):
        """עדכון עובד"""
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                # עדכון Person
                cur.execute(
                    "UPDATE person SET fullname = %s, email = %s, phonenumber = %s WHERE id = %s",
                    (fullname, email, phonenumber, employee_id),
                )
                # עדכון Employee
                cur.execute(
                    "UPDATE employee SET tenure = %s, salary = %s, role = %s WHERE id = %s",
                    (tenure, salary, role, employee_id),
                )
                conn.commit()
                return True

    @staticmethod
    def delete(employee_id):
        """מחיקת עובד"""
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                # מחיקת Employee תחילה (בגלל Foreign Key)
                cur.execute("DELETE FROM employee WHERE id = %s", (employee_id,))
                # מחיקת Person
                cur.execute("DELETE FROM person WHERE id = %s", (employee_id,))
                conn.commit()
                return True


class GuideDB:
    """מחלקה לניהול טבלת Guide"""

    @staticmethod
    def get_all():
        """קבלת כל המדריכים עם פרטי Person"""
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    """
                    SELECT g.id, p.fullname, p.email, p.phonenumber
                    FROM guide g
                    JOIN person p ON g.id = p.id
                    ORDER BY g.id
                """
                )
                return cur.fetchall()

    @staticmethod
    def get_by_id(guide_id):
        """קבלת מדריך ספציפי לפי ID"""
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    """
                    SELECT g.id, p.fullname, p.email, p.phonenumber
                    FROM guide g
                    JOIN person p ON g.id = p.id
                    WHERE g.id = %s
                """,
                    (guide_id,),
                )
                return cur.fetchone()

    @staticmethod
    def create(fullname, email, phonenumber):
        """יצירת מדריך חדש"""
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                # יצירת Person תחילה
                cur.execute(
                    "INSERT INTO person (fullname, email, phonenumber) VALUES (%s, %s, %s) RETURNING id",
                    (fullname, email, phonenumber),
                )
                person_id = cur.fetchone()["id"]

                # יצירת Guide
                cur.execute("INSERT INTO guide (id) VALUES (%s)", (person_id,))
                conn.commit()
                return person_id

    @staticmethod
    def update(guide_id, fullname, email, phonenumber):
        """עדכון מדריך"""
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "UPDATE person SET fullname = %s, email = %s, phonenumber = %s WHERE id = %s",
                    (fullname, email, phonenumber, guide_id),
                )
                conn.commit()
                return True

    @staticmethod
    def delete(guide_id):
        """מחיקת מדריך"""
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                # מחיקת Guide תחילה
                cur.execute("DELETE FROM guide WHERE id = %s", (guide_id,))
                # מחיקת Person
                cur.execute("DELETE FROM person WHERE id = %s", (guide_id,))
                conn.commit()
                return True


def test_connection():
    """בדיקת חיבור לבסיס הנתונים"""
    try:
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT 1")
                logger.info("✅ Connected successfully to PostgreSQL!")
                return True
    except Exception as e:
        logger.error(f"❌ Failed to connect: {e}")
        return False


class CustomerDB:
    """ניהול לקוחות (customer) לפי person_id"""

    @staticmethod
    def delete(customer_id):
        """מחיקת לקוח בלבד (לא מוחק מ-person)"""
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "DELETE FROM customer WHERE id = %s", (str(customer_id),)
                )  # ← המרה למחרוזת
                conn.commit()
                return True


class HotelDB:
    @staticmethod
    def get_all():
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT hotelid, hotelname FROM hotel ORDER BY hotelname")
                return cur.fetchall()


class DestinationDB:
    @staticmethod
    def get_all():
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "SELECT zipcode, country, address FROM destination ORDER BY zipcode"
                )
                return cur.fetchall()


class TripDB:

    @staticmethod
    def get_total_paid_by_customer(customer_id: str) -> float:
        with get_db_connection() as conn:
            with conn.cursor(cursor_factory=RealDictCursor) as cur:  # הכרחי!
                try:
                    print(
                        f"שולח לבסיס נתונים: get_total_paid_by_customer('{customer_id}') [type: {type(customer_id)}]"
                    )
                    cur.execute("SELECT get_total_paid_by_customer(%s)", (customer_id,))
                    result = cur.fetchone()
                    print("תוצאה מהפונקציה:", result)
                    return float(result["get_total_paid_by_customer"]) if result else 0
                except Exception as e:
                    print("שגיאה בפונקציית תשלומים:", e)
                    return -1

    @staticmethod
    def delete(trip_id: str):
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                try:
                    cur.execute("DELETE FROM has WHERE tripid = %s", (trip_id,))
                    cur.execute("DELETE FROM trippay WHERE tripid = %s", (trip_id,))

                    cur.execute("DELETE FROM trip WHERE tripid = %s", (trip_id,))
                    conn.commit()
                except Exception as e:
                    print("שגיאה במחיקת טיול:", e)
                    raise

    @staticmethod
    def get_all():
        with get_db_connection() as conn:
            with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
                cur.execute(
                    """
                SELECT 
                    t.tripid, t.startdate, t.enddate,
                    t.destinationzip, d.country AS destination_name,
                    t.hotelid, h.hotelname,
                    t.guideid, p.fullname AS guide_name
                FROM trip t
                JOIN destination d ON t.destinationzip = d.zipcode
                JOIN hotel h ON t.hotelid = h.hotelid
                JOIN guide g ON t.guideid = g.id
                JOIN person p ON g.id = p.id
                ORDER BY t.startdate DESC
            """
                )
                return cur.fetchall()

    @staticmethod
    def get_available_trips_for_customer(customer_id: str):
        with get_db_connection() as conn:
            with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
                try:
                    cur.execute("BEGIN;")
                    cur.execute(
                        "SELECT get_available_trips_for_customer(%s, 'trip_cursor')",
                        (customer_id,),
                    )
                    cur.execute("FETCH ALL IN trip_cursor;")
                    results = cur.fetchall()
                    return results
                except Exception as e:
                    print("שגיאה בשליפת טיולים זמינים:", e)
                    return []

    @staticmethod
    def merge_small_trips():
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                try:
                    cur.execute("CALL merge_small_trips();")
                    conn.commit()
                except Exception as e:
                    print("שגיאה בפרוצדורה לאיחוד טיולים:", e)
                    raise

    @staticmethod
    def reassign_overloaded_guides():
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                try:
                    cur.execute("CALL reassign_overloaded_guides();")
                    conn.commit()
                except Exception as e:
                    print("שגיאה באיזון עומס מדריכים:", e)
                    raise

    @staticmethod
    def create(start, end, destinationzip, hotelid, guideid: str):
        tripid = str(uuid.uuid4())  # 🔹 מזהה ייחודי באורך מלא
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    """
                    INSERT INTO trip
                      (tripid, startdate, enddate, destinationzip, hotelid, guideid)
                    VALUES (%s, %s, %s, %s, %s, %s)
                    """,
                    (tripid, start, end, destinationzip, hotelid, guideid),
                )
                conn.commit()
                return tripid

    @staticmethod
    def get_by_id(trip_id: str):
        with get_db_connection() as conn:
            with conn.cursor(cursor_factory=RealDictCursor) as cur:
                cur.execute(
                    """
                    SELECT *
                    FROM trip
                    WHERE tripid = %s
                """,
                    (trip_id,),
                )
                return cur.fetchone()

    @staticmethod
    def get_available_guides(start: str, end: str):
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    """
                    SELECT g.id, p.fullname
                    FROM guide g
                    JOIN person p ON g.id = p.id
                    WHERE g.id NOT IN (
                      SELECT guideid
                      FROM trip
                      WHERE NOT (enddate < %s OR startdate > %s)
                    )
                    ORDER BY p.fullname
                    """,
                    (start, end),
                )
                return cur.fetchall()

    @staticmethod
    def get_available_hotels_for_trip(startdate, enddate, current_hotelid=None):
        with get_db_connection() as conn:
            cur = conn.cursor(cursor_factory=RealDictCursor)
            cur.execute(
                """
            SELECT DISTINCT h.hotelid, h.hotelname
            FROM hotel h
            WHERE h.hotelid NOT IN (
                SELECT hotelid FROM trip
                WHERE (%s, %s) OVERLAPS (startdate, enddate)
            )
            OR h.hotelid = %s
        """,
                (startdate, enddate, current_hotelid),
            )
            return cur.fetchall()

    @staticmethod
    def get_available_guides_for_trip(startdate, enddate, current_guideid=None):
        with get_db_connection() as conn:
            cur = conn.cursor(cursor_factory=RealDictCursor)
            cur.execute(
                """
            SELECT DISTINCT g.id, p.fullname
            FROM guide g
            JOIN person p ON g.id = p.id
            WHERE g.id NOT IN (
                SELECT guideid FROM trip
                WHERE (%s, %s) OVERLAPS (startdate, enddate)
            )
            OR g.id = %s
        """,
                (startdate, enddate, current_guideid),
            )
            return cur.fetchall()

    @staticmethod
    def update(trip_id, start, end, destinationzip, hotelid, guideid):
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    """
            UPDATE trip
            SET startdate = %s,
                enddate = %s,
                destinationzip = %s,
                hotelid = %s,
                guideid = %s
            WHERE tripid = %s
        """,
                    (start, end, destinationzip, hotelid, guideid, trip_id),
                )
            conn.commit()


if __name__ == "__main__":
    test_connection()
