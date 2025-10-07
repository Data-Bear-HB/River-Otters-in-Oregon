#River Otter Sighting in Oregon using iNaturalist Data#

This project was started to create more access for hobby naturalists to observe river otters in Oregon. I also wanted to explore SQLpostgre cleaning and vizualing data techniques. The overall goal is to create a dashboard where someone could search by time of year (and a few other search terms) so they would be more likely to spot otter populations for further observations and naturalist learning.

2. **Goals of this project**
   
  a. To answer the questions:
  **"Where in Oregon are the most sightings of river otters (or otter signs)?"
  "What time of year do most Oregon naturalists see river otters?"**

b. Other insights: _______________

c. Actionable information: Try spotting river otters near bodies of water in _____________ (specific parts of Oregon) with a higher likelihood of spotting otters during ________ (specific times of year). We know that otter populations (more than one otter) were observed in __________ (general location) in the past five years.


PROCESS: 

First, I gathered raw data from iNaturalist, a collaborative database for sightings of specific species.
Then I filtering for records with a photo (see image_url in Otter Database) so I could verify the sighting and easily compare for duplicate entries. I also filtered for dates between January 1st 2014 and January 1st 2024.
