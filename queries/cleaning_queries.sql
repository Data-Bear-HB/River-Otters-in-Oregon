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

Next, I started looking for catagories of locations, for instance 'Whitaker Ponds' or 'Columbia River'. 

SELECT place_guess, COUNT(*) AS count
FROM otter_data
WHERE place_guess IS NOT NULL
GROUP BY place_guess
ORDER BY count DESC;
  
Through this query, I initially searched for what showed up many times in place_guess.
  
SELECT id, general_location, place_guess, latitude, longitude
FROM otter_data
WHERE place_guess ILIKE '%cully%';

After confirming the location of each individual record with google maps (using the latitude and longitude), I updated the general_location to a simpler catagory, like 'Whitaker Ponds, Portland' or 'Sellwood Oaksbottom Portland' using this query:

UPDATE otter_data 
SET general_location = 'Whitaker Ponds, Portland'  
WHERE id = '31642242' OR id = '47979780'  OR id = '69243000' OR id = '140937824';

NOTES:
  -I included multiple 'tags' in the naming of these catagories so a user could search by key words like 'Portland' or 'coast' or 'Slough'
  -occasionally the record location wasn't close to anything else on the map so I had to catagorize by county.

(INSERT HERE: LIST OF TAGS or general_location catagories: 
'Ashland'
'Brookings'
'Broughton Beach Portland Airport'
'Camp Westwind Otis'
'Columbia River Hayden Island'
'Columbia Sauvie Island near Sturgeon Lake'
'Columbia Slough near Heron Lakes Golf Course'
'Coos Bay'
'Coos County Oregon Coast'
'Curry Country Oregon Coast'
'Curry County'
'Dallas'
'Depoe Bay'
'Deschutes County'
'Deschutes County Smith Rock'
'Deschutes River meets Columbia River Wasco'
'Devils Lake Lincoln City'
'Diamond Lake Douglas County'
'Douglas County'
'Douglas County Umpqua River'
'Dunes Siltcoos River' 
'Elk Lake near Gold Butte'
'Errol Heights Park Sellwood Johnson Creek'
'Force lake Heron Lakes Golf Course' or 'Force Lake'


  
'Sellwood Oaksbottom Portland'

After a few hundred records were updated using
  I started using the larger scope of latitude and longitude  within these two catagories to see what records I have missed that had too general of a place_guess note
  
SELECT DISTINCT id, general_location, place_guess, latitude, longitude
FROM otter_data
WHERE latitude BETWEEN 45.56 AND 46.0 
AND longitude BETWEEN -122.7 AND -122.5
ORDER BY longitude;

