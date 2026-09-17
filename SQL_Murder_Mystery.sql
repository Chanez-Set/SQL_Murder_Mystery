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



-- 03. Combining those id's and reading the interviews
SELECT * 
FROM interview
WHERE person_id IN (@witness_north, @witness_franklin)
;




-- Sus is a man, goes to 'Get Fit Now Gym' & was there on January 9th 2018
-- He is Gold member
-- Bag stated with 48Z
-- Car plate include 'H42W'




-- Check Gold members that where there in the 09th January
WITH gold_members_48Z AS (
							SELECT * 
							FROM get_fit_now_member
							WHERE	membership_status = 'gold'
							AND 	id LIKE '48Z%'
)

SELECT * 
FROM get_fit_now_check_in
where	check_in_date = 20180109
AND 	membership_id IN (SELECT id FROM gold_members_48Z)
;
-- Both of them where there on that day 



-- Check gold members with 48Z infos 
WITH gold_members_48Z AS (
							SELECT * 
							FROM get_fit_now_member
							WHERE	membership_status = 'gold'
							AND 	id LIKE '48Z%'
),

gym_suspects AS (
				SELECT * 
				FROM person
				where	id IN (SELECT person_id FROM gold_members_48Z)
)

-- Check what matches the sus plates 
SELECT *
FROM gym_suspects
WHERE license_id IN (	SELECT id
						FROM drivers_license
						WHERE plate_number LIKE '%H42W%' 
						AND gender = 'male'
					)
;

-- Solution found : Jeremy Bowers



-- Part 02 :  try querying the interview transcript of the murderer to find the real villain behind this crime
-- no more than 2 queries