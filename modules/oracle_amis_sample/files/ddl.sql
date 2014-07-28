
rem DDL statements to create tables and other database objects

--------------------------------------------------------
--  DDL for Type STRING_TABLE
--------------------------------------------------------

  CREATE OR REPLACE TYPE "STRING_TABLE" as table of varchar2(500);

/

--------------------------------------------------------
--  DDL for Table WC_FOOTBALL_REGIONS
--------------------------------------------------------

  CREATE TABLE "WC_FOOTBALL_REGIONS" 
   (	"ID" NUMBER(2,0), 
	"NAME" VARCHAR2(30 BYTE), 
	"CONTINENT" VARCHAR2(2 BYTE)
   ) ;
/
--------------------------------------------------------
--  DDL for Table WC_MATCH_RESULTS
--------------------------------------------------------

  CREATE TABLE "WC_MATCH_RESULTS" 
   (	"GROUP1" VARCHAR2(1 BYTE), 
	"HOME_TEAM_ID" NUMBER(2,0), 
	"AWAY_TEAM_ID" NUMBER(2,0), 
	"HOME_GOALS" NUMBER(2,0), 
	"AWAY_GOALS" NUMBER(2,0), 
	"SDM_ID" NUMBER(2,0), 
	"LOCAL_START_TIME" DATE, 
	"SCORING_PROCESS" VARCHAR2(20 BYTE), 
	"ID" NUMBER(2,0)
   ) ;
/
--------------------------------------------------------
--  DDL for Table WC_MATCH_TAGS
--------------------------------------------------------

  CREATE TABLE "WC_MATCH_TAGS" 
   (	"TAG_ID" NUMBER(4,0), 
	"MATCH_ID" NUMBER
   ) ;
/
--------------------------------------------------------
--  DDL for Table WC_STADIUMS
--------------------------------------------------------

  CREATE TABLE "WC_STADIUMS" 
   (	"ID" NUMBER(2,0), 
	"NAME" VARCHAR2(50 BYTE), 
	"CITY" VARCHAR2(50 BYTE), 
	"LATTITUDE" NUMBER(5,2), 
	"LONGITUDE" NUMBER(5,2)
   ) ;
/
--------------------------------------------------------
--  DDL for Table WC_TAGS
--------------------------------------------------------

  CREATE TABLE "WC_TAGS" 
   (	"ID" NUMBER(4,0), 
	"TAG" VARCHAR2(200 BYTE)
   ) ;
/
--------------------------------------------------------
--  DDL for Table WC_TEAMS
--------------------------------------------------------

  CREATE TABLE "WC_TEAMS" 
   (	"ID" NUMBER(2,0), 
	"COUNTRY" VARCHAR2(3 BYTE), 
	"GROUP1" VARCHAR2(1 BYTE), 
	"SEQ_IN_GROUP" NUMBER(1,0), 
	"FIFA_RANK" NUMBER(3,0), 
	"RGN_ID" NUMBER(2,0)
   ) ;
/


