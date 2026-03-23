USE traffic_data;

SELECT * FROM traffic_data;


CREATE TABLE main_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(500),
    Keyword VARCHAR(255),
    Keyword_ID INT,
    Position INT,
    Previous_position INT
);

SELECT * FROM main_table; 
-- DROP TABLE main_table;

INSERT INTO main_table (Title, Keyword, Keyword_ID, Position, Previous_position)
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
    END AS Keyword_ID,
    Position,
     `Previous position`
FROM traffic_data; 