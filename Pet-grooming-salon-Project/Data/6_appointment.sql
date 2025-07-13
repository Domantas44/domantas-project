DECLARE
  TYPE t_id_array IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  v_customer_ids t_id_array;
  v_schedule_ids t_id_array;
  v_customer_count NUMBER := 0;
  v_schedule_count NUMBER := 0;
  v_created_bys SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('admin');
BEGIN
  -- Collect all valid customer IDs
  FOR rec IN (SELECT customer_id FROM customer) LOOP
    v_customer_count := v_customer_count + 1;
    v_customer_ids(v_customer_count) := rec.customer_id;
  END LOOP;

  -- Collect all valid groomer_schedule IDs
  FOR rec IN (SELECT groomer_schedule_id FROM groomer_schedule) LOOP
    v_schedule_count := v_schedule_count + 1;
    v_schedule_ids(v_schedule_count) := rec.groomer_schedule_id;
  END LOOP;

  -- Safety check
  IF v_customer_count = 0 OR v_schedule_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Missing customers or schedules. Aborting.');
    RETURN;
  END IF;

  -- Insert one appointment per schedule
  FOR i IN 1..v_schedule_count LOOP
    DBMS_OUTPUT.PUT_LINE('Inserting appointment #' || i);

    INSERT INTO appointment (
      customer_id,
      groomer_schedule_id,
      appointment_cancelled,
      created_by,
      creation_date
    ) VALUES (
      v_customer_ids(MOD(i - 1, v_customer_count) + 1),
      v_schedule_ids(i),
      CASE WHEN MOD(i, 10) = 0 THEN 'Y' ELSE 'N' END,
      v_created_bys(1),
      SYSDATE - MOD(i, 180)
    );
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('All appointments inserted (1 per groomer schedule)!');
END;
/
COMMIT;

