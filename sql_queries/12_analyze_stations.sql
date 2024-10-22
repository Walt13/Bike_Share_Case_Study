
-- See what the top stations are for members vs casuals
SELECT
    member_casual,
    start_station_name,
    COUNT(start_station_name) AS count_station
FROM
    trips_year
WHERE
    start_station_name != 'Not At Station'
GROUP BY
    member_casual,
    start_station_name
ORDER BY
    member_casual,
    count_station DESC;


-- Top stations just for casual riders
SELECT
    start_station_name,
    COUNT(start_station_name) AS count_station
FROM
    trips_year
WHERE
    start_station_name != 'Not At Station' AND
    member_casual = 'casual'
GROUP BY
    start_station_name
ORDER BY
    count_station DESC
LIMIT 10;


-- Top stations for members
SELECT
    start_station_name,
    COUNT(start_station_name) AS count_station
FROM
    trips_year
WHERE
    start_station_name != 'Not At Station' AND
    member_casual = 'member'
GROUP BY
    start_station_name
ORDER BY
    count_station DESC
LIMIT 10;