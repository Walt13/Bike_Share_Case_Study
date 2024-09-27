/*
See if there is any difference in days rides are taken between members and
casuals.
*/

SELECT
    member_casual,
    day_of_week,
    EXTRACT(DOW FROM started_at) AS day_num,
    COUNT(ride_id)
FROM
    trips_year
GROUP BY
    member_casual,
    day_of_week,
    EXTRACT(DOW FROM started_at)
ORDER BY
    member_casual,
    day_num;

/*
From the results, casual riders have higher usage on weekends, when compared
to other casual riders. Members have higher usage during the week...while the
numbers do drop on weekends when compared to member rides during the week, the
dropoff is not as much as the casual rider dropoff when comparing their weekend
vs week rides.
*/