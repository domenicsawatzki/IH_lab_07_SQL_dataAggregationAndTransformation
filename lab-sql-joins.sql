USE sakila;

-- Write SQL queries to perform the following tasks using the Sakila database:

-- 1. List the number of films per category.
SELECT c.name AS category, count(fc.film_id) AS number_of_films
FROM  sakila.film_category fc 
JOIN sakila.category c USING (category_id)
GROUP BY c.name;

-- 2. Retrieve the store ID, city, and country for each store.
SELECT s.store_id, c.city, co.country
FROM sakila.store s
JOIN sakila.address a USING (address_id)
JOIN sakila.city c USING (city_id)
JOIN sakila.country co USING (country_id);

-- 3. Calculate the total revenue generated by each store in dollars.
SELECT c.store_id, SUM(p.amount) AS total_revenue
FROM sakila.customer c
JOIN sakila.payment p USING (customer_id)
GROUP BY c.store_id;

-- 4. Determine the average running time of films for each category.
SELECT c.name, ROUND(AVG(f.length),2) AS cat_average
FROM sakila.film f
JOIN sakila.film_category fc USING (film_id)
JOIN sakila.category c USING (category_id)
GROUP BY name;

-- 5. Identify the film categories with the longest average running time.
SELECT c.name, ROUND(AVG(f.length),2) AS cat_average
FROM sakila.film f
JOIN sakila.film_category fc USING (film_id)
JOIN sakila.category c USING (category_id)
GROUP BY name
ORDER BY cat_average DESC
LIMIT 1;

-- 6. Display the top 10 most frequently rented movies in descending order.
SELECT title
FROM sakila.rental r
JOIN sakila.inventory i USING (inventory_id)
JOIN sakila.film f USING (film_id)
GROUP BY film_id
ORDER BY COUNT(*) DESC
LIMIT 10;

-- 7. Determine if "Academy Dinosaur" can be rented from Store 1.
SELECT DISTINCT
CASE
WHEN store_id = 1 AND title = "ACADEMY DINOSAUR" THEN 'TRUE'
ELSE 'FALSE'
END AS Answer
FROM sakila.inventory i
JOIN sakila.film f USING (film_id)
HAVING Answer = 'TRUE';



-- 8.  List of ALL film titles and if they are available in inventory.
SELECT DISTINCT f.title,
CASE 
WHEN i.store_id IS NULL THEN 'not available'
ELSE 'available'
END AS 'Inventory_check'
FROM sakila.film f
LEFT JOIN sakila.inventory i USING (film_id);


