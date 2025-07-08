CREATE TABLE customer
(
  customer_id NUMBER             DEFAULT customer_seq.nextval,
  first_name   VARCHAR2(20 CHAR) NOT NULL,
  last_name    VARCHAR2(20 CHAR),
  phone        VARCHAR2(20 CHAR) NOT NULL,
  email        VARCHAR(200 CHAR) NOT NULL,
  CONSTRAINT pk_customer PRIMARY KEY (customer_id)
);

ALTER TABLE customer
  ADD CONSTRAINT unique_customer_phone UNIQUE (phone);

ALTER TABLE customer
  ADD CONSTRAINT unique_customer_email UNIQUE (email);

CREATE TABLE groomer
(
  groomer_id     NUMBER             DEFAULT groomer_seq.nextval,
  first_name      VARCHAR2(20 CHAR) NOT NULL,
  last_name       VARCHAR2(20 CHAR) NOT NULL,
  salary          NUMBER            NOT NULL,
  email           VARCHAR2(20 CHAR) NOT NULL,
  phone           VARCHAR2(20 CHAR) NOT NULL,
  birth_date      DATE,
  address         VARCHAR2(20 CHAR),
  groomer_status  VARCHAR2(20 CHAR) DEFAULT 'Available',
  created_by      VARCHAR2(20 CHAR) NOT NULL,
  creation_date   DATE              NOT NULL,
  last_updated_by VARCHAR2(20 CHAR),
  last_update     DATE,
  CONSTRAINT pk_groomer PRIMARY KEY (groomer_id)
);

ALTER TABLE groomer
  ADD CONSTRAINT unique_groomer_email UNIQUE (email);

ALTER TABLE groomer
  ADD CONSTRAINT unique_groomer_phone UNIQUE (phone);

CREATE TABLE service
(
  service_id   NUMBER             DEFAULT service_seq.nextval, 
  service_name VARCHAR2(20 CHAR)  NOT NULL,
  price        NUMBER             NOT NULL,
  description  VARCHAR2(200 CHAR) NOT NULL,
  CONSTRAINT pk_service PRIMARY KEY (service_id)
);

ALTER TABLE service
  ADD CONSTRAINT unique_service_name UNIQUE (service_name);

CREATE TABLE payment_refund
(
  refund_id       NUMBER             DEFAULT refund_seq.nextval,
  payment_id      NUMBER             NOT NULL,
  refund_amount   NUMBER             NOT NULL,
  refund_reason   VARCHAR2(255 CHAR) NOT NULL,
  created_by      VARCHAR2(20 CHAR)  NOT NULL,
  creation_date   DATE               NOT NULL,
  last_updated_by VARCHAR2(20 CHAR) ,
  last_update     DATE              
  CONSTRAINT pk_payment_refund PRIMARY KEY (refund_id)
);

CREATE TABLE pet
(
  pet_id       NUMBER             DEFAULT pet_seq.nextval,
  customer_id  NUMBER             NOT NULL,
  pet_name     VARCHAR2(20 CHAR)  NOT NULL,
  pet_type     VARCHAR2(20 CHAR)  NOT NULL,
  pet_breed    VARCHAR2(20 CHAR),
  description  VARCHAR2(255 CHAR),
  CONSTRAINT pk_pet PRIMARY KEY (pet_id)
);

CREATE TABLE appointment
(
  appointment_id        NUMBER            DEFAULT appointment_seq.nextval, 
  customer_id           NUMBER            NOT NULL,
  groomer_schedule_id   NUMBER            NOT NULL,
  appointment_cancelled CHAR(1)           DEFAULT 'N' CHECK (appointment_cancelled IN ('Y', 'N')), 
  created_by            VARCHAR2(20 CHAR) NOT NULL,
  creation_date         DATE              NOT NULL,
  last_updated_by       VARCHAR2(20 CHAR),
  last_update           DATE,
  CONSTRAINT pk_appointment PRIMARY KEY (appointment_id) 
);

CREATE TABLE payment
(
  payment_id      NUMBER                   DEFAULT payment_seq.nextval,
  amount          NUMBER                   NOT NULL,
  payment_date    DATE                     DEFAULT SYSDATE NOT NULL,
  appointment_id  NUMBER                   NOT NULL,
  payment_method  VARCHAR2(10 CHAR)        NOT NULL,
  created_by      VARCHAR2(20 CHAR)        NOT NULL,
  creation_date   DATE                     NOT NULL,
  last_updated_by VARCHAR2(20 CHAR),
  last_update     DATE,
  CONSTRAINT pk_payment PRIMARY KEY (payment_id)
);


CREATE TABLE groomer_schedule
(
  groomer_schedule_id NUMBER             DEFAULT groomer_schedule_seq.nextval,
  groomer_id          NUMBER             NOT NULL,
  service_id          NUMBER             NOT NULL,
  start_time          DATE               NOT NULL,
  end_time            DATE               NOT NULL,
  notes               VARCHAR2(255 CHAR),
  created_by          VARCHAR2(20 CHAR)  NOT NULL,
  creation_date       DATE               NOT NULL,
  last_updated_by     VARCHAR2(20 CHAR),
  last_update         DATE,
  CONSTRAINT pk_groomer_schedule PRIMARY KEY (groomer_schedule_id)
);


