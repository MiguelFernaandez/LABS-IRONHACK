select count(distinct last_name)
from sakila.actor;

select count(distinct language_id)
from sakila.film;

select count(rating)
from sakila.film
where rating = 'PG-13';

select film_id, title, length
from sakila.film
order by length desc
limit 10;


select max(payment_date) as 'max date', min(payment_date) as 'min date', datediff(max(payment_date), min(payment_date)) as 'dias pasados'
from sakila.payment;



select rental_id, rental_date, inventory_id, customer_id, staff_id, last_update, month(rental_date) as 'mes', weekday(rental_date) as 'dia de la semana'
from sakila.rental
order by rental_date desc
limit 20;



select rental_id, rental_date, inventory_id, customer_id, staff_id, last_update, month(rental_date) as 'mes', weekday(rental_date) as 'dia de la semana',   dayname(rental_date) as 'nombre del dia'
from sakila.rental
order by rental_date desc
limit 20;


select count(*) as 'n de alquileres', month(rental_date) as mes
from sakila.rental
group by month(rental_date)
order by mes desc
limit 1;


