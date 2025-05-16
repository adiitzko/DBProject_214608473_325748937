CREATE TRIGGER trigger_validate_trip_dates
BEFORE INSERT ON trip
FOR EACH ROW
EXECUTE FUNCTION validate_trip_dates();
