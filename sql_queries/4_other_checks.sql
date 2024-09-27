-- Confirming that there are only 3 rideable types: classic, docked and electric.
SELECT
    rideable_type,
    COUNT(rideable_type)
FROM
    trips_year
GROUP BY
    rideable_type;

-- Confirming that there are only 2 member types:  member and casual.
SELECT
    member_casual,
    COUNT(member_casual)
FROM
    trips_year
GROUP BY
    member_casual;

-- Make sure no NULL star times
SELECT
    *
FROM
    trips_year
WHERE
    started_at IS NULL;

-- Make sure no NULL ending times
SELECT
    *
FROM
    trips_year
WHERE
    ended_at IS NULL;
