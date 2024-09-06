WITH RankedCategories AS (
    SELECT 
        publish_year,
        categoryId,
        SUM(view_count) AS total_view_count,
        ROW_NUMBER() OVER (PARTITION BY publish_year ORDER BY SUM(view_count) DESC) AS rn
    FROM 
        date_unique_
    WHERE 
        publish_year BETWEEN 2020 AND 2024
    GROUP BY 
        publish_year, categoryId
)
SELECT 
    publish_year,
    categoryId,
    total_view_count
FROM 
    RankedCategories
WHERE 
    rn <= 5
ORDER BY 
    publish_year ASC, total_view_count DESC
INTO OUTFILE 'C:/Temp/result.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';
