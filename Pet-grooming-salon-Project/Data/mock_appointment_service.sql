-- Mock data for appointment_service table
BEGIN
  FOR i IN 1..100 LOOP
    INSERT INTO appointment_service (
      appointment_id, service_id
    ) VALUES (
      MOD(i-1, 100) + 1,
      MOD(i-1, 100) + 1
    );
  END LOOP;
END;
/
