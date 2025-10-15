#River Otter Sighting in Oregon using iNaturalist Data#

![Otter photo](https://inaturalist-open-data.s3.amazonaws.com/photos/183828265/medium.jpg)

The records in the otter database each had an attached image, similar to this above photo.

**PROJECT OVERVIEW**: This project was started to create more access for hobby naturalists to observe river otters in Oregon. I also wanted to explore [SQLpostgre cleaning](queries/cleaning_queries.sql) and vizualing data techniques. The overall goal is to create a dashboard where someone could search by time of year and location for otter populations with the hope that they would be more likely to spot otter populations for the pleasure of watching them and for further naturalist learning.

**Why**: River otters can be shy and hard to spot so creating a dashboard of seasons and locations will increase the likelihood of a naturalist observing them and adding to community knowledge about this species.

**Data Source**: The data in this project came from [iNaturalist](https://www.inaturalist.org/taxa/41777-Lontra-canadensis). I specifically filtered for observations confirmed with images and occuring only in the state Oregon.

**PROCESS**: 

-Download [raw data](data/raw) from [iNaturalist](https://www.inaturalist.org/taxa/41777-Lontra-canadensis), a collaborative database for sightings of specific species.

-Filter for records with a image  so I could verify the sighting and easily compare for duplicate entries. 

-filter for dates between January 1st 2014 and January 1st 2024.

-clean the data for consistent dates, seasons, and locations.

-create a dashboard and easy charts to give helpful insights.


2. **Project Findings**

   a.  **"Where in Oregon are the most sightings of river otters (or otter signs)?"**

   Answer: __________________________________________________
  
  **"What time of year do most Oregon naturalists see river otters?"**
 
  Answer: Fall.

b. Other insights: _______________

c. Actionable information: If you're looking to observe river otters, I reccomend looking in bodies of water in _____________ (specific parts of Oregon) with a higher likelihood of spotting otters during ________ (specific times of year). We know that otter populations (more than one otter) were observed in __________ (general location) in the past five years.


