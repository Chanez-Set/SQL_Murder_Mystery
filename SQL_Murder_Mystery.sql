--  Getting the right repport based on the informations provided 

SELECT * 
FROM crime_scene_report
WHERE 	
	city = 'SQL City' 
	AND type = 'murder' 
	AND date = 20180115
;


-- Getting the witnesses ID
	-- using defined variables instead of subqueries for readability purpose

-- 01. getting the northwestern Dr Witness
WITH Northwestern_houses AS (
								SELECT * 
								FROM person
								WHERE 	address_street_name LIKE 'Northwestern Dr'
)

SELECT id 
FROM Northwestern_houses
WHERE address_number = 	(
							SELECT MAX(address_number)
							FROM Northwestern_houses
						)
;


-- 02. Getting the Franklin Ave Witness
SELECT id INTO @witness_franklin
FROM person
WHERE address_street_name LIKE 'Franklin Ave' 
AND name LIKE '%Annabel%'
;
;



-- 03. Combining those id's
SELECT * 
FROM interview
WHERE person_id IN (@witness_north, @witness_franklin)
;


-- Sus goes to 'Get Fit Now Gym' & was there on January 9th 2018
-- He is Gold member 
-- Bag stated with 48Z
-- Car plate include 'H42W'


-- -- Check Gold members that where there in the 09th January
WITH gold_members_48Z AS (
							SELECT * 
							FROM get_fit_now_member
							WHERE	membership_status = 'gold'
							AND 	id LIKE '48Z%'
)
-- Check Gold members that where there in the 09th January
SELECT * 
FROM get_fit_now_check_in
where check_in_date = 20180109
AND membership_id IN (
						SELECT id
						FROM get_fit_now_member
						WHERE	membership_status = 'gold'
						AND 	id LIKE '48Z%'
)
;









