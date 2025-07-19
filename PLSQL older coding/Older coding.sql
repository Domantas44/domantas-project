
CREATE PROCEDURE GET_CUSTOMER_COUNT(CUSTOMERS1 OUT NUMBER)
IS
BEGIN 
  SELECT COUNT(*) INTO CUSTOMERS1 FROM CUSTOMERS;
END;

-----------------------------------------------------------------01-30 The basics
DECLARE
    dept_name CONSTANT VARCHAR2(100) NOT NULL := 'IT';
BEGIN
    dbms_output.put_line('dept_name:' || dept_name);
    dept_name := 'Sales';
    dbms_output.put_line('dept_name:' || dept_name);
END;
-----------------------------------------------------------------
DECLARE 
    hours_worked NUMBER DEFAULT 100;
    salary NUMBER := hours_worked * 90;
BEGIN
    dbms_output.put_line('Salary:' || salary);
END;

-- MY FIRST CODE YEY----------------------

DECLARE 
    emp_salary NUMBER;
    
BEGIN
    SELECT salary
    INTO emp_salary
    FROM employees 
    WHERE employee_id = 100;
    dbms_output.put_line('Kings salary is:'||emp_salary);
EXCEPTION 
    WHEN no_data_found THEN dbms_output.put_line('Employee does not exist');
    END;
-----------------------------------------------------------------

DECLARE
    e_salary NUMBER;
BEGIN
    SELECT salary INTO e_salary
    FROM employees 
    WHERE employee_id = 100;
    
    if e_salary < 5000 then dbms_output.put_line('Low');
    elsif e_salary between 5000 and 10000 then dbms_output.put_line('Medium');
    else dbms_output.put_line('High');
    end if;
    
EXCEPTION 
    WHEN no_data_found THEN dbms_output.put_line('No data about salary');
    

END;
/
-----------------------------------------------------------------Variables and loop
DECLARE 
employee_id number;
name varchar2(30);
e_department number;
BEGIN
select emp_id, emp_name, department 
into employee_id, name, e_department
from employees
where emp_id = 102;
dbms_output.put_line('Employees details:'|| employee_id||','|| name||','|| e_department);

EXCEPTION


WHEN others THEN dbms_output.put_line('No employee selected')
END;
----------------------------------------------------------------- IF ELSIF
DECLARE
  e_salary number;
BEGIN
  select salary into e_salary
  from EMPLOYEES
  where emp_id=103;
  if e_salary < 55000 then 
    DBMS_OUTPUT.PUT_LINE('Low salary');
  elsif e_salary between 55000 and 60000 then 
    DBMS_OUTPUT.PUT_LINE('Medium salary');
  else DBMS_OUTPUT.PUT_LINE('High salary');
    
EXCEPTION
  WHEN no_data_found THEN 
    DBMS_OUTPUT.PUT_LINE('No data entered');

END;
----------------------------------------------------------------- LOOP
DECLARE
employee_loop number;
BEGIN
  for employee_loop in 101..105 loop
    DBMS_OUTPUT.PUT_LINE('Processing Employee ID:'|| employee_loop);
    END loop;
EXCEPTION
    WHEN others THEN 
        DBMS_OUTPUT.PUT_LINE('No data found');

END;
/
----------------------------------------------------------------- FIRST CURSOR
/*
REMEMBER CURSOR STRUCTURE
DECLARE
    CURSOR IS xxx
    SELECT
    %TYPE

BEGIN
    OPEN
    LOOP
    FETCH
    EXIT WHEN %NOTFOUND
    END LOOP
    CLOSE CURSOR
END
*/

DECLARE
CURSOR
SELECT
VARIABLE%TYPE
OPEN
LOOP
FETCH
CURSOR TO THE VARIABLE
EXIT WHEN %NOTFOUND
PRINT OUT MESSAGE
ENDLOOP
CLOSE CURSOR
END
----------------------------------------------------------------- CURSORS
DECLARE 
    CURSOR c_employees IS 
    SELECT employee_id 
    FROM employees
    WHERE department_id = 60;
    v_employees_id employees.employee_id%TYPE;

BEGIN
OPEN c_employees;
LOOP
    FETCH
    c_employees INTO v_employees_id;
    EXIT WHEN c_employees%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Processing Employee ID:'|| v_employees_id);
END LOOP;
CLOSE c_employees;
END;
-----------------------------------------------------------------
The HR department wants to increase salaries by 10% for employees in a specific department.

✅ Write a PL/SQL block that:

Retrieves employees from DEPARTMENT_ID = 50.
Increases their SALARY by 10%.
Prints the old salary and new salary for each updated employee.

DECLARE
CURSOR
SELECT
VARIABLE%TYPE
OPEN
LOOP
FETCH
CURSOR TO THE VARIABLE
EXIT WHEN %NOTFOUND
PRINT OUT MESSAGE
ENDLOOP
CLOSE CURSOR
END


DECLARE 
    CURSOR c_employees IS 
    SELECT employee_id, salary
    FROM employees
    WHERE department_id = 50;
    v_employee_id employees.employee_id%TYPE;
    old_salary employees.salary%TYPE;
    v_salary employees.salary%TYPE;
    v_salary_increase NUMBER;
    v_updated_salary employees.salary%TYPE;
    
