DECLARE
  TYPE t_num_array IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  TYPE t_varchar_array IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;

  v_groomer_ids t_num_array;
  v_service_ids t_num_array;

  v_groomer_count  NUMBER := 0;
  v_service_count  NUMBER := 0;

  v_created_bys t_varchar_array := t_varchar_array(1 => 'admin');

  v_start_time   DATE;
  v_end_time     DATE;
  v_hour         NUMBER;
  v_half         NUMBER;
  v_groomer_idx  NUMBER;
BEGIN
  -- Load groomer IDs
  FOR rec IN (SELECT groomer_id FROM groomer) LOOP
    v_groomer_count := v_groomer_count + 1;
    v_groomer_ids(v_groomer_count) := rec.groomer_id;
  END LOOP;

  -- Load service IDs
  FOR rec IN (SELECT service_id FROM service) LOOP
    v_service_count := v_service_count + 1;
    v_service_ids(v_service_count) := rec.service_id;
  END LOOP;

  -- Safety check
  IF v_groomer_count = 0 OR v_service_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Missing groomers or services. Aborting.');
    RETURN;
  END IF;

  FOR i IN 1..1000 LOOP
    BEGIN
      -- Distribute groomer workload evenly
      v_groomer_idx := MOD(i - 1, v_groomer_count) + 1;

      -- Generate working-hour start time (between 9:00 and 16:30)
      v_hour := TRUNC(DBMS_RANDOM.VALUE(9, 17));               -- Hours: 9–16
      v_half := CASE WHEN MOD(i, 2) = 0 THEN 0 ELSE 0.5 END;   -- Half-hour toggle
      v_start_time := TRUNC(SYSDATE + MOD(i, 30)) + ((v_hour + v_half) / 24);
      v_end_time := v_start_time + (1/24); -- 1 hour slot

      -- Insert groomer schedule
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
        groomer_schedule_seq.NEXTVAL,
        v_groomer_ids(v_groomer_idx),
        v_service_ids(MOD(i - 1, v_service_count) + 1),
        v_start_time,
        v_end_time,
        'Auto-generated schedule #' || i,
        v_created_bys(1),
        SYSDATE
      );

      DBMS_OUTPUT.PUT_LINE('Inserted schedule #' || i);

    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Skipped duplicate schedule for groomer at iteration ' || i);
    END;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Finished inserting groomer schedules!');
END;
/
COMMIT;
