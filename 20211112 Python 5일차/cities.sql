USE testdb;
DROP TABLE IF EXISTS cities;
CREATE TABLE cities(id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(255), population INT);
INSERT INTO cities(name, population) VALUES('Bratislava', 432000);
INSERT INTO cities(name, population) VALUES('Budapest', 1759000);
INSERT INTO cities(name, population) VALUES('Prague', 1280000);
INSERT INTO cities(name, population) VALUES('Warsaw', 1748000);
INSERT INTO cities(name, population) VALUES('Los Angeles', 3971000);
INSERT INTO cities(name, population) VALUES('New York', 8550000);
INSERT INTO cities(name, population) VALUES('Edinburgh', 464000);
INSERT INTO cities(name, population) VALUES('Berlin', 3671000);

select * from cities;


select version();
select * from cities;

select * from cities where id = 3;

insert into cities values (null, 'test', 10000);

set @averageVal = 0;
call bookstore.AveragePrice(@averageVal);
select @averageVal;

set @averageVal = 0;
call AveragePrice(@averageVal);
select @averageVal;


create database pythondb;
use pythondb;

create table pelicana_crawling(
	id int auto_increment primary key,
    store varchar(50),
    sido varchar(20),
    gungu varchar(20),
    address varchar(50),
    phone varchar(20),
    regdate timestamp null default current_timestamp()
);