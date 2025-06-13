from fastapi import FastAPI, Request, Form, HTTPException
from fastapi.staticfiles import StaticFiles
from fastapi.responses import HTMLResponse, RedirectResponse
from fastapi.templating import Jinja2Templates
from db import PersonDB, EmployeeDB, GuideDB, CustomerDB, test_connection
import logging
from db import HotelDB, DestinationDB, TripDB
from fastapi.responses import JSONResponse
from typing import Optional


# הגדרת הלוגים
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(title="מערכת טיולים", description="מערכת לניהול טיולים מאורגנים")
app.mount("/static", StaticFiles(directory="static"), name="static")
templates = Jinja2Templates(directory="templates")


# בדיקת חיבור לבסיס נתונים בהפעלה
@app.on_event("startup")
async def startup_event():
    if test_connection():
        logger.info("🚀 Application started successfully!")
    else:
        logger.error("❌ Failed to connect to database on startup")


@app.get("/", response_class=HTMLResponse)
async def login_form(request: Request):
    return templates.TemplateResponse("login.html", {"request": request, "error": None})


@app.post("/login", response_class=HTMLResponse)
async def login(
    request: Request,
    username: str = Form(...),
    password: str = Form(...),
):
    user = EmployeeDB.get_by_credentials(username, password)
    if not user:
        # התחברות לא הצליחה: מציגים שוב את טופס ההתחברות עם שגיאה
        return templates.TemplateResponse(
            "login.html", {"request": request, "error": 'שם משתמש או תע"ז שגויים'}
        )
    # התחברות הצליחה: מציגים את index.html
    return templates.TemplateResponse("index.html", {"request": request})


# ==================== Person Routes ====================


@app.get("/persons", response_class=HTMLResponse)
async def list_persons(request: Request):
    try:
        persons = PersonDB.get_customers_only()
        return templates.TemplateResponse(
            "persons/list.html", {"request": request, "persons": persons}
        )
    except Exception as e:
        logger.error(f"Error fetching persons: {e}")
        raise HTTPException(status_code=500, detail="שגיאה בטעינת הנתונים")


@app.get("/persons/new", response_class=HTMLResponse)
async def new_person_form(request: Request):
    return templates.TemplateResponse(
        "persons/form.html", {"request": request, "person": None, "action": "create"}
    )


@app.post("/persons", response_class=HTMLResponse)
async def create_person(
    request: Request,
    fullname: str = Form(...),
    email: str = Form(...),
    phonenumber: str = Form(...),
):
    try:
        PersonDB.create(fullname, email, phonenumber)
        success_message = f"הלקוח {fullname} נוסף בהצלחה ✅"
        persons = PersonDB.get_customers_only()
        return templates.TemplateResponse(
            "persons/list.html",
            {"request": request, "persons": persons, "success": success_message},
        )
    except Exception as e:
        logger.error(f"Error creating person: {e}")
        raise HTTPException(status_code=500, detail="שגיאה ביצירת רשומה")


@app.get("/persons/{person_id}/edit", response_class=HTMLResponse)
async def edit_person_form(request: Request, person_id: int):
    try:
        person = PersonDB.get_by_id(person_id)
        if not person:
            raise HTTPException(status_code=404, detail="רשומה לא נמצאה")
        return templates.TemplateResponse(
            "persons/form.html",
            {"request": request, "person": person, "action": "edit"},
        )
    except Exception as e:
        logger.error(f"Error fetching person: {e}")
        raise HTTPException(status_code=500, detail="שגיאה בטעינת הנתונים")


@app.post("/persons/{person_id}")
async def update_person(
    person_id: int,
    fullname: str = Form(...),
    email: str = Form(...),
    phonenumber: str = Form(...),
):
    try:
        PersonDB.update(person_id, fullname, email, phonenumber)
        return RedirectResponse(url="/persons", status_code=303)
    except Exception as e:
        logger.error(f"Error updating person: {e}")
        raise HTTPException(status_code=500, detail="שגיאה בעדכון רשומה")


