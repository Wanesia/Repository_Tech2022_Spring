#1
select Count(*) from playlist
left join playlisttrack
on playlist.PlaylistId=playlisttrack.PlaylistId
where Name ='Grunge'
;
#2
select * from artist
where Name like '%Jack%' or Name like '%John%' and not Name like '%Martin%'
;
#3
select BillingCountry,SUM(Total) from invoice
group by BillingCountry
having SUM(Total)>100
order by Total desc;
#4
select EmployeeID,employee.Phone from employee
join customer
on employee.EmployeeId = customer.SupportRepId
join invoice
on customer.CustomerId=invoice.CustomerId
join invoiceline
on invoice.InvoiceId=invoiceline.InvoiceId
join track
on invoiceline.TrackId=track.TrackId
join mediatype
on track.MediatypeId=mediatype.mediatypeId
where track.Composer="Miles Davis" and mediatype.Name='MPEG Audio File'
group by EmployeeId
order by EmployeeId
;

#5
select * from album
left join track
on album.AlbumId=track.AlbumID
where track.GenreID='11' and track.Name like 'Samba%';
#6

select genre.Name as Genre,ROUND(AVG(track.Milliseconds/60000),0) as Minutes from genre
left join track
on genre.GenreID=track.GenreID
where ROUND(track.Milliseconds/60000,0) > 30
group by Genre
;


#7
select Count(*) from customer
where State is null;

#8
SELECT count(*) as Clients, CONCAT(employee.FirstName," ",employee.LastName) as Employee from employee
join customer
on customer.SupportRepId=employee.EmployeeId
where customer.Country="USA" or customer.Country="Canada" or customer.Country="Mexico"
GROUP by EmployeeId
having count(*)>6
;



#9
select CONCAT(LastName,",",FirstName), IFNULL(Fax,"S/he has no fax") from customer
where Country='USA'
order by LastName, FirstName
;

#10
select FirstName,LastName, FLOOR(DATEDIFF(HireDate,BirthDate)/365) as HiredAge from employee

