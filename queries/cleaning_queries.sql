# The goal of cleaning data in this project is to create a dashboard that answers the questions of otter sightings:
  
-by year (2014-2024)
-by season (Spring, Summer, Fall, Winter)
-by place (group by area hubs, county, city, coastal area, etc)

# Make a query accessible column for location: 
  
  ALTER TABLE otter_data
ADD COLUMN general_location VARCHAR(255);

# Make a query accessible column that includes season and year:

ALTER TABLE otter_data
ADD COLUMN season_year VARCHAR(50)

# Convert observed_on column data to "Season, Year" data in the season_year column

UPDATE otter_data
SET season_year = 
    CASE 
        WHEN EXTRACT(MONTH FROM observed_on) IN (12, 1, 2) THEN 
            'Winter ' || EXTRACT(YEAR FROM observed_on)
        WHEN EXTRACT(MONTH FROM observed_on) IN (3, 4, 5) THEN 
            'Spring ' || EXTRACT(YEAR FROM observed_on)
        WHEN EXTRACT(MONTH FROM observed_on) IN (6, 7, 8) THEN 
            'Summer ' || EXTRACT(YEAR FROM observed_on)
        WHEN EXTRACT(MONTH FROM observed_on) IN (9, 10, 11) THEN 
            'Fall ' || EXTRACT(YEAR FROM observed_on)
    END;

# Initial findings for "What are the top three seasons of which years have the most otter sightings?"

SELECT season_year, COUNT(*)
FROM otter_data
GROUP BY season_year
ORDER BY COUNT DESC
  LIMIT 3;

Output
"Fall, 2022"	40
"Spring, 2023"	38
"Fall, 2021"	36

