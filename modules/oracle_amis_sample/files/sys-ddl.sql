create user wc identified by wc default tablespace users temporary tablespace temp;

grant connect, create table , create type, create sequence, create view ,create procedure , create session to wc;
	
ALTER USER wc quota unlimited on users;
