
use bookstore;

-- 가격이 10000원 ~ 20000원 사이의 책 검색 --
select * from book
	where price >= 10000 and price <= 20000;
    
select * from book
	where price between 10000 and 20000;
    
-- in 조건 검색 --
select * from book
	where publisher = '굿스포츠'
		or publisher = '대한미디어';
        
select * from book
	where publisher in ('굿스포츠', '대한미디어');
select * from book
	where publisher not in ('굿스포츠', '대한미디어');
    
select bookname, publisher from book
	where bookname like '축구의 역사';
    
select bookname, publisher from book
	where bookname like '%의 %';
    
select * from book
	order by price desc, publisher asc;
    
-- 집계 함수 --
select sum(saleprice) as total from orders
	where custid = 2;
    
select * from orders;

select sum(saleprice) as total, 
		avg(saleprice) as average, 
        min(saleprice) as minimum, 
        max(saleprice) as maximum 
			from orders;
            
select count(*) as count from orders;


-- 고객별 총수량, 총 판매액 --
select custid, 
		count(*) as 도서수량,
		sum(saleprice) as 총액 
			from orders
				group by custid;

select * from customer;

select orders.custid, customer.name,
		count(*) as 도서수량,
		sum(saleprice) as 총액 
			from orders
				inner join customer
					on orders.custid = customer.custid
						group by orders.custid;
                        
-- 가격 8천원 이상 --
select custid, count(*)
	from orders
		where saleprice >= 8000
			group by custid
				having count(*) >= 2;



use sakila;

select customer_id, count(*) from rental
	group by customer_id;
    
select customer_id, count(*) from rental
	group by customer_id
		order by 2 desc;
select customer_id, count(*) from rental
	group by customer_id
		order by count(*) desc;
    
select customer_id, count(*) from rental
	group by customer_id
		having count(2) >= 40
			order by count(*) desc;
            
            
describe payment;
select * from payment;

select count(customer_id), count(distinct customer_id) 
		from payment;

        
desc rental;

select rental_date, return_date, return_date-rental_date 
	from rental;
select rental_date, return_date, datediff(return_date, rental_date) diff 
	from rental;

select max(datediff(return_date, rental_date)) max, 
		avg(datediff(return_date, rental_date)) avg
			from rental;
            
