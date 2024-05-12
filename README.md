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
