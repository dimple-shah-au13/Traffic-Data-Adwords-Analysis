USE traffic_data;

SELECT * FROM traffic_data;

SELECT * FROM main_table; 

-- 1. keyword_lookup Table
CREATE TABLE keyword_lookup AS
SELECT DISTINCT
    Keyword_ID,
    CASE
        WHEN Keyword_ID = 1 THEN 'PMP'
        WHEN Keyword_ID = 2 THEN 'Scrum'
        WHEN Keyword_ID = 3 THEN 'AWS'
        WHEN Keyword_ID = 4 THEN 'Capm'
        WHEN Keyword_ID = 5 THEN 'ITIL'
        WHEN Keyword_ID = 6 THEN 'Simplilearn'
        ELSE 'Other'
    END AS Category
FROM main_table;

SELECT * FROM keyword_lookup; 

-- 2. search_volume_lookup  Table

CREATE TABLE search_volume_lookup AS
SELECT
    m.Keyword_ID,
    AVG(t.`Search Volume`) AS avg_search_volume
FROM main_table m
JOIN traffic_data t
    ON m.keyword = t.keyword
GROUP BY m.Keyword_ID;

SELECT * FROM search_volume_lookup;


CREATE TABLE search_volumes_lookup AS
SELECT
    m.Keyword_ID,
	SUM(t.`Search Volume`) AS total_search_volume,
    AVG(t.`Search Volume`) AS avg_search_volume
FROM main_table m
JOIN traffic_data t
    ON m.keyword = t.keyword
GROUP BY m.Keyword_ID;

SELECT * FROM search_volumes_lookup;

-- 3. traffic_lookup   Table

CREATE TABLE traffic_lookup AS
SELECT
    m.Keyword_ID,
    SUM(t.Traffic) AS total_traffic,
    AVG(t.`Traffic (%)`) AS avg_traffic_percent
FROM main_table m
JOIN traffic_data t
    ON m.keyword = t.keyword
GROUP BY m.Keyword_ID;

SELECT * FROM traffic_lookup; 

-- 4. search_metrics_lookup  Table

CREATE TABLE search_metrics_lookup AS
SELECT
    m.Keyword_ID,
    AVG(t.`Search Volume`) AS avg_search_volume,
    AVG(t.CPC) AS avg_cpc,
    AVG(t.`Number of Results`) AS avg_number_of_results
FROM main_table m
JOIN traffic_data t
    ON m.keyword = t.keyword
GROUP BY m.Keyword_ID;

SELECT * FROM search_metrics_lookup; 

-- 5. traffic_metrics_lookup   Table

CREATE TABLE traffic_metrics_lookup AS
SELECT
    m.Keyword_ID,
    SUM(t.Traffic) AS total_traffic,
    AVG(t.`Traffic (%)`) AS avg_traffic_percent,
    SUM(t.`Traffic Cost`) AS total_traffic_cost,
    AVG(t.`Traffic Cost (%)`) AS avg_traffic_cost_percent
FROM main_table m
JOIN traffic_data t
    ON m.keyword = t.keyword
GROUP BY m.Keyword_ID;

SELECT * FROM traffic_metrics_lookup; 

-- 6. competition_lookup    Table

CREATE TABLE competition_lookup AS
SELECT
    m.Keyword_ID,
    AVG(t.Competition) AS avg_competition
FROM main_table m
JOIN traffic_data t
    ON m.keyword = t.keyword
GROUP BY m.Keyword_ID;

SELECT * FROM competition_lookup; 

-- 7. difficulty_lookup     Table

CREATE TABLE difficulty_lookup AS
SELECT
    m.Keyword_ID,
    AVG(t.`Keyword Difficulty`) AS avg_keyword_difficulty
FROM main_table m
JOIN traffic_data t
    ON m.keyword = t.keyword
GROUP BY m.Keyword_ID;

SELECT * FROM difficulty_lookup; 


-- 8. date_lookup (last seen)    Table

CREATE TABLE date_lookup AS
SELECT DISTINCT
    STR_TO_DATE(`Last Seen`, '%d-%m-%Y') AS full_date,
    YEAR(STR_TO_DATE(`Last Seen`, '%d-%m-%Y')) AS year,
    MONTH(STR_TO_DATE(`Last Seen`, '%d-%m-%Y')) AS month,
    DAY(STR_TO_DATE(`Last Seen`, '%d-%m-%Y')) AS day
FROM traffic_data;

SELECT * FROM date_lookup; 
