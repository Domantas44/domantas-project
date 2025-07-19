                                                                        --INSERT--

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

--Create a refund procedure that verifies payment existence first
CREATE OR REPLACE PROCEDURE customer_refund (
    v_payment_id payment_refund.payment_id%TYPE,
    v_amount payment_refund.refund_amount%TYPE,
    v_reason payment_refund.refund_reason%TYPE
)
IS
v_count NUMBER;
BEGIN
    SELECT 1 INTO v_count 
    FROM payment 
    WHERE payment_id = v_payment_id;

    INSERT INTO payment_refund (refund_id, payment_id, refund_amount, refund_reason)
    VALUES (refund_seq.NEXTVAL, v_payment_id, v_amount, v_reason);
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

-- Data imported
-- Check low quantity inventory
CREATE OR REPLACE PROCEDURE check_low_inventory
IS
BEGIN
    for i in (
        SELECT service_inventory_id, item_name, quantity
        FROM service_inventory
        WHERE quantity < 5
        )
    LOOP
    DBMS_OUTPUT.PUT_LINE('Low inventory: ' || i.item_name || 'ID: ' || i.service_inventory_id || ' Quantity: ' || i.quantity);
    END LOOP;
END;

EXEC check_low_inventory;

-- Cancel an Appointment and Log a Notification

CREATE OR REPLACE PROCEDURE appointment_cancelling (
    v_appointment_id IN appointment.appointment_id%TYPE,
    v_updated_by IN appointment.last_updated_by%TYPE
)
IS
BEGIN
     UPDATE appointment
      SET appointment_cancelled = 'Y',
      last_updated_by = v_updated_by,
      last_update = SYSDATE
      WHERE appointment_id = v_appointment_id;
   
    
    INSERT INTO appointment_notification (
        appointment_notification_id, 
        appointment_id, 
        notification_text, 
        notification_date
        )
        VALUES (appointment_notification_seq.NEXTVAL, 
        v_appointment_id, 
        'Your appointment was cancelled', 
        TO_DATE('2025-07-14 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));

END;

EXEC appointment_cancelling(1, 'Domantas');

-- Create a New Groomer Schedule

CREATE OR REPLACE PROCEDURE create_groomer_schedule (
    v_groomer_id IN groomer.groomer_id%TYPE,
    v_service_id IN groomer_schedule.service_id%TYPE,
    v_start_time IN groomer_schedule.start_time%TYPE,
    v_end_time IN groomer_schedule.end_time%TYPE,
    v_notes IN groomer_schedule.notes%TYPE,
    v_created_by IN groomer_schedule.created_by%TYPE DEFAULT 'System',
    v_creation_date IN groomer_schedule.creation_date%TYPE DEFAULT SYSDATE
)
IS
    v_count NUMBER;
    v_new_id groomer_schedule.groomer_schedule_id%TYPE;
BEGIN
    SELECT COUNT(*) INTO v_count -- Checking if the groomer is available for the given date and time
    FROM groomer_schedule
    WHERE groomer_id = v_groomer_id AND (start_time < v_end_time AND end_time > v_start_time);

       IF v_count > 0 THEN
           DBMS_OUTPUT.PUT_LINE('Groomer is not available for the selected time.');
        ELSE 

        SELECT groomer_schedule_seq.NEXTVAL INTO v_new_id FROM dual; -- For displaying what id was created

    INSERT INTO groomer_schedule (

       groomer_schedule_id,
       groomer_id,
       service_id,
       start_time,
       end_time,
       notes,
       created_by,
       creation_date
    ) VALUES (
        v_new_id,
        v_groomer_id,
        v_service_id,
        v_start_time,
        v_end_time,
        v_notes,
        v_created_by,
        v_creation_date
    );
              DBMS_OUTPUT.PUT_LINE('Groomer schedule created with ID: ' || v_new_id);
         END IF;
END;

EXEC create_groomer_schedule(4, 3, TO_DATE('2025-07-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-07-15 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Bath and Brush', 'Domantas');


-- Bulk Load Pets by Customer

CREATE TYPE customer_id_list IS TABLE OF NUMBER;
/
CREATE OR REPLACE PROCEDURE customer_pets_list (
    v_customer_id IN customer_id_list
)
IS
    TYPE t_cust_ids IS TABLE OF pet.customer_id%TYPE;
    TYPE t_pet_ids IS TABLE OF pet.pet_id%TYPE;
    TYPE t_pet_names IS TABLE OF pet.pet_name%TYPE;
    TYPE t_pet_types IS TABLE OF pet.pet_type%TYPE;
    TYPE t_pet_breeds IS TABLE OF pet.pet_breed%TYPE;
    
    
    v_cust_id t_cust_ids;
    v_pet_id t_pet_ids;
    v_pet_name t_pet_names;
    v_pet_type t_pet_types;
    v_pet_breed t_pet_breeds;
    
    
BEGIN
    SELECT customer_id, pet_id, pet_name, pet_type, pet_breed
    BULK COLLECT INTO v_cust_id, v_pet_id,v_pet_name, v_pet_type, v_pet_breed
    FROM pet
    WHERE customer_id IN (SELECT COLUMN_VALUE FROM TABLE(v_customer_id));

    IF v_pet_id.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No pets found for given customer id');
    ELSE
        FOR i IN 1..v_pet_id.COUNT 
        LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Customer ID: '     || v_cust_id(i) ||
                ', Pet ID: '    || v_pet_id(i) ||
                ', Name: '      || v_pet_name(i) ||
                ', Type: '      || v_pet_type(i) ||
                ', Breed: '     || v_pet_breed(i)
            );
        END LOOP;
    END IF;
END;

EXEC customer_pets_list(customer_id_list(2, 123, 14, 11));





    
