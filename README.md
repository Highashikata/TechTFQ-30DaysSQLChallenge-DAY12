# TechTFQ-30DaysSQLChallenge-DAY12


Split Hierarchy SQL challenge

going through the challenge of SQL interview questions featured in the TechTFQ channel



In this repository we will be going through the SQL interview questions featured in the following YouTube video [SQL Interview Questions](https://www.youtube.com/watch?v=KrUIQAcFptY&list=PLavw5C92dz9Hxz0YhttDniNgKejQlPoAn&index=12).

# **Day 12: The problem statement: Split Hierarchy **


**PROBLEM STATEMENT :**
Given graph shows the hierarchy of employees in a company. 
Write an SQL query to split the hierarchy and show the employees corresponding to their team.

![image](https://github.com/Highashikata/TechTFQ-30DaysSQLChallenge-DAY12/assets/96960411/a06715ed-6889-45a3-8366-d08bf3f58b67)

**INPUT**

![image](https://github.com/Highashikata/TechTFQ-30DaysSQLChallenge-DAY12/assets/96960411/5de644cb-ec4b-42c0-a2eb-27bc9277119b)

**EXPECTED OUTPUT**

![image](https://github.com/Highashikata/TechTFQ-30DaysSQLChallenge-DAY12/assets/96960411/b5902d99-b148-4ade-9fe2-9384614b79a6)


**DDL&DML**

```
DROP TABLE IF EXISTS company;
CREATE TABLE company
(
	employee	varchar(10) primary key,
	manager		varchar(10)
);

INSERT INTO company values ('Elon', null);
INSERT INTO company values ('Ira', 'Elon');
INSERT INTO company values ('Bret', 'Elon');
INSERT INTO company values ('Earl', 'Elon');
INSERT INTO company values ('James', 'Ira');
INSERT INTO company values ('Drew', 'Ira');
INSERT INTO company values ('Mark', 'Bret');
INSERT INTO company values ('Phil', 'Mark');
INSERT INTO company values ('Jon', 'Mark');
INSERT INTO company values ('Omid', 'Earl');

SELECT * FROM company;
```


**DQL**
```
/* My queries */

SELECT * FROM company;

with recursive hierarchyCTE as(
	SELECT 
		employee,
		manager,
		0 as level,
		CAST(employee as TEXT) as path
	FROM
		company
	WHERE manager is null
	
	UNION ALL
	
	SELECT 
		c.employee,
		c.manager,
		h.level + 1,
		h.path || ', ' || c.employee	
	FROM
		company c
	JOIN 
		hierarchyCTE H on c.manager = h.employee
), hierarchyWithTeams AS (
    SELECT
        employee,
        manager,
        level,
        path,
        CONCAT('Team ', ROW_NUMBER() OVER (ORDER BY level, employee)) AS Teams
    FROM
        hierarchyCTE
)


SELECT
	Teams,
	path as Members
from
	hierarchyWithTeams
ORDER BY
	level, employee;

```

**Another Solution Given by someone**
```
WITH RECURSIVE CTE AS
	(SELECT EMPLOYEE,
			MANAGER,
			ROW_NUMBER() OVER () AS X
		FROM COMPANY
		WHERE MANAGER =
				(SELECT EMPLOYEE
					FROM COMPANY
					WHERE MANAGER IS NULL )
		UNION ALL SELECT D.EMPLOYEE,
			D.MANAGER, X
		FROM CTE C
		JOIN COMPANY D ON C.EMPLOYEE = D.MANAGER)
SELECT CONCAT('team',

								X) AS TEAMS,
	STRING_AGG(MANAGER,

		',') AS MEMBERS
FROM
	(SELECT MANAGER, X
		FROM CTE
		UNION SELECT EMPLOYEE, X
		FROM CTE)Y
GROUP BY X
ORDER BY X;
```




**BONUS**
__Source :__ [MEDIUM](https://medium.com/learning-sql/working-with-hierarchical-data-in-postgres-d92e86464c41)
 

![image](https://github.com/Highashikata/TechTFQ-30DaysSQLChallenge-DAY12/assets/96960411/64f32f93-0e77-499a-8bea-ca7512f49ca0)

![image](https://github.com/Highashikata/TechTFQ-30DaysSQLChallenge-DAY12/assets/96960411/68af0859-aa6d-455b-a874-c193aa57675a)


**Script**

```
DROP TABLE IF EXISTS mobilesCompany;
CREATE TABLE mobilesCompany
(
	folder_id	int primary key,
	folder_name	varchar(100),
	parent_id	int
);

INSERT INTO mobilesCompany values (1, 'Mobiles', null);
INSERT INTO mobilesCompany values (2, 'Apple', 1);
INSERT INTO mobilesCompany values (3, 'Samsung', 1);
INSERT INTO mobilesCompany values (4, 'Iphone 14', 2);
INSERT INTO mobilesCompany values (5, 'Iphone 14 Pro', 2);
INSERT INTO mobilesCompany values (6, 'Iphone 14 Pro Max', 2);
INSERT INTO mobilesCompany values (7, 'S22', 3);
INSERT INTO mobilesCompany values (8, 'S22 Plus', 3);
INSERT INTO mobilesCompany values (9, 'S22 Ultra', 3);
INSERT INTO mobilesCompany values (10, 'TV', null);
INSERT INTO mobilesCompany values (11, 'LG', 10);
INSERT INTO mobilesCompany values (12, 'SONY', 10);


/* Fetching the data */
SELECT * FROM mobilesCompany;


/* Retrieving the Hierarchical level of our data */
WITH recursive hierarchymobilecte AS
(
       SELECT folder_id,
              folder_name,
              parent_id,
              0 AS level
       FROM   mobilescompany
       WHERE  parent_id IS NULL
       UNION ALL
       SELECT m.folder_id,
              m.folder_name,
              m.parent_id,
              h.level + 1
       FROM   mobilescompany m
       JOIN   hierarchymobilecte h
       ON     h.folder_id = m.parent_id )
SELECT   *
FROM     hierarchymobilecte
ORDER BY 1,
         4;

/* Retrieving the Hierarchical path of our data */
WITH recursive hierarchymobilecte AS
(
       SELECT folder_id,
              folder_name,
              parent_id,
              cast(folder_name AS text) AS path
       FROM   mobilescompany
       WHERE  parent_id IS NULL
       UNION ALL
       SELECT m.folder_id,
              m.folder_name,
              m.parent_id,
              h.path
                     || ', '
                     || m.folder_name
       FROM   mobilescompany m
       JOIN   hierarchymobilecte h
       ON     h.folder_id = m.parent_id )
SELECT DISTINCT folder_name,
                path
FROM            hierarchymobilecte
ORDER BY        1,
                2;
```
