-- 1. Get film ratings.

select film_id, title, rating
from sakila.film;

select distinct rating
from sakila.film;

-- 2. Get release years.

select film_id, title, release_year
from sakila.film;

select distinct release_year
from sakila.film;

-- 3. Get all films with ARMAGEDDON in the title.

select * 
from sakila.film
where title like '%ARMAGEDDON';

-- 4. Get all films with APOLLO in the title

select *
from sakila.film
where title like '%APOLLO%';

-- 5. Get all films which title ends with APOLLO.

select *
from sakila.film
where title like concat('%', 'APOLLO');

-- 6. Get all films with word DATE in the title.

select *
from sakila.film
where title like '%DATE';

-- 7. Get 10 films with the longest title.

select *
from sakila.film
order by length(title) desc
limit 10;

-- 8. Get 10 the longest films.

select *
from sakila.film
order by length desc
limit 10;

-- 9. How many films include **Behind the Scenes** content?

select special_features
from sakila.film;


select *
from sakila.film
where special_features like '%Behind the Scenes';

-- 10. List films ordered by release year and title in alphabetical order.

select *
from sakila.film
order by release_year, title asc;
