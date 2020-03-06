use ipl

--#Returning all records
select * from Matches
-- Returns all records from the Matches table (match_id, team1, team2, match_date, season_year, city_name,toss_winner,match_winner,manofmatch,win_type,win_margin)

-- #Using 'where' clause to find for specific condition
select	match_id, team1,team2,match_winner,Win_Type, season_year
from
	Matches
where
	Season_Year = '2016' --Find match_id, team1, team2, match_winner, win_type along with the season_year for Season_Year = 2016

-- #Using 'AND along with 'WHERE' to filter
select match_id, team1,team2,match_winner,Win_Type, season_year
from 
	Matches
where Season_Year = '2016' and Win_Type = 'wickets' -- Win_Type (A team either wins by wickets or by runs)

-- #Using 'OR' along with 'WHERE'to filter
select match_id, team1,team2,match_winner,Win_Type, season_year
from 
	Matches
where Win_Type = 'wickets' or Win_Type = 'runs'

-- # Use of 'IN' operator where more than 2 conditions are present
 SELECT 
    *
FROM
    Matches
WHERE
	match_winner IN ('Mumbai Indians' , 'Chennai Super Kings', 'Delhi Daredevils')

-- # Use of 'NOT IN' operator where more than 2 conditions are present
 SELECT 
    *
FROM
    Matches
WHERE
	match_winner NOT IN ('Mumbai Indians' , 'Chennai Super Kings', 'Delhi Daredevils')

--#Using 'LIKE' operator to filter table with pattern
SELECT 
    *
FROM
    Matches
WHERE
    Win_Type LIKE ('wic%') -- #Starts with 'WIC'
	
SELECT 
    *
FROM
    Matches
WHERE
    Win_Type LIKE ('%wic'); -- #Ends with 'WIC'

--#Using 'NOT LIKE' operator to filter table with pattern
SELECT 
    *
FROM
    Matches
WHERE
    Win_Type NOT LIKE ('wic%') -- #Starts with 'WIC'
	

-- #Using WILDCARD characters *,%,_
SELECT 
    *
FROM
    Matches
WHERE
    Win_Type LIKE ('%run%'); 
	
-- #Using BETWEEN/NOt BETWEEN Operator along with Order By Clause
SELECT 
    *
FROM
    matches
WHERE
    Season_Year BETWEEN '2008' AND '2013'
order by
	Season_Year asc -- #By default it will choose ascending order only!
    
SELECT 
    *
FROM
    matches
WHERE
    match_date NOT BETWEEN '2008' AND '2013'
ORDER BY
Season_Year desc --#ordered in the descending order

-- #Other COMPARISON OPERATORS
SELECT 
    *
FROM
    matches
WHERE
match_datekey >= '20170405' --matchdatekey format = YYYYMMDD

SELECT 
    *
FROM
    matches
WHERE
match_datekey <= '20170405'  --matchdatekey format = YYYYMMDD

SELECT distinct
    *
FROM
    matches
WHERE
    Season_Year > '2010'
        AND match_winner = 'Mumbai Indians'

-- #using SELECT DISTINCT
SELECT DISTINCT -- #It also returns records for which matches were tied or abandoned
    match_winner
FROM
    Matches
    
SELECT 
    *
FROM
    employees
WHERE
    first_name BETWEEN 'mark' AND 'nathan';
    
    
--#Aggregate functions
/*Commonly used aggregate functions
#COUNT()
#SUM()
#MAX()
#MIN()
#AVG()
*/

SELECT 
	count(match_id)
FROM 
	Matches
WHERE 
	Season_Year < '2014'

SELECT 
	COUNT(match_id) 
FROM 
	Matches
WHERE 
	Season_Year 
BETWEEN '2008' AND '2017'

SELECT 
	concat('$',SUM(salary)) --#Since salary is in $ -> Utilized Concat function
FROM 
	Employee
WHERE 
	dept_id = '3'

-- #USing Avg function to display average salary by each department, Sorted from Highest to Lowest
SELECT
	concat('$',AVG(salary)), dept_id
FROM 
	Employee
GROUP BY 
	dept_id
ORDER BY 
	2 DESC 

-- #USing MAX function to display Max salary by each department, sorted from Highest to Lowest
SELECT
	dept_id, concat('$',MAX(salary)) AS SALARY
