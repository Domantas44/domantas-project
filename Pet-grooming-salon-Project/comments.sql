-- Comments
--COMMENT ON COLUMN table_name.column_name is 'Comment...';
--COMMENT ON TABLE table_name IS '....';
-- Syntax for retrieving them
-- SELECT * FROM user_tab_comments WHERE table_name = 'APPOINTMENTS';
-- SELECT * FROM user_col_comments WHERE table_name = 'APPOINTMENTS';


COMMENT ON TABLE CUSTOMERS IS 'This table stores customer contact information: first and last name, phone and email.';

COMMENT ON TABLE GROOMERS IS 'Groomers table stores all the neccessary data about the groomer.';

COMMENT ON TABLE SERVICES IS 'The table stores data about all the services that grooming salon provides.';

COMMENT ON TABLE PETS IS 'Pets table stores data about customers pets, it consists of pet_id, customer_id that shows 
which customer_id has which pet, pets name, type, breed and the description about that pet.';

COMMENT ON TABLE APPOINTMENTS IS 'This is the main table where appointments will be recorded.';

COMMENT ON TABLE PAYMENTS IS 'Payments table stores data everything about the payments - payment amount, method, date, who and 
when updated the last info about the payment.';

COMMENT ON TABLE SERVICE_INVENTORY IS 'Service_inventory table stores data about what items are stored in the inventory for the services 
that your Grooming salon provides. It consists of item_id, item_name, unit and unit_price.';

COMMENT ON TABLE APPOINTMENT_SERVICE IS 'Junction table, it is used to connect "appointments" and "services" tables with foreign keys.
This enables multiple services per appointment as well as multiple appointments per service.';

COMMENT ON TABLE APPOINTMENT_NOTIFICATION IS 'This table is used for notifying the customer about the appointment.';

COMMENT ON TABLE customers IS 'This table stores customer contact information: first and last name, phone and email.';



