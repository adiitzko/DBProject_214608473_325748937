CREATE OR REPLACE PROCEDURE main_program_2()
LANGUAGE plpgsql
AS $$
DECLARE
    my_cursor REFCURSOR := 'my_cursorr';  
    trip_rec RECORD;
BEGIN
    -- Step 1: Call function and pass cursor name
    PERFORM get_available_trips_for_customer('C001', my_cursor);

    -- Step 2: Loop through results
    LOOP
        FETCH my_cursor INTO trip_rec;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Trip: ID=%, Start=%', trip_rec.tripid, trip_rec.startdate;
    END LOOP;

    -- Step 3: Close cursor
    CLOSE my_cursor;

    -- Step 4: Call procedure
    CALL reassign_overloaded_guides();

    RAISE NOTICE 'Completed main program 2.';
END;
$$;