FROM 
	Employee
GROUP BY 
	dept_id
ORDER BY 
	1 DESC 

-- #USing MIN function to display Min salary by each department, sorted from Lowest to Highest
SELECT
	dept_id, concat('$',MIN(salary)) AS SALARY
FROM 
	Employee
GROUP BY 
	dept_id
ORDER BY 
	MIN(salary)


/*#Using Aliases(giving column a name) using 'AS' key 
						& 
#Write a query that obtains season_year, winning_team and the number of times the team won for that season_year. */
SELECT 
    DISTINCT season_year, match_winner, COUNT(match_winner) AS win_counts
FROM
    Matches
GROUP BY 
	season_year,match_winner 
ORDER BY 
	1,3 ASC

--#WHERE vs HAVING
SELECT 
    DISTINCT season_year, match_winner, COUNT(match_winner) AS win_counts
FROM
    Matches
WHERE
	Season_Year BETWEEN 2008 AND 2010 --#WHERE clause is used to filter records
GROUP BY 
	season_year,match_winner 
HAVING 
	COUNT(match_winner) > 7			  --#HAVING clause is used to filter grouped / segregated records
ORDER BY 
	1,3 ASC

--#LIMIT / TOP

SELECT
	TOP 3 match_winner, COUNT(match_winner) AS win_counts
FROM
	Matches
WHERE 
	Season_Year between '2008' and '2017'
GROUP BY 
	match_winner
ORDER BY
	2 DESC

/* INSERT Statement
#We can use INSERT statement without mentioning columns after table name. But we need to insert every value for each column with same order as columns*/
INSERT INTO	team
VALUES
	( 
     '13',
     '13',
	'Temp Team'
	) ;

-- UPDATE Statement
--#UPDATE querry is used to update existing set of records. When using Update Statement, Always use WHERE clause otherwise YOU will update the entire table
UPDATE Team 
SET 
    Team_Id = '14',
	Team_Name = 'Temporary Team'    
WHERE
    Team_SK = '13'

-- DELETE Statement
delete from Team
where Team_SK='13';


-- SUBQUERRIES
/* Select the names from Player table for the same Player ID which can be found in 'Player_Match' table */

SELECT      
	Player_Name
FROM									-- Outer Querry
	Player
WHERE
	Player_Id IN (SELECT Player_id
FROM									-- Inner Querry
	Player_Match)


-- Similar result can be found using JOIN statement
SELECT distinct 
    P.Player_Name
FROM
    Player P
        JOIN
    Player_Match M 
ON 
	P.player_id = M.player_id


-- JOINS

-- Table 1 - Player_Match (Match_ID,P_ID,P_name,DOB,Batting Hand,Bowling Skill,Country, Team 1, Team 2, Season Year)
-- Table 2 - Matches (Match_ID, Team 1, Team 2, Match Date, Season Year, Venue, City, Country, Toss Winner, Match Winner, Win Type, Win Margin, MoM)

-- 1) JOIN / INNER JOIN - The INNER JOIN keyword selects all rows from both the tables as long as the condition satisfies.
-- Q) Return records with Player_Name, Batting & Bowling info, Team info, Season Year, Winner, Win_Type, ManofMatch & Venue where Venue is Wankhede 
SELECT
	p.Player_Name,p.Batting_hand,p.Bowling_skill, m.Team1,m.Team2, m.Season_Year,m.Venue_Name,m.match_winner,m.ManOfMach,m.Win_Type
FROM 
	Player_Match P
INNER JOIN
	Matches M
ON P.Match_Id = M.match_id
and P.Season_year = M.Season_Year
where M.Venue_Name = 'Wankhede Stadium'
and m.Season_Year = '2017'


-- 2) LEFT JOIN / LEFT OUTER JOIN - This join returns all the rows of the table on the left side of the join and matching rows for the table on the right side of join. 
-- Q) Return ALL records from PLayer_Match table and Team info, Season Year, Venue,  Winner, Win_Type from Matches where Season year between 2008 & 2011 
SELECT
	p.Player_Name,p.Batting_hand,p.Bowling_skill,p.Country_Name,m.Team1,m.Team2, m.Season_Year,m.Venue_Name,m.match_winner,m.Win_Type
