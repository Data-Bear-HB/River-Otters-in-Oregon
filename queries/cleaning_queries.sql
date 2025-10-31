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
Changed  ID: 3354398  ID: 12311357  ID: 12311377 ID: 135210934 id: 34434670 id: 171550668  'Rogue River-Siskiyou National Forest'
Changed  ID: 16454665 'Lewis and Clark River Astoria'
Changed ID: 4315496  'Nehalem Bay Beach'
Changed ID: 7516229  Id: 71624927 id: 164546251 194908488 'Siltcoos River Dunes City'
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
Changed  ID: 136952796 ID: 59195480 ID: 63939990  'Coos Bay'
Changed ID: 107051595 ID: 144869598 ID: 68968403 ID: 38039756  ID: 124071050  ID: 123180911  ID: 143394409  ID: 153479085  ID: 6365297 ID: 214078097 ID: 68968403 'Deschutes County'
Changed  ID: 176435305 ID: 171782199 ID: 71043984 ID: 171782199 ID: 65569368 ID: 176435305 id: 169437205 125184164 id: 135209627 'Sunriver'
Changed ID: 152531440 'Deschutes River meets Columbia River Wasco'
Changed  ID: 120263708 ID: 29892899 ID: 190850259 ID: 184736637 ID: 124071050  ID: 130121659 ID: 171859632 ID: 246991535 ID: 171859634 ID: 16445210 ID: 54704939 ID: 15649456 id: 8403772 id:33462124 id:56910122 id: 189684406 id:163857425 'Deschutes County Smith Rock'
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
Changed Id: 148641299 'Sunnyside Park Sweet home'
Changed Id: 17284626 'Detroit Lake'
Changed Id: 148394334 'Oxbow Park Sandy River'
Changed Id: 56989583 'Sandy River Corbett'
Changed Id: 189926890 'Grand Butte Reservoir Gresham'
Changed Id: 90426933 ID: 77182012 'Sandy River Dabney Park'
Changed Id: 41044742 'Salish Ponds Park Fairview'
Changed Id: 42127309 'Sandy River Delta'
Changed Id: 138453234 ID: 138507933 'Columbia River Gary Island'
Changed Id: 71663875 'Blue Lake Park Portland'
Changed Id: 148040707 'Company Lake Columbia River'
Changed Id: 31705164  id: 31704451  'Squaw Lake'
Changed Id: 173847446 ID: 5386205 id: 178904878 id: 129097869  id: 259076107 'Klamath Lake'
Changed Id: 99437413 id : 21974369 'Klamath River'
Changed Id: 246561173 'Acorn Woman Lake'
Changed Id: 119673377 'Harris Beach Coast'
Changed Id: 63168709 'Chetko River Brookings'
Changed ID: 45332010 'Applegate River'
Changed Id: 145285718 'Kalamath Falls Lake Ewuana'
Changed Id: 130877436 id: 32761199 id: 24038453 'Kalamath County'
Changed Id: 99221190  'South Fork Coquille River Powers'
Changed Id: 141013864 'Metford'
Changed  Id: 148743451 'Little Butte Creek Eagle Point'
Changed Id: 110334270 Williamson River Chiloquin
Changed Id: 153506562 id: 58661659 id: 204305018 id: 165769536 id: 156343046     Changed id:192877463 id: 156338572 id: 33033663 'Harney County'
Changed  Id: 14402513 'Cape Blanco Oregon Coast'
Changed Id: 29732386 'Canyonville'
Changed Id: 193547704 'Harney County Krumbo Reservoir'
Changed Id: 38262044 'Winston'
Changed Id: 80198978 'Coquille River Bandon' 
Changed Id: 4840694 id: 4848737 'Roseburg'
Changed Id: 27417335 id: 258871103 'Charleston Coosbay Coast'
Changed Id: 146745440 'Coosbay North Bend Coast'
Changed Id: 44433609 'Crescent Deschutes County'
Changed Id: 196723281 'Odell Lake'
Changed Id: 63140440 'Little Deschutes River La Pine'
Changed id: 33855994 'Camp Creek Coos County'
Changed Id: 177433322 'Gold Lake Bog Blue River'
Changed Id: 62751865 'Wikiup Reservoir La Pine'
Changed Id: 39135908 'Cottage Grove'
Changed Id: 103082262 'Crane Prairie Reservoir Lane County'
Changed  Id: 137111730 'Dexter Reservoir Lowell'
Changed Id: 98056865 'Creswell'
Changed Id: 191741300 'Florence Coast'
Changed Id: 136032115 110227404  84924432  202243979  124685636  134005273  85779241  150982750 55770395  16500666 137059902 'Lane County near Fern Ridge Reservoir near Eugene'
Changed Id: 66409027  186051766  17977571 24537391 156181158  104668748 144826346 37500872  37501901  37502055  104155554 104004572 156183426  252666449  252666450  103974469 22647406  193750799  193691219 148937916 33298922  70371492 103728271 68357147 'Eugene'
Changed Id: 249552623   252531354 'Bend'
Changed Id: 137037360 137111001 139274117  'Springfield'
Changed Id: 8796960 'Alder Lake Coast'
Changed id: 157610907  'Camp Josephine Selma'
Changed id: 1234511 'Bear Creek Metford'
Changed id: 14402513 'Cape Blanco Oregon Coast'
Changed id: 4840694 id: 4848737 'Park Lake Roseburg'
Changed id 143475473 'Davis Lake Deschutes County'
Changed id: 33855994 'Camp Creek Scottsburg'
Changed id: 157915900 id: 167130317 'Umpqua River Scottsburg'
Changed id: 89023003 'Silcoos River Oregon Coast'
Changed id: 26191801 id: 139665569 'Juniper Canyon Crook county'
Changed id: 145117715 'Paulina Crook County'
Changed id: 184608691 id: 186101512 'Fern Ridge Lake'
Changed id: 19791053 'Drake Creek Shotgun Ranch'
Changed id: 140512589 id: 7549346  'Cape Creek Cove Coast'
Changed id 131849442 'Carl Washburne State Park Coast'
Changed id: 56255425 'Crook County'
Changed id: 73443902 'Three forks Malhuer County'
Changed id: 174034666 id: 135206153 id: 147316418  'Near Tokatee Creek Coast'
Changed id: 103573813 id: 37574032 id: 125877126  'Powell Butte'
Changed id: 305814105 id: 21127968  'near Bob Creek Coast'
Changed: 259001307 'Neptune State Park'
Changed: 37575905 id: 174786332  ‘Near Redmond’
Changed: 191872474 'Aspen Lakes Golf Course near Redmond'
Changed: 112523021 'Yachats State Park'
Changed id: 18628753 'Yachats River Yachats'
Changed id: 128087649 'Willamette River near Monroe'
Changed id: 83623164 id: 150930215 id: 95992096 id: 173120469 id: 96033132 id: 115811761 id: 124633453 id: 181998708  'near Smith Rock Park'
Changed id = 111158957 'near Terrebonne'
Changed id = 117913234 'near Black Butte Ranch'
Change id = 107992268 'William Finely Nature Refuge'
Changed id =  305814071 'Near Bear Creek'
Changed id =  91778757 'Brownsville'
Changed id = 110889214  id = 224259772 id = 15305199 'William Finley Wildlife Refuge'
Changed id = 130644870 'Alsea River Waldport'
 Changed id = 138221186 'Suttle Lake'
 Changed id = 60683883 id = 184767712  'Willamette River Peoria'
