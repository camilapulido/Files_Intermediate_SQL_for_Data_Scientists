-- CH.6 COMMON TABLE EXPRESSIONS
----
---INTRODUCTION TO COMMON TABLE EXPRESSIONS (CTEs)
--- CTEs ARE AUXILLIARY STATEMENTS THAT WE CREATE AND THEN REFERENCE IN LARGER QUERIES
-- WE USE THEM TO CREATE TEMPORARY TABLES USED ONLY WITHIN THE QUERY
-- WE DO IT COS IT WILL HELP US SIMPLIFY COMPLEX QUERIES, THAT OTHER WISE WOULD REQUERE SUBQUERIES
-- ABLE TO WORK WITH RECURSIVE DATA STRUCTURES SUCH AS HIERACHICAL DATA.

-- DEFINE BY 'WITH STATEMENT'


----- MULTIPLE TABLE COMMEN TABLE EXPRESSIONS
WITH REGION_SALARIES AS --- CREATE THE FIRST CTEs
	(SELECT REGION_ID, SUM(SALARY) REGION_SALARY
	FROM DATA_SCI.EMPLOYEES
	GROUP BY REGION_ID), ---- END OF CREATION FIRST CTE
	
	TOP_REGION_SALARIES AS  -- CREATE SECOND CTE BASED ON FIRST CTE
	(SELECT REGION_ID
	FROM REGION_SALARIES
	WHERE REGION_SALARY > (SELECT AVG(REGION_SALARY) FROM REGION_SALARIES)) 
	--- SELECT TOP REGIONS WITH SALARIES HIGHER THAN THE AVERAGE,
	
SELECT 
	*
FROM
	REGION_SALARIES
WHERE
	REGION_ID IN (SELECT REGION_ID FROM TOP_REGION_SALARIES)

----------
---- HIERARCHICAL TABLES using WITH RECUSIVE STATEMENT
--CTEs ALLOW US TO WORK WITH HIERARCHICAL RECURSIVE DATA. 
--A recursive function solves a particular problem by 
--calling a copy of itself and solving smaller subproblems of the original problems

-- WITH RECURSIVE <TABLE NAME> (<COLUMNS>) AS
	-- <TERMINAL SELECT STATEMENT> 
	-- UNION  -->(UNION REMOVES DUPLICATE, UNION ALL DOES NOT)
	-- <RECURSIVE SELECT STATEMENT>
-- SELECT
--	...

	
--- RECURSIVE COMMON ABLE EXPRESSIONS
--- WE CAN USE RECURSIVE CTEs TO DO THINGS LIKE FIND PATHS THROUGH TREES
--- IF WE ARE WORKINF WITH AN ORGANIZATIONAL STRUCTUTRE AND WE WANTED TO FIND THE PATH 
-- FROM A DEPARMENT UP TO THE TOP OF THE ROOT NODE, WE CAN USE A RECURSIVE CTE FOR THAT
	
WITH RECURSIVE REPORT_STRUCTURE (ID,DEPARTMENT_NAME,PARENT_DEPARTMENT_ID) AS
	(SELECT ID, DEPARTMENT_NAME, PARENT_DEPARTMENT_ID
	FROM DATA_SCI.ORG_STRUCTURE
	WHERE ID = 4
	UNION
	SELECT OS.ID, OS.DEPARTMENT_NAME, OS.PARENT_DEPARTMENT_ID 
	FROM DATA_SCI.ORG_STRUCTURE OS
	JOIN REPORT_STRUCTURE RS
	ON RS.PARENT_DEPARTMENT_ID = OS.ID)
SELECT
*
FROM 
REPORT_STRUCTURE


----- CHALLENGE

WITH EAST_REGIONS AS --- CREATE CTEs
	(SELECT ID 
	FROM DATA_SCI.COMPANY_REGIONS CR
	WHERE REGION_NAME LIKE '%east%') ---END CTEs
SELECT
	SUM(SALARY),
	ROUND(AVG(SALARY),2)
FROM 
	DATA_SCI.EMPLOYEES E
WHERE
	E.REGION_ID IN (SELECT ID FROM EAST_REGIONS)
