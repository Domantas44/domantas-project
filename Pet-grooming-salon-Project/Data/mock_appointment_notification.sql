-- Mock data for appointment_notification table
DECLARE
  v_texts SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Reminder: Your appointment is tomorrow.','Thank you for booking with us!','Your appointment has been rescheduled.','Payment received for your appointment.','Special offer for your next visit!','We look forward to seeing you.','Contact us if you have questions.');
BEGIN
  FOR i IN 1..100 LOOP
    INSERT INTO appointment_notification (
      appointment_notification_id, appointment_id, notification_text, notification_date, notification_sent
    ) VALUES (
      notification_seq.nextval,
      MOD(i-1, 100) + 1,
      v_texts(MOD(i-1, v_texts.COUNT)+1),
      SYSDATE - MOD(i, 30),
      SYSDATE - MOD(i, 30)
    );
  END LOOP;
END;
/
