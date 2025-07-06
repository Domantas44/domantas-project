--Basic INSERT into customer table
BEGIN
    INSERT INTO CUSTOMER (customer_id, first_name, last_name, phone, email)
    VALUES (CUSTOMER_SEQ.NEXTVAL, 'Tomas', 'Tomaitis', '061111111', 'tomas.tomaitis@gmail.com');
    INSERT INTO CUSTOMER (customer_id, first_name, last_name, phone, email)
    VALUES (CUSTOMER_SEQ.NEXTVAL, 'John', 'James', '061131258', 'john.james1@gmail.com');
    INSERT INTO CUSTOMER (customer_id, first_name, last_name, phone, email)
    VALUES (CUSTOMER_SEQ.NEXTVAL, 'Domas', 'Rimkus', '061131321', 'rimkuus12@yahoo.com');
END;

-- Procedure INSERT into customer table
CREATE OR REPLACE PROCEDURE new_customer
(
    v_first_name customer.first_name%TYPE,
    v_last_name customer.last_name%TYPE,
    v_phone customer.phone%TYPE,
    v_email customer.email%TYPE
)
IS
BEGIN
    INSERT INTO customer (customer_id, first_name, last_name, phone, email)
    VALUES (customer_seq.NEXTVAL, v_first_name, v_last_name, v_phone, v_email);
END;

BEGIN
    new_customer ('Simas', 'Simonaitis', '065535458', 'simassimutis@gmail.com');
END;

/*
Register a New Pet for a Customer
Check if the customer exists.
If not, raise error.
Insert pet info if valid.
*/
CREATE OR REPLACE PROCEDURE pet_registration
(
v_customer_id pet.customer_id%TYPE,
v_pet_name pet.pet_name&TYPE,
v_pet_type pet.pet_type%TYPE,
v_pet_breed pet.pet_breed%TYPE,
v_description pet.description%TYPE
)
IS
v_count NUMBER;
BEGIN
    SELECT 1 INTO v_count
    FROM customer
    WHERE customer_id = v_customer_id;

    INSERT INTO pet (pet_id, customer_id, pet_name, pet_type, pet_breed, description)
    VALUES (pet_seq.NEXTVAL, v_customer_id, v_pet_name, v_pet_type, v_pet_breed, v_description);
    DBMS_OUTPUT.PUT_LINE('Pet registered');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20002, 'Customer does not exist');
END;

BEGIN PET_REGISTRATION (
21, 
'Lutis',
'Cat',
'Mixed',
'-'
);
END;

/*
Book an Appointment with Data Validation
Validate customer and groomer schedule exist.
Insert into appointment.
*/
CREATE OR REPLACE PROCEDURE appointment_booking
(
    v_customer_id appointment.customer_id%TYPE,
    v_groomer_schedule_id appointment.groomer_schedule_id%TYPE
)
IS
    v_number NUMBER;
BEGIN
    BEGIN
        SELECT 1 INTO v_number
        FROM customer
        WHERE customer_id = v_customer_id;
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Customer not found');
    END;

    BEGIN
        SELECT 1 INTO v_number
        FROM groomer_schedule
        WHERE groomer_schedule_id = v_groomer_schedule_id;
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Groomer schedule does not exist');
    END;

    INSERT INTO appointment(
    appointment_id, 
    customer_id, 
    groomer_schedule_id
    )
     VALUES (
    appointment_seq.NEXTVAL, 
    v_customer_id, 
    v_groomer_schedule_id
     );
        DBMS_OUTPUT.PUT_LINE('Appointment booked');
    
END;

BEGIN appointment_booking(
    1, 
    121
);
END;

ALTER SEQUENCE customer_seq RESTART START WITH 1;

-- Delete
BEGIN
    DELETE FROM CUSTOMER
    WHERE customer_id between 4 and 6;
END;

-- Delete an Appointment Notification Sent More Than 30 Days Ago

BEGIN
    DELETE FROM appointment_notification
    WHERE notification_sent < SYSDATE - 30;
END;

/*
Delete Out-of-Stock Service Inventory Items
Items where quantity = 0
*/
CREATE OR REPLACE PROCEDURE inventory_cleanup
IS
BEGIN
    DELETE FROM SERVICE_INVENTORY
    WHERE quantity = 0;
END;

-- Update

BEGIN
    UPDATE CUSTOMER
    SET phone = 061231231
    WHERE customer_id = 1;
END;

--Update Appointment to Cancelled

BEGIN
    UPDATE APPOINTMENT
    SET appointment_cancelled = 'Y'
    WHERE appointment_id = 1;
END;








