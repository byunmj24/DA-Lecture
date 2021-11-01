### 연습문제 1번
select actor_id, first_name, last_name from actor order by last_name asc, first_name; 

### 연습문제 2번
select actor_id, first_name, last_name from actor
		where last_name = 'williams' or last_name = 'davis';
        
### 연습문제 3번
select * from rental;

select rental_id from rental where rental_date like '2005-07-05%';
select rental_id from rental where date(rental_date) = '2005-07-05';

select customer_id from rental
	where rental_date between '2005-07-05 00:00:00' and '2005-07-05 23:59:59';
select customer_id from rental
	where date(rental_date) = '2005-07-05';

### 연습문제 4번
select c.email, r.return_date from customer c
		inner join rental r
				on c.customer_id = r.customer_id
						where date(r.rental_date) = '2005-06-14'
								order by return_date desc, email asc;
	#1  :  r
	#2  :  r.customer_id
    #3  :  return_date desc
    #4  :  email asc