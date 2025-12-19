CREATE OR REPLACE VIEW weather_temperature_trend_by_city AS
SELECT
    date,
    city,
    AVG(temperature_c)        AS avg_temperature_c,
    
FROM weather_pipeline_refined_vincent
GROUP BY date, city;