Changed 152098220 'Alsea River Bayshore'
 Changed  57384394 'Metolius Springs Camp Sherman'
Changed 126756585 'Whychus Creek Geneva'
Changed id = 158438122 'Ellison Lumber Airport'
  Changed id = 47067365 id: 56096835 'Camp Sherman'
Changed id = 55233068  'Seal Rock'
 Changed id = 138199095 id = 7580808  id = 96185973  id = 97152990 id = 176649926  'Brian Booth State Park near Seal Rock'
Changed id = 192594800 id = 37172803  id = 144403898 'Lebanon'
Changed id = 144586582 id = 133874068 id = 139385205   'Philomath'
Changed id = 195397956 id = 103015458  id = 103016012  'Corvallis'
Changed id = 23000340 'Toledo'
 Changed id = 100933728 'Crabtree'
 Changed id = 18747646 'Yaquina Bay'
 Changed id = 169430204 'Albany'
Changed id = 27167549 'Albany Willamette River'
Changed id = 150464122 'Adair Village'
Changed id = 138526463 'Richland'
Changed id = 132209038 'Ankey National Wildlife Refuge'
Changed id = 98573260 'Baker City'
Changed id = 102793104 'Lincoln Beach Coast'
Changed id = 20871052 id = 142095308 'Bellevue'
Changed id = 4784375 'Tillamook County'
Changed id = 188258507 'Nestucca Bay Tillamook County'
 Changed id = 139005750 id = 118690283 'Mt. Hood Forest'
 Changed id = 53735056 'John Day River Sherman County'
