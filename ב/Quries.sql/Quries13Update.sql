//עידכון מחירי חברות התעופה בעשר אחוז יותר
CREATE OR REPLACE FUNCTION update_flight_prices()
RETURNS VOID AS $$
BEGIN
    UPDATE flight
    SET price = price * 1.10;
END;
$$ LANGUAGE plpgsql;
