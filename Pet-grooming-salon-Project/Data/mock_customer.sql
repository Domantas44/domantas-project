-- Mock data for customer table
DECLARE
  v_first_names  SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('John','Emily','Michael','Sarah','David','Jessica','Daniel','Ashley','Matthew','Amanda','James','Jennifer','Joshua','Elizabeth','Andrew','Megan','Joseph','Lauren','Christopher','Hannah');
  v_last_names   SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Smith','Johnson','Williams','Brown','Jones','Garcia','Miller','Davis','Martinez','Hernandez','Lopez','Gonzalez','Wilson','Anderson','Thomas','Taylor','Moore','Jackson','Martin','Lee');
  v_phone_templates SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
    '+3706',      -- Lithuania
    '+4915',      -- Germany
    '+4477',      -- UK
    '+336',       -- France
    '+3934',      -- Italy
    '+3712',      -- Latvia
    '+4851',      -- Poland
    '+3584',      -- Finland
    '+4670',      -- Sweden
    '+3546'       -- Iceland
  );
BEGIN
  FOR i IN 1..100 LOOP
    INSERT INTO customer (customer_id, first_name, last_name, phone, email)
    VALUES (
      customer_seq.nextval,
      v_first_names(MOD(i-1, v_first_names.COUNT)+1),
      v_last_names(MOD(i-1, v_last_names.COUNT)+1),
      v_phone_templates(MOD(i-1, v_phone_templates.COUNT)+1) || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(100000,999999))),
      LOWER(v_first_names(MOD(i-1, v_first_names.COUNT)+1)) || '.' || LOWER(v_last_names(MOD(i-1, v_last_names.COUNT)+1)) || i || '@example.com'
    );
  END LOOP;
END;
/

BEGIN
    DELETE FROM customer WHERE customer_id between 221 and 320;
END;

select * from customer;