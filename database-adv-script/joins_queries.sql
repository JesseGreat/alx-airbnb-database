/* This script was based on the database ERD diagram from the Airbnb project.
then we will be talking about the different types of joins in SQL and how to use them effectively.
The script contains examples of INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL OUTER JOIN queries.
*/
-- INNER JOIN
-- INNER JOIN: Retrieve All Bookings with User Information
-- Goal: Get all bookings along with user information.
-- What is an INNER JOIN?
-- Returns only the rows that have matching values in both tables.
-- Perfect for when you need to combine data from two tables based on a common attribute.
-- Example: Retrieve all bookings with user information
-- This query retrieves all bookings along with the user information for each booking.
-- It uses an INNER JOIN to combine the bookings and users tables based on the user_id.
-- The result will include only those bookings that have a corresponding user in the users table.

--Explanation of the below INNER JOIN query:
-- FROM bookings b: Start with the bookings table (aliased as b).
-- INNER JOIN users u: Join with the users table (aliased as u).
-- ON b.user_id = u.user_id: Matches rows where user_id in bookings equals user_id in users. Since user_id is a UUID in both tables and bookings.user_id is a foreign key referencing users.user_id, this ensures valid matches.
-- SELECT: Pulls booking_id, user_id, user’s first_name and last_name, booking dates, total_price, and status.
-- Result: Only bookings linked to a user appear. If a booking has an invalid user_id (unlikely due to the foreign key constraint), it’s excluded. Users with no bookings are also excluded.
-- Why INNER JOIN?: It’s strict—only matched rows are returned. This is useful for reports where you only want confirmed relationships (e.g., valid bookings by known users).

SELECT
    b.booking_id,
    b.user_id,
    u.first_name,
    u.last_name,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM bookings b
INNER JOIN users u
ON b.user_id = u.user_id;





-- -- LEFT JOIN
-- LEFT JOIN: Retrieve All Properties and Their Reviews (Including Properties with No Reviews)
-- Goal: Get all properties and their reviews, including properties that have no reviews.

-- What is a LEFT JOIN? Left Join returns all rows from the left table (properties) and matching rows from the right table (reviews). If no match exists, reviews columns return NULL.
-- Perfect for listing all properties, even those without reviews.
-- Example: Retrieve all properties and their reviews

-- This query retrieves all properties and their reviews, including properties that have no reviews.
-- It uses a LEFT JOIN to combine the properties and reviews tables based on the property_id.

SELECT 
    properties.property_id,
    properties.name AS property_name,
    properties.description,
    reviews.review_id,
    reviews.rating,
    reviews.comment
FROM properties
LEFT JOIN reviews
ON properties.property_id = reviews.property_id
ORDER BY properties.property_id;

--Explanation of the above LEFT JOIN query:
-- FROM properties p: Start with the properties table (aliased as p).
-- LEFT JOIN reviews r: Join with the reviews table (aliased as r).
-- ON p.property_id = r.property_id: Matches rows where property_id in properties equals property_id in reviews



--FULL OUTER JOIN
--Goal: Get all users and all bookings, including users without bookings and bookings without users (if any).
-- What is a FULL OUTER JOIN? Full Outer Join returns all rows from both tables. If there’s no match, NULLs are returned for the missing side.
-- Perfect for comprehensive reports where you want to see everything, even if some data is missing.
-- Example: Retrieve all users and their bookings
-- This query retrieves all users and their bookings, including users that have no bookings and bookings that have no associated users.
-- It uses a FULL OUTER JOIN to combine the users and bookings tables based on the user_id.

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM users u
FULL OUTER JOIN bookings b
ON u.user_id = b.user_id;

--Explanation of the above FULL OUTER JOIN query:
-- FROM users u: Start with the users table (aliased as u).
-- FULL OUTER JOIN bookings b: Join with the bookings table (aliased as b).
-- ON u.user_id = b.user_id: Matches rows where user_id in users equals user_id in bookings.
-- SELECT: Pulls user_id, first_name, last_name, email from users and booking_id, property_id, start_date, end_date from bookings.


/* in summary 
INNER JOIN: Returns only rows where both tables match. Example: Get bookings and users, but only where a user has a booking (excludes users without bookings or bookings without users).
LEFT JOIN: Returns all rows from the left table and matching rows from the right table; if no match, right table columns are NULL. Example: Get all properties and their reviews, including properties with no reviews.
FULL OUTER JOIN: Returns all rows from both tables, with NULL for non-matching rows. Example: Get all users and all bookings, including users without bookings and bookings without users (if any).
*/