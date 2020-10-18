
# Lab | SQL Queries 8

use sakila;

#Rank films by length.
select title, length, dense_rank() over (order by length desc) as Rank_Length from sakila.film;

#Rank films by length within the rating category.
select*from sakila.film;

select title, rating, length, dense_rank() over (partition by length order by rating) as Ranking from sakila.film;

#Rank languages by the number of films (as original language).
select title, original_language_id, dense_rank() over (order by title) as Ranking_film from sakila.film;

#Rank categories by the number of films.
select a.category_id, b.category_id, a.name, dense_rank() over (order by count(b.film_id) desc) as Rank_Film 
from sakila.film_category as b
join category as a
on a.category_id=b.category_id
group by a.category_id, a.name;

#Which actor has appeared in the most films?
select a.actor_id, b.actor_id, a.first_name, a.last_name, dense_rank() over (order by count(b.film_id) desc) as Rank_Film 
from sakila.actor as a
join film_actor as b
on a.actor_id=b.actor_id
group by a.actor_id, a.first_name, a.last_name;

SELECT * from sakila.actor;
SELECT * from sakila.film_actor;

#Most active customer.
select a.customer_id, b.customer_id, a.first_name, a.last_name, a.active,
dense_rank() over (order by count(b.rental_id) desc) as Ranking 
from sakila.customer as a
join rental as b
on a.customer_id=b.customer_id
group by a.customer_id, a.first_name, a.last_name having a.active=1;

#Most rented film.
select a.inventory_id, b.inventory_id, a.film_id, dense_rank() over (order by count(b.rental_id) desc) as Ranking_film 
from sakila.inventory as a
join rental as b
on a.inventory_id=b.inventory_id
group by a.inventory_id, a.film_id;



