-- What is the average ride length for all riders?
SELECT
    AVG(ride_length_minutes)
FROM
    trips_year;
-- 15.17 minutes for all riders

-- Average ride length for casuals
SELECT
    AVG(ride_length_minutes)
FROM
    trips_year
WHERE
    member_casual = 'casual';
-- 20.41 minutes for casuals

-- Average ride length for members
SELECT
    AVG(ride_length_minutes)
FROM
    trips_year
WHERE
    member_casual = 'member';
-- 12.28 minutes for members

-- Putting the member and casual average into one query
SELECT
    member_casual,
    AVG(ride_length_minutes) AS ride_minutes
FROM
    trips_year
GROUP BY
    member_casual;

-- Break it down more by looking at average ride length by day of week
SELECT
    member_casual,
    day_of_week,
    EXTRACT(DOW FROM started_at) AS day_num,
    AVG(ride_length_minutes) AS ride_minutes
FROM
    trips_year
GROUP BY
    member_casual,
    day_of_week,
    EXTRACT(DOW FROM started_at)
ORDER BY
    member_casual,
    day_num;
