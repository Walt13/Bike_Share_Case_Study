/*
See if there is a difference in the hour rides are started between members
and casuals
*/

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