      ------------------------------------------------------------------------------
--------------------------  PET GROOMING SALON by Domantas  -----------------------------
      ------------------------------------------------------------------------------
/*
This dataset schema consists of 8 tables linked together to create
a data model where Pet grooming salon could store/retrieve/analyze data 
that has accumulated while doing business.
*/


-- Section 1

/* 
This part of the code creates 8 previously mentioned tables where
data will be stored. Further explanation of what the code does is written bellow.
*/

CREATE SEQUENCE app_seq START WITH 1; -- creating appointment_id sequence that will start incrementing from 1(When you import data, unique ID for that specific table will be generated, so the rows of data can always be identified by the unique ID);
CREATE TABLE appointments -- Creating table named 'appointments'
(
  appointment_id        NUMBER    DEFAULT app_seq.nextval NOT NULL, -- appointment_id column data type will be 'Number' and its Default values comes from the previously mentioned sequence which generates unique id's.
  customer_id           NUMBER    NOT NULL, -- customer_id (number)
  groomer_id            NUMBER    NOT NULL, 
  pet_id                NUMBER    NOT NULL, 
  appointment_date      DATE      NOT NULL, -- this column stores the date of an appointment event;
  appointment_cancelled NUMBER(1) DEFAULT 0 CHECK (appointment_cancelled IN (0, 1)) NOT NULL, -- 'CHECK (appointment_cancelled IN (0, 1))' checks if the number is 1 or 0,  if the appointment was cancelled:  1 - True, 0 - False, if no values are inserted it inserts Default - 0 (Not cancelled)
  payment_id            NUMBER, -- column that references other table (payments)
  CONSTRAINT PK_appointments PRIMARY KEY (appointment_id) -- this constraint creates primary key for this table (appointment_id)
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


-- Section 2
/* 
After table creation, relationships have to link together these tables, 
so that the data logic and querying (data retrieval) does not break.
Further explanation of what the code does is written bellow.
*/

-- ERD editor automatically written this code, but i will still leave comments on whats what.
--
ALTER TABLE appointments                        --this code block says (the others below are the same logic), that in appointments table customer_id column is a foreign key from another table and that it must reference(match) customer_id in the customers table.
  ADD CONSTRAINT FK_customers_TO_appointments -- this whole data model consists of one to many relationships
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


-- Section 3 (last part)
/*
Index is a performance-tuning method for allowing faster retrieval of records
it creates an entry for each value that appears in the indexed columns.
Indexes are created for columns which are accessed most frequently
*/

CREATE INDEX idx_appointments_customer_id ON appointments(customer_id); 
CREATE INDEX idx_appointments_groomer_id ON appointments(groomer_id); 
CREATE INDEX idx_appointments_appointment_date ON appointments(appointment_date); 
CREATE INDEX idx_payments_payment_id ON payments(payment_id); 
CREATE INDEX idx_payments_payment_date ON payments(payment_date); 
CREATE INDEX idx_groomers_status ON groomers(status); 
CREATE INDEX idx_service_items_items_id ON service_items(items_id); 



-- Some suggestions and questions after looking into script
/*
1. Please add comments explaining why you chose these tables, similar to documentation. When starting to create a new database, it's usually better to write comments for tables and attributes. This helps anyone looking at your script to understand more clearly what you intend to create.

3. When naming, use either upper case or lower case consistently. For example, FK_appointments_TO_services is not the correct way to write it. The script will be more readable if you use one style. Usually, Oracle functions are written in upper case, while attributes are written in lower case.

2. Can you explain why you need this check?
      appointment_cancelled NUMBER(1) DEFAULT 0 CHECK (appointment_cancelled IN (0, 1)) NOT NULL, -- 'CHECK (appointment_cancelled IN (0, 1))' checks if the number is 1 or 0,  if the appointment was cancelled:  1 - True, 0 - False, if no values are inserted it inserts Default - 0 (Not cancelled)

3. I see you use the type VARCHAR2(200). There are two ways to write VARCHAR2. 
   Can you check and explain the differences between them and which one is better to use?

4. For better understanding of tables, I suggest adding comments to the attributes.
   Can you edit your script?

5. I see that you use NOT NULL everywhere. Is it really necessary? For some attributes, you might not need to use it.
   Can you review and make changes where you think it is not necessary? If it is necessary can you explain why you think that?

6. It will be greate that you creation order end with appointments table, because when you create table or objects ussually start from object which unique and do not have foreign key, it is like primary table and this way is more readable.

7. Also, you need to add audit columns. This makes it easier to check changes. But not for all tables. In this part you also can create triggers.

8. For this table suggest to add email column to customers table.

9. For DB you can also add one more object for automatic message info, in which person is getting information of his appointment.

10. For pets table I suggest to add one more collumn "description". Because if there specific info about pet that are groomer have to know costumer can add it.

11. Create another table for groomers working calendors.

12. For sequences, I suggest using more understandable names, rather than short ones.

13. For table Identification suggest to use "table name" + _id, this way easer to see for which table it is, because in some tables of yours is different from table name.

14. For the diagram, not all relationships are added.
*/

