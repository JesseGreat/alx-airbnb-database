
# 🏠 Airbnb Database Schema (3NF Optimized)

## 📌 Overview
This schema defines a relational database structure for an Airbnb-style booking application. It follows **Third Normal Form (3NF)** to avoid data redundancy and ensure efficient queries.

---

## 👤 Users Table
Stores information about users: guests, hosts, and admins.

```sql
CREATE TABLE users (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(10) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

---

## 🌍 Locations Table
Holds detailed address information.

```sql
CREATE TABLE locations (
    location_id UUID PRIMARY KEY,
    address_line1 VARCHAR(100) NOT NULL,
    address_line2 VARCHAR(100),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

---

## 🏡 Properties Table
Stores all listed properties.

```sql
CREATE TABLE properties (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL REFERENCES users(user_id),
    location_id UUID NOT NULL REFERENCES locations(location_id),
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (updated_at >= created_at)
);
```

---

## 💵 Pricing Table
Details the price per property.

```sql
CREATE TABLE pricing (
    pricing_id UUID PRIMARY KEY,
    property_id UUID NOT NULL REFERENCES properties(property_id),
    base_price_per_night DECIMAL(10, 2) NOT NULL CHECK (base_price_per_night > 0),
    min_nights INTEGER NOT NULL DEFAULT 1 CHECK (min_nights > 0),
    currency VARCHAR(3) NOT NULL DEFAULT 'USD',
    weekly_discount DECIMAL(5, 2) DEFAULT 0 CHECK (weekly_discount BETWEEN 0 AND 100),
    monthly_discount DECIMAL(5, 2) DEFAULT 0 CHECK (monthly_discount BETWEEN 0 AND 100),
    valid_from DATE NOT NULL DEFAULT CURRENT_DATE,
    valid_to DATE,
    CHECK (valid_to IS NULL OR valid_to > valid_from)
);
```

---

## 📅 Bookings Table
Tracks each guest booking.

```sql
CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL REFERENCES properties(property_id),
    user_id UUID NOT NULL REFERENCES users(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL CHECK (total_price > 0),
    status VARCHAR(10) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (end_date > start_date)
);
```

---

## 💳 Payment Methods Table
Stores types of payments available.

```sql
CREATE TABLE payment_methods (
    payment_method_id UUID PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    processing_fee DECIMAL(5, 2) DEFAULT 0
);
```

---

## 🧾 Payments Table
Logs all payment transactions.

```sql
CREATE TABLE payments (
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL REFERENCES bookings(booking_id),
    payment_method_id UUID NOT NULL REFERENCES payment_methods(payment_method_id),
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL CHECK (status IN ('paid', 'failed', 'refunded', 'pending')),
    transaction_id VARCHAR(100)
);
```

---

## 🌟 Reviews Table
Guests can rate and comment on properties.

```sql
CREATE TABLE reviews (
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL REFERENCES properties(property_id),
    user_id UUID NOT NULL REFERENCES users(user_id),
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

---

## 💬 Messages Table
Stores chat messages between users.

```sql
CREATE TABLE messages (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL REFERENCES users(user_id),
    recipient_id UUID NOT NULL REFERENCES users(user_id),
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN NOT NULL DEFAULT FALSE
);
```

---

## ⚙️ Indexes
Indexes help speed up queries.

```sql
-- Users
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);

-- Properties
CREATE INDEX idx_properties_host ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location_id);

-- Pricing
CREATE INDEX idx_pricing_property ON pricing(property_id);
CREATE INDEX idx_pricing_dates ON pricing(valid_from, valid_to);

-- Bookings
CREATE INDEX idx_bookings_property ON bookings(property_id);
CREATE INDEX idx_bookings_user ON bookings(user_id);
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);
CREATE INDEX idx_bookings_status ON bookings(status);

-- Payments
CREATE INDEX idx_payments_booking ON payments(booking_id);
CREATE INDEX idx_payments_status ON payments(status);
CREATE INDEX idx_payments_method ON payments(payment_method_id);

-- Reviews
CREATE INDEX idx_reviews_property ON reviews(property_id);
CREATE INDEX idx_reviews_user ON reviews(user_id);

-- Messages
CREATE INDEX idx_messages_sender ON messages(sender_id);
CREATE INDEX idx_messages_recipient ON messages(recipient_id);
CREATE INDEX idx_messages_timestamp ON messages(sent_at);
```
