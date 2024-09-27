-- Going to make a new column that shows the day of the week that the ride started.
-- Extract day of week from the started at date.
SELECT
    started_at,
    EXTRACT (DOW FROM started_at) AS day_of_week_num,
    CASE
        WHEN EXTRACT (DOW FROM started_at) = 0 THEN 'Sunday'
        WHEN EXTRACT (DOW FROM started_at) = 1 THEN 'Monday'
        WHEN EXTRACT (DOW FROM started_at) = 2 THEN 'Tuesday'
        WHEN EXTRACT (DOW FROM started_at) = 3 THEN 'Wednesday'
        WHEN EXTRACT (DOW FROM started_at) = 4 THEN 'Thursday'
        WHEN EXTRACT (DOW FROM started_at) = 5 THEN 'Friday'
        WHEN EXTRACT (DOW FROM started_at) = 6 THEN 'Saturday'
    END AS day_of_week
FROM
    trips_year
LIMIT 500;
-- Sunday = 0, Monday = 1, etc.

-- Add the day of week column
ALTER TABLE
    trips_year
ADD
    day_of_week VARCHAR;

-- Update the column with the data
UPDATE
    trips_year
SET
    day_of_week = CASE
                    WHEN EXTRACT (DOW FROM started_at) = 0 THEN 'Sunday'
                    WHEN EXTRACT (DOW FROM started_at) = 1 THEN 'Monday'
                    WHEN EXTRACT (DOW FROM started_at) = 2 THEN 'Tuesday'
                    WHEN EXTRACT (DOW FROM started_at) = 3 THEN 'Wednesday'
                    WHEN EXTRACT (DOW FROM started_at) = 4 THEN 'Thursday'
                    WHEN EXTRACT (DOW FROM started_at) = 5 THEN 'Friday'
                    WHEN EXTRACT (DOW FROM started_at) = 6 THEN 'Saturday'
                END;

-- Spot checks to see that the data was added correctly
SELECT
    *
FROM trips_year
LIMIT 500;

SELECT *
FROM
    trips_year
WHERE
    day_of_week != 'Monday' AND
    day_of_week != 'Tuesday' AND
    day_of_week != 'Wednesday' AND
    day_of_week != 'Thursday' AND
    day_of_week != 'Friday' AND
    day_of_week != 'Saturday' AND
    day_of_week != 'Sunday';

