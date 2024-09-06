SELECT 
    DAYNAME(publishedAt) AS weekday,
    SUM(comment_count) AS total_comment_count
FROM 
    youtube
WHERE 
    YEAR(publishedAt) BETWEEN 2020 AND 2024
GROUP BY 
    DAYNAME(publishedAt)
ORDER BY 
    FIELD(weekday, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');