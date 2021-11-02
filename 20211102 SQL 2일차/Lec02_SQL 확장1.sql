select 3000+3000;

select bookname from book
	where price = 6000;
    
select bookname from book
	where price = (select 3000+3000);
    
select bookname from book
	where price = (select max(price) from book);
    

-- 도서를 구매한 적이 있는 고객의 이름을 검색하시오. --
select * from book;
select * from orders;
show tables;
select * from customer;

select distinct custid from orders; -- 1,2,3,4
select name from customer
	where custid in (select distinct custid from orders);

select c.name from customer c
	inner join (select distinct custid from orders) a
		on c.custid = a.custid;


-- 대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오. --
select orders.custid from orders inner join book on orders.bookid = book.bookid where book.publisher = '대한미디어';

select * from customer
	where custid in 
		(select orders.custid from orders 
			inner join book 
				on orders.bookid = book.bookid 
					where book.publisher = '대한미디어');
                    
select * from customer c
	inner join orders o on c.custid = o.custid
		inner join book b on o.bookid = b.bookid
			where b.publisher = '대한미디어';
                    
-- 대한 미디어
select bookid from book
	where publisher = '대한미디어';

-- bookid 3,4                    
select * from orders
	where bookid in (3,4);
    
-- custid 1
select * from customer
	where custid = 1;
    
-- 합치기
select * from customer
	where custid in (
		select custid from orders
			where bookid in (
				select bookid from book
					where publisher = '대한미디어'));
                    

-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오. --
desc book;
select publisher, avg(price) from book
	group by publisher;

select * from book b1 
	where price >= (
		select avg(price) from book b2
			where b2.publisher = b1.publisher);

	-- 내 풀이            
select * from book b
	left outer join (select publisher, avg(price) avg from book
						group by publisher) a
		on b.publisher = a.publisher
			where b.price >= a.avg;
            
select * from book
	group by publisher 
		having price >= avg(price);
        

use sakila;

desc customer;

select max(customer_id) from customer;

select customer_id, concat(first_name, ' ', last_name) name from customer
	where customer_id = (
		select max(customer_id) from customer);
        
show tables;
select * from city;
select * from country;
select * from country where country in ('canada', 'mexcico');

-- 무료 영화를 대여한 적이 없는 모든 고객 --
desc payment;
select distinct customer_id from payment where amount = 0;

select concat(first_name, ' ', last_name) name from customer 
	where customer_id 
		not in (
			select distinct customer_id from payment 
				where amount = 0);


-- 대한민국에서 거주하는 고객의 이름과 도서를 주문한 고객의 이름을 보이시오. --
desc customer;
select * from customer;

select name from customer
	where address like '대한민국%'
		and name not in (
			select name from customer
				where custid in (select distinct custid from orders));



use sakila;

-- Join --
desc customer;
desc address;
desc city;

select * from customer c, address a
	where c.address_id = a.address_id;
    
select c.first_name, c.last_name, a.address, a.postal_code from customer c
	inner join address a
		on c.address_id = a.address_id
	where a.postal_code = 52137;
            
select cs.first_name, cs.last_name from customer cs
	inner join address ad
		on cs.address_id = ad.address_id
	inner join city ct
		on ad.city_id = ct.city_id;
        

-- 두 명의 특정 배우가 출연한 영화 제목을 모두 검색 --
desc film_actor;
desc actor;
desc film;

	-- Cate McQueen, Cuba Birch --
select fl.title, ac.first_name, ac.last_name name from film fl
	inner join film_actor fa
		on fl.film_id = fa.film_id
	inner join actor ac
		on fa.actor_id = ac.actor_id
			where ((ac.first_name = 'cate' and ac.last_name = 'mcqueen') 
				or (ac.first_name = 'cuba' and ac.last_name = 'birch'));

	-- Cate와 Cuba가 나왔던 영화 --
select fl.title, ac.first_name, ac.last_name name from film fl
	inner join film_actor fa
		on fl.film_id = fa.film_id
	inner join actor ac
		on fa.actor_id = ac.actor_id
			where ((ac.first_name = 'cate' and ac.last_name = 'mcqueen') 
				or (ac.first_name = 'cuba' and ac.last_name = 'birch'));   
   
	-- Cate와 Cuba가 동시에 나온 영화 --
select f.title, a1.first_name, a2.first_name from film f
	inner join film_actor fa1
		on f.film_id = fa1.film_id
	inner join actor a1
		on fa1.actor_id = a1.actor_id
	inner join film_actor fa2
		on f.film_id = fa2.film_id
	inner join actor a2
		on fa2.actor_id = a2.actor_id
			where ((a1.first_name = 'cate' and a1.last_name = 'mcqueen') 
				and (a2.first_name = 'cuba' and a2.last_name = 'birch'));

-- 내 풀이 --   
select fl.title, concat(ac.first_name, ' ', ac.last_name) name from film fl
	inner join film_actor fa
		on fl.film_id = fa.film_id
	inner join actor ac
		on fa.actor_id = ac.actor_id
			where concat(ac.first_name, ' ', ac.last_name) in ('cate mcqueen', 'cuba birch');


select cate.title, concat(cate.name, ', ', cuba.name) actor from (
	select fl.title, concat(ac.first_name, ' ', ac.last_name) name from film fl
		inner join film_actor fa
			on fl.film_id = fa.film_id
		inner join actor ac
			on fa.actor_id = ac.actor_id
		where concat(ac.first_name, ' ', ac.last_name) = 'cate mcqueen') cate
			inner join (
				select fl.title, concat(ac.first_name, ' ', ac.last_name) name from film fl
					inner join film_actor fa
						on fl.film_id = fa.film_id
					inner join actor ac
						on fa.actor_id = ac.actor_id
							where concat(ac.first_name, ' ', ac.last_name) = 'cuba birch') cuba
			on cate.title = cuba.title;
            
            
-- 영화 대여에 지불 금액을 기준으로 고객을 그룹화한다. --
-- small Fry 0 ~ 74.99
-- Average Joes 75 - 149.99
-- Heavy Hitters 150 ~ 9,999,999.99

select mygroup.name, count(*) count from 
	(select customer_id, sum(amount) total from payment
		group by customer_id) mypayment
	inner join (
		select 'Small Fry' name, 0 low_limit, 74.99 high_limit
			union
		select 'Average Joes' name, 75 low_limit, 149.99 high_limit
			union
		select 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit) mygroup
	on mypayment.total
		between mygroup.low_limit and high_limit
			group by mygroup.name;
