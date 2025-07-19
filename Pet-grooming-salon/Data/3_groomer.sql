-- Mock data for groomer table
DECLARE
  v_first_names  SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Olivia','Liam','Emma','Noah','Ava','Elijah','Sophia','Lucas','Isabella','Mason','Mia','Logan','Charlotte','Ethan','Amelia','Jacob','Harper','Aiden','Evelyn','Jackson');
  v_last_names   SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Clark','Lewis','Walker','Young','Allen','King','Wright','Scott','Green','Baker','AdAMS','Nelson','Carter','Mitchell','Perez','Roberts','Turner','Phillips','Campbell','Parker');
  v_status       SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Available','On Leave','Busy');
  v_creators SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('admin','manager','employee','employee2');
BEGIN
  FOR i IN 1..10 LOOP
    INSERT INTO groomer (
      groomer_id, first_name, last_name, salary, email, phone, birth_date, address, groomer_status, created_by, creation_date
    ) VALUES (
      groomer_seq.nextval,
      v_first_names(MOD(i-1, v_first_names.COUNT)+1),
      v_last_names(MOD(i-1, v_last_names.COUNT)+1),
      TRUNC(DBMS_RANDOM.VALUE(1200, 3000)),
      SUBSTR(LOWER(v_first_names(MOD(i-1, v_first_names.COUNT)+1)) || '.' || LOWER(v_last_names(MOD(i-1, v_last_names.COUNT)+1)) || i || '@groomers.com', 1, 20),
      '555-' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(200,999))) || '-' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1000,9999))),
      TO_DATE('1980-01-01','YYYY-MM-DD') + TRUNC(DBMS_RANDOM.VALUE(0, 12000)),
      'Street ' || TRUNC(DBMS_RANDOM.VALUE(1, 200)) || ', Vilnius',
      v_status(MOD(i-1, v_status.COUNT)+1),
      v_creators(TRUNC(DBMS_RANDOM.VALUE(1, v_creators.COUNT+1))),
      SYSDATE - TRUNC(DBMS_RANDOM.VALUE(0, 365))
    );
  END LOOP;
END;
COMMIT;
/
