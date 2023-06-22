 
###################
--Q1 : Who is the senior most employee based on job title ? 

Select * from employee
ORDER BY levels desc
LIMIT 1

###################
--Q2 : Which countries have the most invoices ? 

Select billing_country, COUNT(*) as Total_invoices from invoice 
GROUP BY billing_country
ORDER BY Total_invoices desc 

###################
--Q3 : What are the top 3 values of total invoices ? \

Select * from invoice 
ORDER by total desc 
LIMIT 3

###################
--Q4 : Which city has the best customers ? We would like to throw a promotional
--MUSIC festival in the city we made the most money. Write a query that 
--returns one city that has the highest sum of invoice totals.
--Return both the city name and sum of all inovice totals. 


Select billing_city, SUM(total) as sum_total  from invoice
GROUP BY billing_city  
ORDER BY sum_total desc
LIMIT 1

###################
--Q5 : Who is the best customer? The customer who has spent the most money 
--will be declared the best customer. Write a query that returns the person
--who has spent the most money. 

Select customer.customer_id, customer.first_name, customer.last_name, 
SUM(invoice.total) as total from customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total desc 
LIMIT 1 


--Q6 : Write query to return the email, first name, last name, & Genre of all 
--Rock Music listeners. Return your list ordered alphabetically by email 
--starting with A

SELECT DISTINCT c.email, c.first_name, c.last_name
FROM customer AS c 
JOIN invoice AS i ON c.customer_id = i.customer_id
JOIN invoice_line AS il ON i.invoice_id = il.invoice_id
JOIN track AS t ON il.track_id = t.track_id
JOIN genre AS g ON t.genre_id = g.genre_id
WHERE g.name LIKE 'Rock'
ORDER BY c.email;

--Q7 : Let's invite the artists who have written the most rock music 
--in our dataset. Write a query that returns the Artist name and total 
--track count of the top 10 rock bands

select distinct artist.name ,Count(g.genre_id) as Count_of_rock_songs from artist
join album as a on artist.artist_id = a.artist_id
join track as t on a.album_id = t.album_id 
join genre as g on t.genre_id = g.genre_id 
where g.name like 'Rock'
group by artist.name 
order by Count_of_rock_songs desc 
limit 10

--Q8 : Return all the track names that have a song length longer than the 
--average song length. Return the Name and Milliseconds for each track. 
--Order by the song length with the longest songs listed first

Select name, milliseconds from track 
where milliseconds > ( 
	Select AVG(milliseconds) as Song_length from track
)
order by milliseconds desc

--Q9 : Find how much amount spent by each customer on artists? 
--Write a query to return customer name, artist name and total spent

select distinct c.first_name as customer_name, 
artist.name as artist_name, i.total as total from artist
join album as a on artist.artist_id = a.artist_id
join track as t on a.album_id = t.album_id
join invoice_line as il on t.track_id = il.track_id
join invoice as i on il.invoice_id = i.invoice_id
join customer as c on i.customer_id = c.customer_id
order by total desc

--Q10 : We want to find out the most popular music Genre for each country.
--We determine the most popular genre as the genre with the highest amount of
--purchases. Write a query that returns each country along with the top Genre.
--For countries where the maximum number of purchases is shared return all 
--Genres


--Q11 : Write a query that determines the customer that has spent the
--most on music for each country. Write a query that returns the country along
--with the top customer and how much they spent. For countries where the top 
--amount spent is shared, provide all customers who spent this amount