use mydata;

desc dataset2;

select * from dataset2;

-- 1) Division별 평균 평점 계산
-- a) DIVISIOn NAME별 평균 평점
SELECT 
    `Division Name`, AVG(rating)
FROM
    dataset2
GROUP BY 1
ORDER BY 2 DESC;

alter table dataset2 rename column `Division Name` to Division; -- 컬럼 이름 변경 | alter table tableName rename column oldColumnName to newColumnName; |

desc dataset2;

SELECT 
    division, AVG(rating) avg
FROM
    dataset2
GROUP BY 1
ORDER BY 2 DESC;

-- b) Department별 평균 평점
alter table dataset2 rename column `Department name` to Department;

SELECT 
    Department, AVG(rating) Avg, Count(rating) Cnt
FROM
    dataset2
GROUP BY 1
ORDER BY 2;

-- c) Trend의 평점 3점이하 리뷰
SELECT 
    *
FROM
    dataset2
WHERE
    department = 'Trend' AND rating <= 3;
    
-- 2) CASE WHEN
-- 연령을 10세 단위로 그룹핑
select * from dataset2;

SELECT 
    *, CONCAT(TRUNCATE(age, - 1), '대') AgeBand
FROM
    dataset2;

SELECT 
    CASE
        WHEN age BETWEEN 0 AND 9 THEN '0009'
        WHEN age BETWEEN 10 AND 19 THEN '1019'
        WHEN age BETWEEN 20 AND 29 THEN '2029'
        WHEN age BETWEEN 30 AND 39 THEN '3039'
        WHEN age BETWEEN 40 AND 49 THEN '4049'
        WHEN age BETWEEN 50 AND 59 THEN '5059'
        WHEN age BETWEEN 60 AND 69 THEN '6069'
        WHEN age BETWEEN 70 AND 79 THEN '7079'
        WHEN age BETWEEN 80 AND 89 THEN '8089'
        WHEN age BETWEEN 90 AND 99 THEN '9099'
    END AgeBand,
    Age
FROM
    dataset2
WHERE
    department = 'trend' AND rating <= 3;

SELECT 
    FLOOR(age / 10) * 10 AgeBand, Age
FROM
    dataset2
WHERE
    department = 'trend' AND rating <= 3;
    
SELECT 
    CONCAT(TRUNCATE(age, - 1), '대') AgePeriod, COUNT(*) CNT
FROM
    dataset2
WHERE
    department = 'Trend' AND rating <= 3
GROUP BY 1
ORDER BY 2 DESC;

SELECT 
    *
FROM
    dataset2
WHERE
    department = 'trend' AND rating <= 3
        AND (age BETWEEN 50 AND 59)
LIMIT 10; -- 10줄만 뽑는 쿼리