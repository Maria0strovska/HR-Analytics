#Data cleaning 
SELECT *
FROM hr;

DESCRIBE hr;

SELECT birthdate FROM hr;

SET sql_Safe_update=0;
#Change birthdate into correct raw
UPDATE hr
SET birthdate=CASE
WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
ELSE NULL
END;

ALTER TABLE hr 
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date=CASE
WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
ELSE NULL
END;

SELECT hire_date 
FROM hr;

ALTER TABLE hr 
MODIFY COLUMN hire_date DATE;

UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ' ';
ALTER TABLE hr 
MODIFY COLUMN termdate DATE;

ALTER TABLE hr 
ADD COLUMN age INT;


UPDATE hr 
SET age=TIMESTAMPDIFF(YEAR, birthdate, CURDATE());

SELECT birthdate, age 
FROM  hr


SELECT 
	min(age) AS youngest, /*-46*/
    max(age) AS oldest /*-57*/
FROM hr;


SELECT count(*) 
FROM hr WHERE age < 18;  /*967*/
