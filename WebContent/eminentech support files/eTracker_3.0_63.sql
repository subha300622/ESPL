update lead set industry=''
/

alter table "LEAD" modify ("INDUSTRY" NUMBER ) 
/

alter table "LEAD" add ("LEAD_TYPE" VARCHAR2(50) NULL) 
/

update lead set lead_type='Normal'
/

alter table "CONTACT" add ("CONTACT_TYPE" VARCHAR2(50) NULL) 
/

update contact set contact_type='Normal'
/

CREATE TABLE  "CRM_COMPETITORS" 
   (	"COMPETITOR_ID" NUMBER, 
	"COMPANY" VARCHAR2(500), 
	"COMPETITOR" VARCHAR2(500), 
	"CITY" VARCHAR2(100), 
	"STATE" VARCHAR2(100), 
	"COUNTRY" VARCHAR2(100), 
	 CONSTRAINT "CRM_COMPETITORS_PK" PRIMARY KEY ("COMPETITOR_ID") ENABLE
   )
/

 CREATE SEQUENCE   "CRM_COMPETITORS_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE
/


CREATE OR REPLACE TRIGGER  "BI_CRM_COMPETITORS" 
  before insert on "CRM_COMPETITORS"               
  for each row  
begin   
    select "CRM_COMPETITORS_SEQ".nextval into :NEW.COMPETITOR_ID from dual; 
end; 

/
ALTER TRIGGER  "BI_CRM_COMPETITORS" ENABLE
/


CREATE TABLE  "CRM_COMPANY_SALES" 
   (	"SALES_ID" NUMBER, 
	"COMPANY" VARCHAR2(500), 
	"SALES_YEAR" NUMBER, 
	"SALES" NUMBER, 
	"EMPLOYEES" NUMBER, 
	"IT_SPEND" NUMBER, 
	"ERP_SPEND" NUMBER, 
	 CONSTRAINT "CRM_COMPANY_SALES_PK" PRIMARY KEY ("SALES_ID") ENABLE
   )
/
 CREATE SEQUENCE   "CRM_COMPANY_SALES_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER  NOCYCLE
/
CREATE OR REPLACE TRIGGER  "BI_CRM_COMPANY_SALES" 
  before insert on "CRM_COMPANY_SALES"               
  for each row  
begin   
    select "CRM_COMPANY_SALES_SEQ".nextval into :NEW.SALES_ID from dual; 
end; 

/
ALTER TRIGGER  "BI_CRM_COMPANY_SALES" ENABLE
/



CREATE TABLE  "CRM_COMPANY_PLANTS" 
   (	"PLANT_ID" NUMBER, 
	"COMPANY" VARCHAR2(500), 
	"PLANT_ADDRESS" VARCHAR2(500), 
	"PLANT_AREA" VARCHAR2(100), 
	"PLANT_CITY" VARCHAR2(100), 
	"PLANT_STATE" VARCHAR2(100), 
	"PLANT_COUNTRY" VARCHAR2(100), 
	 CONSTRAINT "CRM_COMPANY_PLANTS_PK" PRIMARY KEY ("PLANT_ID") ENABLE
   )
/

 CREATE SEQUENCE   "CRM_COMPANY_PLANTS_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER  NOCYCLE
/

CREATE OR REPLACE TRIGGER  "BI_CRM_COMPANY_PLANTS" 
  before insert on "CRM_COMPANY_PLANTS"               
  for each row  
begin   
    select "CRM_COMPANY_PLANTS_SEQ".nextval into :NEW.PLANT_ID from dual; 
end; 

/
ALTER TRIGGER  "BI_CRM_COMPANY_PLANTS" ENABLE
/

CREATE TABLE  "CONTACT_WORK_HISTORY" 
   (	"CON_WORK_ID" NUMBER NOT NULL ENABLE, 
	"CONTACTID" NUMBER NOT NULL ENABLE, 
	"COMPANY" VARCHAR2(200), 
	"FROM_YEAR" NUMBER, 
	"TO_YEAR" NUMBER, 
	"ROLE" VARCHAR2(100), 
	"LEADID" NUMBER, 
	 CONSTRAINT "CONTACT_WORK_HISTORY_PK" PRIMARY KEY ("CON_WORK_ID") ENABLE
   )
/

 CREATE SEQUENCE   "CONTACT_WORK_HISTORY_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER  NOCYCLE
/


CREATE OR REPLACE TRIGGER  "BI_CONTACT_WORK_HISTORY" 
  before insert on "CONTACT_WORK_HISTORY"               
  for each row  
