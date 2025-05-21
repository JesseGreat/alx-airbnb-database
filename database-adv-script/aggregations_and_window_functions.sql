/* Total Number of Bookings per User (COUNT and GROUP BY)
Goal: Find the total number of bookings made by each user, using COUNT and GROUP BY.
*/

--Below is the explanation of SQL query to find the total number of bookings made by each user, using COUNT and GROUP BY with 
/*
What it does: Counts how many bookings each user has made, including users with zero bookings.
SELECT:
users.user_id, users.first_name, users.last_name: Gets user details.
COUNT(bookings.booking_id) AS booking_count: Counts the number of bookings per user, named booking_count in the output (like a variable name).
FROM users: Starts with the users table, so we include all users.
LEFT JOIN bookings ON users.user_id = bookings.user_id: Links users to bookings via user_id. Using LEFT JOIN ensures users with no bookings appear (with a count of 0).
GROUP BY users.user_id, users.first_name, users.last_name: Groups rows by user, so COUNT applies per user. All non-aggregated columns (user_id, first_name, last_name) must be in GROUP BY.
ORDER BY booking_count DESC: Sorts users by their booking count, highest to lowest (like sort((a, b) => b.count - a.count) in code).
*/


SELECT 
    users.user_id,
    users.first_name,
    users.last_name,
    COUNT(bookings.booking_id) AS booking_count
FROM users
LEFT JOIN bookings
ON users.user_id = bookings.user_id
GROUP BY users.user_id, users.first_name, users.last_name
ORDER BY booking_count DESC;


/*
Rank Properties by Total Bookings (Window Functions)
Goal: Use a window function (ROW_NUMBER or RANK) to rank properties based on the total number of bookings they’ve received.
*/
--Below is the explanation of SQL query to rank properties by total bookings using window functions (ROW_NUMBER or RANK):
/*
What it does: Counts bookings per property and assigns a rank based on booking count, with the most-booked properties ranked highest.
Window Function: A function that computes a value (like a rank) for each row without collapsing the results (unlike GROUP BY).
SELECT:
properties.property_id, properties.name, properties.description: Property details.
COUNT(bookings.booking_id) AS booking_count: Counts bookings per property.
RANK() OVER (ORDER BY COUNT(bookings.booking_id) DESC) AS booking_rank:
RANK(): Assigns a rank (1 for highest, 2 for next, etc.). Ties get the same rank (e.g., two properties with 3 bookings both get rank 1).
OVER (ORDER BY COUNT(bookings.booking_id) DESC): Defines the "window" (group of rows) to rank, sorting by booking count in descending order.
AS booking_rank: Names the rank column.
FROM properties LEFT JOIN bookings ON properties.property_id = bookings.property_id: Includes all properties, even those with no bookings (count = 0).
GROUP BY properties.property_id, properties.name, properties.description: Groups rows by property for the COUNT.
ORDER BY booking_rank, properties.property_id: Sorts by rank (lowest number first) and property_id as a tiebreaker.
Analogy: Imagine ranking restaurants by order count. RANK() is like assigning #1 to the busiest, #2 to the next, etc., but ties (same order count) share the same rank.
ROW_NUMBER vs. RANK:

ROW_NUMBER(): Gives unique numbers (1, 2, 3, ...) even for ties.
RANK(): Gives the same number for ties (e.g., 1, 1, 3 if two properties tie for first).
I chose RANK because it’s common for rankings with ties (like sports rankings).
*/
SELECT 
    properties.property_id,
    properties.name,
    properties.description,
    COUNT(bookings.booking_id) AS booking_count,
    RANK() OVER (ORDER BY COUNT(bookings.booking_id) DESC) AS booking_rank
FROM properties
LEFT JOIN bookings
ON properties.property_id = bookings.property_id
GROUP BY properties.property_id, properties.name, properties.description
ORDER BY booking_rank, properties.property_id;