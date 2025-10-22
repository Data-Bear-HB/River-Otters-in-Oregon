# The goal of cleaning data in this project is to create a dashboard that answers the questions of otter sightings:
  
-by year (2014-2024)
-by season (Spring, Summer, Fall, Winter)
-by place (group by area hubs, county, city, coastal area, etc)
-by time of day

# Make a new column for location: 
  
  ALTER TABLE otter_data
ADD COLUMN general_location VARCHAR(255);

# Make a new column to includes season and year:

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

# look for groups of locations in place_guess 

SELECT place_guess, COUNT(*) AS count
FROM otter_data
WHERE place_guess IS NOT NULL
GROUP BY place_guess
ORDER BY count DESC;
  
# based on patterns that show up multiple times
  
SELECT id, general_location, place_guess, latitude, longitude
FROM otter_data
WHERE place_guess ILIKE '%cully%';

# to update a record, first confirm the location of each individual record with google maps (using the latitude and longitude)
  
# update the general_location to a simpler, more searchable catagory, like 'Whitaker Ponds, Portland' or 'Sellwood Oaksbottom Portland' using this query:

UPDATE otter_data 
SET general_location = 'Whitaker Ponds, Portland'  
WHERE id = '31642242' OR id = '47979780'  OR id = '69243000' OR id = '140937824';

NOTES:
  -include multiple 'tags' in the naming of these catagories so a user can search by key words like 'Portland' or 'coast' or 'Slough'
  -sometimes the exact location is not close to anything else on the map so catagorize by county.
  -some of the entries have 'near' a landmark

# examples of general_location tags: 

SELECT DISTINCT general_location
FROM otter_data
WHERE general_location IS NOT NULL
ORDER BY general_location
LIMIT 10;

After a few hundred records were updated using the above method,
#  start using latitude and longitude to search for patterns in the records. 

  
SELECT DISTINCT id, general_location, place_guess, latitude, longitude
FROM otter_data
WHERE latitude BETWEEN 45.56 AND 46.0 
AND longitude BETWEEN -122.7 AND -122.5
ORDER BY longitude;

# Seached for null values in general_location and slowly expanded latitude  
  
SELECT DISTINCT id, general_location, place_guess, latitude, longitude
FROM otter_data
WHERE latitude BETWEEN 45.45 AND 46.0 
AND longitude BETWEEN -122.7 AND -122.5
AND general_location IS NULL
ORDER BY latitude; 
  
# update general_location null values on close latitude or longitude
  
UPDATE otter_data 
SET general_location = 'Columbia Slough'  
WHERE id = '127554925';

# Verified location general_location to the following

Changed 'Portland Airport'  id: 101730628
Changed  Id: 109107408 'columbia slough by smith and bybee lake'
Changed  Id: 4924803  id: 19371200        'willamette river NW industrial district'
Changed Id: 98754064 id: 70976100 'willamette sauvie island near wapato bridge'
Changed  ID: 9042518, ID: 9321906, ID: 4375165 'Columbia Sauvie Island near Sturgeon Lake'
Changed  Id: 9788640 'Force lake Heron Lakes Golf Course'
Changed  Id: 21787694  'NE portland Columbia Slough near Airport way'
Changed Id: 30462187  id: 93288240  id:94078805  'N Portland Columbia Slough near Heron Lakes Golf Course'
Changed Id: 36473452  id: 101423037  id: 137832554 id: 143060344  id: 152431308   'Whitaker Ponds Portland'
Changed Id: 54576418  'Broughton Beach Portland Airport'
Changed  Id: 61629170 'Commonwealth Lake Cedar Hills'
Changed  Id: 63221403 id: 101065709 'Reed Lake Portland'
Changed Id: 66615128  id: 71346783 id: 142632089 id: 39672490 
  'Smith and Bybee Lake'
