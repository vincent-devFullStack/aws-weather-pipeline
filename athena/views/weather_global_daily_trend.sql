CREATE OR REPLACE VIEW weather_global_daily_trend AS
SELECT
    date,
    AVG(temperature_c)        AS avg_temperature_c,
    AVG(humidity)             AS avg_humidity,
    AVG(wind_kmh)             AS avg_wind_kmh,
    SUM(precipitation_mm)     AS total_precipitation_mm
FROM weather_pipeline_refined_vincent
GROUP BY date
ORDER BY date;
