                                -- Basic crud operations --
-- Create Table and Insert Data
CREATE TABLE employees1 (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2 (50),
    last_name VARCHAR2 (50),
    email VARCHAR2 (100),
    hire_date DATE,
    salary NUMBER (10, 2) CHECK (salary >= 0)
)

    -- when no negative values are allowed:
    -- salary NUMBER(10, 2) CHECK (salary >= 0)
 
 -- Inserting one record
BEGIN
    INSERT INTO EMPLOYEES1
        VALUES (1, 'Paulius', 'Paulauskas', 'paulius@gmail.com', DATE '2025-08-25', 2000);
    COMMIT;
END;

-- Updating that record
BEGIN 
    UPDATE EMPLOYEES1
    SET salary = 2150
    WHERE employee_id = 1;
END;

-- Removing salary
BEGIN
    UPDATE EMPLOYEES1
    SET salary = NULL
    WHERE employee_id = 1;
END;

-- Deleting the record
BEGIN
    DELETE FROM EMPLOYEES1
    WHERE employee_id = 1;
END;

-- Removing the table
DROP TABLE EMPLOYEES1;

---- One more time basic of the basics (Procedure this time)

--Create table
CREATE TABLE books (
book_id number PRIMARY KEY,
title VARCHAR2 (50),
author VARCHAR2 (50),
quantity NUMBER (5) CHECK (quantity >= 0)
)

-- Insert (Procedure)
CREATE OR REPLACE PROCEDURE book_insert (
    v_book_id NUMBER,
    v_title VARCHAR2,
    v_author VARCHAR2,
    v_quantity NUMBER
)
IS
BEGIN
    INSERT INTO BOOKS
    VALUES (v_book_id, v_title, v_author, v_quantity);
END;
-- Executing the insert
BEGIN
    book_insert(2, 'Harry Potter', 'Rowling', 44);
END; 

--Update (Procedure)
CREATE OR REPLACE PROCEDURE book_qupdate (
v_book_id IN books.book_id%TYPE,
v_quantity IN books.quantity%TYPE
)
IS
BEGIN
    UPDATE books
    SET quantity = v_quantity
    WHERE book_id = v_book_id;
END;

-- Executing update
BEGIN
    book_qupdate(2, 43);
END;

-- Delete (Procedure)
CREATE OR REPLACE PROCEDURE book_delete (
    v_book_id IN books.book_id%TYPE
)
IS
BEGIN
    DELETE from BOOKS
    WHERE book_id = v_book_id;
END;
-- Executing delete
BEGIN
    book_delete(2);
END;

DROP TABLE books;

---- Beginner friendly coding from Gemini given exercises (variables, conditionals, loops, database interaction)
-- Conditional Logic and User Input 
DECLARE
    v_customer_type VARCHAR2(10);
    v_order_total NUMBER := '&Order amount';
    v_discount NUMBER;
BEGIN
    if -- will continue on friday-saturday 

















-------------- Just random coding ------------------------
-- Retrieving Data (employees, customers table)
-- simple select
SELECT customer_id, first_name, last_name
FROM CUSTOMERS
WHERE DATE_OF_BIRTH > TO_DATE('31-DEC-1980');


-- simple employee_info procedure to retrieve specific employees id and its info
CREATE OR REPLACE PROCEDURE employee_info (
    v_employee_id IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    v_first_name OUT EMPLOYEES.FIRST_NAME%TYPE,
    v_last_name OUT EMPLOYEES.LAST_NAME%TYPE,
    v_email OUT EMPLOYEES.EMAIL%TYPE
)
IS
BEGIN
SELECT first_name, last_name, email
INTO v_first_name, v_last_name, v_email
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = v_employee_id;
END;
-- executing it
DECLARE
    v_first_name EMPLOYEES.FIRST_NAME%TYPE;
    v_last_name EMPLOYEES.LAST_NAME%TYPE;
    v_email EMPLOYEES.EMAIL%TYPE;
BEGIN
    employee_info(100, v_first_name, v_last_name, v_email);
    dbms_output.put_line('Employees info: ' || v_first_name ||' '|| v_last_name ||' '|| v_email);
END;

SET SERVEROUTPUT ON;

-- remembering loops

BEGIN
for i in (select first_name, last_name, SALARY
            from EMPLOYEES
            where salary > 5000)
loop 
    DBMS_OUTPUT.PUT_LINE('Salaries above 5000:' || i.first_name || i.last_name || i.salary);
end loop;
end;