BEGIN
    OPEN c_employees;
    LOOP
    FETCH c_employees INTO v_employee_id, v_salary;
        EXIT WHEN c_employees%NOTFOUND;
    old_salary := v_salary;
    v_salary_increase := v_salary * 0.10;
    
    UPDATE employees
    SET salary = v_salary + v_salary_increase
    WHERE employee_id = v_employee_id
    RETURNING salary INTO v_updated_salary;
    DBMS_OUTPUT.PUT_LINE('Salary updated for: ' || v_employee_id || 'This much: ' || v_salary_increase || 'Old salary was: ' || old_salary);
    DBMS_OUTPUT.PUT_LINE('Now salary is: '|| v_updated_salary);
    
    END LOOP;
    CLOSE c_employees;
    COMMIT;
    
END;
----------------------------------------------------------------- Hiring new employee automation
When a new employee is hired, their data should be inserted into the EMPLOYEES table.

✅ Write a PL/SQL block that:

Inserts a new employee with EMPLOYEE_ID = 300, FIRST_NAME = 'John', LAST_NAME = 'Doe', JOB_ID = 'IT_PROG', SALARY = 7000, DEPARTMENT_ID = 60.
Displays "Employee John Doe has been added successfully!".
Handles any constraint violations (like duplicate EMPLOYEE_ID).

CREATE OR REPLACE PROCEDURE procedure_name (
    param1_name param1_type,
    param2_name param2_type
)
IS
    -- Declare local variables here
BEGIN
    -- Write PL/SQL logic (INSERT, UPDATE, DELETE, etc.)
    DBMS_OUTPUT.PUT_LINE('Procedure executed successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END procedure_name;
/


CREATE OR REPLACE PROCEDURE new_employee (
    p_employee_id   employees.employee_id%TYPE,
    p_first_name    employees.first_name%TYPE,
    p_last_name     employees.last_name%TYPE,
    p_email       employees.email%TYPE,
    p_phone_number employees.phone_number%TYPE,
    p_hire_date   employees.hire_date%TYPE,
    p_job_id  employees.job_id%TYPE,
    p_salary  employees.salary%TYPE,
    p_commission_pct  employees.commission_pct%TYPE,
    p_manager_id  employees.manager_id%TYPE,
    p_department_id   employees.department_id%TYPE
    )
IS
BEGIN 
    INSERT INTO employees (
    employee_id, first_name, last_name, email, phone_number,
    hire_date, job_id, salary, commission_pct, manager_id, department_id
    )
    VALUES (
    p_employee_id, p_first_name, p_last_name, p_email, p_phone_number,
    p_hire_date, p_job_id, p_salary, p_commission_pct, p_manager_id,
    p_department_id
    );
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Employee'|| p_first_name || 'has been added successfully!');
    
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN 
    DBMS_OUTPUT.PUT_LINE('Error: Employee already exists');
    WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE('Error: '|| SQLERRM);

END new_employee;


BEGIN new_employee(
101, 'John', 'Doe', 'jdoe@example.com', '1234567890',TO_DATE('2024-02-01', 'YYYY-MM-DD')
, 'IT_PROG', 5000, NULL, 100, 50);
end;


DECLARE
v_employee_id employees.employee_id%TYPE;
v_first_name employees.first_name%TYPE;

Begin
select employee_id, first_name 
INTO v_employee_id, v_first_name
from employees
where employee_id = 101;

DBMS_OUTPUT.PUT_LINE('Employee: ' || v_employee_id || v_first_name);
end;
----------------------------------------------------------------- CURSORS
DECLARE
CURSOR
SELECT
VARIABLE%TYPE
OPEN
LOOP
FETCH
CURSOR TO THE VARIABLE
EXIT WHEN %NOTFOUND
PRINT OUT MESSAGE
ENDLOOP
CLOSE CURSOR
END

✅ Write a PL/SQL block that:

Retrieves employees from DEPARTMENT_ID = 50.
Increases their SALARY by 10%.
Prints the old salary and new salary for each updated employee.

----------------------------------------------------------------- CURSOR

DECLARE

    CURSOR c_employees IS
    SELECT employee_id, first_name, salary
    FROM employees
    WHERE department_id = 50;
        v_employee_id employees.employee_id%TYPE;
        v_first_name employees.first_name%TYPE;
        v_old_salary employees.salary%TYPE;
        v_new_salary employees.salary%TYPE;
BEGIN
    OPEN c_employees;
    LOOP
    FETCH c_employees INTO v_employee_id, v_first_name, v_old_salary;
    EXIT WHEN c_employees%NOTFOUND;
         
        v_new_salary := v_old_salary * 1.10;
        
    UPDATE employees
    SET salary = v_new_salary
    WHERE employee_id = v_employee_id;
    DBMS_OUTPUT.PUT_LINE
    ('Department 50 employee salary increased for:'
    || v_employee_id ||','|| v_first_name || 'Old salary:' || v_old_salary
    ||'New salary'|| v_new_salary);
    END LOOP;
    CLOSE c_employees;
    COMMIT;
END;
----------------------------------------------------------------- bulk collect and forall

-----------------------------------------------------------------
Exercise: Write a PL/SQL block that fetches all employees from the employees table
(HR schema) into a collection (e.g., employee_record_type array).

DECLARE
    TYPE t_emp_id IS TABLE OF employees.employee_id%TYPE;
    v_emp_id t_emp_id;
    v_count number;
    
BEGIN

    SELECT employee_id
    BULK COLLECT INTO v_emp_id
    FROM employees;
    
    v_count := v_emp_id.COUNT;
    
    IF v_emp_id.COUNT > 0 THEN
        FOR i IN 1..v_emp_id.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Temp table employees:'|| v_emp_id(i));
    END LOOP;
    ELSE 
        DBMS_OUTPUT.PUT_LINE('No employees found');
    END IF;
    DBMS_OUTPUT.PUT_LINE('Total number of employees in temp table: ' || v_count);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
-----------------------------------------------------------------

-----------------------------------------------------------------
HR needs a summary report that shows the total salary payout per department.

✅ Write a PL/SQL block that:

Uses a bulk collect for DEPARTMENTS.
For each department, calculates the total salary payout.
Prints: "Department <dept_name> has a total salary of $<total_salary>".


DECLARE 
    TYPE t_depart_id IS TABLE OF departments.department_id%TYPE;
    TYPE t_depart_name IS TABLE OF departments.department_name%TYPE;
    TYPE t_salary IS TABLE OF NUMBER;

        v_depart_id t_depart_id;
        v_depart_name t_depart_name;
        v_salary t_salary;

BEGIN
    SELECT d.department_id, d.department_name, COALESCE(SUM(e.salary), 0)
    BULK COLLECT INTO v_depart_id, v_depart_name, v_salary
    FROM departments d
    JOIN employees e 
    ON d.department_id = e.department_id
    GROUP by d.department_id, d.department_name;


    FOR i IN 1..v_depart_id.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Department ID:'|| v_depart_id(i)  || 
        ' Total Salary: ' || v_salary(i));
