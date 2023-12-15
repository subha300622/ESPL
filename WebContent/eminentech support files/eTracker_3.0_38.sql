


BEGIN  EXECUTE IMMEDIATE 'DROP TABLE closedissue ';EXCEPTION WHEN OTHERS THEN  IF SQLCODE != -942 THEN RAISE;   END IF;END;
 create table closedissue as (select ics.issueid as issueid,ics.COMMENTEDBY as commenter,ics.COMMENTEDTO as commenterto from ISSUE i,ISSUESTATUS iss,ISSUECOMMENTS ics where i.issueid=iss.issueid and i.issueid=ics.issueid and to_char(i.Modifiedon,'Mon-YYYY')=to_char(sysdate,'Mon-YYYY') and iss.status='Closed' and ics.issueid not in(select DISTINCT s.issueid from ISSUECOMMENTS ic, issuestatus s where ic.issueid=s.issueid and s.status='Closed' and to_char(ic.COMMENT_DATE,'Mon-YYYY')=to_char(sysdate,'Mon-YYYY') and (ic.status='Rejected' or ic.status='Duplicate') )group by ics.issueid,ics.COMMENTEDBY,ics.COMMENTEDTO);


create or replace procedure isuueCloseded is begin EXECUTE IMMEDIATE 'TRUNCATE TABLE closedissue';
 INSERT INTO closedissue (issueid,commenter,commenterto )(select icss.issueid as issueid,icss.COMMENTEDBY as commenter,icss.COMMENTEDTO as commenterto from ISSUE i,ISSUESTATUS iss,ISSUECOMMENTS icss where i.issueid=iss.issueid and iss.issueid=icss.issueid and to_char(i.Modifiedon,'Mon-YYYY')=to_char(sysdate,'Mon-YYYY') and iss.status='Closed' and icss.issueid not in(select issueid from issuestatus where status='Closed' minus (select distinct issueid from issuecomments where status!='Closed' and (status='Verified' OR status='User Error')   group by comment_date ,issueid having to_char(Max(comment_date),'DD-Mon-YYYY HH:mi:ss') =to_char(issuecomments.comment_date,'DD-Mon-YYYY HH:mi:ss'))) group by icss.issueid,icss.COMMENTEDBY,icss.COMMENTEDTO); end isuueCloseded ;