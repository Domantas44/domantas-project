-- Mock data for appointment_notification table
DECLARE
  v_texts SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
    'Hi there! Just a quick reminder that you have a grooming appointment scheduled for tomorrow at [Time] with [Salon Name]. We’re looking forward to pampering your pet! 🐾 Please let us know if you need to reschedule.'
  );
BEGIN
  FOR i IN 1..100 LOOP
    INSERT INTO appointment_notification (
      appointment_notification_id, appointment_id, notification_text, notification_date, notification_sent
    ) VALUES (
      notification_seq.nextval,
      MOD(i-1, 100) + 1,
      v_texts(TRUNC(DBMS_RANDOM.VALUE(1, v_texts.COUNT+1))),
      TRUNC(SYSDATE - DBMS_RANDOM.VALUE(0, 60)),
      TRUNC(SYSDATE - DBMS_RANDOM.VALUE(0, 60))
    );
  END LOOP;
END;
/