END LOOP;
END;
----------------------------------------------------------------- BULK COLLECT
Write a procedure that increases the salary of all employees in a department 
using BULK COLLECT & FORALL.

CREATE OR REPLACE PROCEDURE IS 
DECLARE
TYPE T_C IS TABLE OF T.C_N
V_C T_C 

BEGIN
SELECT
BULK COLLECT INTO V
FROM T
WHERE

FORALL i IN 1..V.COUNT
UPDATE T
SET C = V(i) any calculation
WHERE C = V(i)
PRINT MSG
EXCEPTION
WHEN OTHERS THEN
PRINT MSG

CREATE OR REPLACE PROCEDURE increase_salary (
    p_department_id IN employees.department_id%TYPE
) AS
    TYPE emp_table IS TABLE OF employees.employee_id%TYPE;
    v_emp_ids emp_table;
BEGIN
    SELECT employee_id 
    BULK COLLECT INTO v_emp_ids 
    FROM employees WHERE department_id = p_department_id;

    FORALL i IN 1..v_emp_ids.COUNT
        UPDATE employees SET salary = salary * 1.05 WHERE employee_id = v_emp_ids(i);

    COMMIT;
END;
/

BEGIN
    increase_salary(50);
END;

-----------------------------------------------------------------
Write a PL/SQL block that retrieves employee_id, first_name, 
and salary from the employees table using an explicit cursor and prints them.

DECLARE
    CURSOR c_employees IS
    SELECT employee_id, first_name, salary
    FROM EMPLOYEES;
    
    v_employees employees.employee_id%TYPE;
    v_first_name employees.first_name%TYPE;
    v_salary employees.salary%TYPE;
BEGIN
    OPEN c_employees;
    LOOP
    FETCH c_employees INTO v_employees, v_first_name, v_salary;
    EXIT WHEN c_employees%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Employee info: '|| v_employees ||', '|| 
    v_first_name ||', '|| v_salary);
    END LOOP;
    CLOSE c_employees;
    
END;
----------------------------------------------------------------- 
Increase Salaries Using Bulk Collect & Forall
👉 Create a procedure that increases the salary of all employees in a specific
department by a given percentage.
📌 Use: BULK COLLECT, FORALL, and UPDATE.

