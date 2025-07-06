-- Mock data for groomer_schedule table
DECLARE
BEGIN
  FOR i IN 1..100 LOOP
    INSERT INTO groomer_schedule (
      groomer_schedule_id, groomer_id, service_id, start_time, end_time, notes, created_by, creation_date
    ) VALUES (
      groomer_schedule_seq.nextval,
      MOD(i-1, 100) + 1,
      MOD(i-1, 100) + 1,
      SYSDATE + MOD(i, 30) + (MOD(i, 8) * 0.25),
      SYSDATE + MOD(i, 30) + (MOD(i, 8) * 0.25) + (1/24),
      'Schedule for groomer #' || MOD(i-1, 100) + 1 || ' and service #' || MOD(i-1, 100) + 1,
      'admin',
      SYSDATE - MOD(i, 365)
    );
  END LOOP;
END;
/