@app.post("/persons/{person_id}/delete")
async def delete_person(person_id: str):
    try:

        CustomerDB.delete(person_id)
        # ואז מחיקת האדם
        PersonDB.delete(person_id)
        return RedirectResponse(url="/persons", status_code=303)
    except Exception as e:
        logger.error(f"Error deleting person: {e}")
        raise HTTPException(status_code=500, detail="שגיאה במחיקת רשומה")


# ==================== Employee Routes ====================


@app.get("/employees", response_class=HTMLResponse)
async def list_employees(request: Request):
    try:
        employees = EmployeeDB.get_all()
        return templates.TemplateResponse(
            "employees/list.html", {"request": request, "employees": employees}
        )
    except Exception as e:
        logger.error(f"Error fetching employees: {e}")
        raise HTTPException(status_code=500, detail="שגיאה בטעינת הנתונים")


@app.get("/employees/new", response_class=HTMLResponse)
async def new_employee_form(request: Request):
    return templates.TemplateResponse(
        "employees/form.html",
        {"request": request, "employee": None, "action": "create"},
    )


@app.post("/employees")
async def create_employee(
    fullname: str = Form(...),
    email: str = Form(...),
    phonenumber: str = Form(...),
    tenure: int = Form(...),
    salary: float = Form(...),
    role: str = Form(...),
):
    try:
        EmployeeDB.create(fullname, email, phonenumber, tenure, salary, role)
        return RedirectResponse(url="/employees", status_code=303)
    except Exception as e:
        logger.error(f"Error creating employee: {e}")
        raise HTTPException(status_code=500, detail="שגיאה ביצירת רשומה")


@app.get("/employees/{employee_id}/edit", response_class=HTMLResponse)
async def edit_employee_form(request: Request, employee_id: int):
    try:
        employee = EmployeeDB.get_by_id(employee_id)
        if not employee:
            raise HTTPException(status_code=404, detail="רשומה לא נמצאה")
        return templates.TemplateResponse(
            "employees/form.html",
            {"request": request, "employee": employee, "action": "edit"},
        )
    except Exception as e:
        logger.error(f"Error fetching employee: {e}")
        raise HTTPException(status_code=500, detail="שגיאה בטעינת הנתונים")


@app.post("/employees/{employee_id}")
async def update_employee(
    employee_id: int,
    fullname: str = Form(...),
    email: str = Form(...),
    phonenumber: str = Form(...),
    tenure: int = Form(...),
    salary: float = Form(...),
    role: str = Form(...),
):
    try:
        EmployeeDB.update(
            employee_id, fullname, email, phonenumber, tenure, salary, role
        )
        return RedirectResponse(url="/employees", status_code=303)
    except Exception as e:
        logger.error(f"Error updating employee: {e}")
        raise HTTPException(status_code=500, detail="שגיאה בעדכון רשומה")


@app.post("/employees/{employee_id}/delete")
async def delete_employee(employee_id: int):
    try:
        EmployeeDB.delete(employee_id)
        return RedirectResponse(url="/employees", status_code=303)
    except Exception as e:
        logger.error(f"Error deleting employee: {e}")
        raise HTTPException(status_code=500, detail="שגיאה במחיקת רשומה")


# ==================== Guide Routes ====================


@app.get("/guides", response_class=HTMLResponse)
async def list_guides(request: Request):
    try:
        guides = GuideDB.get_all()
        return templates.TemplateResponse(
            "guides/list.html", {"request": request, "guides": guides}
        )
    except Exception as e:
        logger.error(f"Error fetching guides: {e}")
        raise HTTPException(status_code=500, detail="שגיאה בטעינת המדריכים")


@app.get("/guides/new", response_class=HTMLResponse)
async def new_guide_form(request: Request):
    return templates.TemplateResponse(
        "guides/form.html", {"request": request, "guide": None, "action": "create"}
    )


