select *
from sakila.actor, sakila.film, customer;

select column_name
from information_schema.columns
where table_name = 'film';


select count(distinct name)
from sakila.language;

select distinct name
from sakila.language;


-- 5.1

select count(distinct store_id) AS total_stores
from sakila.store;

-- 5.2
select count(distinct staff_id)
from sakila.staff;

-- 5.3
select first_name
from sakila.staff;

select *
from sakila.actor
where first_name = 'Scarlett';

select *
from sakila.actor
where last_name = 'Johansson';

select count(distinct film_id)
from sakila.film;

select*
from sakila.film;

select max(length) as max_length, min(length) as min_length
from sakila.film;
-- En horas:
select max(length)/60 as max_length, min(length)/60 as min_length
from sakila.film;

select avg(length)
from sakila.film;

select avg(length) /60
from sakila.film;

select count(length)
from sakila.film
where length/60 > 3;


select max(length(title)) as largest_title
from sakila.film_text;

