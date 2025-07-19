BEGIN
  -- Loop over all appointment IDs
  FOR appt IN (SELECT appointment_id FROM appointment) LOOP
    -- For each appointment, loop through all service IDs
    FOR svc IN (SELECT service_id FROM service) LOOP
      -- Insert the combination
      INSERT INTO appointment_service (
        appointment_id,
        service_id
      ) VALUES (
        appt.appointment_id,
        svc.service_id
      );

      DBMS_OUTPUT.PUT_LINE('Linked appointment ID ' || appt.appointment_id || 
                           ' to service ID ' || svc.service_id);
    END LOOP;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('All appointment-service links inserted!');
END;
/
COMMIT;
