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


-- using my older 'dataset' and memorizing constraints that i still dont know, by leaving comments
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL, -- emails must be unique and not null
    phone_number VARCHAR2(20) UNIQUE,
    date_of_birth DATE NOT NULL,
    created_at DATE DEFAULT SYSDATE -- logs system date
);


CREATE TABLE accounts (
    account_id NUMBER PRIMARY KEY,
    customer_id NUMBER REFERENCES customers(customer_id), -- 'references' creates relationsip between tables
    account_type VARCHAR2(10) CHECK (account_type IN ('SAVINGS', 'CHECKING', 'LOAN')), -- 'check' ensures that any values inserted must be 'SAVINGS', 'CHECKING', 'LOAN'
    balance NUMBER(12,2) DEFAULT 0, -- 'default' if no values are inserted, 0 is default
    currency VARCHAR2(3) DEFAULT 'EUR',
    status VARCHAR2(10) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'BLOCKED', 'CLOSED')), -- 'status' values must be one of the following 'ACTIVE', 'BLOCKED', 'CLOSED'
    created_at DATE DEFAULT SYSDATE 
);

CREATE TABLE transactions (
    transaction_id NUMBER PRIMARY KEY,
    account_id NUMBER REFERENCES accounts(account_id),
    transaction_type VARCHAR2(10) CHECK (transaction_type IN ('DEPOSIT', 'WITHDRAWAL', 'TRANSFER')),
    amount NUMBER(12,2) NOT NULL,
    transaction_date DATE DEFAULT SYSDATE,
    status VARCHAR2(15) DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'COMPLETED', 'FAILED')),
    description VARCHAR2(255)
);


CREATE TABLE card_transactions (
    card_transaction_id NUMBER PRIMARY KEY,
    account_id NUMBER REFERENCES accounts(account_id),
    card_number VARCHAR2(16) NOT NULL,
    transaction_amount NUMBER(12,2) NOT NULL,
    merchant VARCHAR2(100),
    transaction_date DATE DEFAULT SYSDATE,
    status VARCHAR2(15) DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'COMPLETED', 'FAILED'))
);


CREATE TABLE loans (
    loan_id NUMBER PRIMARY KEY,
    customer_id NUMBER REFERENCES customers(customer_id),
    loan_amount NUMBER(12,2) NOT NULL,
    interest_rate NUMBER(5,2) NOT NULL,
    loan_term NUMBER NOT NULL,
    loan_status VARCHAR2(10) CHECK (loan_status IN ('ACTIVE', 'CLOSED', 'DEFAULTED')),
    created_at DATE DEFAULT SYSDATE
);


CREATE TABLE etl_audit_log (
    log_id NUMBER PRIMARY KEY,
    table_name VARCHAR2(50) NOT NULL,
    operation VARCHAR2(10) CHECK (operation IN ('INSERT', 'UPDATE', 'DELETE')),
    changed_at DATE DEFAULT SYSDATE,
    changed_by VARCHAR2(50) NOT NULL
);

-- INDEX'es are very valuable when working with large datasets which is a must to know.

-- An index is a performance-tuning method of allowing faster retrieval of records
-- Index creates an entry for each value that appears in the indexed columns.
CREATE INDEX idx_accounts_customer_id ON accounts(customer_id); -- customer_id is most oftenly accessed
CREATE INDEX idx_transactions_account_id ON transactions(account_id);
CREATE INDEX idx_transactions_status ON transactions(status);
CREATE INDEX idx_transactions_date ON transactions(transaction_date);
CREATE INDEX idx_card_transactions_account_id ON card_transactions(account_id);
CREATE INDEX idx_card_transactions_status ON card_transactions(status);
CREATE INDEX idx_loans_customer_id ON loans(customer_id);
CREATE INDEX idx_loans_status ON loans(loan_status);
CREATE INDEX idx_audit_table_op ON etl_audit_log(table_name, operation);

-- Indexes are created for specific columns which are accessed most frequently

-- Theoretical knowledge for know, practice with index'es will come later on


---- Beginner friendly coding from Gemini given exercises (variables, conditionals, loops, database interaction)
-- Retrieving Data (employees, customers table)

SET SERVEROUTPUT ON;
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


-- Conditional Logic and User Input (Discount calculator)

DECLARE
    v_customer_type VARCHAR2(10) := 'REGULAR';
    v_order NUMBER := 25;
    v_order_total NUMBER;
    
BEGIN

     if v_customer_type = 'VIP' 
        then v_order_total := v_order * 0.95;-- 5% discount

    elsif v_customer_type = 'REGULAR' and v_order > 100
        then v_order_total := v_order * 0.95; --5% discount

    elsif v_customer_type = 'NEW' and v_order > 200 
        then v_order_total := v_order * 0.90; --10% discount

    else 
        v_order_total := v_order * 0.98; -- 2% discount
    END IF;

    DBMS_OUTPUT.PUT_LINE('Customer type: ' || v_customer_type);
    DBMS_OUTPUT.PUT_LINE('Order price' || v_order);
    DBMS_OUTPUT.PUT_LINE('Final price' || v_order_total);
END;
-- Status checker
DECLARE
    product_id NUMBER := 150;
    quantity_stock NUMBER := 20;
    product_status VARCHAR(20);
