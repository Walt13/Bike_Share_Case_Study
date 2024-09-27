
-- Find rides that were less than a minute
SELECT
    started_at,
    ended_at,
    ended_at - started_at AS ride_length
FROM
    trips_year
WHERE
    ended_at - started_at < '1 minute';
-- Found 134,983 rides that were under a minute.

-- Find rides that were over a day long
SELECT
    started_at,
    ended_at,
    ended_at - started_at AS ride_length
FROM
    trips_year
WHERE
    ended_at - started_at > '24 hours'
ORDER BY
    ride_length DESC;
-- Found 393 rides that were over 24 hours.

/*
Going to remove all the rides that were under a minute, and rides that were
over 1 day. It's possible that the rides under 1 minute were users having
trouble docking/undocking their bikes or having other issues starting their
rides? Again, if I were actually working with Divvy, this would be something to
dig more into.
*/

DELETE FROM
    trips_year
WHERE
    ended_at - started_at < '1 minute';

DELETE FROM
    trips_year
WHERE
    ended_at - started_at > '24 hours';

-- Still looking for outliers...how many rides over 8 hours?
SELECT
    started_at,
    ended_at,
    ended_at - started_at AS ride_length
FROM
    trips_year
WHERE
    ended_at - started_at > '8 hours'
ORDER BY
    ride_length DESC;
-- Found 4190 rides that were over 8 hours.

/*
If I was actually working with Divvy, I would work more with them to find out
what a good cutoff time would be for these outliers. The rides over 8 hours 
could possibly be bikes that had not been correctly docked, technical issues
when docking bikes, etc. Going to remove these 4190 records (out of a total
of more that 5.5 million records) as well.
*/

DELETE FROM
    trips_year
WHERE
    ended_at - started_at > '8 hours';


-- Add a ride_length column since it would be useful to run calculations on it
-- Add the column
ALTER TABLE
    trips_year
ADD
    ride_length INTERVAL;

-- Calculate the ride length and update the table
UPDATE
    trips_year
SET
    ride_length = ended_at - started_at;

-- Check to see that the new column looks OK.
SELECT *
FROM trips_year
LIMIT 50;

/*
Might be useful to also have the ride_length in number of minutes in addition to
interval, which shows hours, minutes, seconds separately.
*/
SELECT
    ride_length,
    (EXTRACT(epoch FROM ride_length)/60)::numeric(6,2) AS ride_length_minutes
FROM
    trips_year
LIMIT 500;

-- Add the column
ALTER TABLE
    trips_year
ADD
    ride_length_minutes NUMERIC(6,2);

-- Add the data to the column
UPDATE
    trips_year
SET
    ride_length_minutes = (EXTRACT(epoch FROM ride_length)/60)::numeric(6,2);

-- Check the results
SELECT
    ride_length,
    ride_length_minutes
FROM
    trips_year
LIMIT 500;