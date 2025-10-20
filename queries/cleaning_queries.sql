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

After a series of individual record look-ups of latitude and longitude (in google maps) to co-align place_guess with general_location, for example, many queries that looked like this:
  
SELECT DISTINCT id, general_location, place_guess, latitude, longitude
FROM otter_data
WHERE place_guess ILIKE '%cully%';

After confirming the location of each individual record with google maps (using the latitude and longitude), I updated the general_location to a simpler catagory, like 'Whitaker Ponds, Portland' or 'Sellwood Oaksbottom Portland'

UPDATE otter_data 
SET general_location = 'Whitaker Ponds, Portland'  
WHERE id = '31642242' OR id = '47979780'  OR id = '69243000' OR id = '140937824';

I included multipe 'tags' in the naming of these catagories so a user could search by 'Portland' or 'Pond'

(INSERT HERE: LIST OF TAGS or general_location catagories: 
'Sellwood Oaksbottom Portland'

After a few hundred records were updated using
  I started using the larger scope of latitude and longitude  within these two catagories to see what records I have missed that had too general of a place_guess note
  
SELECT DISTINCT id, general_location, place_guess, latitude, longitude
FROM otter_data
WHERE latitude BETWEEN 45.56 AND 46.0 
AND longitude BETWEEN -122.7 AND -122.5
ORDER BY longitude;