begin   
    select "CONTACT_WORK_HISTORY_SEQ".nextval into :NEW.CON_WORK_ID from dual; 
end; 

/
ALTER TRIGGER  "BI_CONTACT_WORK_HISTORY" ENABLE
/


	alter table "CRM_COMPANY_SALES" add ("CURRENCY" VARCHAR2(50) NULL) /


CREATE OR REPLACE FORCE VIEW  "CRM_ANALYSIS" ("COUNTA", "STATE", "INDUSTRY") AS 
  select sum(count) as counta,state,industry from ( 
select count(*) as count,NVL(mailingstate, 'YET TO UPDATE') as state,NVL(i.industry, 'YET TO UPDATE') as INDUSTRY  from contact c left join crm_industry i on c.industry=i.industry_id where roleid=2 group by mailingstate,i.industry  union ALL 
select count(*) as count,NVL(state, 'YET TO UPDATE') as state,NVL(i.industry, 'YET TO UPDATE') as INDUSTRY from lead c left join crm_industry i on c.industry=i.industry_id where roleid=2 group by state,i.industry union ALL 
select count(o.OPPORTUNITYID) as count,NVL(state, 'YET TO UPDATE') as state,NVL(i.industry, 'YET TO UPDATE') as INDUSTRY from OPPORTUNITY o left join lead l on o.LEAD_REFERENCE=l.leadid left join crm_industry i on l.industry=i.industry_id where o.roleid=2 group by state,i.industry) group by state,industry
/

alter table "ERM_APPLICANT" add
("ISFAKE" NUMBER NULL)
/   
update ERM_APPLICANT set isfake=0



CREATE OR REPLACE FORCE VIEW  "ERM_ANALYSIS" ("COUNT", "LOCATION", "SKILLS") AS 
  select count(*) as count,UPPER(CURRENT_LOCATION) as location,UPPER(AREA_OF_EXPERTISE) as skills from ERM_APPLICANT group by UPPER(CURRENT_LOCATION) ,UPPER(AREA_OF_EXPERTISE) order by count desc
/



CREATE OR REPLACE FORCE VIEW  "ERM_CURRENT_EMPLOYER_PROJECT" ("APPLICANT_ID", "CURRENT_EMPLOYER", "CLIENT") AS 
  select e.APPLICANT_ID,NVL(CURRENT_EMPLOYER, 'N/A') as CURRENT_EMPLOYER,NVL(CLIENT, 'N/A') as CLIENT from ERM_APPLICANT_EXPERIENCE e,ERM_APPLICANT_PROJECT p  where  e.APPLICANT_ID=p.APPLICANT_ID and e.APPLICANT_ID in (select APPLICANT_ID from ERM_APPLICANT_EXPERIENCE group by APPLICANT_ID having count(*)=1) union
  select e.APPLICANT_ID,NVL(CURRENT_EMPLOYER, 'N/A') as CURRENT_EMPLOYER,NVL(CLIENT, 'N/A') as CLIENT from ERM_APPLICANT_EXPERIENCE e,ERM_APPLICANT_PROJECT p  where  e.APPLICANT_ID=p.APPLICANT_ID and EXPERIENCE_ID in (select min(EXPERIENCE_ID) from ERM_APPLICANT_EXPERIENCE where APPLICANT_ID in (select APPLICANT_ID  from ERM_APPLICANT_EXPERIENCE group by APPLICANT_ID having count(*)>1) group by APPLICANT_ID)
/

update ERM_APPLICANT set current_location='BANGALORE' where UPPER(current_location) in ('BANAGALORE','BANAGLORE','BANALORE','BANGALOR','BANGALORE CHENNAI','BANGALORE ELECTRONIC CITY PHAS','BANGALORE IND','BANGALORU','BANGALURU','BANGAORE','BEGUR','BENGALORE','BENGALURU','BENGULURU','BENGALURU','BLR','BNAGALORE','BTM','BTM LAYOUT','HSR LAYOUT','HSR','JP NAGAR','KANAKAPURA','MARATHAHALLI BANGALORE','MARATHALLI','RAJAJINAGAR BANGALORE')

update ERM_APPLICANT set current_location='ANDHRA PRADESH' where UPPER(current_location) in ('ANDHRAPRADESH','ANDRAPRADESH')

