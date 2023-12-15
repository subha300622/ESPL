CREATE OR REPLACE FORCE VIEW  "WRMPERIOD" ("PID") AS 
  select pid from project where wrm_day is not null order by  CASE  WHEN wrm_day-to_char(sysdate,'D') < 0 THEN 7+wrm_day-to_char(sysdate,'D') WHEN wrm_day-to_char(sysdate,'D') >= 0 THEN wrm_day-to_char(sysdate,'D')END ,pname

CREATE TABLE  "MOM_MAINTANANCE" 
   (	"MAINTANCE_ID" NUMBER, 
	"USERID" NUMBER NOT NULL ENABLE, 
	"TEAM" NUMBER NOT NULL ENABLE, 
	"SINO" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "MOM_USER_MAINTANANCE_PK" PRIMARY KEY ("MAINTANCE_ID") ENABLE, 
	 CONSTRAINT "MOM_USER_MAINTANANCE_UK1" UNIQUE ("USERID") ENABLE
   )
/

CREATE OR REPLACE TRIGGER  "BI_MOM_USER_MAINTANANCE" 
  before insert on "MOM_MAINTANANCE"               
  for each row  
begin   
    select "MOM_USER_MAINTANANCE_SEQ".nextval into :NEW.MAINTANCE_ID from dual; 
end; 

/
ALTER TRIGGER  "BI_MOM_USER_MAINTANANCE" ENABLE
/
CREATE SEQUENCE   "MOM_USER_MAINTANANCE_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 0 NOORDER  NOCYCLE
/