CREATE OR REPLACE PROCEDURE NAMEOFPROCEDURE(KA NORI PADARYT NAME 
IN (KUR PAGRINDINIS STULPAS %TYPE, PARAMETRAS KURIUO NORI PAKEIST DUOMENIS 
percentage IN NUMBER)
AS
TYPE T_C IS TABLE OF T.C_N
V_C T_C 

BEGIN
SELECT
BULK COLLECT INTO V
FROM T WHERE TO DEPLOY THE CALCULATIONS

FORALL i IN 1..V_IDS.COUNT
UPDATE T
SET C = C + - / * any calculation
WHERE C = KAM IR KUR = (i)
PRINT MSG ('Succesfull')
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE salary_adjust_department (p_department_id IN
employees.department_id%TYPE, p_percentage IN NUMBER)

AS

TYPE t_employee_id IS TABLE OF employees.employee_id%TYPE;
v_employee_id t_employee_id;

BEGIN
    SELECT employee_id
    BULK COLLECT INTO v_employee_id
    FROM employees WHERE department_id = p_department_id;
    
    FORALL i IN 1..v_employee_id.COUNT
        UPDATE employees
        SET salary = salary + (salary * p_percentage / 100)
        WHERE employee_id = v_employee_id(i);
END;

BEGIN salary_adjust_department (30, 10);
END;
--------------------------------------------------------------------- 


CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    phone_number VARCHAR2(20) UNIQUE,
    date_of_birth DATE NOT NULL,
    created_at DATE DEFAULT SYSDATE
);


CREATE TABLE accounts (
    account_id NUMBER PRIMARY KEY,
    customer_id NUMBER REFERENCES customers(customer_id),
    account_type VARCHAR2(10) CHECK (account_type IN ('SAVINGS', 'CHECKING', 'LOAN')),
    balance NUMBER(12,2) DEFAULT 0,
    currency VARCHAR2(3) DEFAULT 'EUR',
    status VARCHAR2(10) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'BLOCKED', 'CLOSED')),
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
    loan_term MONTHS NOT NULL,
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
-------------------------------------------------------------------------------
--Declare variables for first_name and last_name using %TYPE.
--Select the first name and last name of the customer with customer_id = 1 into these variables.
--Output the full name using DBMS_OUTPUT.PUT_LINE.

DECLARE 
v_first_name customers.first_name%TYPE;
v_last_name customers.last_name%TYPE;
BEGIN
SELECT first_name, last_name
INTO v_first_name, v_last_name
FROM customers
WHERE customer_id = 1;
DBMS_OUTPUT.PUT_LINE('Customer:' || v_first_name ||' '||v_last_name);
END;

-------------------------------------------------------------------------------
--Assume the bind variables :v_customer_id and :v_balance are provided.
--Declare a variable for the new account_id using %TYPE.
--Insert a new SAVINGS account using the bind variables and the new account_id.
--Output the new account ID.


DECLARE
    v_account_id accounts.account_id%TYPE;
BEGIN
    v_account_id := accounts_seq.NEXTVAL;

    INSERT INTO accounts (account_id, customer_id, account_type, balance, currency, status)
    VALUES (v_account_id, :v_customer_id, 'SAVINGS', :v_balance, 'EUR', 'ACTIVE');

    DBMS_OUTPUT.PUT_LINE('New account created with ID: ' || v_account_id);
    COMMIT;
END;

--Declare variables using %TYPE based on the customers table.
--Select the first name, last name, and date of birth of the customer with customer_id = 1 
--into these variables.
--Convert the date_of_birth to the format DD-MON-YYYY using the TO_CHAR function.
--Output the full name and formatted date of birth using DBMS_OUTPUT.PUT_LINE.

DECLARE
v_first_name customers.first_name%TYPE;
v_last_name customers.last_name%TYPE;
v_date VARCHAR2(20);

BEGIN
SELECT first_name, last_name, TO_CHAR(date_of_birth, 'DD-MON-YYYY') 
INTO v_first_name, v_last_name, v_date
FROM customers
WHERE customer_id = 1;
DBMS_OUTPUT.PUT_LINE('Customer: ' || v_first_name || v_last_name || v_date);
EXCEPTION 
    WHEN no_data_found THEN dbms_output.put_line('customer does not exist');
END;

--Objective: Use bind variables to update data in the accounts table and log the changes 
--in the etl_audit_log table.
--Steps:
--Assume the bind variables :v_account_id and :v_new_balance are provided.
--Declare a variable for current_balance using %TYPE.
--Select the current balance of the specified account into the variable.
--Update the balance of the specified account using the bind variable.
--Log the update operation in the etl_audit_log table.


DECLARE

    v_current_balance accounts.balance%TYPE;
BEGIN
  
    SELECT balance
    INTO v_current_balance
    FROM accounts
    WHERE account_id =: v_account_id;

 
    UPDATE accounts
    SET balance = :v_new_balance
    WHERE account_id = :v_account_id;

    
    INSERT INTO etl_audit_log (log_id, table_name, operation, changed_at, changed_by)
    VALUES (etl_audit_log_seq.NEXTVAL, 'accounts', 'UPDATE', SYSDATE, 'ETL_USER');

   
    DBMS_OUTPUT.PUT_LINE('Account ID ' || :v_account_id || ' updated to new balance: ' || :v_new_balance);
    COMMIT;
END;
/

-----------------------

DECLARE
  c_grade CHAR( 1 );
  c_rank  VARCHAR2( 20 );
BEGIN
  c_grade := 'A';
  CASE c_grade
  WHEN 'A' THEN
    c_rank := 'Excellent' ;
  WHEN 'B' THEN
    c_rank := 'Very Good' ;
  WHEN 'C' THEN
    c_rank := 'Good' ;
  WHEN 'D' THEN
    c_rank := 'Fair' ;
  WHEN 'F' THEN
    c_rank := 'Poor' ;
  ELSE
    c_rank := 'No such grade' ;
  END CASE;
  DBMS_OUTPUT.PUT_LINE( c_rank );
