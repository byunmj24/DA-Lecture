### PPT 53번 연습문제 ###
use sakila;

-- (1) 다음 테이블의 정의와 데이터를 사용해서 고객의 총 지물액과 함께 고객 이름을 반환하는 쿼리를 작성하시오. 
--     해당 고객에 대한 지물 기록이 없는 경우 모든 고객을 포함 한다.
select * from customer;
select * from payment;

select c.customer_id, concat(c.first_name, ' ', c.last_name) name, sum(amount) total from customer c
	left join payment p
		on c.customer_id = p.customer_id
	group by customer_id;

-- (2) 다른 외부 조인 유형을 사용하도록 1)쿼리를 재구성하세요.
--     예를 들어 외쪽 외부 조인을 사용했다면, 오른쪽 외부 조인을 사용해 보세요. 결과는 1)번과 같아야 한다.
select c.customer_id, concat(c.first_name, ' ', c.last_name) name, sum(amount) total from payment p
	right join customer c
		on p.customer_id = c.customer_id
	group by customer_id;

-- (3) {1, 2, 3, ..., 99, 100} 집합을 생성하는 쿼리를 작성하시오. 
--     이때 적어도 2개 이상의 from 절 서브쿼리를 가지고 교차 조인을 사용한다.
select (ones.num+tens.num) num
	from  
		(select 0 num union all
		select 1 num union all
		select 2 num union all
		select 3 num union all
		select 4 num union all
		select 5 num union all
		select 6 num union all
		select 7 num union all
		select 8 num union all
		select 9 num) ones
			cross join
		(select 0 num union all
		select 10 num union all
		select 20 num union all
		select 30 num union all
		select 40 num union all
		select 50 num union all
		select 60 num union all
		select 70 num union all
		select 80 num union all
		select 90 num) tens
        order by 1;


### PPT 62번 연습문제 ###
use sakila;

-- (1) 검색된 case 표현식으로 동일한 결과를 얻을 수 있도록, 단순 case 표현식을 사용하는 다음 쿼리를 다시 작성하시오.
--     최대한 when 절을 적게 사용하시오.
select * from language;
SELECT name,
	CASE name
		WHEN 'English' THEN 'latin1'
		WHEN 'Italian' THEN 'latin1'
		WHEN 'French' THEN 'latin1'
		WHEN 'German' THEN 'latin1'
		WHEN 'Japanese' THEN 'utf8'
		WHEN 'Mandarin' THEN 'utf8'
	ELSE 'Unknown'
	END character_set
FROM language;

SELECT name,
	CASE
		WHEN (name in ('English', 'Italian', 'French', 'German'))  THEN 'latin1'
		WHEN (name in ('Japanese', 'Mandarin')) THEN 'utf8'
	ELSE 'Unknown'
	END character_set
FROM language;

-- (2) 5개의 열이 있는 하나의 행을 결과 셋에 표시하도록 다음 쿼리를 다시 작성 하시오. 
--     G, PG, PG_13, R, and NC_17.
SELECT rating, count(*)
	FROM film
	GROUP BY rating;
    
select sum(case when rating = 'PG'then 1 else 0 end) 'PG', 
	sum(case when rating = 'G'then 1 else 0 end) 'G',
	sum(case when rating = 'NC-17'then 1 else 0 end) 'NC-17',
	sum(case when rating = 'PG-13'then 1 else 0 end) 'PG-13',
	sum(case when rating = 'R'then 1 else 0 end) 'R'
    from film;


### PPT 71번 연습문제 ###
select * from book;
select * from orders;
select * from customer;

-- (1) 판매가격이 20,000원 이상인 도서의 도서번호, 도서이름, 고객이름, 출판사, 판매가격을 보여주는 highorders 뷰를 생성하시오.
create view vw_JoinAll as
select o.orderid, o.custid, c.name, o.bookid, 
		o.saleprice, o.orderdate, b.bookname, c.address, 
        c.phone, b.publisher, b.price 
	from orders o
	inner join customer c
		on o.custid = c.custid
	inner join book b
		on o.bookid = b.bookid;

select * from vw_JoinAll;

create view highorders as
	select bookid, name, publisher, saleprice from vw_JoinAll
		where saleprice >= '20000';
        
select * from highorders;

-- (2) 생성한 뷰를 이용하여 판매된 도서의 이름과 고객의 이름을 출력하는 SQL 문을 작성하시오.
select b.bookname, h.name from book b
	inner join highorders h
		on b.bookid = h.bookid;
        
-- (3) highorders 뷰를 변경하고자 한다. 판매가격 속성을 삭제하는 명령을 수행하시오. 삭제 후 (2)번 SQL 문을 다시 수행하시오.
create or replace view highorders as
	select bookid, name, publisher from vw_JoinAll
		where saleprice >= '20000';

select b.bookname, h.name from book b
	inner join highorders h
		on b.bookid = h.bookid;

