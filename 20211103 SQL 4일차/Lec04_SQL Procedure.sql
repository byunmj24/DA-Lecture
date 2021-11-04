delimiter $$
	create procedure userProc()
		begin
			select * from customer;
        end $$
delimiter ;

call userProc();

select * from customer
	where name = '김연아';
    
delimiter $$
	create procedure userProc1(in userName varchar(40))
		begin
			select * from customer
				where name = userName;
        end $$
delimiter ;

call userProc1('김연아');

-- 삽입 작업을 하는 프로시저 --
select * from book;
delimiter //
	create procedure insertBook(
		in myBookId integer,
        in myBookName varchar(40),
        in myPublisher varchar(40),
        in myPrice integer)
	begin
		insert into book(bookid, bookname, publisher, price)
			values (myBookId, myBookName, myPublisher, myPrice);
	end //
delimiter ;

call insertBook('14', '데이터란', 'MJ미디어', 35000);
select * from book; 

-- 동일한 도서가 있는지 점검한 후 삽입하는 프로시저
delimiter //
	create procedure BookInsertOrUpdate(
		in myBookId integer,
        in myBookName varchar(40),
        in myPublisher varchar(40),
        in myPrice integer)
    begin
		declare myCount integer;
        select count(*) into myCount from book
			where bookname like myBookName;
		If mycount != 0 then
			set SQL_SAFE_UPDATES = 0;
            update book set price = myPrice
				where bookname like myBookName;
		else
			insert into book (bookid, bookname, publisher, price)
				values (myBookId, myBookName, myPublisher, myPrice);
		end if;
	end //
delimiter ;

call bookinsertorupdate(15,'스포츠 즐거움','마당과학서적',25000);
select * from book;

call bookinsertorupdate(15,'스포츠 즐거움','마당과학서적',20000);
select * from book;

select avg(price) from book
	where price is not null;

select avg(price) from book;

insert into book values(100,'aaa','aaa',null);

select * from book;

-- Book 테이블에 저장된 도서의 평균가격을 반환하는 프로시저
delimiter //
	create procedure AveragePrice(out averageVal integer)
	begin
		select avg(price) into averageVal from book where price is not null;
	end //
delimiter ;

show procedure status;
call averagePrice(@myResult);

select @myResult;


create table if not exists testTBL(
	id int auto_increment primary key,
    txt char(10)
);

desc testtbl;

delimiter //
	create procedure testTBLInsert(
		in txtValue char(10),
        out outValue int
    )
		begin
			insert into testtbl value (null, txtValue);
			select max(id) into outValue from testtbl;
        end //
delimiter ;

select * from testtbl;

call testTBLInsert('내맘이야2', @myValue);
select concat('현재 입력된 ID :', @myValue) result;


-- Orders 테이블의 판매 도서에 대한 이익을 계산하는 프로시저
delimiter //  
CREATE PROCEDURE Interest()
BEGIN
  DECLARE myInterest INTEGER DEFAULT 0.0;
  DECLARE Price INTEGER;
  DECLARE endOfRow BOOLEAN DEFAULT FALSE; 
  DECLARE InterestCursor CURSOR FOR 
	SELECT saleprice FROM Orders;
  DECLARE CONTINUE handler 
	FOR NOT FOUND SET endOfRow=TRUE;
  OPEN InterestCursor;
  cursor_loop: LOOP
    FETCH InterestCursor INTO Price;
    IF endOfRow THEN LEAVE cursor_loop; 
    END IF;
    IF Price >= 30000 THEN 
        SET myInterest = myInterest + Price * 0.1;
    ELSE 
        SET myInterest = myInterest + Price * 0.05;
    END IF;
  END LOOP cursor_loop;
  CLOSE InterestCursor;
  SELECT CONCAT(' 전체 이익 금액 = ', myInterest);
END;
//
delimiter ;

CALL Interest();


use sqldb;
desc usertbl;
desc buytbl;

select * from usertbl;
select * from buytbl;

-- 테이블에 열 하나 추가 후 구매총액 따라 회원등급 설정
alter table usertbl add grade varchar(5);

select u.userid, u.name, sum(price * amount) total,
		(case when (sum(price * amount) > 0) then '우수고객'
        else '유령고객' end) grade
	from usertbl u
	left outer join buytbl b
		on u.userid = b.userid
	group by u.userid, u.name;

-- 스토어드 프로시저 작성
drop procedure if exists gradeProc;
delimiter //
	create procedure gradeProc()
	begin
		declare id varchar(10); 	-- 사용자 아이디를 저장할 변수
        declare hap bigint; 		-- 총 구매액을 저장할 변수
        declare userGrade char(5);	-- 고객 등급 변수
        
        declare vRowCount int default 0;	-- 커서가 도는 횟수 카운트
        
        declare endOfRow boolean default false;
        
        declare userCursor cursor for	-- 커서 선언
			select u.userid, sum(price * amount) from usertbl u
				left outer join buytbl b
				on u.userid = b.userid
			group by u.userid, u.name;
        
        declare continue handler	-- 커서가 마지막에 도착할 때의 상태값
			for not found set endOfRow = true;
            
		open userCursor;	-- 커서 열기
			grade_loop:LOOP
				fetch userCursor into id, hap;	-- 첫 행 값을 대입, 커서로 만들어진 데이터
				
			if endOfRow then leave grade_loop;	-- 커서가 마지막에 도착하면 Loop를 빠져나감
			end if;
			
			case 
				when (hap >= 1500) then set usergrade = '최우수고객';
				when (hap >= 1000) then set usergrade = '우수고객';
				when (hap >= 1) then set usergrade = '일반고객';
				else set usergrade = '유령고객';
			end case;
			
			update usertbl set grade = usergrade 
				where userId = id;
			
            set vRowCount = vRowCount + 1;	-- 커서가 몇 번을 도는지 카운트 한다.
            
			end loop grade_loop;
		
		select vRowCount;
        close userCursor;	-- 커서 닫기
	end //
delimiter ;

select * from usertbl;
call gradeProc();

