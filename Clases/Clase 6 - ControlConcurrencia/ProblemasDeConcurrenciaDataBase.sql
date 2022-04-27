CREATE DATABASE ProblemaDeConcurrencia
USE ProblemaDeConcurrencia

CREATE TABLE STOCK
(
	id_product int not null identity(1,1) primary key,
	name_product varchar(50) not null,
	amount int 
)

CREATE TABLE PURCHARSE
(
	id_product int not null identity(1,1) primary key,
	name_product varchar(50) not null,
	amount int 
)

CREATE TABLE SALES
(
	id_product int not null identity(1,1) primary key,
	name_product varchar(50) not null,
	amount int 
)
