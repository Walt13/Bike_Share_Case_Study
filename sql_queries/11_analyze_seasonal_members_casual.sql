-- Are there differences in months rides are taken?

SELECT
    member_casual,
    EXTRACT(MONTH FROM started_at) AS month_num,
    CASE
        WHEN EXTRACT(MONTH FROM started_at) = 1 THEN 'January'
        WHEN EXTRACT(MONTH FROM started_at) = 2 THEN 'February'
        WHEN EXTRACT(MONTH FROM started_at) = 3 THEN 'March'
        WHEN EXTRACT(MONTH FROM started_at) = 4 THEN 'April'
        WHEN EXTRACT(MONTH FROM started_at) = 5 THEN 'May'
        WHEN EXTRACT(MONTH FROM started_at) = 6 THEN 'June'
        WHEN EXTRACT(MONTH FROM started_at) = 7 THEN 'July'
        WHEN EXTRACT(MONTH FROM started_at) = 8 THEN 'August'
        WHEN EXTRACT(MONTH FROM started_at) = 9 THEN 'September'
        WHEN EXTRACT(MONTH FROM started_at) = 10 THEN 'October'
        WHEN EXTRACT(MONTH FROM started_at) = 11 THEN 'November'
        WHEN EXTRACT(MONTH FROM started_at) = 12 THEN 'December'
    END AS month_desc,
    COUNT(member_casual)
FROM
    trips_year
GROUP BY
    member_casual,
    month_num
ORDER BY
    member_casual,
    month_num;