show databases;

create database test;
use test;

create table person (
	person_id smallint unsigned,
    fname varchar(20),
    iname varchar(20),
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