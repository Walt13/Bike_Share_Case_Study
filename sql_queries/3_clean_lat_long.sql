
-- Looking for NULL start lat and longs
SELECT *
FROM trips_year
WHERE
    start_lat IS NULL OR
    start_long IS NULL;
-- No records

-- Looking for NULL end lat and longs
SELECT *
FROM trips_year
WHERE
    end_lat IS NULL OR
    end_lng IS NULL;
-- 106 records

-- These 106 records do have end_station names and ids. What stations are they?
SELECT
    end_station_name,
    COUNT(end_station_id)
FROM trips_year
WHERE
    end_lat IS NULL OR
    end_lng IS NULL
GROUP BY
    end_station_name
ORDER BY
    COUNT(end_station_id) DESC;
/*
These are the five stations that appear.
- Halsted St & Fulton St 59 times
- Elizabeth St & Randolph St 25 times
- Lincoln Ave & Byron St 11 times
- Stony Island Ave & 63rd St 6 times
- Drexel Ave & 60th St 5 times
*/


SELECT
    end_station_name,
    end_lat,
    end_lng
FROM
    trips_year
WHERE
    end_station_name = 'Halsted St & Fulton St'
ORDER BY
    end_lat DESC;
/*
In other entries for Halsted St & Fulton St, there are lat and lng listed...
...(41.886871, -84.648089)
*/


-- For Elizabeth St & Randolph St
SELECT
    end_station_name,
    end_lat,
    end_lng
FROM
    trips_year
WHERE
    end_station_name = 'Elizabeth St & Randolph St'
ORDER BY
    end_lat DESC;
-- (41.884336, -87.658902)


-- For Lincoln Ave & Byron St
SELECT
    end_station_name,
    end_lat,
    end_lng
FROM
    trips_year
WHERE
    end_station_name = 'Lincoln Ave & Byron St'
ORDER BY
    end_lat DESC;
-- (41.952372, -87.677296)


-- For Stony Island Ave & 63rd St
SELECT
    end_station_name,
    end_lat,
    end_lng
FROM
    trips_year
WHERE
    end_station_name = 'Stony Island Ave & 63rd St'
ORDER BY
    end_lat DESC;
-- (41.780506, -87.586853) Also found one where lat/long were listed as 0/0


-- For Drexel Ave & 60th St
SELECT
    end_station_name,
    end_lat,
    end_lng
FROM
    trips_year
WHERE
    end_station_name = 'Drexel Ave & 60th St'
ORDER BY
    end_lat DESC;
-- (41.785861, -87.604553)

/* 
If I were actually working for/with Divvy, I would inquire as to why these end
lat/longs are missing. Could have just been a technical issue? Since I was able
to find the lat/long of the stations from the other records, going to update
the NULL records with the correct values.
*/

-- Update entries for Halsted St & Fulton St (41.886871, -84.648089)
UPDATE
    trips_year
SET
    end_lat = 41.886871,
    end_lng = -84.648089
WHERE
    end_station_name = 'Halsted St & Fulton St' AND
    (end_lat IS NULL AND end_lng IS NULL);
-- Checking to make sure records were updated.
SELECT *
FROM trips_year
WHERE
    end_station_name = 'Halsted St & Fulton St' AND
    (end_lat IS NULL AND end_lng IS NULL)


-- Update entries for Elizabeth St & Randolph St (41.884336, -87.658902)
UPDATE
    trips_year
SET
    end_lat = 41.884336,
    end_lng = -87.658902
WHERE
    end_station_name = 'Elizabeth St & Randolph St' AND
    (end_lat IS NULL AND end_lng IS NULL);
-- Checking to make sure records were updated.
SELECT *
FROM trips_year
WHERE
    end_station_name = 'Elizabeth St & Randolph St' AND
    (end_lat IS NULL AND end_lng IS NULL)


-- Update entries for Lincoln Ave & Byron St (41.952372, -87.677296)
UPDATE
    trips_year
SET
    end_lat = 41.952372,
    end_lng = -87.677296
WHERE
    end_station_name = 'Lincoln Ave & Byron St' AND
    (end_lat IS NULL AND end_lng IS NULL);
-- Checking to make sure records were updated.
SELECT *
FROM trips_year
WHERE
    end_station_name = 'Lincoln Ave & Byron St' AND
    (end_lat IS NULL AND end_lng IS NULL)


-- Update entries for Stony Island Ave & 63rd St (41.780506, -87.586853)
UPDATE
    trips_year
SET
    end_lat = 41.780506,
    end_lng = -87.586853
WHERE
    end_station_name = 'Stony Island Ave & 63rd St' AND
    (end_lat IS NULL AND end_lng IS NULL);
-- Checking to make sure records were updated.
SELECT *
FROM trips_year
WHERE
    end_station_name = 'Stony Island Ave & 63rd St' AND
    (end_lat IS NULL AND end_lng IS NULL)
-- Also updating the record where lat and long were 0
UPDATE
    trips_year
SET
    end_lat = 41.780506,
    end_lng = -87.586853
WHERE
    end_station_name = 'Stony Island Ave & 63rd St' AND
    (end_lat = 0 AND end_lng = 0);
-- Checking to make sure records were updated.
SELECT *
FROM trips_year
WHERE
    end_station_name = 'Stony Island Ave & 63rd St' AND
    (end_lat = 0 AND end_lng = 0);


-- Update entries for Drexel Ave & 60th St (41.785861, -87.604553)
UPDATE
    trips_year
SET
    end_lat = 41.785861,
    end_lng = -87.604553
WHERE
    end_station_name = 'Drexel Ave & 60th St' AND
    (end_lat IS NULL AND end_lng IS NULL);
-- Checking to make sure records were updated.
SELECT *
FROM trips_year
WHERE
    end_station_name = 'Drexel Ave & 60th St' AND
    (end_lat IS NULL AND end_lng IS NULL);



-- Looking for more records where lat/long are 0
SELECT *
FROM trips_year
WHERE
    end_lat = 0 OR
    end_lng = 0;
-- No records found 

SELECT *
FROM trips_year
WHERE
    start_lat = 0 OR
    start_long = 0;
-- No records found