update ERM_APPLICANT set current_location='CHENNAI' where UPPER(current_location) in ('CHENAI','CHENNNAI')
update ERM_APPLICANT set current_location='COIMBATORE' where UPPER(current_location) in ('COIMBATOUR')
update ERM_APPLICANT set current_location='HYDERABAD' where UPPER(current_location) in ('HYBERABAD','HYD','HYDERABAD AP','HYDERAD','HYDERBAD','HYDHERBAB','HYDRABAD')



CREATE TABLE  "TIMESHEET_CRM_DETAIL" 
   (	"TIME_CRM_ID" NUMBER, 
	"TIMESHEETID" VARCHAR2(20), 
	"REFERENCEID" NUMBER, 
	"CRM_TYPE" VARCHAR2(20), 
	 CONSTRAINT "TIMESHEET_CRM_DETAIL_PK" PRIMARY KEY ("TIME_CRM_ID") ENABLE
   )
/

 CREATE SEQUENCE   "TIMESHEET_CRM_DETAIL_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER  NOCYCLE
/

CREATE OR REPLACE TRIGGER  "BI_TIMESHEET_CRM_DETAIL" 
  before insert on "TIMESHEET_CRM_DETAIL"               
  for each row  
begin   
    select "TIMESHEET_CRM_DETAIL_SEQ".nextval into :NEW.TIME_CRM_ID from dual; 
end; 

/
ALTER TRIGGER  "BI_TIMESHEET_CRM_DETAIL" ENABLE
/

alter table "TIMESHEET" add
("HOURS_IN_OFFICE" NUMBER NULL,
"HOURS_IN_MEETING" NUMBER NULL,
"WON_ACCOUNTS" VARCHAR2(20) NULL,
"MET_DECISION_MAKER" VARCHAR2(20) NULL,
"IDENTITY_DECISION_MAKER" VARCHAR2(20) NULL,    
"MET_INFLUENCER" VARCHAR2(20) NULL,
"IDENTITY_INFLUENCER" VARCHAR2(20) NULL
)

// 


  CREATE OR REPLACE FORCE VIEW "EMINENTTRACKER"."MOM_USER_STATUS_COUNT" ("USERID", "STATUS", "COUNT") AS 
  select userid,status,count(*) as count from MOM_USER_DETAIL where status in ('Intimated','Permission') and EXTRACT( YEAR FROM MOMDATE) = EXTRACT(YEAR FROM sysdate) and EXTRACT( MONTH FROM MOMDATE) = EXTRACT(MONTH FROM sysdate) group by userid,status order by userid,status;
 
//

alter table "mom_for_client" add
("pmanager" NUMBER NULL)

//


 CREATE OR REPLACE FORCE VIEW  "PM_FROM_ISSUES" ("COMMENT_DATE", "YEARS", "WEEKS", "ISSUE", "STATUS", "PID", "COMMENTEDTO") AS 
  select comment_date,to_char(comment_date- 7/24,'IYYY') as years, to_char(comment_date - 7/24,'IW') as weeks,c.issueId as issue,c.status,i.pid,c.COMMENTEDTO from ISSUECOMMENTS c,issue i where i.issueid=c.issueID and c.status in ('Unconfirmed','Solution Review')  and to_char(comment_date - 7/24,'IYYY')>2013 order by comment_date
/


CREATE OR REPLACE FORCE VIEW  "PM_FOR_WRM" ("MOM_CLIENT_ID", "COMMENTEDTO", "COMMENT_DATE", "YEARS", "WEEKS") AS 
  select MOM_CLIENT_ID,COMMENTEDTO,COMMENT_DATE,years,weeks from MOM_FOR_CLIENT c,PM_FROM_ISSUES p where to_char(HELD_ON- 7/24,'IW')=weeks   and to_char(HELD_ON- 7/24,'IYYY')=years and c.pid=p.pid order by MOM_CLIENT_ID
/

create or replace PROCEDURE "MOM_FOR_CLIENT_UPDATE" IS 
BEGIN
 FOR mom_week IN ( SELECT * FROM pm_for_wrm ) 
loop
 UPDATE mom_for_client SET pmanager = mom_week.COMMENTEDTO where mom_client_id = mom_week.mom_client_id; 
end loop; 
 FOR mom_week_new IN ( SELECT * FROM mom_for_client where pmanager is null ) 
loop
 UPDATE mom_for_client SET pmanager = mom_week_new.CREATED_BY where mom_client_id = mom_week_new.mom_client_id; 
end loop; 
END;

//
begin 
MOM_FOR_CLIENT_UPDATE;
end

