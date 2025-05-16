CREATE OR REPLACE PROCEDURE main_program_1()
LANGUAGE plpgsql
AS $$
DECLARE
    total_paid NUMERIC;
BEGIN
    -- Step 1: Check total payment of a specific customer
    SELECT get_total_paid_by_customer('C001') INTO total_paid;
    RAISE NOTICE 'Customer C001 has paid a total of: %₪', total_paid;

    -- Step 2: Merge small trips
    CALL merge_small_trips();

    RAISE NOTICE 'Small trips merge operation completed.';
END;
$$;
