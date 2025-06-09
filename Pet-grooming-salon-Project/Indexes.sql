CREATE INDEX idx_appointment_customer_id ON appointment(customer_id); 
CREATE INDEX idx_appointment_groomer_id ON appointment(groomer_id); 
CREATE INDEX idx_appointment_pet_id ON appointment (pet_id);
CREATE INDEX idx_payment_payment_date ON payment(payment_date); 
CREATE INDEX idx_payment_amount ON payment(amount); 
CREATE INDEX idx_payment_appointment_id ON payment (appointment_id);
CREATE INDEX idx_pet_customer_id ON pet (customer_id);
CREATE INDEX idx_groomer_schedule_groomer_id ON groomer_schedule (groomer_id);
CREATE INDEX idx_groomer_schedule_appointment_id ON groomer_schedule (appointment_id);
CREATE INDEX idx_service_inventory_service_id ON service_inventory (service_id);

