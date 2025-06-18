
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
v_customer_id customer.customer_id%TYPE,
v_pet_name VARCHAR2,
v_pet_type VARCHAR2,
v_pet_breed VARCHAR2,
v_description VARCHAR2
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
    DBMS_OUTPUT.PUT_LINE('Customer does not exist');
END;

BEGIN PET_REGISTRATION (21, 'Lutis', 'Cat', 'Mixed', '-');
END;

