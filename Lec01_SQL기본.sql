use bookstore;
select * from book;
select bookid, bookname from book;

select publisher, price,bookname from book
		where bookname like '축구의%';
        
select * from customer;
select name, phone from customer customer
		where name = '김연아';
        
use sakila;

select * from actor;

select customer_id, first_name from customer
		where last_name = 'Smith';

select * from language;

select language_id, last_update, name from language;

select name from language;

select upper(name), language_id*3.14
		from language;

create view vlanguage as 
	select upper(name), language_id*3.14
		from language;

select * from vlanguage;

select title, rating, rental_duration from film
		where rating = 'G' and rental_duration >= 7;

-- G등급이고, 7일이상 이거나 PG-13이고 3일 이하인 영화 --
select * from film;
select title from film
		where (rating = 'G' and rental_duration >= 7)
			or (rating = 'PG-13' and rental_duration <= 3);
			
-- 40편 이상의 영화를 대여한 모든 고객 --
select * from rental;
select * from customer;

select c.first_name, c.last_name, a.count 
	from (select count(*) count, customer_id from rental group by customer_id) a 
			inner join customer c 
				on a. customer_id = c.customer_id
					where a.count >= 40;

select customer.first_name, customer.last_name, count(*) count
	from customer
		inner join rental
			on customer.customer_id = rental.customer_id
				group by customer.first_name, customer.last_name
					having count >= 40;

-- 2005년 6월 14일에 영화를 대여한 모든 고객 목록을  --
select customer.first_name, customer.last_name, rental.rental_date
	from customer
		inner join rental
			on customer.customer_id = rental.customer_id
				where rental.rental_date like '2005-06-14%'
					order by rental.rental_date asc;
                    
select c.first_name, c.last_name, time(r.rental_date) time
	from customer c
		inner join rental r
			on c.customer_id = r.customer_id
				where date(r.rental_date) = '2005-06-14'
					order by c.last_name asc;


### 연습문제 1번
select actor_id, first_name, last_name from actor order by last_name asc, first_name; 

### 연습문제 2번
select actor_id, first_name, last_name from actor
		where last_name = 'williams' or last_name = 'davis';
        
### 연습문제 3번
select rental_id from rental where rental_date like '2005-07-05%';
select rental_id from rental where date(rental_date) = '2005-07-05';

### 연습문제 4번
select c.email, r.return_date from customer c
		inner join rental r
				on c.customer_id = r.customer_id
						where date(r.rental_date) = '2005-06-14'
								order by return_date desc;
	#1  :  r
	#2  :  r.customer_id
    #3  :  return_date desc
    #4  :  email asc
    
### 연습문제 2
## (1)