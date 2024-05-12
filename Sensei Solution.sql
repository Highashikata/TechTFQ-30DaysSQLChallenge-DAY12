/* TechTFQ-sensei solution */
-- Writing a first block of our query to construct our teams
SELECT
	CONCAT('Team ',
	CAST(row_number() OVER(ORDER BY MNG.EMPLOYEE) AS text)) as Teams,
	 MNG.EMPLOYEE
FROM COMPANY ROOT
JOIN COMPANY MNG ON ROOT.EMPLOYEE = MNG.MANAGER
WHERE ROOT.MANAGER IS NULL
ORDER BY MNG.EMPLOYEE;


-- Using the recursive query

with recursive cteRec as
(
	SELECT c.employee, c.manager, t.teams
	FROM COMPANY c
	cross join cte_teams t
	where c.manager is null
	
	UNION ALL
	
	SELECT
		c.employee, c.manager, t.teams
	FROM 
		COMPANY c
	JOIN cteRec on cteRec.employee = cteRec.manager
	LEFT JOIN cte_teams t on t.employee = c.employee
), cte_teams as(
	SELECT
		CONCAT('Team ',
		CAST(row_number() OVER(ORDER BY MNG.EMPLOYEE) AS text)) as Teams,
	 	MNG.EMPLOYEE
	FROM 
		COMPANY ROOT
	JOIN 
		COMPANY MNG ON ROOT.EMPLOYEE = MNG.MANAGER
	WHERE ROOT.MANAGER IS NULL
)

select * from cteRec