Changed Id: 88888697  id: 140324586 id: 141028926  id: 195294869  'Columbia River Hayden Island'
Changed Id: 93109885 'Metzger Slough'
Changed Id: 143375277 'Sellwood Oaksbottom Portland'
Changed Id: 190210994  'Errol Heights Park Sellwood Johnson Creek'
Changed Id: 231315202 'South Waterfront Park Willamette River Hawthorne Bridge'
Changed   Id: 4929731   ID: 19668262  ID: 139523435  ID: 144327144 'Sunset Lake or Beach Oregon Coast'
Changed Id: 12311403  ID: 34916938  ID: 108654626  'Rogue River near Gold Beach'
Changed  ID: 3354398  ID: 12311357  ID: 12311377  'Rogue River-Siskiyou National Forest'
Changed  ID: 16454665 'Lewis and Clark River Astoria'
Changed ID: 4315496  'Nehalem Bay Beach'
Changed ID: 7516229   'Siltcoos River Dunes City'
Changed  ID: 101450089  ID: 135338738 ID: 159664517  'North Powder Pond Baker City'
Changed  ID: 30225757 'John Day River Spray'
Changed  ID: 134670716  'Elk Lake near Gold Butte'
Changed ID: 47291033 'Mill Creek Salem'
Changed ID: 200125489 'Rodger’s Creek Sunnyside'
Changed ID: 103739865 'Salem Pringle Creek Willamette River'
Changed ID: 36259329  'Salem Minto-Brown Island Park'
Changed  ID: 70649406  'Willamette River Riverview Park Independence'
Changed ID: 161922793 'Dallas'
Changed  ID: 153650337 'Yamhill River Willamina'
Changed  ID: 191311679 'Mercer Reservoir'
Changed  ID: 186949482 'near Rose Lodge'
Changed ID: 162319662 'Siletz River Lincoln County'
Changed ID: 184965451   ID: 184965452  ID: 186950552 ID: 189566717  'Devils Lake Lincoln City'
Changed  ID: 34457357 'Schooner Creek Lincoln county'
Changed  ID: 15695087 'Mink creek otis junction'
Changed  ID: 190873029 'Camp Westwind Otis'
Changed ID: 118313207  ID: 50797321  ID: 47363395  ID: 112826367  ID: 166470864   'Siletz Bay' 
Changed ID: 97541911 'Lincoln City'
Changed ID: 102793104 'Lincoln Beach'
Changed ID: 27360795   ID: 17816405 ID: 194386232 ID: 17522521 ID: 147491964  ID: 17700267  'Depoe Bay'  
Changed ID: 7140515   ID:  7255378  ID: 137488085 ID: 59650805  ID: 66691799  ID: 160338597  ID: 188856469 'Douglas County'
Changed ID:  201202765  'Diamond Lake'
Changed  ID:  41973198  ID: 6189983  'Roseburg'
Changed  ID: 202118055 ID: 137488085   'Umpqua River Roseburg North'
Changed ID: 204320202  ID: 192999349 ID:151686325 ID: 153629857   ID: 164349006  ID: 141394698  'Sutherlin Douglas County'
Changed ID: 152331080 'Winchester Bay Umpqua River'
Changed ID: 5462841  ID: 109520965  ID: 186500137 'Douglas County Umpqua River'
Changed ID: 61684427 'Winchuck River Oregon Coast'
Changed  ID: 154109292 ID: 92536458 ID: 63532230 ID:  62713920  iD: 153132367  'Brookings'
Changed  ID: 130283335 ID: 169325228  ID: 64218839 ID: 80790611 ID: 26977383  ID: 60675068 'Curry Country Oregon Coast'
Changed ID: 93112871 'Curry County'
Changed  ID: 135146541 'Jackson Country'
Changed   ID: 34369278  ID: 52632464 'Jackson Country Hyatt Reservoir'
Changed ID: 173639740 ID: 110796191  ID: 40998850 ID: 66036660  ID: 36762603  ID: 34640440 ID: 35451653 'Ashland'
Changed  ID: 1969201 ID: 259930834  'Coos County Oregon Coast'
Changed ID: 41578891 ID: 34358030 ID: 38352235  'Coos County'
Changed ID: 194908488 'Dunes Siltcoos River'
Changed  ID: 136952796 ID: 59195480 ID: 63939990  'Coos Bay'
Changed ID: 107051595 ID: 144869598 ID: 68968403 ID: 38039756  ID: 124071050  ID: 123180911  ID: 143394409  ID: 153479085  ID: 6365297 ID: 214078097 ID: 68968403 'Deschutes County'
Changed  ID: 176435305 ID: 171782199 ID: 71043984 ID: 171782199 ID: 65569368 ID: 176435305 'Sunriver'
Changed ID: 152531440 'Deschutes River meets Columbia River Wasco'
Changed  ID: 120263708 ID: 29892899 ID: 190850259 ID: 184736637 ID: 124071050  ID: 130121659 ID: 171859632 ID: 246991535 ID: 171859634 ID: 16445210 ID: 54704939 ID: 15649456 'Deschutes County Smith Rock'
Changed ID: 29365099 'Wikiup Reservoir Deschutes County'
Changed ID: 180852008 ID: 82150453 ID: 254737742 'Black Butte Deschutes County'
Changed ID: 13060258 ID: 18920259 ID: 14330433 ID: 66639593 ID: 42293793 ID: 57096803  ID: 177453327  ID: 80560662 ID: 56071700   Lincoln County Oregon Coast
Changed ID: 16159493 'Yachats Oregon Coast'
Changed  ID: 204305030 ID: 34050721 ID:12960303 ID: 129296033   'Beaver Creek Lincoln Country Oregon Coast'
Changed ID: 94034593  ID: 33786157 ID: 94650908  'Crystal Springs Rhododendron Garden Portland'
Changed ID: 101975389 ID: 40109624 'Jackson Creek Scappoose'
Changed ID: 94263910 ID: 72001984  ID: 119969409  'Pond by millar park Scappoose'
Changed ID: 65915572  'Dawson Creek Hillsboro'
Changed ID: 181867769 'Jackson Bottom Wetlands Hillsboro'
Changed ID: 89934236  'Tualatin River National Wildlife Refuge Sherwood'
Changed ID: 96909304 'Rock Creek Sherwood'
Changed ID: 188807081 'Scappoose Bay'
Changed ID: 74007710 'Columbia River near Deer Island'
Changed ID: 4006597 'Sturgeon Lake Sauvie Island'
Changed ID: 41448914 'Dalton Lake St Helens near Columbia River'
Changed ID: 25805232 'Summer Creek Tigard'
Changed ID: 26954695 ID: 35353473  'Columbia River St. Helens'
Changed ID: 176913641 ID: 133816845 ID:137574550 ID: 98445685 ID: 34948230 ID: 103501195 ID: 103501196 ID: 103501197  ID: 219145507  ID: 191061375 ID: 96190268  ID: 133817018 ID:145372612 ID: 134223298 ID: 138196257 ID: 137196267 ID: 170062636 ID: 203868553 'Greenway Park Beaverton'
Changed Id: 147072018 'Metzger'
Changed Id: 152083495 'Beavercreek'

  
# Found and deleted these entries:
-Deleted record (id: 152442844, id: 259930834) because it was a repeat
-Deleted one record (id: 97100855) because incorrect location/ location could not be verified.
-Deleted records (id: 29011942, id:4446353) because they were in Washington State.


DELETE FROM otter_data 
  WHERE id = 29011942 OR id = 97100855 OR id = 152442844


