SELECT id, user_id, place_guess, 
       image_url, season_year,  latitude, longitude
FROM otter_data
WHERE general_location IS NULL
AND place_guess ILIKE '%coos%';