END;

-------------------------------------------------------------------------------

DECLARE
    v_discount NUMBER(2); 
    purchase_p NUMBER(5);
BEGIN
    purchase_p := 500;

CASE 
    WHEN purchase_p > 500 
    THEN v_discount := 20;

    WHEN purchase_p BETWEEN 300 AND 500
    THEN v_discount := 15;

    WHEN purchase_p BETWEEN 100 AND 300 
    THEN v_discount := 10;

    WHEN purchase_p < 100
    THEN v_discount := 5;
    
    END CASE;
    DBMS_OUTPUT.PUT_LINE( 'The discount is: ' || v_discount);
END;

-------------------------------------------------------------------------------
DECLARE
  l_counter NUMBER := 0;
BEGIN
  LOOP
    l_counter := l_counter + 1;
    EXIT WHEN l_counter > 3;
    dbms_output.put_line( 'Inside loop: ' || l_counter ) ;
  END LOOP;

  -- control resumes here after EXIT
  dbms_output.put_line( 'After loop: ' || l_counter );
END;
-------------------------------------------------------------------------------
DECLARE
  l_i NUMBER := 0;
  l_j NUMBER := 0;
BEGIN
  <<outer_loop>>
  LOOP
    l_i := l_i + 1;
    EXIT outer_loop WHEN l_i > 2;    
    dbms_output.put_line('Outer counter ' || l_i);
    -- reset inner counter
    l_j := 0;
      <<inner_loop>> LOOP
      l_j := l_j + 1;
      EXIT inner_loop WHEN l_j > 3;
      dbms_output.put_line(' Inner counter ' || l_j);
    END LOOP inner_loop;
  END LOOP outer_loop;
END;
-------------------------------------------------------------------------------
DECLARE
  l_step  PLS_INTEGER := 2;
BEGIN
  FOR l_counter IN 1..5 LOOP
    dbms_output.put_line (l_step*l_counter);
  END LOOP;
END;

-------------------------------------------------------------------------------
DECLARE
  principal NUMBER := 1000;  -- initial amount
  rate      NUMBER := 0.05;  -- 5% interest rate
  periods   NUMBER := 10;    -- number of periods (years)
BEGIN
  FOR i IN 1..periods LOOP
    principal := principal * (1 + rate);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Future Value: ' || principal);
END:
------------------------------------BIG PRACTICE BIG TIME-----------------------------------
DECLARE
    v_account_id accounts.account_id%TYPE := &account_id;
    v_balance accounts.balance%TYPE;
BEGIN
    select balance 
    INTO v_balance
    FROM accounts
    where account_id = v_account_id;
    
    DBMS_OUTPUT.PUT_LINE('Account id:' || v_account_id || 'Balance: '|| v_balance);

EXCEPTION WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('There is no data about account id: ' || v_account_id);
END;


select * from accounts;
select * from card_transactions

------------------------------------------------------------------------------
DECLARE
   v_account_id accounts.account_id%TYPE := &v_account_id;
    v_transaction_id transactions.transaction_id%TYPE;
    v_transaction_type transactions.transaction_type%TYPE;
    v_amount transactions.amount%TYPE;
    v_status transactions.status%TYPE;
    
    CURSOR latest_transactions IS
    SELECT t.transaction_id, t.transaction_type,
    t.amount, t.status
    FROM transactions t
    WHERE t.account_id = v_account_id
    ORDER BY t.transaction_date DESC;
    
    row_count NUMBER := 0;
   
BEGIN
    
    OPEN latest_transactions;
    LOOP 
    FETCH latest_transactions INTO v_transaction_id, v_transaction_type,
    v_amount, v_status;
    IF latest_transactions%NOTFOUND THEN
        RAISE NO_DATA_FOUND; 
    END IF;
    EXIT WHEN latest_transactions%NOTFOUND;
    row_count := row_count + 1;
    IF row_count > 5 THEN
    EXIT;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_transaction_id ||
                             ', Type: ' || v_transaction_type ||
                             ', Amount: ' || v_amount ||
                             ', Status: ' || v_status);
    END LOOP;
    
    CLOSE latest_transactions;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('No transactions found for this account.');
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);

END;

-----------------------------------------------



/*
DECLARE 
    ALL THE VARIABLES, input variable := &v_account_id
      
    give row_count  NUMBER := 0 (for row counting later on)

    CURSOR XXX IS 
    SELECT 
    ....
BEGIN
    OPEN THE CUSOR
        CHECK IF THE IS ANY ROWS WITH THAT ID INSTANTLY
    FETCH the cursor into the variables
    IF CURSOR %NOTFOUND THEN CLOSE CURSOR
    RAISE NO_DATA_FOUND;
    END IF; 
    (If there is a record then:)
    
    THEN LOOP FOR THE 5 RECORDS.
    
    row_count := row_count + 1
    if row_count > 5 THEN EXIT;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Transaction details' || variables....);
    
    FETCH cursor into the variables.
    
    EXIT WHEN cursor%NOTFOUND;
    END LOOP;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
    DBMS_OUTPUT.PUT_LINE('NO DATA BRO');
    WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('ERROR BRO:' || SQLERRM);
     
END;
*/
-----------------------------------------------------------------------

