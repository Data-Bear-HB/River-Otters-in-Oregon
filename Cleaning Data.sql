# The Goal of cleaning data in this project is to create a dashboard that answers the questions of otter sightings
-by year (2014-2024)
-by season (Spring, Summer, Fall, Winter)
-by place (group by area hubs, county, city, coastal area, etc)

# 1. Make an easy to query column for location

  ALTER TABLE otter_data
ADD COLUMN general_location VARCHAR(255);

# 2. Make an easy to search column that includes season, year

ALTER TABLE otter_data
ADD COLUMN season_year VARCHAR(50)

#Convert observed_on column data to "Season, Year" data in the season_year column

UPDATE otter_data
SET season_year = 
    CASE 
        WHEN EXTRACT(MONTH FROM observed_on) IN (12, 1, 2) THEN 
            'Winter ' EXTRACT(YEAR FROM observed_on)
        WHEN EXTRACT(MONTH FROM observed_on) IN (3, 4, 5) THEN 
            'Spring ' || EXTRACT(YEAR FROM observed_on)
        WHEN EXTRACT(MONTH FROM observed_on) IN (6, 7, 8) THEN 
            'Summer ' || EXTRACT(YEAR FROM observed_on)
        WHEN EXTRACT(MONTH FROM observed_on) IN (9, 10, 11) THEN 
            'Fall ' || EXTRACT(YEAR FROM observed_on)
    END;

