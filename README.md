#River Otter Sighting in Oregon using iNaturalist Data#

![Otter photo](https://inaturalist-open-data.s3.amazonaws.com/photos/183828265/medium.jpg)

The records in the otter database each had an attached image, similar to this above photo.

**PROJECT OVERVIEW**: This project analyzes river otter sighting patterns in Oregon to help naturalists find otter populations more easily. Using [SQL data cleaning](queries/analysis_queries.sql) and visualization techniques, the analysis will inform a searchable dashboard where users can find the most likely viewing times and locations.

**Why**: River otters can be illustive and hard to spot so creating a dashboard of seasons and locations will increase the likelihood of a naturalist observing them and adding to community knowledge about this species.

**Data Source**: The data in this project came from [iNaturalist](https://www.inaturalist.org/taxa/41777-Lontra-canadensis). It was  filtered for confirmed observations (with image urls) and locations occuring only in the state Oregon.

**PROCESS**: 

-Download [raw data](data/raw) from [iNaturalist](https://www.inaturalist.org/taxa/41777-Lontra-canadensis), a collaborative database for sightings of specific species.

-Filter for records with a verified image to easily compare for duplicate entries. 

-Filter for dates between January 1st 2014 and January 1st 2024.

-Clean the data for consistent dates, seasons, and locations.

-Create a dashboard and easy charts to give helpful insights.


2. **Project Findings**

   a.  **"Where in Oregon are the most sightings of river otters (or otter signs)?"**

   Answer: (Currently)_Warrenton Astoria ______________________
  
  **"What time of year do most Oregon naturalists see river otters?"**
 
  Answer: Fall.

b. Other insights: _______________Otter track observations often took place in the strip of undeveloped land between two bodies of water (for instance between the Columbia River and Heron Lake on Sauvie Island)

c. Actionable information: If you're looking to observe river otters, I reccomend looking in bodies of water in
Portland:
Coast Populations:
Rivers with many sightings:
_____________ (specific parts of Oregon) with a higher likelihood of spotting otters during ________ (specific times of year). We know that otter populations (more than one otter) were observed in __________ (general location) in the past five years.


