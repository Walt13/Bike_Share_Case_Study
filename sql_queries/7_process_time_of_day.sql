/*
Might be good to categorize the start times by time of day. May be able to
perform some analysis by time of day.
*/

-- Making sure I can extract the hour from the start time
SELECT
    started_at,
    EXTRACT(HOUR FROM started_at) AS start_hour
FROM
    trips_year
LIMIT 500;

-- How many rides started at each hour?
SELECT
    EXTRACT(HOUR FROM started_at) AS start_hour,
    COUNT(EXTRACT(HOUR FROM started_at))
FROM
    trips_year
GROUP BY
    EXTRACT(HOUR FROM started_at)
ORDER BY
    EXTRACT(HOUR FROM started_at);
-- Note, saved screenshot in Assets folder (count_rides_started_by_hour.png)
    
-- Adding start_hour column to the spreadsheet
ALTER TABLE
    trips_year
ADD
    start_hour INTEGER;

-- Extracting the hour from started_at and adding to the start_hour column
UPDATE
    trips_year
SET start_hour = EXTRACT(HOUR FROM started_at);


-- Checking to make sure the new column works and splitting members and casuals
SELECT
    member_casual,
    start_hour,
    COUNT(start_hour)
FROM
    trips_year
GROUP BY
    member_casual,
    start_hour
ORDER BY
    member_casual,
    start_hour;


-- Seeing if I might want to add categories for certain hours
SELECT
    EXTRACT(HOUR FROM started_at) AS hour,
    CASE
        WHEN EXTRACT(HOUR FROM started_at) BETWEEN 0 AND 4 THEN 'Past Midnight'
        WHEN EXTRACT(HOUR FROM started_at) BETWEEN 5 AND 7 THEN 'Early Morning'
        WHEN EXTRACT(HOUR FROM started_at) BETWEEN 8 AND 11 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM started_at) BETWEEN 12 AND 14 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM started_at) BETWEEN 15 AND 17 THEN 'Late Afternoon'
        WHEN EXTRACT(HOUR FROM started_at) BETWEEN 18 AND 20 THEN 'Early Evening'
        WHEN EXTRACT(HOUR FROM started_at) BETWEEN 21 AND 23 THEN 'Night'
    END AS hour_cat
FROM
    trips_year
LIMIT 500;

SELECT *
FROM trips_year
LIMIT 500;