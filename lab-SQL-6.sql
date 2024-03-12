-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

select rank() over (order by length desc) as rango, title, length
from sakila.film
where length != '' or length != ' ';
 
select row_number() over (order by length desc) as rango, title, length
from sakila.film
where length != '' or length != ' '
order by rango, title;

-- 2. Rank films by length within the `rating` category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.  

select title, row_number() over (order by length desc) as 'rank', length, rating
from sakila.film
where rating != '' or rating != ' '
order by rating, 'rank';

-- 3. How many films are there for each of the categories in the category table? **Hint**: Use appropriate join between the tables "category" and "film_category".

select c.name as category, count(fc.film_id) as conteo
from sakila.category c
join sakila.film_category fc on c.category_id = fc.category_id
group by c.name
order by conteo desc;

-- 4. Which actor has appeared in the most films? **Hint**: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

select a.first_name as nombre, a.last_name as apellido, count(fa.film_id) as conteo
from sakila.actor a
join sakila.film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id
order by conteo desc;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? **Hint**: Use appropriate join between the tables "customer" and "rental" and count the `rental_id` for each customer.

select c.first_name as nombre, c.last_name as apellido, count(r.customer_id) as conteo
from sakila.customer c join sakila.rental r on r.customer_id = c.customer_id
group by c.customer_id
order by conteo desc;

-- 6. List the number of films per category.

select count(fc.film_id) as conteo, c.name as categoria
from sakila.film_category fc join sakila.category c on fc.category_id = c.category_id
group by c.name
order by conteo desc;

-- 7. Display the first and the last names, as well as the address, of each staff member.

select s.first_name, s.last_name, a.address, a.district
from sakila.staff s join sakila.address a on s.address_id = a.address_id;

-- 8. Display the total amount rung up by each staff member in August 2005.

select sum(amount) as 'facturado', staff_id
from sakila.payment
where payment_date between '2005-08-01' and '2005-08-31'
group by staff_id;

-- 9. List all films and the number of actors who are listed for each film.

select actor_id, film_id
from sakila.film_actor
order by film_id asc;

select a.first_name as nombre, a.last_name as apellido, fa.film_id
from sakila.actor a join sakila.film_actor fa on a.actor_id = fa.actor_id
order by film_id;

-- 10. Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names.

select c.customer_id as ID, c.first_name as nombre, c.last_name as apellido, sum(p.amount) as pagado
from sakila.customer c join sakila.payment p on c.customer_id = p.customer_id
group by c.customer_id
order by c.last_name, pagado desc;

-- 11. Write a query to display for each store its store ID, city, and country.

select s.store_id, a.address, c.city, co.country
from sakila.store s join sakila.address a on s.address_id = a.address_id
join sakila.city c on c.city_id = a.city_id
join sakila.country co on c.country_id=co.country_id;

-- 12. Write a query to display how much business, in dollars, each store brought in.

select s.store_id, sum(p.amount) as 'total'
from sakila.store s
left join sakila.staff st on s.store_id = st.store_id
left join sakila.payment p on st.staff_id = p.staff_id
group by s.store_id
order by total desc;



-- 13. What is the average running time of films by category?

select avg(f.length) as duracion_media, c.name
from sakila.film f
join sakila.film_category fc on f.film_id = fc.film_id
join sakila.category c on fc.category_id = c.category_id
group by c.name
order by duracion_media;


-- 14. Which film categories are longest?

select avg(f.length) as duracion_media, c.name
from sakila.film f
join sakila.film_category fc on f.film_id = fc.film_id
join sakila.category c on fc.category_id = c.category_id
group by c.name
order by duracion_media
limit 1;

-- Las peliculas de ciencia ficcion son las más largas

-- 15. Display the most frequently rented movies in descending order.

select count(i.film_id) as conteo, f.title
from sakila.inventory i join sakila.film f on i.film_id = f.film_id
group by f.title
order by conteo desc;

-- 16. List the top five genres in gross revenue in descending order.

select c.name as genre, sum(p.amount) as total
from sakila.payment p
join sakila.rental r on p.rental_id = r.rental_id
join sakila.inventory i on r.inventory_id = i.inventory_id
join sakila.film_category fc on i.film_id = fc.film_id
join sakila.category c on fc.category_id = c.category_id
group by c.name
order by total desc
limit 5;


-- 17. Is "Academy Dinosaur" available for rent from Store 1?

select f.title, i.store_id, i.inventory_id, i.last_update
from sakila.film f join sakila.inventory i on f.film_id = i.film_id
where f.title = 'Academy Dinosaur' and i.inventory_id > 0 and store_id = 1;
