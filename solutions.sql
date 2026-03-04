Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, c.city, co.country from store s
JOIN address a on s.address_id = a. address_id
join city c  on a.city_id = c.city_id
join country co on c.country_id = co.country_id


Write a query to display how much business, in dollars, each store brought in.
SELECT 
    s.store_id AS store_name,  
    SUM(p.amount) AS total_dollars
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id;


What is the average running time of films by category?
SELECT 
    c.name AS category_name,
    AVG(f.length) AS average_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY average_running_time DESC;


Which film categories are longest?
SELECT 
    c.name AS category_name,  round (avg (f.length)) as  average_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY average_length DESC


Display the most frequently rented movies in descending order.
SELECT  f.title AS movie_title,  count (*) as  rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r  ON i.inventory_id = r.inventory_id
GROUP BY f.film_id,  f.title
ORDER BY rental_count DESC

List the top five genres in gross revenue in descending order.
SELECT 
    c.name AS genre,
    SUM(p.amount) AS gross_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY gross_revenue DESC
LIMIT 5;

Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    f.title,
    i.inventory_id,
    CASE 
        WHEN r.rental_id IS NULL THEN 'Available'
        ELSE 'Not Available'
    END AS availability_status
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id 
    AND r.return_date IS NULL
WHERE f.title = 'Academy Dinosaur' 
    AND i.store_id = 1;