BEGIN
    CASE 
        WHEN quantity_stock > 10
        THEN product_status := 'In stock';

        WHEN quantity_stock BETWEEN 1 AND 10
        THEN product_status := 'Low stock';

        WHEN quantity_stock = 0
        THEN product_status := 'Out of stock';

        WHEN quantity_stock < 0
        THEN product_status := 'Error';
    END CASE;

    DBMS_OUTPUT.PUT_LINE('Product id: ' || product_id);
    DBMS_OUTPUT.PUT_LINE('Quantity in stock: ' || quantity_stock);
    DBMS_OUTPUT.PUT_LINE('Product status: ' || product_status);
END;

-- Simple loop

BEGIN
for i in (select first_name, last_name, SALARY
            from EMPLOYEES
            where salary > 5000)
loop 
    DBMS_OUTPUT.PUT_LINE('Salaries above 5000:' || i.first_name || i.last_name || i.salary);
end loop;
end;

--Looping with Database Interaction (employees table)
CREATE OR REPLACE PROCEDURE salary_increase -- displaying all employees whose salary is < 3000 and showing 10% increase

IS
n_salary employees.salary%TYPE;

BEGIN
    FOR i in (select first_name, last_name, SALARY
            from EMPLOYEES
            where salary < 3000)
    LOOP
        n_salary := i.salary + (i.salary * 0.1);

    DBMS_OUTPUT.PUT_LINE('Employees and their old and new increased salaries: ' ||
    ' ' || i.first_name ||', '|| i.last_name ||', '|| i.salary ||', '|| n_salary);
    END LOOP;
END;

BEGIN
    SALARY_INCREASE;
END;

-- Another loop
/*Loop through accounts with account_type = 'SAVINGS'.
If the balance is less than 100, add 50 to the balance.
Print the account ID and the action taken.*/

CREATE OR REPLACE PROCEDURE add_balance
IS

v_balance accounts.balance%TYPE;

BEGIN
    FOR i IN (SELECT account_id, balance FROM ACCOUNTS WHERE account_type = 'SAVINGS')
    LOOP
        IF i.balance < 100 THEN 
            v_balance := i.balance + 50;
            UPDATE ACCOUNTS
            SET balance = i.balance + 50
            WHERE account_id = i.account_id;

            DBMS_OUTPUT.PUT_LINE('Account ids updated and their new balance' ||
            ' ' || i.account_id ||' '|| v_balance);
        END IF;
    END LOOP;
END;

BEGIN
    add_balance;
END;

-- And another loop
/*Check all transactions with status 'PENDING' and a transaction_date older than 7 days.
Update their status to 'FAILED'.
Print how many transactions were updated.*/

CREATE OR REPLACE PROCEDURE p_transactions
IS
t_count NUMBER := 0;
BEGIN
    FOR i IN (SELECT transaction_id, status, transaction_date 
                FROM transactions 
                WHERE transaction_date < SYSDATE -7 AND status = 'PENDING')
    LOOP
        UPDATE transactions
        SET status = 'FAILED'
        WHERE transaction_id = i.transaction_id;

            t_count := t_count + SQL%ROWCOUNT; 

        DBMS_OUTPUT.PUT_LINE('Transaction ids: ' || i.transaction_id);
    END LOOP;

        DBMS_OUTPUT.PUT_LINE('Total transactions updated: ' || t_count);
END;

BEGIN
    p_transactions;
END;

-- Write a PL/SQL block that checks for duplicate emails in the customers table
BEGIN
    for i in (
        SELECT email, count(email) AS emailcount
        FROM customers 
        GROUP BY email
        HAVING count(email) > 1)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Email: ' || i.email || 'Email count: ' || i.emailcount);
    END LOOP;
END;

/*Declare variables for a new loan (amount, rate, term, etc).
Insert it into the loans table.
Then insert a log entry into etl_audit_log for this action.*/

CREATE OR REPLACE PROCEDURE n_loan (  
    v_customer_id IN loans.customer_id%TYPE,
    v_loan_amount IN loans.loan_amount%TYPE,
    v_interest_rate IN loans.interest_rate%TYPE,
    v_loan_term IN loans.loan_term%TYPE,
    v_loan_status IN loans.loan_status%TYPE,
    v_changed_by IN etl_audit_log.changed_by%TYPE
)
IS
    v_loan_id NUMBER;
    v_log_id NUMBER;
BEGIN

    
    INSERT INTO loans (loan_id, customer_id, loan_amount, interest_rate, loan_term, loan_status, created_at)
    VALUES (loanseq.NEXTVAL, v_customer_id, v_loan_amount, v_interest_rate, v_loan_term, v_loan_status, SYSDATE)
    RETURNING loan_id INTO v_loan_id;

    INSERT INTO etl_audit_log (log_id, table_name, operation, changed_at, changed_by)
    VALUES (logseq.NEXTVAL, 'loans', 'INSERT', SYSDATE, v_changed_by)
    RETURNING log_id INTO v_log_id;

    DBMS_OUTPUT.PUT_LINE('Load id and customer id:  ' || v_loan_id ||' '|| v_customer_id );
    DBMS_OUTPUT.PUT_LINE('log id: ' || v_log_id);
END;

CREATE SEQUENCE loanseq START WITH 1 INCREMENT BY 1; 
CREATE SEQUENCE logseq START WITH 1 INCREMENT BY 1;

BEGIN
    n_loan( -- does not execute properly, needs fixing
        v_customer_id = 11,  
        v_loan_amount = 10000,
        v_interest_rate = 4.5,
        v_loan_term = 24,
        v_loan_status = 'ACTIVE',
        v_changed_by = 'Domantas'
    );
END; 










































