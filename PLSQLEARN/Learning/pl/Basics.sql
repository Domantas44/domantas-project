CREATE TABLE employees1 (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2 (50),
    last_name VARCHAR2 (50),
    email VARCHAR2 (100),
    hire_date DATE,
    salary NUMBER
);



SET SERVEROUTPUT ON;

BEGIN
for i in (select first_name, last_name, SALARY
            from EMPLOYEES
            where salary > 5000)
loop 
    DBMS_OUTPUT.PUT_LINE('Salaries above 5000:' || i.first_name || i.last_name || i.salary);
end loop;
end;
