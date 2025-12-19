CREATE OR REPLACE VIEW weather_city_comparison AS
SELECT
    city,
    AVG(temperature_c)        AS avg_temperature_c,
    MIN(temperature_c)        AS min_temperature_c,
    MAX(temperature_c)        AS max_temperature_c,
    AVG(humidity)             AS avg_humidity,
    AVG(wind_kmh)             AS avg_wind_kmh,
    SUM(precipitation_mm)     AS total_precipitation_mm,
    COUNT(DISTINCT date)      AS nb_days
FROM weather_pipeline_refined_vincent
GROUP BY city;
