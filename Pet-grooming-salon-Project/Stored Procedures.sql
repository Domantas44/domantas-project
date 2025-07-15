-- Cancel an Appointment and Log a Notification

CREATE OR REPLACE PROCEDURE appointment_cancelling (
    v_appointment_id IN appointment.appointment_id%TYPE,
    v_updated_by IN appointment.last_updated_by%TYPE
)
IS
BEGIN
     UPDATE appointment
      SET appointment_cancelled = 'Y',
      last_updated_by = v_updated_by,
      last_update = SYSDATE
      WHERE appointment_id = v_appointment_id;
   
    
    INSERT INTO appointment_notification (
        appointment_notification_id, 
        appointment_id, 
        notification_text, 
        notification_date
        )
        VALUES (appointment_notification_seq.NEXTVAL, 
        v_appointment_id, 
        'Your appointment was cancelled', 
        TO_DATE('2025-07-14 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));

END;

EXEC appointment_cancelling(1, 'Domantas');

-- Create a New Groomer Schedule

CREATE OR REPLACE PROCEDURE create_groomer_schedule (
    v_groomer_id IN groomer.groomer_id%TYPE,
    v_service_id IN groomer_schedule.service_id%TYPE,
    v_start_time IN groomer_schedule.start_time%TYPE,
    v_end_time IN groomer_schedule.end_time%TYPE,
    v_notes IN groomer_schedule.notes%TYPE,
    v_created_by IN groomer_schedule.created_by%TYPE DEFAULT 'System',
    v_creation_date IN groomer_schedule.creation_date%TYPE DEFAULT SYSDATE
)
IS
    v_count NUMBER;
    v_new_id groomer_schedule.groomer_schedule_id%TYPE;
BEGIN
    SELECT COUNT(*) INTO v_count -- Checking if the groomer is available for the given date and time
    FROM groomer_schedule
    WHERE groomer_id = v_groomer_id AND (start_time < v_end_time AND end_time > v_start_time);

       IF v_count > 0 THEN
           DBMS_OUTPUT.PUT_LINE('Groomer is not available for the selected time.');
        ELSE 

        SELECT groomer_schedule_seq.NEXTVAL INTO v_new_id FROM dual; -- For displaying what id was created

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
        v_new_id,
        v_groomer_id,
        v_service_id,
        v_start_time,
        v_end_time,
        v_notes,
        v_created_by,
        v_creation_date
    );
              DBMS_OUTPUT.PUT_LINE('Groomer schedule created with ID: ' || v_new_id);
         END IF;
END;

EXEC create_groomer_schedule(4, 3, TO_DATE('2025-07-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-07-15 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Bath and Brush', 'Domantas');