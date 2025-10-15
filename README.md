#River Otter Sighting in Oregon using iNaturalist Data#

![Otter photo](https://inaturalist-open-data.s3.amazonaws.com/photos/183828265/medium.jpg)

The records in [this otter database](data/cleaned) each have an image url, similar to this above photo.

**PROJECT OVERVIEW**: This project analyzes river otter sighting patterns in Oregon to help naturalists find otter populations more easily. Using [SQL data cleaning](queries/analysis_queries.sql) and visualization techniques, the analysis will inform a searchable dashboard where users can find the most likely viewing times and locations.

(ADD CHART VISUALIZATION HERE)

**WHY**: River otters can be illusive to spot in the wild so creating a dashboard of seasons and locations will increase the likelihood of a naturalist observing them and adding to community knowledge about this species.

**DATA SOURCE**: The data in this project came from [iNaturalist](https://www.inaturalist.org/taxa/41777-Lontra-canadensis). It was  filtered for confirmed observations (with image urls) and locations occuring only in the state Oregon.

**PROCESS**: 

-Download [raw data](data/raw) from [iNaturalist](https://www.inaturalist.org/taxa/41777-Lontra-canadensis), a collaborative database for sightings of specific species.

-Filter for records with a verified image to easily compare for duplicate entries. 

-Filter for dates between January 1st 2014 and January 1st 2024.

-Clean the data for consistent dates, seasons, and locations.

-Create a dashboard and easy charts to give helpful insights.


2. **Project Findings**

   a.  **"Where in Oregon are the most sightings of river otters (or otter signs)?"**

   Answer: (Current answer)_The Warrenton Astoria Area ___
  
  **"What time of year do most Oregon naturalists see river otters?"**
 
  Answer: Fall.

  Note: iNaturalist [*disclaimer*](https://www.inaturalist.org/taxa/41777-Lontra-canadensis) about the seasonal data: "Keep in mind that these are numbers of observations, so they are influenced both by when the organism can be observed and when people bother to observe them." Therefore, we cannot conclude that more otters are more present at certain times of year.

b. Other insights: _______________

   -Observataions of otter tracks often took place in the strip of undeveloped land between two bodies of water (for instance between the Columbia River and Heron Lake on Sauvie Island)
   
   -the user who made the highest number of otter observation records was [BearTracker](https://www.inaturalist.org/people/beartracker), Kim Cabrera

   -After observing several otter scat images (INSERT PHOTO HERE), it seems that otters eat a lot of crayfish because you can see their shells in the scat.

c. **Actionable information**: If you're looking to observe river otters, many were spotted in these areas:

Portland: Whitaker Ponds, Bybee Lake, and ________(golf course pond)

Coast Populations:

Rivers with many sightings: 




