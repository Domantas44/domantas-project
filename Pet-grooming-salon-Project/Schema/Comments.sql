
COMMENT ON TABLE customer IS 
'This table stores customer contact information: first and last name, phone, and email. 
Its a key point for identifying customers across the data system.';

COMMENT ON TABLE groomer IS 
'Groomer table stores all the necessary data about the groomer.';
COMMENT ON COLUMN groomer.groomer_status IS
"Column saves info if the groomer is Available or not. 'Available','Unavailable, 'On vacation', 'Sickness Leave' or another specific reason why the employee cannot work on their schedule";

COMMENT ON TABLE service IS 
'The table stores data about all the services that the grooming salon provides. 
Each service has a unique name and a set price with description.';
COMMENT ON COLUMN service.service_name IS
'This stores unique names that the groomer salon provides as well as they cannot be null';

COMMENT ON TABLE pet IS 
'Pet table stores data about customers pets. It consists of pet_id and customer_id to show which pet belongs to which customer, along with the pets name, type, breed and description. 
This table links customers to the pets they own.';
COMMENT ON COLUMN pet.pet_type IS
'Pet types: Cat, Dog etc..';

COMMENT ON TABLE appointment IS 
'This is the main table where appointments are recorded. 
It tracks which customer and pet the appointment is for and when it is scheduled to happen.';
COMMENT ON COLUMN appointment.groomer_schedule_id IS
'Foreign key from groomer_schedule table, used to display for which groomer_schedule_id this appointment_id is';
COMMENT ON COLUMN appointment.appointment_cancelled IS
"This column is needed for data integrity, so that other values are not allowed to be entered. 'Yes' or 'No' only. Default is 'No'.";

COMMENT ON TABLE payment IS 
'Payment table stores everything about the payments - amount, method, date and who updated the record and when. 
It ensures that each appointments payment can be easily tracked and audited.';
COMMENT ON COLUMN payment.appointment_id IS
'Foreign key from appointment table, used to display for which appointment_id was this payment made.';

COMMENT ON TABLE groomer_schedule IS 
'The groomer_schedule table stores data about a groomers work time - when an appointment started and ended. 
It helps to plan and track the work shifts for each groomer.';

COMMENT ON TABLE service_inventory IS 
'Service_inventory table stores data about items in stock for the services offered by the grooming salon. 
It includes item name, quantity and unit price. 
This table helps monitor product usage and inventory quantity.';

COMMENT ON TABLE appointment_service IS 
"Junction table used to connect 'appointments' and 'services' tables with foreign keys. 
This allows multiple services per appointment and multiple appointments per service. 
It enables flexible service combinations for each customer visit.";

COMMENT ON TABLE appointment_notification IS 
'This table is used to notify the customer about an appointment. 
It stores the message, when it was created and when it was sent.';




