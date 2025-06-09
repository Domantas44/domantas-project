--COMMENT ON COLUMN table_name.column_name is 'Comment...';
--COMMENT ON TABLE table_name IS '....';
-- Syntax for retrieving them
-- SELECT * FROM user_tab_comments WHERE table_name = 'APPOINTMENTS';
-- SELECT * FROM user_col_comments WHERE table_name = 'APPOINTMENTS';


COMMENT ON TABLE CUSTOMER IS 
'This table stores customer contact information: first and last name, phone, and email. 
The primary key is customer_id, and it increments using the sequence named "customer_seq" - the same logic is used in other tables as well. 
Its a key point for identifying customers across the data system.';

COMMENT ON TABLE GROOMER IS 
'Groomer table stores all the necessary data about the groomer. 
Auditing columns (created_by, creation_date, last_updated_by, last_update) are self-explanatory they show who created the record, when it was created, who last updated it, and when. 
This table helps manage groomer schedules and availability.';

COMMENT ON TABLE SERVICE IS 
'The table stores data about all the services that the grooming salon provides. 
Each service has a unique name and a set price with description.';

COMMENT ON TABLE PET IS 
'Pet table stores data about customers pets. It consists of pet_id and customer_id to show which pet belongs to which customer, along with the pets name, type, breed, and description. 
This table links customers to the pets they own.';

COMMENT ON TABLE APPOINTMENT IS 
'This is the main table where appointments are recorded. 
It tracks which customer and pet the appointment is for and when it is scheduled to happen.';

COMMENT ON TABLE PAYMENT IS 
'Payment table stores everything about the payments - amount, method, date, and who updated the record and when. 
It ensures that each appointments payment can be easily tracked and audited.';

COMMENT ON TABLE GROOMER_SCHEDULE IS 
'The groomer_schedule table stores data about a groomers work time - when an appointment started and ended. 
The groomer_status column shows if the groomer is "Available", "Unavailable", "On Vacation", etc. 
It helps to plan and track the work shifts for each groomer.';

COMMENT ON TABLE SERVICE_INVENTORY IS 
'Service_inventory table stores data about items in stock for the services offered by the grooming salon. 
It includes item name, quantity and unit price. 
This table helps monitor product usage and inventory quantity.';

COMMENT ON TABLE APPOINTMENT_SERVICE IS 
'Junction table used to connect "appointments" and "services" tables with foreign keys. 
This allows multiple services per appointment and multiple appointments per service. 
It enables flexible service combinations for each customer visit.';

COMMENT ON TABLE APPOINTMENT_NOTIFICATION IS 
'This table is used to notify the customer about an appointment. 
It stores the message, when it was created, and when it was sent.';




