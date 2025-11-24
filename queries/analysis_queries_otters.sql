#RIVER OTTERS OF OREGON ANALYSIS QUERIES#

-Using SQLPostGre 

-iNaturalist data

-verified observations of river otters 

-in Oregon.

#QUESTION 1. What *general areas* in Oregon have the most sighting?

SELECT general_location, COUNT(*) as frequency
FROM otter_data
GROUP BY general_location
ORDER BY frequency DESC
  LIMIT 5;

Data output: (general_location, number of sightings)
  
  'Fort Stevens/ Hammond/ Astoria/ Warrenton',  61
  'Deschutes County Smith Rock,  25
  'Eugene', 24
  'Greenway Park Beaverton' 18
  'Columbia River Svensen Island' 15



##  (INSERT HERE: link to DASHBOARD FOR LOCATION CROSS REFERENCED WITH SEASON_YEAR) ##

# 2. What time of year are the otters most likely to be observed?
  
  SELECT 
    SPLIT_PART(season_year, ' ', 1) AS season, COUNT(*) AS count
FROM otter_data
GROUP BY SPLIT_PART(season_year, ' ', 1)
ORDER BY count DESC;

Data output:
  "Fall,"	194
"Spring,"	149
"Summer,"	129
"Winter,"	126

  **Answer: Fall is a clear outlier with a much higher number of observations.**


# 4. Seasonality: Which *season in the 10 year period* had the highest number of records/observations?
  
 SELECT season_year, COUNT(*) AS count
FROM otter_data
GROUP BY season_year
ORDER BY count DESC
  LIMIT 5;

**Answer: the top 5 number of records for each recorded season are:**

"Fall, 2022"	40
"Spring, 2023"	38
"Fall, 2021"	36
"Fall, 2023"	35
"Summer, 2023"	30

#  5. What time of day are most of the sightings? Include NULL values for time_of_day

SELECT 
    CASE 
        WHEN time_observed_at IS NULL THEN 'NULL (no time)'
        ELSE time_of_day 
    END AS time_of_day, 
    COUNT(*) AS frequency
FROM otter_data
GROUP BY time_observed_at IS NULL, time_of_day
ORDER BY frequency DESC;

output: 
"afternoon"	210
"morning"	164
"early morning"	103
"evening"	61
"night"	26
"NULL (no time recorded)"	18

# 5 Answer: Though it would seems that the majority of the sightings are in the afternoon and morning, remember that this is just "when people have recorded an obserservation", rather than "when otters can be seen".

