-- Mock data for groomer_schedule table
DECLARE
  TYPE t_id_array IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  v_groomer_ids t_id_array;
  v_service_ids t_id_array;
  v_groomer_count NUMBER := 0;
  v_service_count NUMBER := 0;
BEGIN
  -- Fetch all valid groomer_ids
  FOR rec IN (SELECT groomer_id FROM groomer) LOOP
    v_groomer_count := v_groomer_count + 1;
    v_groomer_ids(v_groomer_count) := rec.groomer_id;
  END LOOP;
  -- Fetch all valid service_ids
  FOR rec IN (SELECT service_id FROM service) LOOP
    v_service_count := v_service_count + 1;
    v_service_ids(v_service_count) := rec.service_id;
  END LOOP;

  IF v_groomer_count = 0 OR v_service_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No groomers or services found. Aborting insert.');
    RETURN;
  END IF;

  FOR i IN 1..10 LOOP
    INSERT INTO groomer_schedule (
      groomer_schedule_id, groomer_id, service_id, start_time, end_time, notes, created_by, creation_date
    ) VALUES (
      groomer_schedule_seq.nextval,
      v_groomer_ids(MOD(i-1, v_groomer_count) + 1),
      v_service_ids(MOD(i-1, v_service_count) + 1),
      SYSDATE + MOD(i, 30) + (MOD(i, 8) * 0.25),
      SYSDATE + MOD(i, 30) + (MOD(i, 8) * 0.25) + (1/24),
      'Schedule for groomer #' || v_groomer_ids(MOD(i-1, v_groomer_count) + 1) || ' and service #' || v_service_ids(MOD(i-1, v_service_count) + 1),
      'admin',
      SYSDATE - MOD(i, 365)
    );
  END LOOP;
END;
/

select * from GROOMER_SCHEDULE;