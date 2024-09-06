-- 연도별 카테고리 ID  당 콘텐츠 총 개수
SELECT publishedAt, categoryId, COUNT(categoryId) AS category_cnt 
FROM youtube_videos
WHERE YEAR(publishedAT) = 2023
group by categoryId;

-- 연도별 1~4월 카테고리 당 콘텐츠 총 개수
SELECT publishedAt, categoryId, COUNT(categoryId) AS category_cnt 
FROM youtube_videos
WHERE YEAR(publishedAT) = 2021 and (
month(publishedAt) = 1 or month(publishedAt) = 2 or month(publishedAt) = 3 or month(publishedAt) = 4
)
group by categoryId;

-- 카테고리별 상위 콘텐츠 조회수 평균 (조회수 100만 미만)
WITH Ranked_view AS (
    SELECT 
        video_id, title, categoryId, view_count,
        ROW_NUMBER() OVER (PARTITION BY categoryId ORDER BY view_count DESC) AS row_num
    FROM youtube_videos
)
SELECT categoryId, view_count, avg(view_count) AS avg_view
FROM Ranked_view
WHERE view_count < 1000000
GROUP BY categoryId


-- 카테고리별 상위 10개 콘텐츠 조회수 평균
WITH Ranked_view AS (
    SELECT 
        video_id, title, categoryId, view_count,
        ROW_NUMBER() OVER (PARTITION BY categoryId ORDER BY view_count DESC) AS row_num
    FROM youtube_videos
)
SELECT categoryId, avg(view_count) AS avg_view
FROM Ranked_view
WHERE row_num <= 10
GROUP BY categoryId

-- 카테고리별 콘텐츠 총 합계
SELECT categoryId, COUNT(1) AS cnt
FROM youtube_videos
group by categoryId
