CREATE DATABASE traffic_data_adwords;
-- DROP DATABASE traffic_data;
USE traffic_data_adwords;

SELECT * FROM traffic_data;
SELECT * FROM main_table;
SELECT * FROM keyword_lookup;
SELECT * FROM search_volume_lookup;
SELECT * FROM traffic_lookup;
SELECT * FROM search_metrics_lookup;
SELECT * FROM competition_lookup;
SELECT * FROM difficulty_lookup;
SELECT * FROM date_lookup;

-- traffic_data table

DESCRIBE traffic_data;


-- Handled NULL values using IFNULL / UPDATE
SELECT *
FROM traffic_data
WHERE Keyword_Id IS NULL
   OR `Search Volume` IS NULL
   OR CPC IS NULL;

-- Removed duplicates using DISTINCT   
SELECT Keyword_Id, COUNT(*)
FROM traffic_data
GROUP BY Keyword_Id, Title
HAVING COUNT(*) > 1;

SELECT Title, Keyword_Id, COUNT(*)
FROM traffic_data
GROUP BY Title, Keyword_Id
HAVING COUNT(*) > 1;

SELECT 
    Keyword_Id,
    Title,
    COUNT(*) AS duplicate_count,
    COUNT(*) OVER (PARTITION BY Keyword_Id) AS total_keyword_count
FROM traffic_data
GROUP BY Keyword_Id, Title
HAVING COUNT(*) > 1;

SELECT  DISTINCT Count( *)
FROM traffic_data;

Select count(*) from traffic_data;

SELECT * FROM traffic_data;

ALTER TABLE traffic_data
RENAME COLUMN ï»¿Title TO Title;

-- Trimmed extra spaces using TRIM()
UPDATE traffic_data
SET Keyword = TRIM(Keyword),
    Title = TRIM(Title);
    

-- Check if any bad text values exist:
SELECT * 
FROM traffic_data
WHERE CPC REGEXP '[^0-9.]';

-- Standardized data types (INT, DECIMAL, DATE)
ALTER TABLE traffic_data
MODIFY CPC DECIMAL(10,2);

ALTER TABLE traffic_data
MODIFY `Traffic (%)` DECIMAL(5,2);

ALTER TABLE traffic_data
MODIFY `Traffic Cost (%)` DECIMAL(12,2);

ALTER TABLE traffic_data
MODIFY Title VARCHAR(255),
MODIFY Keyword VARCHAR(255);

SELECT `Last Seen`
FROM traffic_data
WHERE STR_TO_DATE(`Last Seen`, '%d-%m-%Y') IS NULL;

UPDATE traffic_data
SET `Last Seen` = STR_TO_DATE(`Last Seen`, '%d-%m-%Y');

ALTER TABLE traffic_data
MODIFY `Last Seen` DATE;

SELECT `Last Seen`
FROM traffic_data
LIMIT 10;

SELECT * FROM traffic_data
WHERE `Search Volume` < 0
   OR CPC < 0;

-- main_table 

DESCRIBE main_table;

SELECT * FROM main_table;

ALTER TABLE main_table
CHANGE `ï»¿Title` Title VARCHAR(255);

ALTER TABLE main_table
MODIFY Keyword VARCHAR(255);

SELECT t.Keyword_Id
FROM traffic_data t
LEFT JOIN main_table m
ON t.Keyword_Id = m.Keyword_Id
WHERE m.Keyword_Id IS NULL;

-- keyword_lookup table

Describe keyword_lookup;

SELECT * FROM keyword_lookup;

ALTER TABLE keyword_lookup
CHANGE `ï»¿Keyword_Id` Keyword_Id INT;

ALTER TABLE keyword_lookup
MODIFY Keyword VARCHAR(255);

SELECT t.keyword_Id
FROM traffic_data t
LEFT JOIN keyword_lookup k
ON t.keyword_Id = k.keyword_Id
WHERE k.keyword_Id IS NULL;

-- search_volume_lookup table

Describe search_volume_lookup;

SELECT * FROM search_volume_lookup;

ALTER TABLE search_volume_lookup
CHANGE `ï»¿Keyword_Id` Keyword_Id INT;

-- traffic_lookup table

Describe traffic_lookup;

SELECT * FROM traffic_lookup;

ALTER TABLE traffic_lookup
CHANGE `ï»¿Keyword_Id` Keyword_Id INT;

SELECT t.Keyword_Id
FROM traffic_data t
LEFT JOIN traffic_lookup l
ON t.Keyword_Id = l.Keyword_Id
WHERE l.Keyword_Id IS NULL;

SELECT DISTINCT t.Keyword_Id
FROM traffic_data t
LEFT JOIN traffic_lookup l
ON t.Keyword_Id = l.Keyword_Id
WHERE l.Keyword_Id IS NULL;

-- search_metrics_lookup table

Describe search_metrics_lookup;

SELECT * FROM search_metrics_lookup;

ALTER TABLE search_metrics_lookup
CHANGE `ï»¿Keyword_Id` Keyword_Id INT;

SELECT t.Keyword_Id
FROM traffic_data t
LEFT JOIN search_metrics_lookup sm
ON t.Keyword_Id = sm.Keyword_Id
WHERE sm.Keyword_Id IS NULL;


-- competition_lookup table

Describe competition_lookup;
SELECT * FROM competition_lookup;

ALTER TABLE competition_lookup
CHANGE `ï»¿Keyword_Id` Keyword_Id INT;

SELECT t.Keyword_Id
FROM traffic_data t
LEFT JOIN competition_lookup c
ON t.Keyword_Id = c.Keyword_Id
WHERE c.Keyword_Id IS NULL;

-- difficulty_lookup table

Describe difficulty_lookup;

SELECT * FROM difficulty_lookup;

ALTER TABLE difficulty_lookup
CHANGE `ï»¿Keyword_Id` Keyword_Id INT;

SELECT t.Keyword_Id
FROM traffic_data t
LEFT JOIN difficulty_lookup d
ON t.Keyword_Id = d.Keyword_Id
WHERE d.Keyword_Id IS NULL;


-- date_lookup table

Describe date_lookup;

SELECT * FROM date_lookup;

ALTER TABLE date_lookup
CHANGE `ï»¿Last Seen` `Last Seen` TEXT;

-- Use STR_TO_DATE():
UPDATE date_lookup
SET `Last Seen` = STR_TO_DATE(`Last Seen`, '%d-%m-%Y');

ALTER TABLE date_lookup
MODIFY `Last Seen` DATE;

SELECT t.`Last Seen`
FROM traffic_data t
LEFT JOIN date_lookup d
ON t.`Last Seen` = d.`Last Seen`
WHERE d.`Last Seen` IS NULL;
