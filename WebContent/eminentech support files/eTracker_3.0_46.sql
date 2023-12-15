
/* In --- Tags --- Table add one new column */


ALTER TABLE TAGS
ADD "TAG_TYPE" NUMBER(10,0) DEFAULT 0  NOT NULL ENABLE

/

/*In --- TAGISSUES--- Table add one new column*/

 

ALTER TABLE TAGISSUES
ADD "ADDEDBY" NUMBER(10,0) DEFAULT 0  NOT NULL ENABLE

/

/*Tag users*/
CREATE TABLE  "TAGSUSERS" 
   (	"TAGUSERID" NUMBER, 
	"USERID" NUMBER NOT NULL ENABLE, 
	"TAG_ID" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "TAGSUSERS_PK" PRIMARY KEY ("TAGUSERID") ENABLE, 
	 CONSTRAINT "TAGSUSERS_UK1" UNIQUE ("USERID", "TAG_ID") ENABLE, 
	 CONSTRAINT "TAGSUSERS_FK" FOREIGN KEY ("TAG_ID")
	  REFERENCES  "TAGS" ("TAG_ID") ENABLE
   )
/
 CREATE SEQUENCE   "TAGUSERS_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE

/
CREATE OR REPLACE TRIGGER  "BI_TAGSUSERS" 
  before insert on "TAGSUSERS"               
  for each row  
begin   
    select "TAGUSERS_SEQ".nextval into :NEW.TAGUSERID from dual; 
end; 

/
ALTER TRIGGER  "BI_TAGSUSERS" ENABLE
/
