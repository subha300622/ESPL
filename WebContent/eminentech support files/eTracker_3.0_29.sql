CREATE TABLE  "APM_ADDITIONAL_CLOSED" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"WRMID" NUMBER NOT NULL ENABLE, 
	"ISSUEID" VARCHAR2(12) NOT NULL ENABLE, 
	 CONSTRAINT "APM_ADDITIONAL_CLOSED_PK" PRIMARY KEY ("ID") ENABLE, 
	 CONSTRAINT "APM_ADDITIONAL_CLOSED_CON" UNIQUE ("WRMID", "ISSUEID") ENABLE, 
	 CONSTRAINT "APM_ADDITIONAL_CLOSED_FK" FOREIGN KEY ("WRMID")
	  REFERENCES  "APM_WRM_PLAN" ("ID") ENABLE
   )
/
CREATE SEQUENCE   "APM_ADDITIONAL_CLOSED_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER  NOCYCLE
/
CREATE OR REPLACE TRIGGER  "BI_APM_ADDITIONAL_CLOSED" 
  before insert on "APM_ADDITIONAL_CLOSED"               
  for each row  
begin   
    select "APM_ADDITIONAL_CLOSED_SEQ".nextval into :NEW.ID from dual; 
end; 

/
ALTER TRIGGER  "BI_APM_ADDITIONAL_CLOSED" ENABLE
/