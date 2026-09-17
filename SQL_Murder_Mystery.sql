--  Getting the right repport based on the informations provided 

SELECT * 
FROM crime_scene_report
WHERE 	
	city = 'SQL City' 
	AND type = 'murder' 
	AND date = 20180115
;


-- Getting the witnesses ID

-- 01. getting the northwestern Dr Witness
WITH Northwestern_houses AS (
								SELECT * 
								FROM person
								WHERE 	address_street_name LIKE 'Northwestern Dr'
)

SELECT id INTO @witness_north
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



-- 03. Combining those id's


SELECT * 
FROM interview
INNER JOIN 
;













