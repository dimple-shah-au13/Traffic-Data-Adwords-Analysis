CREATE DATABASE traffic_data;
USE traffic_data;

-- DROP DATABASE traffic_data;

SELECT * FROM traffic_data; 

select * from Keyword;

-- DROP TABLE traffic_data;

ALTER TABLE traffic_data
RENAME COLUMN ï»¿Title TO Title;

SELECT * FROM traffic_data WHERE Keyword NOT LIKE '%pmp%';

SELECT *,
	CASE
		WHEN Keyword LIKE '%pmp%' THEN 'PMP'
        WHEN Keyword LIKE '%scrum%' THEN 'Scrum'
        WHEN Keyword LIKE '%aws%' THEN 'AWS'
        WHEN Keyword LIKE '%capm%' THEN 'Capm'
        WHEN Keyword LIKE '%simplilearn%' THEN 'Simplilearn'
        WHEN Keyword LIKE '%itil%' THEN 'ITIL'
        ELSE 'OTHER'
	END AS category
FROM traffic_data;

SELECT *,
	 DENSE_RANK() OVER (ORDER BY category) AS Keyword_ID
FROM (
	SELECT Title, Keyword,
		CASE
			WHEN Keyword LIKE '%pmp%' THEN 1
			WHEN Keyword LIKE '%scrum%' THEN 2
			WHEN Keyword LIKE '%aws%' THEN 3
			WHEN Keyword LIKE '%capm%' THEN 4
			WHEN Keyword LIKE '%simplilearn%' THEN 5
			WHEN Keyword LIKE '%itil%' THEN 6
			ELSE 7
		END AS category
	FROM traffic_data
) t;
     
     
SELECT 
    Title,
    Keyword,
    CASE
        WHEN Keyword LIKE '%pmp%' THEN 1
        WHEN Keyword LIKE '%scrum%' THEN 2
        WHEN Keyword LIKE '%aws%' THEN 3
        WHEN Keyword LIKE '%capm%' THEN 4
        WHEN Keyword LIKE '%itil%' THEN 5
        WHEN Keyword LIKE '%simplilearn%' THEN 6
        ELSE 7
    END AS Keyword_ID
FROM traffic_data;

SELECT *,
       DENSE_RANK() OVER (
           ORDER BY 
           CASE
               WHEN category = 'PMP' THEN 1
               WHEN category = 'Scrum' THEN 2
               WHEN category = 'AWS' THEN 3
               WHEN category = 'Capm' THEN 4
               WHEN category = 'ITIL' THEN 5
               WHEN category = 'Simplilearn' THEN 6
               ELSE 7
           END
       ) AS Keyword_ID
FROM (
    SELECT Title, Keyword,
        CASE
            WHEN Keyword LIKE '%pmp%' THEN 'PMP'
            WHEN Keyword LIKE '%scrum%' THEN 'Scrum'
            WHEN Keyword LIKE '%aws%' THEN 'AWS'
            WHEN Keyword LIKE '%capm%' THEN 'Capm'
            WHEN Keyword LIKE '%simplilearn%' THEN 'Simplilearn'
            WHEN Keyword LIKE '%itil%' THEN 'ITIL'
            ELSE 'OTHER'
        END AS category
    FROM traffic_data
) t;

