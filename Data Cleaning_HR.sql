#Data cleaning
SELECT* 
FROM
	hr;
#Describe date
DESCRIBE hr;

SELECT birthdate 
FROM hr;

SET sql_Safe_update = 0;

#Change birthdate into correct type of data
UPDATE hr 
SET birthdate =
CASE
		
		WHEN birthdate LIKE '%/%' THEN
		DATE_FORMAT( STR_TO_DATE( birthdate, '%m/%d/%Y' ), '%Y-%m-%d' ) 
		WHEN birthdate LIKE '%-%' THEN
		DATE_FORMAT( STR_TO_DATE( birthdate, '%m-%d-%Y' ), '%Y-%m-%d' ) ELSE NULL 
	END;
ALTER TABLE hr 
MODIFY COLUMN birthdate DATE;

#Change hiredate into correct type of data
UPDATE hr 
SET hire_date =
CASE
		
		WHEN hire_date LIKE '%/%' THEN
		DATE_FORMAT( STR_TO_DATE( hire_date, '%m/%d/%Y' ), '%Y-%m-%d' ) 
		WHEN hire_date LIKE '%-%' THEN
		DATE_FORMAT( STR_TO_DATE( hire_date, '%m-%d-%Y' ), '%Y-%m-%d' ) ELSE NULL 
	END;
SELECT
	hire_date 
FROM
	hr;
ALTER TABLE hr 
MODIFY COLUMN hire_date DATE;

#Change termdate into correct type of data
UPDATE hr 
SET termdate = DATE (
str_to_date( termdate, '%Y-%m-%d %H:%i:%s UTC' )) 
WHERE
	termdate IS NOT NULL 
	AND termdate != ' ';
ALTER TABLE hr MODIFY COLUMN termdate DATE;

#Add age column
ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr 
SET age = TIMESTAMPDIFF(
	YEAR,
	birthdate,
CURDATE());
SELECT birthdate, age 
FROM hr

#Find min and max age
SELECT
	min( age ) AS youngest, /*-46*/
	max( age ) AS oldest /*57*/
FROM hr;

SELECT
	count(*) 
FROM hr 
WHERE
	age < 18; /*967*/
