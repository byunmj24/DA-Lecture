show databases;

create database test;
use test;

create table person (
	person_id smallint unsigned,
    fname varchar(20),
    lname varchar(20),
    eye_color char(2),
    birth_date date,
    street varchar(30),
    city varchar(20),
    state varchar(20),
    country varchar(20),
    postal_code varchar(20),
    constraint pk_person primary key (person_id)
);

desc person;
drop table person;

alter table person
	modify person_id int unsigned auto_increment;
    
insert into person(
		person_id, fname, lname, eye_color, birth_date
	)
	values (
		null, 'William', 'Turner', 'BR', '1970-04-02'
);

select * from person;


-- Create 실습 --
use bookstore;

create table NewBook(
	bookname varchar(20),
    publisher varchar(20),
    price integer,
    primary key (bookname, publisher)
    );
desc newbook;
drop table newbook;
create table NewBook(
	bookname varchar(20) not null,
    publisher varchar(20) unique,
    price integer default 10000 check(price > 1000),
    primary key (bookname, publisher)
);

create table NewCustomer(
	custid integer primary key,
    name varchar(40),
    address varchar(40),
    phone varchar(30)
);
desc newcustomer;

create table NewOrders(
	orderid integer,
    custid integer not null,
    bookid integer not null,
    saleprice integer,
    orderdate date,
    primary key (orderid),
    foreign key (custid) references newCustomer(custid) on update cascade
);
desc neworders;

alter table newbook add isbn varchar(13);
desc newbook;

alter table newbook modify isbn integer;
alter table newbook drop column isbn;
alter table newbook modify price integer not null;
alter table newbook add primary key(bookid);

drop table newbook;
drop table newcustomer;
drop table neworders;

show tables;

insert into book (
		bookid, bookname, publisher, price
	) values (
		11, '재밌는 음악이야기', '그냥출판사', 12000
    );
select * from book;

update book set bookname = '재미는 음악이야기'
	where bookid = 11;
    
update book set price = 12320
	where bookid = 11;