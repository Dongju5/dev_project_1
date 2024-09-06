-- 데이터 처리
-- 1. video_id 가 같으면서 trending_date가 같은 행 제거
-- 2. video_id 중복시 trending_date 일자별 갯수를 view_count 최댓값 행에 저장
-- 3. video_id 중복시 view_count 최댓값 행만 남기고 나머지 제거

-- 업로드 시간대별 트렌드 영상 갯수
-- SELECT 
--     HOUR(publishedAt) AS upload_hour,
--     COUNT(*) AS count_per_hour
-- FROM 
--     youtube
-- GROUP BY 
--     HOUR(publishedAt)
-- ORDER BY 
--     upload_hour;

-- 업로드 시간대별 조회수
-- SELECT 
--     YEAR(publishedAt) AS upload_year,
--     HOUR(publishedAt) AS upload_hour,
--     SUM(view_count) AS total_views
-- FROM 
--     youtube
-- WHERE 
--     YEAR(publishedAt) BETWEEN 2020 AND 2024
-- GROUP BY 
--     YEAR(publishedAt),
--     HOUR(publishedAt)
-- ORDER BY 
--     upload_year, 
--     upload_hour;
-- 업로드 시간대별 좋아요 수
-- SELECT 
--     YEAR(publishedAt) AS upload_year,
--     HOUR(publishedAt) AS upload_hour,
--     SUM(likes) AS total_likes
-- FROM 
--     youtube
-- WHERE 
--     YEAR(publishedAt) BETWEEN 2020 AND 2024
-- GROUP BY 
--     YEAR(publishedAt),
--     HOUR(publishedAt)
-- ORDER BY 
--     upload_year, 
--     upload_hour;
-- 업로드 시간대별 댓글 수 
-- SELECT 
--     YEAR(publishedAt) AS upload_year,
--     HOUR(publishedAt) AS upload_hour,
--     SUM(comment_count) AS total_comment_count
-- FROM 
--     youtube
-- WHERE 
--     YEAR(publishedAt) BETWEEN 2020 AND 2024
-- GROUP BY 
--     YEAR(publishedAt),
--     HOUR(publishedAt)
-- ORDER BY 
--     upload_year, 
--     upload_hour;
    
-- 업로드 요일별 트렌드 영상 수
-- SELECT 
--     DAYNAME(publishedAt) AS upload_day, 
--     COUNT(*) AS count_per_day
-- FROM 
--     youtube
-- GROUP BY 
--     DAYNAME(publishedAt)
-- ORDER BY 
--     FIELD(upload_day,'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday','Sunday');

-- 업로드 요일별 조회수
-- SELECT 
--     YEAR(publishedAt) AS upload_year,
--     DAYNAME(publishedAt) AS upload_day,
--     SUM(view_count) AS total_views
-- FROM 
--     youtube
-- GROUP BY 
--     YEAR(publishedAt),
--     DAYNAME(publishedAt)
-- ORDER BY 
--     upload_year,
--     FIELD(upload_day,'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday','Sunday');
-- 업로드 요일별 좋아요 수
-- SELECT 
--     YEAR(publishedAt) AS upload_year,
--     DAYNAME(publishedAt) AS upload_day,
--     SUM(likes) AS total_likes
-- FROM 
--     youtube
-- GROUP BY 
--     YEAR(publishedAt),
--     DAYNAME(publishedAt)
-- ORDER BY 
--     upload_year,
--     FIELD(upload_day,'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday','Sunday');
    
-- 업로드 요일별 댓글  수
SELECT 
    YEAR(publishedAt) AS upload_year,
    DAYNAME(publishedAt) AS upload_day,
    SUM(comment_count) AS total_comment_count
FROM 
    youtube
GROUP BY 
    YEAR(publishedAt),
    DAYNAME(publishedAt)
ORDER BY 
    upload_year,
    FIELD(upload_day,'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday','Sunday');