@app.post("/guides")
async def create_guide(
    fullname: str = Form(...), email: str = Form(...), phonenumber: str = Form(...)
):
    try:
        GuideDB.create(fullname, email, phonenumber)
        return RedirectResponse(url="/guides", status_code=303)
    except Exception as e:
        logger.error(f"Error creating guide: {e}")
        raise HTTPException(status_code=500, detail="שגיאה ביצירת רשומה")


@app.get("/guides/{guide_id}/edit", response_class=HTMLResponse)
async def edit_guide_form(request: Request, guide_id: str):
    try:
        guide = GuideDB.get_by_id(guide_id)
        if not guide:
            raise HTTPException(status_code=404, detail="רשומה לא נמצאה")
        return templates.TemplateResponse(
            "guides/form.html", {"request": request, "guide": guide, "action": "edit"}
        )
    except Exception as e:
        logger.error(f"Error fetching guide: {e}")
        raise HTTPException(status_code=500, detail="שגיאה בטעינת הנתונים")


@app.post("/guides/{guide_id}")
async def update_guide(
    guide_id: str,
    fullname: str = Form(...),
    email: str = Form(...),
    phonenumber: str = Form(...),
):
    try:
        GuideDB.update(guide_id, fullname, email, phonenumber)
        return RedirectResponse(url="/guides", status_code=303)
    except Exception as e:
        logger.error(f"Error updating guide: {e}")
        raise HTTPException(status_code=500, detail="שגיאה בעדכון רשומה")


@app.post("/guides/{guide_id}/delete")
async def delete_guide(guide_id: str):
    try:
        GuideDB.delete(guide_id)
        return RedirectResponse(url="/guides", status_code=303)
    except Exception as e:
        logger.error(f"Error deleting guide: {e}")
        raise HTTPException(status_code=500, detail="שגיאה במחיקת רשומה")


@app.get("/queries", response_class=HTMLResponse)
async def queries_page(request: Request):
    return templates.TemplateResponse("queries.html", {"request": request})


@app.get("/trips/new", response_class=HTMLResponse)
async def new_trip_form(request: Request):

    hotels = HotelDB.get_all()
    destinations = DestinationDB.get_all()
    return templates.TemplateResponse(
        "trips/form.html",
        {
            "request": request,
            "hotels": hotels,
            "destinations": destinations,
        },
    )


@app.get("/guides/available", response_class=JSONResponse)
async def available_guides(start: str, end: str):
    guides = TripDB.get_available_guides(start, end)

    return JSONResponse(content=guides)


from typing import Optional


@app.get("/trips", response_class=HTMLResponse)
async def list_trips(request: Request):
    try:
        trips = TripDB.get_all()
        return templates.TemplateResponse(
            "trips/list.html", {"request": request, "trips": trips}
        )
    except Exception as e:
        logger.error(f"Error fetching trips: {e}")
        raise HTTPException(status_code=500, detail="שגיאה בטעינת הטיולים")


@app.post("/trips/form", response_class=HTMLResponse)
async def create_trip(
    request: Request,
    start: str = Form(...),
    end: str = Form(...),
    destinationzip: str = Form(...),
    hotelid: int = Form(...),
    guideid: Optional[str] = Form(None),  # מקבלים string
):
    error = None

    # בדיקת guideid
    if not guideid:
        error = "אנא בחרי מדריך לפני שליחה"

    if error:
        hotels = HotelDB.get_all()
        destinations = DestinationDB.get_all()
        return templates.TemplateResponse(
            "trips/form.html",
            {
                "request": request,
                "hotels": hotels,
                "destinations": destinations,
                "error": error,
            },
        )

    # אחרת – יוצרים טיול ומקצים מדריך
    tripid = TripDB.create(start, end, destinationzip, hotelid, guideid)

    success_message = (
        f"הטיול נוצר בהצלחה! ✅<br>"
        f"מזהה טיול: <b>{tripid}</b><br>"
        f"מתאריך: {start} עד {end}<br>"
        f"יעד: {destinationzip} | מלון: {hotelid} | מדריך: {guideid}"
    )

    return templates.TemplateResponse(
        "index.html", {"request": request, "success": success_message}
    )


