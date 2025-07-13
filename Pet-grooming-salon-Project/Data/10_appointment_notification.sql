DECLARE
  TYPE t_id_array IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  v_appointment_ids t_id_array;
  v_texts SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
    'Hi there! Just a quick reminder that you have a grooming appointment scheduled for tomorrow at [Time] with [Salon Name]. We’re looking forward to pampering your pet! 🐾 Please let us know if you need to reschedule.',
    'Reminder: your pet’s appointment is coming up tomorrow! 🐶 We can’t wait to see them. Reply to this message if you’d like to change the time.',
    'Heads up! Your grooming appointment is set for tomorrow. Please arrive 10 minutes early for check-in. 🐕 Thank you!'
  );

  v_count NUMBER := 0;
BEGIN
  -- Load actual appointment IDs
  FOR rec IN (SELECT appointment_id FROM appointment) LOOP
    v_count := v_count + 1;
    v_appointment_ids(v_count) := rec.appointment_id;
  END LOOP;

  -- Safety check
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No appointments found. Aborting notification insert.');
    RETURN;
  END IF;

  -- Insert notifications linked to appointments
  FOR i IN 1..v_count LOOP
    INSERT INTO appointment_notification (
      appointment_notification_id,
      appointment_id,
      notification_text,
      notification_date,
      notification_sent
    ) VALUES (
      notification_seq.NEXTVAL,
      v_appointment_ids(i),
      v_texts(TRUNC(DBMS_RANDOM.VALUE(1, v_texts.COUNT + 1))),
      TRUNC(SYSDATE - DBMS_RANDOM.VALUE(0, 60)),
      TRUNC(SYSDATE - DBMS_RANDOM.VALUE(0, 60))
    );

    DBMS_OUTPUT.PUT_LINE('Notification added for appointment ID ' || v_appointment_ids(i));
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Finished inserting ' || v_count || ' appointment notifications!');
END;
/
COMMIT;

