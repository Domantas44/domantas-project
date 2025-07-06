-- Mock data for appointment table
DECLARE
  v_created_bys SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('admin');
BEGIN
  FOR i IN 1..100 LOOP
    INSERT INTO appointment (
      appointment_id, customer_id, groomer_schedule_id, appointment_cancelled, created_by, creation_date
    ) VALUES (
      appointment_seq.nextval,
      MOD(i-1, 100) + 1,
      MOD(i-1, 100) + 1,
      CASE WHEN MOD(i, 10) = 0 THEN 'Y' ELSE 'N' END,
      v_created_bys(MOD(i-1, v_created_bys.COUNT)+1),
      SYSDATE - MOD(i, 180)
    );
  END LOOP;
END;
/
