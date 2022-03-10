Use library;

#1
select * from tmember
where cName = 'Jens S.' and dBirth <'1970-01-01' and dNewMember >= '2013-01-01' and dNewMember <= '2013-12-31';
#2
select * from tbook
where nPUblishingCompanyID not in ('32','15')
or cTitle in(select cTitle from tbook
where nPUblishingCompanyID in ('32','15')
and nPublishingYear <2000)
;
#3
select cName,cSurname from tmember
where cPhoneNo is not null and cAddress is null;
#4
select * from tauthor
where cName like 'A%' and cName like '%S%' and cSurname='Byatt' ;

#5
select COUNT(*) from tbook
where nPublishingYear='2007' and nPublishingCompanyID='32';
#6
select Count(*),dLoan from tloan
where dLoan >= '2014-01-01' and dLoan <= '2014-12-31' and cCPR ='0305393207'
group by dLoan;

#7
select Count(*),dLoan from tloan
where dLoan >= '2014-01-01' and dLoan <= '2014-12-31' and cCPR ='0305393207'
group by dLoan
having count(*)>1
;
#8
select * from tmember
order by dNewMember, cSurname, cName;
#9
select cTitle,cName from tbook,ttheme
where nPublishingCompanyID='32';
#10
select cName, cSurname, Count(*) from tauthorship,tauthor
where tauthorship.nAuthorID=tauthor.nAuthorID
group by tauthorship.nAuthorID
;
#11
select tauthor.cName, tauthor.cSurname, MIN(tbook.nPublishingYear) from tauthor
join tauthorship on
tauthorship.nAuthorID=tauthor.nAuthorID
join tbook on
tbook.nBookID=tauthorship.nBookID
group by tauthor.cSurname
;
#12
select tloan.cSignature,tloan.dLoan,tbook.cTitle,tmember.cName,tmember.cSurname  from tmember
join tloan on
tmember.cCPR=tloan.cCPR
join tbookcopy on
tbookcopy.cSignature=tloan.cSignature
join tbook on
tbook.nBookID=tbookcopy.nBookID
;

#14
select ttheme.cName, tbook.cTitle from ttheme
left join tbooktheme
on tbooktheme.nThemeID=ttheme.nThemeID
left join tbook
on tbook.nBookID=tbooktheme.nBookID
group by ttheme.cName
order by ttheme.cName
;


#15
select tmember.cSurname ,tmember.cName, tloan.dLoan from tmember
left join tloan
on tmember.cCPR=tloan.cCPR
left join tbookcopy
on tbookcopy.cSignature= tloan.cSignature
left join tbook
on tbook.nBookID=tbookcopy.nBookID
where tmember.dNewMember between '2013-01-01' and '2013-12-31' and tloan.dLoan between '2013-01-01' and '2013-12-01' or tloan.dLoan is null
group by tmember.cSurname,tmember.cName
order by tmember.cSurname,tmember.cName
;

#16
select tauthor.cName as 'Name',tauthor.cSurname as'Surname',tcountry.cName as 'Nationality', tbook.cTitle as 'Title' from tauthor
left join tnationality
on tnationality.nAuthorID=tauthor.nAuthorID
left join tcountry
on tcountry.nCountryID=tnationality.nCountryID
left join tauthorship
on tauthorship.nAuthorID=tauthor.nAuthorID
left join tbook
on tbook.nBookID=tauthorship.nBookID
order by tauthor.cName, tauthor.cSurname
;

#17
select cTitle from tbook
where nPublishingYear = 1970 or nPublishingYear = 1989
group by cTitle
having count(*)>1
;

#18
select cName,cSurname from tmember
where dNewMember between '2013-01-01' and '2013-12-31'
Union all
select cName,cSurname from tauthor
where cName="William"
;

#19
select cName,cSurname from tmember
where dNewMember=(select MIN(dNewMember) from tmember)
;
#20
select nPublishingYear,count(*) from tbook,
(select tcountry.cName from tcountry
join tnationality on
tcountry.nCountryID=tnationality.nCountryID
join tauthor on
tauthor.nAuthorID=tnationality.nAuthorID
group by tcountry.cName
having count(*)>=3) t3
group by nPublishingYear,cName

;
#21
select tpublishingcompany.cName as 'Name', tcountry.cName as 'Country' from tpublishingcompany
join tcountry
on tcountry.nCountryID=tpublishingcompany.nCountryID
;

#22
select cTitle from tbook 
where not nPublishingCompanyID=32 and nPublishingYear BETWEEN 1926 and 1978
;

#23
Select cName,cSurname from tmember
where cAddress is null and dNewMember >= '2016-01-01'
;
#24
select tcountry.nCountryID from tcountry
join tpublishingcompany
on tpublishingcompany.nCountryID=tcountry.nCountryID
group by nCountryID
;
#25
select tbook.cTitle from tbook
join tpublishingcompany
on tpublishingcompany.nPublishingCompanyID=tbook.nPublishingCompanyID
where not tpublishingcompany.cName='Lynch Inc' and tbook.cTitle like "The Tale%"
;
#26
select ttheme.cName from tpublishingcompany
join tbook
on tbook.nPublishingCompanyID=tpublishingcompany.nPublishingCompanyID
join tbooktheme
on tbooktheme.nBookID=tbook.nBookID
join ttheme
on ttheme.nThemeID=tbooktheme.nThemeID
where tpublishingcompany.cName="Lynch Inc" 
group by ttheme.cName
;

#27
select cTitle from tbook
where cTitle not in(select cTitle from tbook
join tbookcopy on tbook.nBookID=tbookcopy.nBookID
join tloan on tloan.cSignature=tbookcopy.cSignature)
;
#28
select count(*) as "No. of Books", tpublishingcompany.cName  from tpublishingcompany
join tbook
on tbook.nPublishingCompanyID=tpublishingcompany.nPublishingCompanyID
group by tbook.nPublishingCompanyID
;


#29
select Count(*) from tmember
join tloan
on tloan.cCPR=tmember.cCPR
where dLoan between '2013-01-01 00:00:00' and '2013-12-31';

#30
select count(*)  as "No. of Authors",tbook.cTitle from tbook
join tauthorship
on tauthorship.nBookID=tbook.nBookID
group by tauthorship.nAuthorID
having Count(*)>=2;