DECLARE
    v_account_id accounts.account_id%TYPE := &v_account_id;
    v_transaction_id   transactions.transaction_id%TYPE;
    v_transaction_type transactions.transaction_type%TYPE;
    v_amount           transactions.amount%TYPE;
    v_transaction_date transactions.transaction_date%TYPE;
    v_status           transactions.status%TYPE;

    row_count NUMBER := 0;

    CURSOR latest_transactions IS
        SELECT transaction_id, transaction_type, transaction_date, amount, status
        FROM transactions 
        WHERE account_id = v_account_id;
        
BEGIN

    OPEN latest_transactions;
    
    FETCH latest_transactions INTO v_transaction_id, v_transaction_type, v_transaction_date, v_amount, v_status;
        IF latest_transactions%NOTFOUND 
        THEN CLOSE latest_transactions;
        RAISE NO_DATA_FOUND;
        END IF;
    LOOP
        row_count := row_count + 1;
    IF row_count > 5 THEN
    EXIT;
    END IF;
        DBMS_OUTPUT.PUT_LINE(' Transaction type: ' ||  v_transaction_type ||
                            ' Transaction_id: ' || v_transaction_id ||
                            ' Transaction Date '|| v_transaction_date ||
                            ' Amount ' || v_amount ||
                            ' Status '|| v_status);
    
    FETCH 
        latest_transactions INTO v_transaction_id, v_transaction_type, v_transaction_date, v_amount, v_status;
    EXIT WHEN latest_transactions%NOTFOUND;
    END LOOP;
    
    CLOSE latest_transactions;
    
    EXCEPTION WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('There is no data ragarding this ID');
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error:' || SQLERRM);


END;
/

------------------------practice mo and mo-----------------------------------------------------------------------------
Write a PL/SQL block that takes an account_id and a threshold amount as input.  
Display all transactions for that account
where the transaction amount is greater than or equal to the given threshold

select * from transactions;

DECLARE
    v_account_id accounts.account_id%TYPE := &v_account_id;
    v_threshold transactions.amount%TYPE := &v_threshold;
    v_amount transactions.amount%TYPE;

 CURSOR i_threshold IS
    SELECT amount
    FROM transactions
    WHERE account_id = v_account_id AND amount >= v_threshold;
    
BEGIN
    OPEN i_threshold;
    
    LOOP
    FETCH i_threshold INTO v_amount;
    EXIT WHEN i_threshold%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE('Account id: ' || v_account_id ||
                        'Amounts ' || v_amount);
    END LOOP;
    CLOSE i_threshold;
    
END;

--------------------------------------------------------------------------------
DECLARE
    v_account_id accounts.account_id%TYPE := &v_account_id;
    v_transaction_id transactions.transaction_id%TYPE;
    v_transaction_type transactions.transaction_type%TYPE;
    v_amount transactions.amount%TYPE;

row_count NUMBER := 0;

CURSOR latest_transactions IS
    SELECT transaction_id, transaction_type, amount
    FROM transactions
    WHERE account_id = v_account_id AND amount >= 1000;

BEGIN
    OPEN latest_transactions;
    FETCH latest_transactions INTO v_transaction_id, v_transaction_type, v_amount;
    IF latest_transactions%NOTFOUND
    THEN RAISE NO_DATA_FOUND;
    END IF;
    
    LOOP
    row_count := row_count + 1;
    IF row_count > 3 THEN
    EXIT;
    END IF;
     DBMS_OUTPUT.PUT_LINE(' Transaction id: ' ||  v_transaction_id ||
                            ' Transaction_type: ' || v_transaction_type ||
                            ' Amount ' || v_amount);
                            
    FETCH latest_transactions INTO v_transaction_id, v_transaction_type, v_amount;
    END LOOP;
    CLOSE latest_transactions;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('There is no data');
    
    WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM );
    
END;

------------------------------------------02-09 LOOPS AND LOOPS AND LOOPS ------------------------------------
DECLARE
    CURSOR n_accounts IS
    SELECT account_id
    FROM accounts
    WHERE balance < 0;

BEGIN
    FOR i in n_accounts LOOP
    UPDATE accounts
    SET balance = balance - 10
    WHERE account_id = i.account_id;

    INSERT INTO etl_audit_log (LOG_ID, TABLE_NAME, OPERATION ,CHANGED_AT, CHANGED_BY)
    VALUES (etl_audit_log_seq.NEXTVAL, 'accounts', 'UPDATE', SYSDATE, USER);
    
        DBMS_OUTPUT.PUT_LINE('Penalty applied to Account ID: ' || i.account_id);
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM );
        ROLLBACK;
END;
/


select * from transactions;

--------------------------------------------------------------------------------
BEGIN
    FOR i IN (SELECT account_id FROM accounts WHERE status = 'ACTIVE')
    LOOP 
     DBMS_OUTPUT.PUT_LINE('Active account ID: ' || i.account_id );
    END LOOP;
