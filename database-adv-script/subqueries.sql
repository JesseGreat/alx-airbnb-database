/* Non-Correlated Subquery: Properties with Average Rating > 4.0
Goal: Find all properties where the average rating (from the reviews table) is greater than 4.0.
*/

SELECT 
    properties.property_id,
    properties.name AS property_name,
    properties.description
FROM properties
WHERE properties.property_id IN (
    SELECT reviews.property_id
    FROM reviews
    GROUP BY reviews.property_id
    HAVING AVG(reviews.rating) > 4.0
)
ORDER BY properties.property_id;


/*
Write a correlated subquery to find users who have made more than 3 bookings.
*/
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS booking_count
FROM 
    users u
JOIN 
    bookings b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name, u.email
HAVING 
    COUNT(b.booking_id) > 3
ORDER BY 
    booking_count DESC;