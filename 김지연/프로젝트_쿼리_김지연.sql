WITH
### 중복 제거 ###
distinct_data AS (
		SELECT DISTINCT *
		FROM youtube_trend
),
### 평균값 ###
trend AS (
	SELECT 
	    video_id, 
	    publishedat, 
	    categoryid, 
	    trending_date,
	    AVG(view_count) AS view_count,
	    AVG(likes) AS likes,
	    AVG(dislikes) AS dislikes,
	    AVG(comment_count) AS comment_count
	FROM 
	    distinct_data
	GROUP BY 
	    video_id, 
	    publishedat, 
	    categoryid, 
	    trending_date
),
### 트렌드된 기간 추출 ###
filter_data AS (
		SELECT *
		FROM trend
		WHERE trending_date BETWEEN '2021-03-01' AND '2024-02-29'
		ORDER BY trending_date
),
### 계절별 데이터 분류 ###
season_data AS(
		SELECT
			video_id, view_count, likes, comment_count, trending_date,
			case
				when EXTRACT(MONTH FROM trending_date) IN (3,4,5) then 'spring'
				when EXTRACT(MONTH FROM trending_date) IN (6,7,8) then 'summer'
				when EXTRACT(MONTH FROM trending_date) IN (9,10,11) then 'fall'
				else 'winter'
			END AS season,
			case
				when EXTRACT(MONTH FROM trending_date) IN (3,4,5) then '1'
				when EXTRACT(MONTH FROM trending_date) IN (6,7,8) then '2'
				when EXTRACT(MONTH FROM trending_date) IN (9,10,11) then '3'
				else '4'
			END AS season_index
		FROM filter_data
)

### 날짜별 평균 데이터 ###
-- SELECT
-- 		trending_date,
-- 		SUM(view_count) AS total_view,
-- 		SUM(likes) AS total_likes,
-- 		SUM(dislikes) AS total_dislikes,
-- 		SUM(comment_count) AS total_comment	
-- FROM trend
-- GROUP BY trending_date

### 연도별 평균 데이터 ###
-- SELECT 
--     EXTRACT(YEAR FROM publishedat) AS year,
--     round(AVG(view_count),0) AS avg_view_count,
--     round(AVG(likes),0) AS avg_likes,
--     round(AVG(dislikes),0) AS avg_dislikes,
--     round(AVG(comment_count),0) AS avg_comment_count,
--     COUNT(1) AS cnt
-- FROM 
--     trend
-- GROUP BY 
--     EXTRACT(YEAR FROM publishedat)
-- ORDER BY 
--     year
    
### 계절별 평균 데이터 ###
SELECT
		season_index, season,
		round(AVG(view_count),0) AS avg_view, round(AVG(likes),0) AS avg_likes, round(AVG(comment_count),0) AS avg_comment
FROM season_data
GROUP BY season
ORDER BY season_index