### 연습문제 ###
-- 1. 마당서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오. --
show tables;
select * from customer;
select * from orders;
select * from book;

-- (1) 박지성이 구매한 도서의 출판사 수 --
select count(*) count from book b
	where b.bookid in (
		select distinct bookid from orders o
			where o.custid = (select custid from customer c 
								where c.name = '박지성')
);

-- (2) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이 --
select distinct o.bookid, o.saleprice from orders o
			where o.custid = (select custid from customer c 
								where c.name = '박지성');
                                
select b.bookname, b.price, a.saleprice, (b.price-a.saleprice) diff from book b
	inner join (
		select distinct o.bookid, o.saleprice from orders o
			where o.custid = (select custid from customer c 
								where c.name = '박지성')) a
	on a.bookid = b.bookid;
    
-- (3) 박지성이 구매하지 않은 도서의 이름 -- 
select b.bookid, b.bookname from book b
	 where b.bookid not in (
		select distinct o.bookid from orders o
			where o.custid = (select custid from customer c 
								where c.name = '박지성'));


-- 2. 마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL 문을 작성하시오. --
select * from customer;
select * from orders;
select * from book;

-- (1) 주문하지 않은 고객의 이름(부속질의 사용) --
select custid, name from customer c
	where custid not in (
		select distinct custid from orders
    );
    
 -- (2) 주문 금액의 총액과 주문의 평균 금액 --
select sum(saleprice) sum, avg(saleprice) avg from orders;

-- (3) 고객의 이름과 고객별 구매액 --
select c.name, sum(o.saleprice) total from orders o
	inner join customer c
		on o.custid = c.custid
	group by c.name;
 
 -- (4) 고객의 이름과 고객이 구매한 도서 목록 --
 select c.name, b.bookname from orders o
	inner join customer c
		on o.custid = c.custid
	inner join book b
		on o.bookid = b.bookid;
 
-- (5) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문 --
select max(b.price-o.saleprice) MaxDiff from book b
	inner join orders o
		on b.bookid = o.bookid;
        
select o.orderid, o.custid, b.price, o.saleprice, (b.price-o.saleprice) diff from book b
	inner join orders o
	on o.bookid = b.bookid
		where (b.price-o.saleprice) = (select max(b.price-o.saleprice) from book b
			inner join orders o
				on b.bookid = o.bookid
);
  
-- (6) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름 --
select avg(saleprice) from orders;
select custid, avg(saleprice) avg from orders
	group by custid;

select custid, name from customer
	where custid in (
		select custid from orders
			group by custid
				having avg(saleprice) > (
					select avg(saleprice) from orders));
