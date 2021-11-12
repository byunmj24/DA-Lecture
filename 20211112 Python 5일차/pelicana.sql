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