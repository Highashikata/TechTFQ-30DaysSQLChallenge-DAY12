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