CREATE TABLE  "APM_TARGET_ISSUE_COUNT" 
   (	"TID" NUMBER NOT NULL ENABLE, 
	"PID" NUMBER NOT NULL ENABLE, 
	"TARGET_DATE" DATE NOT NULL ENABLE, 
	"COUNT" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "APM_TARGET_ISSUE_COUNT_PK" PRIMARY KEY ("TID") ENABLE
   )
/

 CREATE SEQUENCE   "APM_TARGET_ISSUE_COUNT_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE
/


CREATE OR REPLACE TRIGGER  "BI_APM_TARGET_ISSUE_COUNT" 
  before insert on "APM_TARGET_ISSUE_COUNT"               
  for each row  
begin   
    select "APM_TARGET_ISSUE_COUNT_SEQ".nextval into :NEW.TID from dual; 
end; 

/
ALTER TRIGGER  "BI_APM_TARGET_ISSUE_COUNT" ENABLE
/
