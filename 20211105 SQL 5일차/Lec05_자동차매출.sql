use sakila;

SELECT 
    COUNT(*)
FROM
    rental;

SELECT 
    *
FROM
    rental INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/rental.csv' FIELDS TERMINATED BY ',' LINES TERMINATED BY '
';

use mydata;

SELECT 
    *
FROM
    dataset2;
SELECT 
    *
FROM
    dataset3;
SELECT 
    *
FROM
    dataset3;

use classicmodels;
show tables;

-- 자동차 매출
-- 1) 매출액 조회(일별, 월별, 연도별)
-- 일별 매출액 조회
use classicmodels;

SELECT 
    *
FROM
    orders;


SELECT 
    orderDate, SUM(priceEach * quantityOrdered) price
FROM
    orders o
        LEFT JOIN
    orderdetails od ON o.ordernumber = od.ordernumber
GROUP BY 1
ORDER BY 1;

desc orders;


-- 월별 매출액 조회
select substr('2003-05-07', 1, 7);

SELECT 
    SUBSTR(orderDate, 1, 7) MM,
    SUM(priceEach * quantityOrdered) price
FROM
    orders o
        LEFT JOIN
    orderdetails od ON o.ordernumber = od.ordernumber
GROUP BY 1
ORDER BY 1;


-- 연도별 매출액 조회
SELECT 
    SUBSTR(orderDate, 1, 4) YY,
    SUM(priceEach * quantityOrdered) price
FROM
    orders o
        LEFT JOIN
    orderdetails od ON o.ordernumber = od.ordernumber
GROUP BY 1
ORDER BY 1;


-- 2) 구매자수, 구매건수(일자별, 월별, 연도별)
select * from orders order by orderdate;

SELECT 
    orderDate,
    COUNT(distinct customerNumber) num_purchaser,
    COUNT(orderNumber) num_orders
FROM
    orders
GROUP BY 1
ORDER BY 1;


-- 3) 인원수, 총 매출액(연도별)
SELECT 
    SUBSTR(orderDate, 1, 4) YY,
    COUNT(DISTINCT customerNumber) num_purchaser,
    SUM(priceEach * quantityOrdered) price
FROM
    orders o
        INNER JOIN
    orderdetails od ON o.ordernumber = od.ordernumber
GROUP BY 1
ORDER BY 1	;


-- 3. 그룹별 구매 지표 구하기
-- 1) 국가별, 도시별 매출액
select * from orders;
select * from orderdetails;
select * from customers;
select * from payments;

SELECT 
    c.country, c.city, SUM(priceEach * quantityOrdered) sales
FROM
    orders o
        INNER JOIN
    orderdetails od ON o.ordernumber = od.ordernumber
        INNER JOIN
    customers c ON o.customernumber = c.customernumber
GROUP BY c.country , c.city
order by c.country, c.city;


-- 2) 북미(USA, Canada)와 비북미를 구분하는 CASE WHEN 구문
SELECT 
    CASE
        WHEN country IN ('USA' , 'Canada') THEN 'North America'
        ELSE 'Others'
    END Country_grp
FROM
    customers;

SELECT 
    c.country,
    CASE
        WHEN country IN ('USA' , 'Canada') THEN 'North America'
        ELSE 'Others'
    END Country_grp,
    SUM(priceEach * quantityOrdered) sales
FROM
    orders o
        INNER JOIN
    orderdetails od ON o.ordernumber = od.ordernumber
        INNER JOIN
    customers c ON o.customernumber = c.customernumber
GROUP BY c.country
ORDER BY c.country;