END;
--------------------------------------------------------------------------------
BEGIN


FOR i in (SELECT account_id, customer_id, account_type, balance
FROM accounts WHERE status = 'ACTIVE')
LOOP
DBMS_OUTPUT.PUT_LINE('Active accounts info: ' || i.account_id || i.customer_id ||
 i.account_type || i.balance);
END LOOP;

END;
--------------------------------------------------------------------------------
DECLARE
BEGIN
  FOR rec IN (SELECT status  -- Or select other columns if you need them
              FROM transactions
              WHERE status = 'PENDING')
  LOOP
    DBMS_OUTPUT.PUT_LINE('Pending transactions: ' || rec.status); -- Use rec.status
  END LOOP;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);  -- Corrected exception handling
END;
/
--------------------------------------------------------------------------------
BEGIN

FOR i IN (SELECT transaction_id, status
FROM transactions 
WHERE status = 'PENDING')

LOOP
 DBMS_OUTPUT.PUT_LINE('Pending: '|| i.transaction_id ||' '|| i.status);
 END LOOP; 
 END;
--------------------------------------------------------------------------------
BEGIN

FOR i IN (SELECT loan_id, loan_amount, interest_rate
FROM LOANS
WHERE loan_status = 'ACTIVE')

LOOP 
UPDATE loans
SET loan_amount = loan_amount + loan_amount * 0.050
WHERE loan_id = i.loan_id;

DBMS_OUTPUT.PUT_LINE('Loan increased 5% for:' || i.loan_id ||' '|| i.loan_amount);

END LOOP;
COMMIT;
END;
---------------------------------------------------------------------------
BEGIN

FOR i IN (SELECT loan_id, loan_amount
FROM loans
WHERE loan_status = 'ACTIVE')
LOOP

UPDATE loans
SET loan_amount = loan_amount + loan_amount * 0.05
WHERE loan_id = i.loan_id;
DBMS_OUTPUT.PUT_LINE('Loan increased for:' || i.loan_id || ' ' || i.loan_amount);

END LOOP;
COMMIT;
END;
--------------------------------PROCEDURES PRACTICE 
-----------------------------------EXAMPLE CODE--------------------------
CREATE OR REPLACE PROCEDURE print_contact(
    in_customer_id NUMBER 
)
IS
  r_contact contacts%ROWTYPE;
BEGIN
  -- get contact based on customer id
  SELECT *
  INTO r_contact
  FROM contacts
  WHERE customer_id = in_customer_id;

  -- print out contact's information
  dbms_output.put_line( r_contact.first_name || ' ' ||
  r_contact.last_name || '<' || r_contact.email ||'>' );

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line( SQLERRM );
END;
---------------------------------MY PROCEDURES START HERE-----------------------------------------------
CREATE OR REPLACE PROCEDURE t_amount (
    v_id IN transactions.account_id%TYPE)
IS
    result NUMBER;
BEGIN
    SELECT sum(amount) INTO result
    FROM transactions
    WHERE account_id = v_id;
    
    dbms_output.put_line('Account id: ' || v_id || 'Total amount:' || result);
    
EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line('0');
END t_amount;
/
    
BEGIN
    t_amount(101);
END;

SELECT * FROM transactions;
---------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE t_amount (
    v_id IN transactions.account_id%TYPE,
    result OUT NUMBER)
IS
    
BEGIN
result := 0;

    SELECT sum(amount) INTO result
    FROM transactions
    WHERE account_id = v_id;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    result := 0;
END;
/

DECLARE
result NUMBER;
BEGIN
    t_amount(101, result);
    dbms_output.put_line('Amount: ' || result);
END;
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE t_amount (
v_id IN transactions.account_id%TYPE,
result OUT NUMBER)
IS
BEGIN

        result := 0;

    SELECT sum(amount) INTO result
    FROM transactions
    WHERE account_id = v_id;

EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    result := 0;
    WHEN OTHERS THEN
    dbms_output.put_line('Error' || SQLERRM);
END;
/

DECLARE
result NUMBER;
BEGIN
t_amount(101, result);
dbms_output.put_line('AMOUNT: ' || result);
END;
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE n_transaction (
v_id transactions.account_id%TYPE,
v_amount transactions.amount%TYPE,
v_transaction_date transactions.transaction_date%TYPE)
IS

a_id NUMBER;
BEGIN
    SELECT COUNT(*) INTO a_id
    FROM accounts
    WHERE account_id = v_id;
    
    if a_id > 0
    THEN 
    INSERT INTO transactions(ACCOUNT_ID, AMOUNT, TRANSACTION_DATE)
    VALUES (v_id, v_amount, v_transaction_date);
    DBMS_OUTPUT.PUT_LINE('Transaction added successfully for account ID: ' || v_id);
    ELSE
        dbms_output.put_line('Error, no account exists');
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line('Unexpected error: '|| SQLERRM);
    
END;
/


BEGIN
n_transaction (101, 100, TO_DATE('01-OCT-24', 'DD-MON-RR')); -- date format DAY-MON-YR

END;


