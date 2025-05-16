CREATE OR REPLACE FUNCTION validate_trip_dates()
RETURNS trigger AS $$
BEGIN
    IF NEW.endDate < NEW.startDate THEN
        RAISE EXCEPTION 'Trip end date (%) cannot be before start date (%)',
            NEW.endDate, NEW.startDate;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
