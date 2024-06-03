--- CH3 NOTEBOOK --- 
-------- REFORMAT CHARACTHER DATA --- 
SELECT UPPER(DEPARTMENT_NAME)  --- ALL THE TEXT /// LOWER
FROM DATA_SCI.COMPANY_DEPARTMENTS

SELECT INITCAP(DEPARTMENT_NAME)  --- CAP JUST FIRST CARACTHER
FROM DATA_SCI.COMPANY_DEPARTMENTS

SELECT RTRIM(LTRIM(' KELLY  '))  --- TRIM SPACE FROM THE LEFT SIDE // RTRIM FROM RIGHT SIDE

SELECT JOB_TITLE ||'_' ||LAST_NAME  ---- concatenate ||
FROM DATA_SCI.EMPLOYEES

SELECT concat(JOB_TITLE,'_',null)  ---- concat when happens to be a NULL value in one of the columns 
FROM DATA_SCI.EMPLOYEES

SELECT concat_WS('-',JOB_TITLE,last_name,email)  ---- concat with separator
FROM DATA_SCI.EMPLOYEES

----- EXTRACT STRING FROM CHARACTER DATA ---- 
SELECT SUBSTRING('ABCDEFGHIJK',1,3) TEST_STRING 

SELECT JOB_TITLE, (JOB_TITLE LIKE '%assistant') is_assitant
FROM DATA_SCI.EMPLOYEES

------- FILTER WITH REGULAR EXPRESIONS -------- 
SELECT DISTINCT
	JOB_TITLE
FROM	
	DATA_SCI.EMPLOYEES
WHERE 
	JOB_TITLE SIMILAR TO '(vp%|web%)'  --- match like vp% or denoted as (|)carefull with spaces in betwee |


SELECT DISTINCT
	JOB_TITLE
FROM	
	DATA_SCI.EMPLOYEES
WHERE 
	JOB_TITLE SIMILAR TO 'vp (a|m)%'  --- match like vp% followed by a or m denoted as (|)carefull with spaces in betwee |

-------------- REFORMAT NUMERIC DATA -----
SELECT 
	TRUNC(AVG(SALARY),2)
FROM 
	DATA_SCI.EMPLOYEES


SELECT 
	CEIL(AVG(SALARY))
FROM 
	DATA_SCI.EMPLOYEES


----- USE SOUNDEX WITH MISSPELLED TEXT -----
-- SOUNDEX RETURN A CODE FOR A PICE OF TEXT
CREATE EXTENSION IF NOT EXISTS FUZZYSTRMATCH


SELECT SOUNDEX('Postgres') = soundex('Postgress') --- works for short text

select difference('Postgres','Posgres') --- 

select levenshtein('Postgres','Posgres')  	--- return a distance between two strings. 
											-- tell us hte number of operation we have 
											--to perform to get it to match the second str


------ QUESTIONS --- 
--1) ROUND(XX,2), TRUNC(XX,2)
--2) SIMILAR TO
--3) LEVENSHTEIN()