Changed id = 47555858  'Pacific City'
Changed id = 4024691  'Sand Lake' 
 Changed id = 273426351 id = 189294766 'Trillium Lake'
 Changed id = 163073625 'Mirror Lake'
Changed id = 47169864  'John Day River Cottonwood Canyon State Park'
  Changed id = 9261628 'Henry Hagg Lake'
Changed id = 155245271 'Forest Grove'
  Changed Id: 155968417 'Unity Reservoir'
 ChangedId: 23000340 'Toledo'
Changed id : 188480328 'Yaquina Bay Newport'
Changed id: 194607478 'Forest Grove'
Changed id: 104066176 id: 104066176 'Lower Deschutes Wildlife Area'
Changed id: 178195618 id: 137285895 'Wallowa River Wallowa' 
Changed id 21669011 'Deschutes River Recreational Area'
Changed: id 190551283 'Columbia River Celilo Park'
Changed 103400950 id:8701580 id:5246118  id: 140326593 'Nehalem Bay'
Changed 83892663 'Nehalem River Tillamook County'
Changed 62754580 id:106030294  id:20871506 id:97183089  id:103400950 'Nehalem River Nahalem Park'
Changed id: 62450618 id:186900895 id:172270469 id:12464772  'Warrenton Fort Stevens State Park'
Changed id:104286036 id:128686591  id:63570447  id:5104329 id:52753742  id:89790396  id: 109307904  'Seaside'
Changed id:24284986 'Columbia River Boardman'
Changed id:106287578  id:92870665  'Umatilla National Wildlife Refuge'
Changed id:63220172 'Grand Ronde River Troy'
Changed id: 182120431 'Cannon Beach'
Changed id:71398637 id:9048685   'Vernonia Lake Vernonia'
Changed id:70127987 id:187047758   id:167940672   id:152879483   id:151232602  id:41571536 id:52441024   id:151232597  id:69687179 id: 74426781  id:74426783 id:109950318  id:106888984  id:100661080  id:106456981 'Columbia River Svensen Island'
Changed id:166128498  id:166138041 id:128474585 'Manzanita Beach' 
Changed id:19424765 id:42436336  'Lewis and Clark River near Warrenton'
Changed id:17976881 id:38201808  'Salisbury Slough Columbia River'
Changed id:170210255 'Eola Creek near Cannon Beach'
Changed id:102143305 'Imnaha River'
Changed id:4914685 'Tucker Creek Clatsop County'
Changed id:24619499, id:9267093, id:10478634, id:12965192,  id:144194622,  id:147292703,  'near Warrenton'
Changed id:25413623, id:98487001, id:5952021, id:66708921 'River near Astoria'
Changed id:53673133, id:22035690,  id:30854062,  id:40425663 'Lewis and Clark River'
Changed id:124938137 'near Seaside'
Changed id:57084991 'Bay near Gearhart'
Changed id:140723614, id:147292703, id:193764053  'Sunset Beach near Warrenton'
Changed id:16431529 'Swash Lake near Fort Stevens'
Changed id:69174296 'Cascade Locks'


  
# Found and deleted these entries:
-Deleted record (id: 152442844, id: 259930834, id: 136816528, id:305814105, id: 98573257, id: 155968421, id: 152098226, id:178195619, id:187047757,  id:151232607, id:151232600  id:151232595, id:151232594, id:9048686) because a repeat record
-Deleted one record (id: 97100855, id:92676713 ) because incorrect location/ location could not be verified.
-Deleted records (id: 29011942, id:4446353) because they were in Washington State.
-Deleted Id: 5954439 because cannot confirm any signs of otter



DELETE FROM otter_data 
  WHERE id = 29011942 OR id = 97100855 OR id = 152442844


