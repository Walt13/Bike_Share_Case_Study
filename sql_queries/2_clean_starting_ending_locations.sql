-- How many records do not have a starting and/or ending station?
SELECT
    COUNT(ride_id)
FROM trips_year
WHERE
    start_station_name IS NULL AND
    start_station_id IS NULL;
-- 932,980

SELECT
    COUNT(ride_id)
FROM trips_year
WHERE
    end_station_name IS NULL OR
    end_station_id IS NULL;
-- 980,476


SELECT
    COUNT(ride_id)
FROM trips_year
WHERE
    (start_station_name IS NULL AND
    start_station_id IS NULL) OR
    (end_station_name IS NULL AND
    end_station_id IS NULL);
-- 1,459,837 records do not have a starting or ending station.

-- Getting more info on the records that have NULL start/end stations
SELECT
    ride_id,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_long,
    end_lat,
    end_lng
FROM trips_year
WHERE
    (start_station_name IS NULL AND
    start_station_id IS NULL) OR
    (end_station_name IS NULL AND
    end_station_id IS NULL)
ORDER BY
    started_at DESC;

/*
Most of the records that have NULL start or end station names/ids do have 
latitude and longitude info. Normally, I would clarify with Divvy why there
might be blank station names and ids, but for this case study, I will be changing
the NULL station names and ids to "Not At Station" as long as there is
latitude and longitude info.
*/

-- Finding records with NULL start_station name and id, but do have lat and long
SELECT
    *
FROM trips_year
WHERE
    (start_station_name IS NULL AND
    start_station_id IS NULL) AND
    (start_lat IS NOT NULL AND
    start_long IS NOT NULL);
-- 932,980

-- Updating start_station_name
UPDATE
    trips_year
SET
    start_station_name = 'Not At Station'
WHERE
    (start_station_name IS NULL AND
    start_station_id IS NULL) AND
    (start_lat IS NOT NULL AND
    start_long IS NOT NULL);
-- 932980 rows affected

--Update the start_station_id
SELECT
    *
FROM trips_year
WHERE
    (start_station_name = 'Not At Station' AND
    start_station_id IS NULL) AND
    (start_lat IS NOT NULL AND
    start_long IS NOT NULL);

UPDATE
    trips_year
SET
    start_station_id = 'Not At Station'
WHERE
    (start_station_name = 'Not At Station' AND
    start_station_id IS NULL) AND
    (start_lat IS NOT NULL AND
    start_long IS NOT NULL);
-- 932980 rows affected

-- Checking to make sure the columns were updated.
SELECT
    *
FROM trips_year
WHERE
    (start_station_name = 'Not At Station' AND
    start_station_id = 'Not At Station') AND
    (start_lat IS NOT NULL AND
    start_long IS NOT NULL);


-- Finding records with NULL end_station name and id, but do have lat and long
SELECT
    *
FROM trips_year
WHERE
    (end_station_name IS NULL AND
    end_station_id IS NULL) AND
    (end_lat IS NOT NULL AND
    end_lng IS NOT NULL);
-- 972,703

UPDATE
    trips_year
SET
    end_station_name = 'Not At Station',
    end_station_id = 'Not At Station'
WHERE
    (end_station_name IS NULL AND
    end_station_id IS NULL) AND
    (end_lat IS NOT NULL AND
    end_lng IS NOT NULL);

-- Checking to make sure the columns were updated
SELECT
    *
FROM trips_year
WHERE
    (end_station_name = 'Not At Station' AND
    end_station_id = 'Not At Station') AND
    (end_lat IS NOT NULL AND
    end_lng IS NOT NULL);


-- How many records have NULL stations name and id and NULL lat/long?
SELECT *
FROM trips_year
WHERE
    (start_station_name IS NULL AND
    start_station_id IS NULL) AND
    (start_lat IS NULL AND
    start_long IS NULL);
-- None

SELECT
    *
FROM trips_year
WHERE
    (end_station_name IS NULL AND
    end_station_id IS NULL) AND
    (end_lat IS NULL AND
    end_lng IS NULL);
/*
7,773 records do not have end station names or ids, and also do not have end
latitude and longitude info. Again, if I was actually working with Divvy I would
dig more into this, but for this case study, I will be removing these records.
*/

DELETE FROM
    trips_year
WHERE
    (end_station_name IS NULL AND
    end_station_id IS NULL) AND
    (end_lat IS NULL AND
    end_lng IS NULL);


