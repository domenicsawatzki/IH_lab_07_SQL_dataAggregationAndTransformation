USE sakila;

-- How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT c.name, count(fc.film_id)  AS number_of_films
FROM sakila.film_category fc
JOIN sakila.category c USING (category_id)
GROUP BY fc.category_id
ORDER BY number_of_films DESC;

-- Display the total amount rung up by each staff member in August of 2005.
SELECT CONCAT(s.first_name, ' ', s.last_name) AS name, SUM(amount) AS total_amount
FROM sakila.payment p
JOIN sakila.staff s USING (staff_id)
WHERE p.payment_date LIKE '2005-08%'
GROUP BY p.staff_id;

-- Which actor has appeared in the most films?
SELECT  fa.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS actor, count(f.title) AS number_of_films
FROM sakila.film f
JOIN sakila.film_actor fa ON f.film_id = fa.film_id
JOIN sakila.actor a ON fa.actor_id = a.actor_id
GROUP BY fa.actor_id
ORDER BY number_of_films DESC
LIMIT 1;


-- Most active customer (the customer that has rented the most number of films)
SELECT r.customer_id, COUNT(r.rental_id) AS number_of_rental
FROM sakila.rental r
GROUP BY r.customer_id
ORDER BY number_of_rental DESC
LIMIT 1;

-- Display the first and last names, as well as the address, of each staff member.
SELECT s.first_name, s.last_name, a.address
FROM sakila.staff s
JOIN sakila.address a ON s.address_id = a.address_id;


-- List each film and the number of actors who are listed for that film.
SELECT title, COUNT(actor_id) AS number_of_actors
FROM sakila.film f
JOIN sakila.film_actor fa ON f.film_id = fa.film_id
GROUP BY title;

-- Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT c.first_name, c.last_name, SUM(amount) AS payment
FROM sakila.payment p
JOIN sakila.customer c USING (customer_id)
GROUP BY p.customer_id
ORDER BY c.last_name ASC;

-- List the titles of films per category.
SELECT c.name, f.title
FROM sakila.film f
JOIN film_category fc USING(film_id)
JOIN sakila.category c USING(category_id);
