-- This function receives a customer ID and returns the total amount the customer has paid.
-- If the customer does not exist, an exception is raised.
-- In case of any other error, the function returns -1.
CREATE OR REPLACE FUNCTION get_total_paid_by_customer(customer_id_input VARCHAR)
RETURNS NUMERIC AS $$
DECLARE
    total_paid NUMERIC := 0;
BEGIN

    IF NOT EXISTS (SELECT 1 FROM customer WHERE ID = customer_id_input) THEN
        RAISE EXCEPTION 'Customer with ID % does not exist', customer_id_input;
    END IF;

   
    SELECT COALESCE(SUM(p.totalpay), 0)
    INTO total_paid
    FROM payment p
    WHERE p.id = customer_id_input;

    RETURN total_paid;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'An error occurred: %', SQLERRM;
        RETURN -1;
END;
$$ LANGUAGE plpgsql;
