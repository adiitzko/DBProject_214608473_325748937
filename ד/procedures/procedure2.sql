-- Procedure: reassign_overloaded_guides

-- Description:
-- This procedure identifies overloaded guides who have at least 
-- 3 future trips starting within a 40-day period. 
-- To balance guide workloads, the procedure searches for an alternative guide 
-- who has no trips scheduled within the same time window.
-- If found, the third trip in the overloaded window is reassigned to that alternative guide.
-- Only one reassignment is performed per procedure call for demonstration purposes.
-- The procedure outputs a message using RAISE NOTICE when a reassignment is made.

CREATE OR REPLACE PROCEDURE reassign_overloaded_guides()
LANGUAGE plpgsql
AS $$
DECLARE
    g RECORD;
    t1 RECORD;
    t2 RECORD;
    t3 RECORD;
    alt_guide RECORD;
BEGIN
    -- Loop through all guides with at least 3 upcoming trips
    FOR g IN (
        SELECT guideID
        FROM trip
        WHERE startDate > CURRENT_DATE
        GROUP BY guideID
        HAVING COUNT(*) >= 3
    )
    LOOP
        -- Get the first three upcoming trips for the guide
        SELECT * INTO t1
        FROM trip
        WHERE guideID = g.guideID AND startDate > CURRENT_DATE
        ORDER BY startDate
        LIMIT 1 OFFSET 0;

        SELECT * INTO t2
        FROM trip
        WHERE guideID = g.guideID AND startDate > CURRENT_DATE
        ORDER BY startDate
        LIMIT 1 OFFSET 1;

        SELECT * INTO t3
        FROM trip
        WHERE guideID = g.guideID AND startDate > CURRENT_DATE
        ORDER BY startDate
        LIMIT 1 OFFSET 2;

        -- Check if the third trip is within 40 days from the first
        IF t3.startDate <= t1.startDate + INTERVAL '40 days' THEN

            -- Look for an alternative guide with no trips in that time window
            SELECT p.id INTO alt_guide
            FROM person p
            WHERE p.id NOT IN (
                SELECT guideID FROM trip
                WHERE startDate BETWEEN t1.startDate AND t1.startDate + INTERVAL '40 days'
            )
            AND p.id <> g.guideID
            LIMIT 1;

            IF FOUND THEN
                -- Reassign the third trip to the alternative guide
                UPDATE trip
                SET guideID = alt_guide.id
                WHERE tripID = t3.tripID;

                RAISE NOTICE 'Guide % is overloaded. Trip % reassigned to guide %',
                    g.guideID, t3.tripID, alt_guide.id;

                EXIT; -- stop after one reassignment for demonstration
            END IF;
        END IF;
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error: %', SQLERRM;
END;
$$;
