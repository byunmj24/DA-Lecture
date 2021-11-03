use bookstore;

select custid '고객번호', round(avg(saleprice), -2) '평균금액' from orders
	group by custid;
    
-- 도서 제목에 야구가 포함된 도서를 농구로 변경한 후 도서 목록 --
select bookid, replace(bookname, '야구', '농구') bookname, publisher, price from book;

-- 굿스포츠에서 출판한 도서의 제목과 제목의 글자 수
select bookname '제목', char_length(bookname) '문자수' from book
	where publisher = '굿스포츠';
    
-- 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오. --
select substr(name, 1, 1) '성', count(*) '인원'
	from customer
		group by substr(name, 1, 1);
        
-- 마당서점이 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 단, 주문일은 '%Y-%m-%d' 형태로 표시한다. --
select orderid, str_to_date(orderdate, '%Y-%m-%d') '주문일', custid, bookid
	from orders
		where orderdate = date_format('20140707', '%Y%m%d');
        
select sysdate(), date_format(sysdate(), '%Y/%m/%d %M %h:%s') 'SYSDATE_1';

-- MyBook 스키마 생성 --
create table mybook (
	bookid integer,
    price integer
);

insert into mybook value(1,10000);
insert into mybook value(2,20000);
insert into mybook value(3,null);
select * from mybook;

select * from mybook where price is null;
select * from mybook where price = '';

select bookid, ifnull(price, 0) price
	from mybook;
    
    
set @num := 0;
select @num;

set @num:=0;
select (@num:=@num+10) '순번', custid, name, phone
	from customer;


-- 마당서점의 고객별 판매액 --
select name from customer where custid = 1;

select (select name from customer where custid = 1) name,
	sum(saleprice) total
		from orders
			group by orders.custid;

desc orders;
desc book;

alter table orders add bname varchar(40);
set SQL_SAFE_UPDATES = 0;
update orders
	set bname = (select bookname from book
					where book.bookid = orders.bookid);

set SQL_SAFE_UPDATES = 1;


-- 고객번호가 2 이하인 고객의 판매액 (고객이름, 판매액)
select custid, name
	from customer
		where custid <= 2;

select cs.name, sum(o. saleprice) 
	from orders o
		inner join (select c.custid, c.name
						from customer c
							where c.custid <= 2) cs
		on cs.custid = o.custid
		group by o.custid;
        
## ALL, SOME, ANY
-- 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오. --
select orderid, saleprice
	from orders
		where saleprice > (select max(saleprice)
								from orders
									where custid = '3');

select orderid, saleprice
	from orders
		where saleprice > all (select saleprice
									from orders
										where custid = '3');

## EXISTS, NOT EXISTS
-- 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액 --
select sum(saleprice) total
	from orders
		where exists (select * from customer
							where address like '%대한민국%' 
											and customer.custid = orders.custid);


use sakila;

select f.film_id, f.title, count(*) num
	from film f
		inner join inventory i
			on f.film_id = i.film_id
		group by f.film_id, f.title;
        
select f.film_id, f.title, count(*) num
	from film f
		left outer join inventory i
			on f.film_id = i.film_id
		group by f.film_id, f.title;
        
use bookstore;

select * from customer;
insert into customer value (6, '조용필', '울산시 대림동', '000-1234-1234');
insert into customer value (7, '박미선', '대구시 명동', '123-1234-1234');

select cs.custid, cs.name, count(o.orderid) 구매량
	from customer cs
	left outer join orders o
		on cs.custid = o.custid
	group by cs.custid;
    
use sakila;
select * from category
	cross join language l;
    
select * from category;
select * from language;

-- select ones.num, tens.num, hundreds.num, 
select ones.num+tens.num+hundreds.num num
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
			cross join
		(select 0 num union all
		select 100 num union all
		select 200 num union all
		select 300 num) hundreds
	order by 1;
 
select date_add('2020-01-01', interval(ones.num+tens.num+hundreds.num) day) date
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
			cross join
		(select 0 num union all
		select 100 num union all
		select 200 num union all
		select 300 num) hundreds
	where date_add('2020-01-01', interval(ones.num+tens.num+hundreds.num) day) < '2021-01-01'
	order by 1; 
 
    
select date_add('2020-01-01', interval(40) day);


select * from rental;
select days.date, count(r.rental_id) num_rental
	from rental r
		right join (select date_add('2005-01-01', interval(ones.num+tens.num+hundreds.num) day) date
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
			cross join
		(select 0 num union all
		select 100 num union all
		select 200 num union all
		select 300 num) hundreds
	where date_add('2005-01-01', interval(ones.num+tens.num+hundreds.num) day) < '200
    
    6-01-01') days
		on days.date = date(r.rental_date)
	group by days.date
    order by 1;