-- This function receives a customer ID and returns the total amount the customer has paid.
-- If the customer does not exist, an exception is raised.
-- In case of any other error, the function returns -1.
CREATE OR REPLACE FUNCTION get_customer_payments_details(customer_id_input VARCHAR)
RETURNS NUMERIC AS $$
DECLARE
    payment_cursor CURSOR FOR SELECT id, totalpay FROM payment WHERE id = customer_id_input;
    pay_rec RECORD; -- בלי TYPE, פשוט RECORD כללי
    total_paid NUMERIC := 0;
    num_payments INTEGER := 0;
BEGIN
    -- בדיקת קיום לקוח
    IF NOT EXISTS (SELECT 1 FROM customer WHERE ID = customer_id_input) THEN
        RAISE EXCEPTION 'Customer with ID % does not exist', customer_id_input;
    END IF;

    -- פתיחת המצביע
    OPEN payment_cursor;
    LOOP
        FETCH payment_cursor INTO pay_rec;
        EXIT WHEN NOT FOUND;
        
        -- סכימה
        total_paid := total_paid + pay_rec.totalpay;
        num_payments := num_payments + 1;

        RAISE NOTICE 'תשלום ID: %, סכום: %', pay_rec.id, pay_rec.totalpay;
    END LOOP;
    CLOSE payment_cursor;

    RAISE NOTICE 'סה"כ תשלומים: %, סה"כ שולם: %', num_payments, total_paid;
    RETURN total_paid;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'שגיאה: %', SQLERRM;
        RETURN -1;
END;
$$ LANGUAGE plpgsql;
