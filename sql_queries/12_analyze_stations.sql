
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


