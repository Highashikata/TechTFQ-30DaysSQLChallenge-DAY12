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
	
	
	
	