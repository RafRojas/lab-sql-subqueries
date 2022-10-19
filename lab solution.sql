USE sakila;

-- 1) How many copies of the film Hunchback Impossible exist in the inventory system? 

SELECT film_id, title FROM film
WHERE title LIKE 'Hunchback Impossible';

SELECT COUNT(film_id) AS 'Number of copies of Hunchback Impossible' FROM (SELECT f.film_id AS film_id, f.title, i.inventory_id FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
HAVING f.film_id = '439') AS sub1;

-- 2) List all films whose length is longer than the average of all the films.

SELECT AVG(length) FROM film;

SELECT title, length FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length;

-- 3) Use subqueries to display all actors who appear in the film Alone Trip.

SELECT name as 'Actors in Alone Trip' FROM 
(SELECT f.title as title, CONCAT(a.first_name, ' ', a.last_name) as name FROM film as f
JOIN film_actor as fa
ON f.film_id = fa.film_id
JOIN actor as a
ON fa.actor_id = a.actor_id
GROUP BY name) as sub1
WHERE title LIKE 'Alone Trip';

-- 4) Identify all movies categorized as family films.

SELECT title as 'Family movies' FROM (SELECT f.title as title , c.name as name from FILM as f
JOIN film_category as fc
ON f.film_id = fc.film_id
JOIN category as c
ON fc.category_id = c.category_id) as sub1
WHERE name LIKE 'family'
ORDER BY title;

-- 5) Get name and email from customers from Canada using subqueries.

SELECT * FROM (SELECT CONCAT(c.first_name, ' ', c.last_name) as Name, c.email as Email, co.country as Country FROM customer as c
JOIN address as a
ON c.address_id = a.address_id
JOIN city as ci
ON a.city_id = ci.city_id
JOIN country as co
ON ci.country_id = co.country_id) as sub1
WHERE country LIKE 'Canada';

-- 6) Which are films starred by the most prolific actor?

SELECT COUNT(a.actor_id) as ID, CONCAT(a.first_name, ' ', a.last_name) as name FROM film as f
JOIN film_actor as fa
ON f.film_id = fa.film_id
JOIN actor as a
ON fa.actor_id = a.actor_id
GROUP BY a.actor_id
ORDER BY ID DESC;

SELECT title as 'Films by most prolific actor' FROM 
(SELECT a.actor_id as ID, f.title as title, CONCAT(a.first_name, ' ', a.last_name) as name FROM film as f
JOIN film_actor as fa
ON f.film_id = fa.film_id
JOIN actor as a
ON fa.actor_id = a.actor_id) as sub1
WHERE ID LIKE '107'
ORDER BY title;

-- 7) Films rented by most profitable customer.


SELECT CONCAT(c.first_name, ' ', c.last_name) as name, SUM(p.amount) AS Profitability, c.customer_id as customer_id  FROM customer as c
JOIN rental as r
ON c.customer_id = r.customer_id
JOIN payment as p
ON r.customer_id = p.customer_id
GROUP BY name
ORDER BY Profitability DESC;

SELECT title as 'Films rented by most profitable customer' FROM (SELECT f.title as title, r.customer_id as customer_id FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN rental as r
ON i.inventory_id = r.inventory_id)sub1
WHERE customer_id LIKE '526'
ORDER BY title;


-- 8) Customers who spent more than the average payments.

SELECT (AVG(total)) as 'Average payments' FROM (SELECT SUM(amount) as total, customer_id FROM payment
GROUP BY customer_id) as sub1;


SELECT * FROM (SELECT CONCAT(c.first_name, ' ', c.last_name) as name, SUM(p.amount) as total FROM customer as c
JOIN payment as p
ON c.customer_id = p.customer_id
GROUP BY name) as sub1
WHERE total > '112,53'
ORDER BY total ASC;




