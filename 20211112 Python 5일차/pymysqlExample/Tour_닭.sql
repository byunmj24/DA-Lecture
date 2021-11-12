drop table if exists tour_crawling;
create table tour_crawling (
	id int(11) not null auto_increment primary key,
    title varchar(150) null,
    price varchar(50) null,
    term varchar(50) null,
    area varchar(50) null,
    regdate timestamp null default current_timestamp());
    
    
insert into tour_crawling values
(null, '1','2','3','4', default );
insert into tour_crawling(title, price, term , area)
value('1','2','3','4');
select * from tour_crawling;

drop table if exists pelicana_crawling;

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

insert into pelicana_crawling
(store, sido, gungu, address, phone)
values('1',null,null, null,null);

select * from pelicana_crawling;

truncate pelicana_crawling;