-- <실습 4> --
CREATE DATABASE IF NOT EXISTS testDB;
USE testDB;
CREATE TABLE IF NOT EXISTS testTbl (id INT, txt VARCHAR(10));
INSERT INTO testTbl VALUES(1, '레드벨벳');
INSERT INTO testTbl VALUES(2, '잇지');
INSERT INTO testTbl VALUES(3, '블랙핑크');

DROP TRIGGER IF EXISTS testTrg;
DELIMITER // 
CREATE TRIGGER testTrg  -- 트리거 이름
    AFTER  DELETE -- 삭제후에 작동하도록 지정
    ON testTbl -- 트리거를 부착할 테이블
    FOR EACH ROW -- 각 행마다 적용시킴
BEGIN
	SET @msg = '가수 그룹이 삭제됨' ; -- 트리거 실행시 작동되는 코드들
END // 
DELIMITER ;

SET @msg = '';
INSERT INTO testTbl VALUES(4, '마마무');
SELECT @msg;
UPDATE testTbl SET txt = '블핑' WHERE id = 3;
SELECT @msg;
DELETE FROM testTbl WHERE id = 4;
SELECT @msg;
-- </실습 4> --

delimiter //
	create trigger testTrg
		after delete on testTbl for each row
    begin
		set @msg = '가수 그룹이 삭제됨';
    end //
delimiter ;

select * from testtbl;
set @msg = '';
select @msg;
insert into testtbl values(4, '마마무');
insert into testtbl values(5, 'ㅇㅇㅇ');
insert into testtbl values(6, 'aaa');

set SQL_SAFE_UPDATES = 0;
delete from testtbl where id = 4;

use sqlDB;
DROP TABLE buyTbl; -- 구매테이블은 실습에 필요없으므로 삭제.
Drop table if exists backup_userTbl;
CREATE TABLE backup_userTbl
( id int auto_increment primary key,
  userID  CHAR(8) NOT NULL, 
  name    VARCHAR(10) NOT NULL, 
  birthYear   INT NOT NULL,  
  addr	  CHAR(2) NOT NULL, 
  mobile1	CHAR(3), 
  mobile2   CHAR(8), 
  height    SMALLINT,  
  mDate    DATE,
  modType  CHAR(2), -- 변경된 타입. '수정' 또는 '삭제'
  modDate  DATE, -- 변경된 날짜
  modUser  VARCHAR(256) -- 변경한 사용자
);

desc backup_userTbl;

DROP TRIGGER IF EXISTS backUserTbl_UpdateTrg;
DELIMITER // 
CREATE TRIGGER backUserTbl_UpdateTrg  -- 트리거 이름
    AFTER UPDATE -- 변경 후에 작동하도록 지정
    ON userTBL -- 트리거를 부착할 테이블
    FOR EACH ROW 
BEGIN
    INSERT INTO backup_userTbl VALUES(null, OLD.userID, OLD.name, OLD.birthYear, 
        OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, 
        '수정', CURDATE(), USER());
END // 
DELIMITER ;

DROP TRIGGER IF EXISTS backUserTbl_DeleteTrg;
DELIMITER // 
CREATE TRIGGER backUserTbl_DeleteTrg  -- 트리거 이름
    AFTER DELETE -- 삭제 후에 작동하도록 지정
    ON userTBL -- 트리거를 부착할 테이블
    FOR EACH ROW 
BEGIN
    INSERT INTO backup_userTbl VALUES(null, OLD.userID, OLD.name, OLD.birthYear, 
        OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, 
        '삭제', CURDATE(), USER());
END // 
DELIMITER ;

select current_user();

show triggers;

select * from usertbl;
update usertbl set height = height * 1.1;

use sqldb;
select * from backup_userTbl;

/*
use mysql;
select * from user;

alter user MJ identified by 'mj1234'; -- 비밀번호 변경?
grant all privileges on *.* to MJ@localhost identified by 'mj147856';
*/

use sqlDB;
SET GLOBAL log_bin_trust_function_creators = 1;
drop function if exists getAgeFunc;
delimiter //
	create function getAgeFunc(bYear int)
		returns int
	begin
		declare age int;
        set age = year(curdate()) - bYear;
        return age;
    end //
delimiter ;

select getagefunc(1990);