select * from mvcboard;
select * from members;
select * from item;
select * from product;
select * from saleorder;

CREATE TABLE MEMBERS (
ID VARCHAR2(20) PRIMARY KEY,
PASSWD VARCHAR2(20),
EMAIL VARCHAR2(50),
SIGNUPTIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


create table mvcboard (
	idx number primary key, 
	name varchar2(50) not null, 
	title varchar2(200) not null, 
	content varchar2(2000) not null, 
	postdate date default sysdate not null, 
	ofile varchar2(200), 
	sfile varchar2(30), 
	downcount number(5) default 0 not null, 
	pass varchar2(50) not null, 
	visitcount number default 0 not null
);

CREATE SEQUENCE seq_board_num 
INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;

insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '김우혁', '자료실 제목1 입니다.','내용','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '문혜민', '자료실 제목2 입니다.','내용','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '정찬영', '자료실 제목3 입니다.','내용','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '방휘원', '자료실 제목4 입니다.','내용','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '정하영', '자료실 제목5 입니다.','내용','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '조정희', '자료실 제목6 입니다.','내용','1234');
    
create table product(
id number primary key,
category varchar2(10) not null,
wname varchar2(20) not null,
pname varchar2(20) not null,
sname varchar2(20) not null,
price number default 0,
downprice number default 0,
inputdate varchar2(50),
stock number default 0,
description varchar2(200),
small varchar2(20),
large varchar2(20)
);

create table saleorder(
id number primary key,
name varchar2(20) not null,
orderdate varchar2(20) not null,
addr varchar2(50) not null,
tel varchar2(20) not null,
pay varchar2(10) not null,
cardno varchar2(20) not null,
prodcount number default 0,
total number default 0
);

create table item(
orderid number not null,
mynum number not null,
prodid number not null,
pname varchar2(40),
quantity number default 0,
price number default 0
);    
    
commit;