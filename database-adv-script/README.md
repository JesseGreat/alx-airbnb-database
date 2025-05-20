
# SQL JOIN Examples with Explanations

This script is based on the database ERD diagram from the Airbnb project.  
We will explore the different types of JOINs in SQL and how to use them effectively.  
The script contains examples of **INNER JOIN**, **LEFT JOIN**, **RIGHT JOIN** (not included here), and **FULL OUTER JOIN** queries.

---

## INNER JOIN

### Goal:
Get all bookings along with user information.

### What is an INNER JOIN?
- Returns only the rows that have matching values in both tables.
- Perfect for combining data from two tables based on a common attribute.

### Example: Retrieve all bookings with user information

```sql
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
```

### Explanation:
- `FROM bookings b`: Start with the bookings table (aliased as b).
- `INNER JOIN users u`: Join with the users table (aliased as u).
- `ON b.user_id = u.user_id`: Matches rows where `user_id` in bookings equals `user_id` in users.
- `SELECT`: Retrieves booking and user information.

**Why INNER JOIN?**  
It’s strict—only matched rows are returned. Useful for reports where only confirmed relationships (like valid bookings by known users) are needed.

---

## LEFT JOIN

### Goal:
Get all properties and their reviews, including properties that have no reviews.

### What is a LEFT JOIN?
- Returns all rows from the left table and matching rows from the right table.
- If no match, columns from the right table are NULL.

### Example: Retrieve all properties and their reviews

```sql
SSELECT 
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
```

### Explanation:
- `FROM properties p`: Start with the properties table (aliased as p).
- `LEFT JOIN reviews r`: Join with the reviews table (aliased as r).
- `ON p.property_id = r.property_id`: Matches rows by property ID.

---

## FULL OUTER JOIN

### Goal:
Get all users and all bookings, including users without bookings and bookings without users (if any).

### What is a FULL OUTER JOIN?
- Returns all rows from both tables.
- If no match, columns from the missing side are NULL.

### Example: Retrieve all users and their bookings

```sql
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
```

### Explanation:
- `FROM users u`: Start with the users table (aliased as u).
- `FULL OUTER JOIN bookings b`: Join with the bookings table (aliased as b).
- `ON u.user_id = b.user_id`: Matches user and booking by user_id.

---

## Summary

- **INNER JOIN**: Returns only rows where both tables match.  
  _Example: Get bookings and users, but only where a user has a booking._

- **LEFT JOIN**: Returns all rows from the left table and matching rows from the right.  
  _Example: Get all properties and their reviews, including properties with no reviews._

- **FULL OUTER JOIN**: Returns all rows from both tables, NULLs for non-matching sides.  
  _Example: Get all users and all bookings, including users without bookings and bookings without users._
