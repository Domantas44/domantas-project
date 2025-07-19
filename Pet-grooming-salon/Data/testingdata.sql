-- Pet Grooming Salon Database Testing Data, to check if mock data is valid
-- Appointments with valid customer and groomer schedules
SELECT a.appointment_id, c.first_name || ' ' || c.last_name AS customer_name,
       g.first_name || ' ' || g.last_name AS groomer_name,
       a.creation_date
FROM appointment a
JOIN customer c ON a.customer_id = c.customer_id
JOIN groomer_schedule gs ON a.groomer_schedule_id = gs.groomer_schedule_id
JOIN groomer g ON gs.groomer_id = g.groomer_id;

-- Payments linked to appointments
SELECT p.payment_id, a.appointment_id, p.amount, p.payment_date
FROM payment p
JOIN appointment a ON p.appointment_id = a.appointment_id;

-- Pets and their owners
SELECT pet_name, pet_type, c.first_name || ' ' || c.last_name AS owner
FROM pet
JOIN customer c ON pet.customer_id = c.customer_id;

-- Refunds for valid payments
SELECT pr.refund_id, p.payment_id, pr.refund_amount, pr.refund_reason
FROM payment_refund pr
JOIN payment p ON pr.payment_id = p.payment_id;

-- Groomer schedules and linked services
SELECT g.first_name || ' ' || g.last_name AS groomer_name,
       s.service_name, gs.start_time, gs.end_time
FROM groomer_schedule gs
JOIN groomer g ON gs.groomer_id = g.groomer_id
JOIN service s ON gs.service_id = s.service_id;

-- Service and its inventory items
SELECT s.service_name, si.item_name, si.quantity, si.unit_price
FROM service_inventory si
JOIN service s ON si.service_id = s.service_id;

-- Notifications
SELECT an.appointment_id, an.appointment_notification_id, an.notification_text, an.notification_date, an.notification_sent
FROM appointment_notification an
JOIN appointment a ON an.appointment_id = a.appointment_id;

-- Unique constraints check
SELECT email, COUNT(*) FROM customer GROUP BY email HAVING COUNT(*) > 1;
SELECT phone, COUNT(*) FROM groomer GROUP BY phone HAVING COUNT(*) > 1;
SELECT service_name, COUNT(*) FROM service GROUP BY service_name HAVING COUNT(*) > 1;