CREATE TABLE appointment_service
(
  appointment_id NUMBER NOT NULL,
  service_id     NUMBER NOT NULL
);

CREATE TABLE service_inventory
(
  service_inventory_id  NUMBER             DEFAULT service_inventory_seq.nextval,
  item_name             VARCHAR2(100 CHAR) NOT NULL,
  quantity              NUMBER             NOT NULL,
  unit_price            NUMBER             NOT NULL,
  service_id            NUMBER             NOT NULL,
  created_by            VARCHAR2(20 CHAR)  NOT NULL,
  creation_date         DATE               NOT NULL,
  last_updated_by       VARCHAR2(20 CHAR),
  last_update           DATE,
  CONSTRAINT pk_service_inventory PRIMARY KEY (service_inventory_id)
);

CREATE TABLE appointment_notification
(
  appointment_notification_id   NUMBER             DEFAULT notification_seq.nextval,
  appointment_id                NUMBER             NOT NULL,
  notification_text             VARCHAR2(255 CHAR) NOT NULL,
  notification_date             DATE,
  notification_sent             DATE               DEFAULT SYSDATE,
  CONSTRAINT pk_appointment_notification PRIMARY KEY (appointment_notification_id)
);

CREATE SEQUENCE customer_seq START WITH 1
INCREMENT BY 1;
CREATE SEQUENCE groomer_seq START WITH 1
INCREMENT BY 1;
CREATE SEQUENCE service_seq START WITH 1
INCREMENT BY 1;
CREATE SEQUENCE pet_seq START WITH 1
INCREMENT BY 1;
CREATE SEQUENCE appointment_seq START WITH 1
INCREMENT BY 1;
CREATE SEQUENCE payment_seq START WITH 1
INCREMENT BY 1;
CREATE SEQUENCE refund_seq START WITH 1
INCREMENT BY 1;
CREATE SEQUENCE groomer_schedule_seq START WITH 1
INCREMENT BY 1;
CREATE SEQUENCE service_inventory_seq START WITH 1
INCREMENT BY 1;
CREATE SEQUENCE notification_seq START WITH 1
INCREMENT BY 1;

DROP TABLE payment_refund;
DROP TABLE appointment_notification;
DROP TABLE appointment_service;
DROP TABLE payment;
DROP TABLE service_inventory;
DROP TABLE appointment;
DROP TABLE pet;
DROP TABLE groomer_schedule;
DROP TABLE customer;
DROP TABLE groomer;
DROP TABLE service;

ALTER TABLE appointment
  ADD CONSTRAINT fk_customer_to_appointment
    FOREIGN KEY (customer_id)
    REFERENCES customer (customer_id);

ALTER TABLE pet
  ADD CONSTRAINT fk_customer_to_pet
    FOREIGN KEY (customer_id)
    REFERENCES customer (customer_id);

ALTER TABLE payment
  ADD CONSTRAINT fk_appointment_to_payment
    FOREIGN KEY (appointment_id)
    REFERENCES appointment (appointment_id);

ALTER TABLE service_inventory
  ADD CONSTRAINT fk_service_to_service_inventory
    FOREIGN KEY (service_id)
    REFERENCES service (service_id);

ALTER TABLE appointment_service
  ADD CONSTRAINT fk_appointment_to_appointment_service
    FOREIGN KEY (appointment_id)
    REFERENCES appointment (appointment_id);

ALTER TABLE appointment_service
  ADD CONSTRAINT fk_service_to_appointment_service
    FOREIGN KEY (service_id)
    REFERENCES service (service_id);

ALTER TABLE groomer_schedule
  ADD CONSTRAINT fk_groomer_to_groomer_schedule
    FOREIGN KEY (groomer_id)
    REFERENCES groomer (groomer_id);

ALTER TABLE appointment_notification
  ADD CONSTRAINT fk_appointment_to_appointment_notification
    FOREIGN KEY (appointment_id)
    REFERENCES appointment (appointment_id);

ALTER TABLE groomer_schedule
  ADD CONSTRAINT fk_service_to_groomer_schedule
    FOREIGN KEY (service_id)
    REFERENCES service (service_id);

ALTER TABLE appointment
  ADD CONSTRAINT fk_groomer_schedule_to_appointment
    FOREIGN KEY (groomer_schedule_id)
    REFERENCES groomer_schedule (groomer_schedule_id);

ALTER TABLE payment_refund
  ADD CONSTRAINT fk_payment_to_payment_refund
    FOREIGN KEY (payment_id)
    REFERENCES payment (payment_id);


-- Multiple unique columns 

ALTER TABLE appointment_notification
  ADD CONSTRAINT unique_appointment_notification_and_appointment_id
  UNIQUE (appointment_id);

ALTER TABLE groomer_schedule
  ADD CONSTRAINT unique_groomer_and_working_time 
  UNIQUE (groomer_id, start_time);

ALTER TABLE service_inventory
  ADD CONSTRAINT unique_service_and_item
  UNIQUE (service_id, item_name);
