      ------------------------------------------------------------------------------
--------------------------  PET GROOMING SALON by Domantas  -----------------------------
      ------------------------------------------------------------------------------
/*
This dataset schema consists of 8 tables linked together to create
a data model where Pet grooming salon could store/retrieve/analyze data 
that has accumulated while doing business.
*/




CREATE SEQUENCE app_seq START WITH 1; -- creating appointment_id sequence that will start incrementing from 1;
CREATE TABLE appointments 
(
  appointment_id        NUMBER    DEFAULT app_seq.nextval NOT NULL, -- appointments id default (number) values are sequence that i created above and it can not be null;
  customer_id           NUMBER    NOT NULL, -- customer_id (number)
  groomer_id            NUMBER    NOT NULL, 
  pet_id                NUMBER    NOT NULL, 
  appointment_date      DATE      NOT NULL, -- this column stores the date of an appointment event;
  appointment_cancelled NUMBER(1) DEFAULT 0 CHECK (appointment_cancelled IN (0, 1)) NOT NULL, -- column where you can see if the appointment was cancelled or not, 0 - False, 1 - True. Default - 0 (Not cancelled)
  payment_id            NUMBER, -- column that references other table (payments)
  CONSTRAINT PK_appointments PRIMARY KEY (appointment_id) -- this constraint creates primary key for the table which is (appointment_id)
);

CREATE SEQUENCE cus_seq START WITH 1;
CREATE TABLE customers
(
  customer_id NUMBER   DEFAULT cus_seq.nextval NOT NULL,
  first_name  VARCHAR2(20) NOT NULL,
  last_name   VARCHAR2(20) NOT NULL,
  phone       NUMBER NOT NULL,
  CONSTRAINT PK_customers PRIMARY KEY (customer_id)
);

CREATE SEQUENCE gro_seq START WITH 1;
CREATE TABLE groomers
(
  groomer_id NUMBER   DEFAULT gro_seq.nextval NOT NULL,
  first_name VARCHAR2(20) NOT NULL,
  last_name  VARCHAR2(20) NOT NULL,
  status     VARCHAR2(20) NOT NULL,
  salary     NUMBER   NOT NULL,
  email      VARCHAR2(30) NOT NULL,
  phone      NUMBER   NOT NULL,
  birth_date DATE     NOT NULL,
  address    VARCHAR2(30) NOT NULL,
  CONSTRAINT PK_groomers PRIMARY KEY (groomer_id)
);

CREATE SEQUENCE pay_seq START WITH 1;
CREATE TABLE payments
(
  payment_id     NUMBER   DEFAULT pay_seq.nextval NOT NULL,
  amount         NUMBER   NOT NULL,
  payment_date   DATE     NOT NULL,
  appointment_id NUMBER   NOT NULL,
  payment_method VARCHAR2(10) NOT NULL,
  CONSTRAINT PK_payments PRIMARY KEY (payment_id)
);

CREATE SEQUENCE pet_seq START WITH 1;
CREATE TABLE pets
(
  pet_id      NUMBER   DEFAULT pet_seq.nextval NOT NULL,
  customer_id NUMBER   NOT NULL,
  pet_name    VARCHAR2(20) NOT NULL,
  pet_breed   VARCHAR2(20) NOT NULL,
  CONSTRAINT PK_pets PRIMARY KEY (pet_id)
);

CREATE SEQUENCE item_seq START WITH 1;
CREATE TABLE service_inventory
(
  item_id    NUMBER DEFAULT item_seq.nextval NOT NULL,
  item_name  VARCHAR2(50) NOT NULL,
  unit       NUMBER   NOT NULL,
  unit_price NUMBER   NOT NULL,
  CONSTRAINT PK_service_inventory PRIMARY KEY (item_id)
);

CREATE TABLE service_items
(
  item_id    NUMBER NOT NULL,
  quantity   NUMBER NOT NULL,
  service_id NUMBER NOT NULL,
  CONSTRAINT PK_service_items PRIMARY KEY (item_id)
);

CREATE TABLE services
(
  service_id     NUMBER   NOT NULL, -- not creating a sequence for services, because there are not too many of them in the business, this would be imported manually
  price          NUMBER   NOT NULL,
  description    VARCHAR2(200) NOT NULL,
  appointment_id NUMBER   NOT NULL,
  CONSTRAINT PK_services PRIMARY KEY (service_id)
);

/* After table creation, relationships have to link together these tables, so that the data logic and querying (data retrieval) does not break.
    ERD editor automatically written this code, but i will still leave comments on whats what.
*/
--
ALTER TABLE appointments                        --this code block says (the others below are the same logic), that in appointments table customer_id column is a foreign key from other table and that it must reference(match) customer_id in the customers table.
  ADD CONSTRAINT FK_customers_TO_appointments -- so this is one to many relationship right there, for now i believe all of this model has to be one to many
    FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id);
--
ALTER TABLE pets
  ADD CONSTRAINT FK_customers_TO_pets
    FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id);

ALTER TABLE appointments
  ADD CONSTRAINT FK_groomers_TO_appointments
    FOREIGN KEY (groomer_id)
    REFERENCES groomers (groomer_id);

ALTER TABLE payments
  ADD CONSTRAINT FK_appointments_TO_payments
    FOREIGN KEY (appointment_id)
    REFERENCES appointments (appointment_id);

ALTER TABLE service_items
  ADD CONSTRAINT FK_services_TO_service_items
    FOREIGN KEY (service_id)
    REFERENCES services (service_id);

ALTER TABLE service_items
  ADD CONSTRAINT FK_service_inventory_TO_service_items
    FOREIGN KEY (item_id)
    REFERENCES service_inventory (item_id);

ALTER TABLE services
  ADD CONSTRAINT FK_appointments_TO_services
    FOREIGN KEY (appointment_id)
    REFERENCES appointments (appointment_id);

/*Data amount on this sort of business should be pretty minor, 
but i still want to practice and write indexes for this particular 
data model.

Index is a performance-tuning method for allowing faster retrieval of records
it creates an entry for each value that appears in the indexed columns.
Indexes are created for columns which are accessed most frequently
*/

-- These are the indexes that i believe are the most beneficial for this data model:
CREATE INDEX idx_appointments_customer_id ON appointments(customer_id); 
CREATE INDEX idx_appointments_groomer_id ON appointments(groomer_id); 
CREATE INDEX idx_appointments_appointment_date ON appointments(appointment_date); 
CREATE INDEX idx_payments_payment_id ON payments(payment_id); 
CREATE INDEX idx_customers_phone ON customers(phone); 
CREATE INDEX idx_groomers_status ON groomers(status); 


---- must finish on friday
-- indexes
-- further explanation and simplification of description
-- few questions for mentor



