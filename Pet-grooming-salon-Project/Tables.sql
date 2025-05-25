CREATE SEQUENCE customers_seq START WITH 1;
CREATE TABLE customers
(
  customers_id NUMBER   DEFAULT customers_seq.nextval NOT NULL,
  first_name  VARCHAR2(20 CHAR) NOT NULL,
  last_name   VARCHAR2(20 CHAR),
  phone       VARCHAR2(20 BYTE) NOT NULL,
  email       VARCHAR(200 BYTE) NOT NULL,
  CONSTRAINT pk_customers PRIMARY KEY (customers_id)
);

CREATE SEQUENCE groomers_seq START WITH 1;
CREATE TABLE groomers
(
  groomers_id     NUMBER   DEFAULT groomers_seq.nextval NOT NULL,
  first_name      VARCHAR2(20 CHAR) NOT NULL,
  last_name       VARCHAR2(20 CHAR) NOT NULL,
  status          VARCHAR2(20 BYTE) NOT NULL,
  salary          NUMBER   NOT NULL,
  email           VARCHAR2(20 BYTE) NOT NULL,
  phone           VARCHAR2(20 BYTE)  NOT NULL,
  birth_date      DATE,
  address         VARCHAR2(20 CHAR),
  created_by      VARCHAR2(20 BYTE),
  creation_date   DATE DEFAULT SYSDATE,
  last_updated_by VARCHAR2(20 BYTE),
  last_update     DATE DEFAULT SYSDATE,
  CONSTRAINT pk_groomers PRIMARY KEY (groomers_id)
);

CREATE SEQUENCE services_seq START WITH 1;
CREATE TABLE services
(
  services_id  NUMBER   DEFAULT services_seq.nextval NOT NULL, 
  service_name VARCHAR2(20 BYTE) NOT NULL,
  price        NUMBER   NOT NULL,
  description  VARCHAR2(200 BYTE) NOT NULL,
  CONSTRAINT pk_services PRIMARY KEY (services_id)
);

CREATE SEQUENCE pets_seq START WITH 1;
CREATE TABLE pets
(
  pets_id      NUMBER   DEFAULT pets_seq.nextval NOT NULL,
  customer_id  NUMBER   NOT NULL,
  pet_name     VARCHAR2(20 CHAR) NOT NULL,
  pet_type     VARCHAR2(20 CHAR) NOT NULL,
  pet_breed    VARCHAR2(20 CHAR),
  description  VARCHAR2 (255 CHAR),
  CONSTRAINT pk_pets PRIMARY KEY (pets_id)
);

CREATE SEQUENCE appointments_seq START WITH 1; 
CREATE TABLE appointments 
(
  appointments_id       NUMBER    DEFAULT appointments_seq.nextval NOT NULL, 
  customer_id           NUMBER    NOT NULL, 
  groomer_id            NUMBER    NOT NULL, 
  pet_id                NUMBER    NOT NULL, 
  appointment_date      DATE      NOT NULL, 
  appointment_cancelled CHAR(1) DEFAULT 'N' CHECK (appointment_cancelled IN ('Y', 'N')), 
  created_by            VARCHAR2(20 BYTE),
  creation_date         DATE DEFAULT SYSDATE NOT NULL,
  last_updated_by       VARCHAR2(20 BYTE),
  last_update           DATE DEFAULT SYSDATE,
  CONSTRAINT pk_appointments PRIMARY KEY (appointments_id) 
);


CREATE SEQUENCE payments_seq START WITH 1;
CREATE TABLE payments
(
  payments_id     NUMBER   DEFAULT payments_seq.nextval NOT NULL,
  amount          NUMBER   NOT NULL,
  payment_date    DATE     DEFAULT SYSDATE NOT NULL,
  appointment_id  NUMBER   NOT NULL,
  payment_method  VARCHAR2(10 BYTE) NOT NULL,
  created_by      VARCHAR2(20 BYTE),
  creation_date   DATE DEFAULT SYSDATE,
  last_updated_by VARCHAR2(20 BYTE),
  last_update     DATE DEFAULT SYSDATE,
  
  CONSTRAINT pk_payments PRIMARY KEY (payments_id)
);


CREATE SEQUENCE groomer_schedule_seq START WITH 1;
CREATE TABLE groomer_schedule
(
  groomer_schedule_id    NUMBER DEFAULT groomer_schedule_seq.nextval NOT NULL,
  groomer_id      NUMBER NOT NULL,
  appointment_id  NUMBER NOT NULL,
  start_time      DATE NOT NULL,
  end_time        DATE NOT NULL,
  status          VARCHAR2(20 BYTE) DEFAULT 'Available',
  notes           VARCHAR2(255 BYTE),
  created_by      VARCHAR2(20 BYTE),
  creation_date   DATE DEFAULT SYSDATE,
  last_updated_by VARCHAR2(20 BYTE),
  last_update     DATE DEFAULT SYSDATE,
  CONSTRAINT pk_groomer_schedule PRIMARY KEY (groomer_schedule_id)
);


CREATE TABLE appointment_service
(
  appointments_id NUMBER NOT NULL,
  service_id     NUMBER NOT NULL
);

CREATE SEQUENCE items_seq START WITH 1;
CREATE TABLE service_inventory
(
  service_inventory_id  NUMBER DEFAULT items_seq.nextval NOT NULL,
  item_name             VARCHAR2(100 CHAR) NOT NULL,
  quantity              NUMBER   NOT NULL,
  unit_price            NUMBER NOT NULL,
  service_id            NUMBER   NOT NULL,
  created_by            VARCHAR2(20 BYTE),
  creation_date         DATE DEFAULT SYSDATE,
  last_updated_by       VARCHAR2(20 BYTE),
  last_update           DATE DEFAULT SYSDATE,
  CONSTRAINT pk_service_inventory PRIMARY KEY (service_inventory_id)
);

