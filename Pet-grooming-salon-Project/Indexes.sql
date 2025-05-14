CREATE INDEX idx_appointments_customers_id ON appointments(customers_id); 
CREATE INDEX idx_appointments_groomers_id ON appointments(groomers_id); 
CREATE INDEX idx_appointments_pet_id ON appointments (pet_id);
CREATE INDEX idx_payments_payment_date ON payments(payments_date); 
CREATE INDEX idx_payments_amount ON payments(amount); 
CREATE INDEX idx_payments_appointment_id ON payments (appointment_id);
CREATE INDEX idx_pets_customer_id ON pets (customer_id);
CREATE INDEX idx_groomer_schedule_groomer_id ON groomer_schedule (groomer_id);
CREATE INDEX idx_groomer_schedule_appointment_id ON groomer_schedule (appointment_id);
CREATE INDEX idx_service_inventory_service_id ON service_inventory (service_id);

