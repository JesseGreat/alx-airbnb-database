-- ==============================================
-- SAMPLE DATA FOR AIRBNB DATABASE
-- ==============================================

-- 1. Insert Users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
-- Admins
('11111111-1111-1111-1111-111111111111', 'Admin', 'System', 'admin@airbnb.com', '$2a$10$xyz', '+1234567890', 'admin'),

-- Hosts
('22222222-2222-2222-2222-222222222222', 'Sarah', 'Johnson', 'sarah@example.com', '$2a$10$abc', '+1555123456', 'host'),
('33333333-3333-3333-3333-333333333333', 'Michael', 'Chen', 'michael@example.com', '$2a$10$def', '+1555987654', 'host'),

-- Guests
('44444444-4444-4444-4444-444444444444', 'Emma', 'Williams', 'emma@example.com', '$2a$10$ghi', '+1555111222', 'guest'),
('55555555-5555-5555-5555-555555555555', 'James', 'Brown', 'james@example.com', '$2a$10$jkl', '+1555333444', 'guest');

-- 2. Insert Locations
INSERT INTO locations (location_id, address_line1, city, state, country, postal_code, latitude, longitude) VALUES
-- New York
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '123 Main St', 'New York', 'NY', 'USA', '10001', 40.7128, -74.0060),

-- San Francisco
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '456 Market St', 'San Francisco', 'CA', 'USA', '94103', 37.7749, -122.4194),

-- Paris
('cccccccc-cccc-cccc-cccc-cccccccccccc', '789 Rue de Rivoli', 'Paris', 'Île-de-France', 'France', '75001', 48.8566, 2.3522);

-- 3. Insert Properties
INSERT INTO properties (property_id, host_id, location_id, name, description) VALUES
-- Sarah's properties
('dddddddd-dddd-dddd-dddd-dddddddddddd', '22222222-2222-2222-2222-222222222222', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 
 'Cozy NYC Apartment', 'Modern 1-bedroom apartment in Manhattan'),

('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', '22222222-2222-2222-2222-222222222222', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 
 'SF Bay View', 'Luxury condo with bay views'),

-- Michael's property
('ffffffff-ffff-ffff-ffff-ffffffffffff', '33333333-3333-3333-3333-333333333333', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 
 'Parisian Loft', 'Charming loft near Louvre');

-- 4. Insert Pricing
INSERT INTO pricing (pricing_id, property_id, base_price_per_night, min_nights, weekly_discount, monthly_discount, valid_from) VALUES
-- NYC pricing
('11111111-1111-1111-1111-111111111111', 'dddddddd-dddd-dddd-dddd-dddddddddddd', 150.00, 2, 10, 20, '2023-01-01'),

-- SF pricing
('22222222-2222-2222-2222-222222222222', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 250.00, 3, 15, 25, '2023-01-01'),

-- Paris pricing (with seasonal rates)
('33333333-3333-3333-3333-333333333333', 'ffffffff-ffff-ffff-ffff-ffffffffffff', 120.00, 1, 5, 10, '2023-01-01'),
('44444444-4444-4444-4444-444444444444', 'ffffffff-ffff-ffff-ffff-ffffffffffff', 180.00, 1, 5, 10, '2023-06-01');

-- 5. Insert Payment Methods
INSERT INTO payment_methods (payment_method_id, name, is_active, processing_fee) VALUES
('99999999-9999-9999-9999-999999999999', 'Credit Card', TRUE, 2.5),
('88888888-8888-8888-8888-888888888888', 'PayPal', TRUE, 3.0),
('77777777-7777-7777-7777-777777777777', 'Bank Transfer', TRUE, 0.0);

-- 6. Insert Bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
-- Emma's bookings
('55555555-5555-5555-5555-555555555555', 'dddddddd-dddd-dddd-dddd-dddddddddddd', '44444444-4444-4444-4444-444444444444', 
 '2023-05-10', '2023-05-15', 750.00, 'confirmed'),

('66666666-6666-6666-6666-666666666666', 'ffffffff-ffff-ffff-ffff-ffffffffffff', '44444444-4444-4444-4444-444444444444', 
 '2023-07-20', '2023-07-27', 1260.00, 'confirmed'),

-- James' booking
('77777777-7777-7777-7777-777777777777', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', '55555555-5555-5555-5555-555555555555', 
 '2023-06-01', '2023-06-05', 1000.00, 'confirmed');

-- 7. Insert Payments
INSERT INTO payments (payment_id, booking_id, payment_method_id, amount, status, transaction_id) VALUES
('12121212-1212-1212-1212-121212121212', '55555555-5555-5555-5555-555555555555', '99999999-9999-9999-9999-999999999999', 
 750.00, 'paid', 'txn_123456'),

('23232323-2323-2323-2323-232323232323', '66666666-6666-6666-6666-666666666666', '88888888-8888-8888-8888-888888888888', 
 1260.00, 'paid', 'txn_789012'),

('34343434-3434-3434-3434-343434343434', '77777777-7777-7777-7777-777777777777', '99999999-9999-9999-9999-999999999999', 
 1000.00, 'paid', 'txn_345678');

-- 8. Insert Reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment) VALUES
('45454545-4545-4545-4545-454545454545', 'dddddddd-dddd-dddd-dddd-dddddddddddd', '44444444-4444-4444-4444-444444444444', 
 5, 'Great location and very clean!'),

('56565656-5656-5656-5656-565656565656', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', '55555555-5555-5555-5555-555555555555', 
 4, 'Amazing views but street noise at night');

-- 9. Insert Messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body) VALUES
-- Guest to Host
('78787878-7878-7878-7878-787878787878', '44444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222', 
 'Hi Sarah, is the apartment available for late check-in?'),

-- Host to Guest
('89898989-8989-8989-8989-898989898989', '22222222-2222-2222-2222-222222222222', '44444444-4444-4444-4444-444444444444', 
 'Yes Emma, we can arrange a late check-in until 10pm');