CREATE SEQUENCE notification_seq START WITH 1;
CREATE TABLE appointment_notification
(
  appointment_notification_id   NUMBER             DEFAULT notification_seq.nextval NOT NULL,
  appointments_id               NUMBER             NOT NULL,
  notification_text             VARCHAR2(255 BYTE) NOT NULL,
  notification_date             DATE,
  notification_sent             DATE,
  status                        CHAR(1)            DEFAULT 'N'  CHECK (status IN ('Y', 'N')),
  CONSTRAINT PK_appointment_notification PRIMARY KEY (appointment_notification_id)
);


DROP TABLE customers;
DROP TABLE groomers;
DROP TABLE appointments;
DROP TABLE appointments_service;
DROP TABLE payments;
DROP TABLE services;
DROP TABLE service_inventory;
DROP TABLE pets;
DROP TABLE groomer_schedule;
DROP TABLE appointment_notification;

-- Relationships
ALTER TABLE appointments
  ADD CONSTRAINT fk_customers_to_appointments
    FOREIGN KEY (customers_id)
    REFERENCES customers (customers_id);

ALTER TABLE pets
  ADD CONSTRAINT fk_customers_to_pets
    FOREIGN KEY (customers_id)
    REFERENCES customers (customers_id);

ALTER TABLE payments
  ADD CONSTRAINT fk_appointments_to_payments
    FOREIGN KEY (appointments_id)
    REFERENCES appointments (appointments_id);

ALTER TABLE service_inventory
  ADD CONSTRAINT fk_services_to_service_inventory
    FOREIGN KEY (services_id)
    REFERENCES services (services_id);

ALTER TABLE appointment_service
  ADD CONSTRAINT fk_appointments_to_appointment_service
    FOREIGN KEY (appointments_id)
    REFERENCES appointments (appointments_id);

ALTER TABLE appointment_service
  ADD CONSTRAINT fk_services_to_appointment_service
    FOREIGN KEY (services_id)
    REFERENCES services (services_id);

ALTER TABLE groomer_schedule
  ADD CONSTRAINT fk_appointments_to_groomer_schedule
    FOREIGN KEY (appointments_id)
    REFERENCES appointments (appointments_id);

ALTER TABLE groomer_schedule
  ADD CONSTRAINT fk_groomers_to_groomer_schedule
    FOREIGN KEY (groomers_id)
    REFERENCES groomers (groomers_id);
    
ALTER TABLE appointment_notification
  ADD CONSTRAINT fk_appointments_to_appointment_notification
    FOREIGN KEY (appointments_id)
    REFERENCES appointments (appointments_id);

-- Some suggestions and questions after looking into script
/*
1. Please add comments explaining why you chose these tables, similar to documentation. When starting to create a new database, it's usually better to write comments for tables and attributes. This helps anyone looking at your script to understand more clearly what you intend to create.
    -- Doc
3. When naming, use either upper case or lower case consistently. For example, FK_appointments_TO_services is not the correct way to write it. The script will be more readable if you use one style. Usually, Oracle functions are written in upper case, while attributes are written in lower case.
    -- Noted
2. Can you explain why you need this check?
      appointment_cancelled NUMBER(1) DEFAULT 0 CHECK (appointment_cancelled IN (0, 1)) NOT NULL, -- 'CHECK (appointment_cancelled IN (0, 1))' checks if the number is 1 or 0,  if the appointment was cancelled:  1 - True, 0 - False, if no values are inserted it inserts Default - 0 (Not cancelled)
      -- it is needed for data integrity, so that other values are not allowed to be entered.
      -- 05-11 changed it to char values Y/N more logical and easier to read

3. I see you use the type VARCHAR2(200). There are two ways to write VARCHAR2. 
   Can you check and explain the differences between them and which one is better to use?
    -- Cool! i didnt know till now that you can (and probably must) specify if you want to use bytes or full characters which could be more then 1 byte.
    -- So there are 2 options (byte is default if not specified which is important) "VARCHAR2(200 byte)" and "VARCHAR2(200 char)". 
    -- Byte is used for English, numbers and other single byte symbols, char is not always 1 byte for example certain language words store up to 4 bytes in a single letter.
    -- In another words "Byte" stores certain amount of bytes regardless of how many characters it represents, "Char" stores specified number of characters regardless of how many bytes it has. 

4. For better understanding of tables, I suggest adding comments to the attributes.
   Can you edit your script?
    -- documentation filled

5. I see that you use NOT NULL everywhere. Is it really necessary? For some attributes, you might not need to use it.
   Can you review and make changes where you think it is not necessary? If it is necessary can you explain why you think that?
    -- You're right i am being overly restrictive using not null everywhere, some columns could be left empty and is not mandatory to fill in the data. 
    

6. It will be greate that you creation order end with appointments table, because when you create table or objects ussually start from object which unique and do not have foreign key, it is like primary table and this way is more readable.
    -- Done

7. Also, you need to add audit columns. This makes it easier to check changes. But not for all tables. In this part you also can create triggers.
    -- Working on it, figuring out triggers need more time

8. For this table suggest to add email column to customers table.
    -- Done

9. For DB you can also add one more object for automatic message info, in which person is getting information of his appointment.
    -- Done
10. For pets table I suggest to add one more collumn "description". Because if there specific info about pet that are groomer have to know costumer can add it.
    -- Done
11. Create another table for groomers working calendors.
    -- Done
12. For sequences, I suggest using more understandable names, rather than short ones.
    -- Done
13. For table Identification suggest to use "table name" + _id, this way easer to see for which table it is, because in some tables of yours is different from table name.
    -- Done
14. For the diagram, not all relationships are added.
    -- Should be better now
*/

