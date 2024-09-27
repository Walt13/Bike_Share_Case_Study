
-- Get a quick look at the database again
SELECT *
FROM trips_year
ORDER BY
    started_at ASC
LIMIT 500;

-- Get a count of the number of records in the full year database
SELECT
    COUNT(ride_id)
FROM trips_year;
-- returns 5,734,381 records

-- Make sure that all of the ride_id's are unique
SELECT
    COUNT(DISTINCT ride_id)
FROM trips_year;
-- returns 5,734,170...looks like a few duplicates...211 to be exact.

-- Find out which ride_id's are the duplicates
SELECT
    ride_id,
    COUNT(ride_id)
FROM trips_year
GROUP BY ride_id
HAVING
    COUNT(ride_id) > 1;
-- Found the 211 duplicates

-- Display all the info on the duplicates...used the previous query as a subquery
SELECT *
FROM trips_year
WHERE
    ride_id IN (
        SELECT
            ride_id
        FROM trips_year
        GROUP BY ride_id
        HAVING
            COUNT(ride_id) > 1
    )
ORDER BY
    ride_id;

/*
Found that for each pair of duplicated ride_id's, one of the rows will have either
a starting or ending time with milliseconds, while the other does not. All of the
info in the other fields match up for each pair of duplicates. Going to remove
the records that do not have milliseconds.
*/

-- Playing around with ways to differentiate the rows with milliseconds
SELECT
    *,
    EXTRACT(MILLISECOND FROM ended_at) AS extract_mili,
    EXTRACT(MILLISECOND FROM ended_at) % 1000 AS extract_mod,
    EXTRACT(SECOND FROM ended_at) AS extract_second,
    DATE_PART('milliseconds', ended_at) AS date_part_milli
FROM trips_year
WHERE
    ride_id = '2F9BC5B5C50E3E3C';


--  Query to only select the duplicated records without milliseconds
SELECT
    ride_id,
    started_at,
    ended_at,
    EXTRACT(MILLISECOND FROM started_at) % 1000 AS extract_started_mod,
    EXTRACT(MILLISECOND FROM ended_at) % 1000 AS extract_ended_mod
FROM trips_year
WHERE
    ride_id IN (
        SELECT
            ride_id
        FROM trips_year
        GROUP BY ride_id
        HAVING
            COUNT(ride_id) > 1
    ) AND
    (EXTRACT(MILLISECOND FROM started_at) % 1000 = 0 AND
    EXTRACT(MILLISECOND FROM ended_at) % 1000 = 0)
ORDER BY
    ride_id;


-- Deleting the records

DELETE FROM trips_year
WHERE
    ride_id IN (
        SELECT
            ride_id
        FROM trips_year
        GROUP BY ride_id
        HAVING
            COUNT(ride_id) > 1
    ) AND
    (EXTRACT(MILLISECOND FROM started_at) % 1000 = 0 AND
    EXTRACT(MILLISECOND FROM ended_at) % 1000 = 0)
RETURNING
    ride_id;


-- Once deleted, confirmed that there are no more duplicate ride_id's.
SELECT
    COUNT(ride_id)
FROM trips_year;

SELECT
    COUNT(DISTINCT ride_id)
FROM trips_year;
-- Counts match up now.