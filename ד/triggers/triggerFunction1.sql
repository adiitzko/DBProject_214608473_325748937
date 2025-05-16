CREATE OR REPLACE FUNCTION check_totalpay()
RETURNS trigger AS $$
BEGIN
    IF NEW.totalpay <= 0 THEN
        RAISE EXCEPTION 'Payment must be positive!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