select * from transactions;
----------------------------KARTOJIMAS PROCEDURES--------------------------------------------------
CREATE OR REPLACE PROCEDURE i_transactions (
    v_transaction_id IN transactions.transaction_id%TYPE,
    v_account_id IN accounts.account_id%TYPE,
    v_amount IN transactions.amount%TYPE,
    v_transaction_date IN transactions.transaction_date%TYPE)
IS

    id_count NUMBER := 0;

BEGIN
    SELECT COUNT(*) 
        INTO id_count
            FROM accounts
                WHERE account_id = v_account_id;

    IF id_count > 0
        THEN 
            INSERT INTO transactions (TRANSACTION_ID, ACCOUNT_ID, 
            AMOUNT, TRANSACTION_DATE)
            VALUES (v_transaction_id, v_account_id, v_amount, v_transaction_date);
                COMMIT;
    ELSE 
            dbms_output.put_line('There is no such ID');
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND
        THEN dbms_output.put_line('No data entered');
        
END;

BEGIN
    i_transactions (10087, 102, 2222, TO_DATE('05-OCT-24', 'DD-MON-RR'));
END;

select * from transactions;




EXPLAIN PLAN, Ref Cursors, EXPLAIN PLAN, Ref Cursors, EXPLAIN PLAN, Ref Cursors, 

----------------------------- Control Structures & Loops--------------------------------------------------
CREATE OR REPLACE PROCEDURE UPDATE_ACCOUNT_STATUS
IS

BEGIN
    For u_status IN (
    SELECT account_id, balance, status 
    FROM accounts)
    
    LOOP
    IF u_status.balance < 0 THEN
        UPDATE accounts
            SET status = 'BLOCKED'
                WHERE account_id = u_status.account_id;
    
    ELSIF u_status.balance >= 0 AND u_status.status = 'BLOCKED'  THEN
        UPDATE accounts
            SET STATUS = 'ACTIVE'
                WHERE account_id = u_status.account_id;
    END IF;
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error accured:' || SQLERRM);
  
END;
    
select * from accounts;
----------------------------------------------------------------------------------------------------   

CREATE OR REPLACE PROCEDURE increase_salary (
    p_department_id IN employees.department_id%TYPE
) AS
    TYPE emp_table IS TABLE OF employees.employee_id%TYPE;
    v_emp_ids emp_table;
BEGIN
    SELECT employee_id 
    BULK COLLECT INTO v_emp_ids 
    FROM employees WHERE department_id = p_department_id;

    FORALL i IN 1..v_emp_ids.COUNT
        UPDATE employees SET salary = salary * 1.05 WHERE employee_id = v_emp_ids(i);

    COMMIT;
END;
/

BEGIN
    increase_salary(50);
END;
------------------------------EXCEPTION HANDLING----------------------------------------------------------------------

✅ NO_DATA_FOUND ONLY FOR SELECT STATEMENTS
✅ DUP_VAL_ON_INDEX WHEN CHECKING IF THERE ARE ANY DUPLICATE IDS
✅ TOO_MANY_ROWS WHEN IN SELECT STATEMENT IT RETRIEVES MORE THAN 1 ROW
✅ ZERO_DIVIDE CHECK IF DIVIDES BY ZERO ERROR
✅ OTHERS SQLERRM
----------MORE STORED PROCEDURES WITH DIFFERENT KIND OF APPROACHES--------------

CREATE OR REPLACE PROCEDURE H_VALUE_C -- not working
IS

CURSOR a_balance IS
    SELECT c.customer_id, c.first_name, sum(a.balance) as total_balance
        FROM accounts a
        LEFT JOIN customers c USING (customer_id)
                    GROUP BY customer_id, first_name
                        HAVING SUM(a.balance) > 10000;

v_customer_id accounts.customer_id%TYPE;
v_first_name customers.first_name%TYPE;
v_total NUMBER;
          
BEGIN
    OPEN a_balance;
    LOOP
        FETCH
         a_balance INTO v_customer_id, v_first_name, v_total;
            EXIT WHEN a_balance%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('High-Value Customers balances over 10,000 EUR: ' 
            || v_customer_id || v_first_name || v_total);
    END LOOP;
    CLOSE a_balance;
    
    
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN
            DBMS_OUTPUT.PUT_LINE('No data');
    WHEN OTHERS
        THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
----------------------------------------------------------------------------------------------------
 v_customer_id loans.customer_id%TYPE;
    v_loan loans.loan_status%TYPE;
    v_interest_rate loans.interest_rate%TYPE;
    
CREATE OR REPLACE PROCEDURE active_loans
IS

BEGIN

    for i IN (SELECT customer_id, loan_amount, interest_rate
            FROM loans
                WHERE loan_status = 'ACTIVE')
    LOOP
     DBMS_OUTPUT.PUT_LINE('Active Loans: ' || i.customer_id ||' '|| i.loan_amount ||
     ' ' || i.interest_rate);
    END LOOP;
    
EXCEPTION
    WHEN OTHERS
        THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;    
    
BEGIN
    active_loans;
END;

----------------------------------------------------------------------------------------------------

