FROM 
	Player_Match P
LEFT OUTER JOIN
	Matches M
ON P.Match_Id = M.match_id
and P.Season_year = M.Season_Year
where M.Season_Year BETWEEN 2008 AND 2011
ORDER BY M.Season_Year


-- 3) RIGHT JOIN / RIGHT OUTER JOIN - RIGHT JOIN is similar to LEFT JOIN. This join returns all the rows of the table on the right side of the join and matching rows for the table on the left side of join
-- Q) Return ALL records from Table 2 (Matches) and Player_Info from Table 1 (PLayer_Match)
SELECT
	m.Team1,m.Team2, m.Season_Year,m.Venue_Name,m.match_winner,m.Win_Type, p.Player_Name,p.Batting_hand,p.Bowling_skill,p.Country_Name
FROM 
	Matches M
RIGHT JOIN
	Player_Match P
ON P.Match_Id = M.match_id
and P.Season_year = M.Season_Year
ORDER BY M.Season_Year


-- 4) FULL OUTER JOIN / FULL JOIN - It creates the result-set by combining result of both LEFT JOIN and RIGHT JOIN. 
-- Q) Return ALL records from both Tables

SELECT 
	p.*, m.* 
FROM
	Player_Match P
FULL OUTER JOIN
	Matches M
ON 
	P.Season_year = M.Season_Year


-- 5) SELF JOIN - It is a join in which a table is joined with itself especially when the table has a FOREIGN KEY which references its own PRIMARY KEY
-- Q) Return records of those Departments where Employee Salary > Manager's Salary
SELECT * from Employee
SELECT 
	e1.dept_id
FROM 
	Employee e1
	join Employee e2
ON
	e1.emp_id = e2.mngr_id
WHERE
	E1.salary > E2.salary


/* VIEWS - They are used in the following cases:
1. When you want to restrict a user to specific rows or columns.
2. When you want to hide the complexity of the data i.e. Join columns from multiple tables so that they look like a simple table
3. When you want to hide aggregated information and only show the summarized data
4. (Note) Order by clause cannot be used on a View. */

-- Q) Return records of most matches won by a team along with their Captain Info & Season_Year

-- Creating a view
create view v_match_summary as
select
	count(match_winner) as teams_win_count,p.Player_Captain,p.Season_year 
from 
	Matches M
inner join 
	Player_Match P
on 
	M.match_id = p.Match_Id
group by 
	p.Player_Captain, p.Season_year

-- Retrieving records from a View
SELECT
	* 
From
	v_match_summary

-- Altering/Editing a View
-- Q) How did the team win --> Through extra runs or wickets? Let's find out!

Alter view v_match_summary as
select
	count(m.match_winner) as teams_win_count,p.Player_Captain,p.Season_year, m.Win_Type
from 
	Matches M
inner join 
	Player_Match P
on 
	M.match_id = p.Match_Id
group by 
	p.Player_Captain, p.Season_year,m.Win_Type


-- Dropping a view

drop view v_match_summary


-- Stored Procedures
/* 
Advantages of a stored procedure:
1. It is compiled once and can be executed again & again. Thus faster & quicker results.
2. Simple & Easy to use
3. Can also provide input & output parameters to a procedure
*/

-- Creating a procedure that calls 1000 records from the Player_Match table
Drop procedure if exists select_player_info;
use ipl

CREATE PROCEDURE select_player_info	AS

BEGIN
	SELECT TOP 10000
		*
	FROM
		Player
END

/* 
2 Ways to call a Procedure:
	1. EXEC Procedure Name
	2. EXECUTE Procedure Name
*/

EXECUTE select_player_info

-- Alter a Procedure using Modify 

-- Dropping a Procedure

Drop procedure select_player_info


-- Creating a PROCEDURE with an 'IN' PARAMETER i.e. we have to give input

CREATE PROCEDURE player_info (@Player_id INT) AS
BEGIN

SELECT
	P.Player_Id,P.Player_Name,M.Player_team, M.Country_Name            
FROM 
    Player P 
JOIN 
    Player_Match M
ON p.Player_Id = M.Player_Id   

END

-- Here we will give Player_ID as the input and return player information

EXEC player_info 1