@app.post("/queries/customer-actions", response_class=JSONResponse)
async def customer_queries(customer_id: str = Form(...), action: str = Form(...)):
    result = ""

    if action == "payments":
        try:
            total = TripDB.get_total_paid_by_customer(customer_id)
            print(total)

            result = f"💰 סך כל התשלומים של לקוח {customer_id}: <b>{total}</b> ₪"
        except Exception as e:
            result = f"שגיאה בחישוב תשלומים: {str(e)}"

    elif action == "available_trips":
        try:
            trips = TripDB.get_available_trips_for_customer(customer_id)
            if not trips:
                result = "אין טיולים זמינים ללקוח זה."
            else:
                result = "<ul>"
                for t in trips:
                    result += f"<li>🧭 {t['country']} ({t['startdate']} - {t['enddate']}) - {t['availability_level']}</li>"
                result += "</ul>"
        except Exception as e:
            result = f"שגיאה בשליפת טיולים: {str(e)}"

    return JSONResponse(content={"html": result})


@app.post("/queries/general-actions", response_class=HTMLResponse)
async def general_queries(request: Request, action: str = Form(...)):
    result = ""

    try:
        if action == "merge_trips":
            TripDB.merge_small_trips()
            result = "🔀 בוצע איחוד טיולים קטנים בהצלחה."

        elif action == "reassign_guides":
            TripDB.reassign_overloaded_guides()
            result = "🔄 בוצע איזון עומס מדריכים בהצלחה."

    except Exception as e:
        result = f"שגיאה: {str(e)}"

    return templates.TemplateResponse(
        "queries.html", {"request": request, "result": result}
    )


@app.post("/trips/{trip_id}/delete")
async def delete_trip(trip_id: str):
    try:
        TripDB.delete(trip_id)
        return RedirectResponse(url="/trips", status_code=303)
    except Exception as e:
        logger.error(f"שגיאה במחיקת טיול {trip_id}: {e}")
        raise HTTPException(status_code=500, detail="שגיאה במחיקת טיול")


@app.get("/trips/{trip_id}/edit", response_class=HTMLResponse)
async def edit_trip_form(request: Request, trip_id: str):
    try:
        trip = TripDB.get_by_id(trip_id)
        if not trip:
            raise HTTPException(status_code=404, detail="טיול לא נמצא")

        hotels = TripDB.get_available_hotels_for_trip(
            trip["startdate"], trip["enddate"], trip["hotelid"]
        )
        guides = TripDB.get_available_guides_for_trip(
            trip["startdate"], trip["enddate"], trip["guideid"]
        )
        destinations = DestinationDB.get_all()

        return templates.TemplateResponse(
            "trips/form.html",
            {
                "request": request,
                "trip": trip,
                "hotels": hotels,
                "destinations": destinations,
                "guides": guides,
                "action": "edit",
            },
        )

    except Exception as e:
        logger.error(f"Error fetching trip for editing: {e}")
        raise HTTPException(status_code=500, detail="שגיאה בטעינת טופס העריכה")


@app.post("/trips/{trip_id}")
async def update_trip(
    trip_id: str,
    start: str = Form(...),
    end: str = Form(...),
    destinationzip: str = Form(...),
    hotelid: int = Form(...),
    guideid: str = Form(...),
):
    try:
        TripDB.update(trip_id, start, end, destinationzip, hotelid, guideid)
        return RedirectResponse(url="/trips", status_code=303)
    except Exception as e:
        logger.error(f"שגיאה בעדכון טיול {trip_id}: {e}")
        raise HTTPException(status_code=500, detail="שגיאה בעדכון הטיול")


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
