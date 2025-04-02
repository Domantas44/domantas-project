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
/
    -- when no negative values are allowed:
    -- salary NUMBER(10, 2) CHECK (salary >= 0)
 
 -- Inserting one record
BEGIN
    INSERT INTO EMPLOYEES1
        VALUES (1, 'Paulius', 'Paulauskas', 'paulius@gmail.com', DATE '2025-08-25', 2000);
    COMMIT;
END;

-- Removing the table
/
DROP TABLE EMPLOYEES1;


-- Retrieving Data (employees, customers table)
-- simple select
SELECT customer_id, first_name, last_name
FROM CUSTOMERS
WHERE DATE_OF_BIRTH > TO_DATE('31-DEC-1980');


-- simple employee_info procedure
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
/
DECLARE
    v_first_name EMPLOYEES.FIRST_NAME%TYPE;
    v_last_name EMPLOYEES.LAST_NAME%TYPE;
    v_email EMPLOYEES.EMAIL%TYPE;
BEGIN
    employee_info(100, v_first_name, v_last_name, v_email);
    dbms_output.put_line('Employees info: ' || v_first_name ||' '|| v_last_name ||' '|| v_email);
END;
/



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
