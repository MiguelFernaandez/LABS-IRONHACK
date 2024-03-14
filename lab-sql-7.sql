-- 1. How many copies of the film _Hunchback Impossible_ exist in the inventory system?

select i.inventory_id, f.title , i.last_update
from sakila.inventory i left join sakila.film f on i.film_id = f.film_id
where f.title = 'Hunchback Impossible'
order by i.last_update desc;

-- 2. List all films whose length is longer than the average of all the films.

select title, (select avg(length) from sakila.film) as avg_length, length
from sakila.film
where (select avg(length) from sakila.film) < length
order by length desc;

-- 3. Use subqueries to display all actors who appear in the film _Alone Trip_.

select a.first_name, a.last_name, f.title
from sakila.actor a left join sakila.film_actor fa on a.actor_id = fa.actor_id
left join sakila.film f on fa.film_id = f.film_id
where f.title = "Alone Trip";

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

select distinct rating from sakila.film;

select title, rating
from sakila.film
where rating = "PG" or rating = "g";

-- 5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

select cu.first_name,cu.last_name, cu.email
from sakila.customer cu left join sakila.address a on cu.address_id = a.address_id
left join sakila.city c on a.city_id = c.city_id
left join sakila.country co on c.country_id = co.country_id
where  co.country = "Canada";

--  subquery

select cu.first_name,cu.last_name, cu.email
from sakila.customer cu 
where cu.address_id in (select a.address_id from sakila.address a
where a.city_id in (select c.city_id from sakila.city c
where c.country_id in (select co.country_id from sakila.country co 
where co.country = 'Canada')));


-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

select a.first_name, a.last_name, a.actor_id, count(fa.actor_id)
from sakila.actor a left join sakila.film_actor fa on a.actor_id = fa.actor_id
group by a.first_name, a.last_name, a.actor_id
order by count(fa.actor_id) desc
limit 1;

select title from sakila.film where film_id in
	(select film_id from sakila.film_actor where actor_id in 
		(select actor_id from 
			(select count(*) as conteo, actor_id
			from sakila.film_actor 
			group by actor_id
			order by conteo desc
			limit 1
			) as sub1
		) 
	);

-- 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

select customer_id 
from 
	(select sum(amount) as suma_payments, customer_id
    from sakila.payment
    group by customer_id
    order by suma_payments
    limit 1) as sub1;

select title from sakila.film
where film_id in 
	(select film_id from sakila.inventory where inventory_id in 
		(select inventory_id from sakila.rental where customer_id in 
			(select customer_id 
			from (select sum(amount) as suma_payments, customer_id
					from sakila.payment
					group by customer_id
					order by suma_payments
					limit 1
				) as sub1
			)
		)
	);

-- 8. Get the `client_id` and the `total_amount_spent` of those clients who spent more than the average of the `total_amount` spent by each client.

select customer_id, sum(amount) AS total_amount_spent
from sakila.payment
group by customer_id
having sum(amount) > (
    select avg(sum_amount)
    from (
        select sum(amount) as sum_amount
        from sakila.payment
        group by customer_id
    ) as avg_amount
);


