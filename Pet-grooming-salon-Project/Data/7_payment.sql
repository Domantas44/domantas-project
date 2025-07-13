DECLARE
  TYPE t_id_array IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  v_appointment_ids t_id_array;
  v_methods     SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Cash', 'Card', 'Online');
  v_created_bys SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('admin', 'system', 'user1', 'user2');

  v_count NUMBER := 0;
BEGIN
  -- Load all valid appointment IDs
  FOR rec IN (SELECT appointment_id FROM appointment) LOOP
    v_count := v_count + 1;
    v_appointment_ids(v_count) := rec.appointment_id;
  END LOOP;

  -- Safety check
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No appointments found. Aborting payment insert.');
    RETURN;
  END IF;

  -- Insert payments for each appointment
  FOR i IN 1..v_count LOOP
    INSERT INTO payment (
      payment_id,
      amount,
      payment_date,
      appointment_id,
      payment_method,
      created_by,
      creation_date
    ) VALUES (
      payment_seq.NEXTVAL,
      TRUNC(DBMS_RANDOM.VALUE(20, 200)),
      SYSDATE - MOD(i, 180),
      v_appointment_ids(i),
      v_methods(MOD(i - 1, v_methods.COUNT) + 1),
      v_created_bys(MOD(i - 1, v_created_bys.COUNT) + 1),
      SYSDATE - MOD(i, 180)
    );

    DBMS_OUTPUT.PUT_LINE('Payment inserted for appointment ID ' || v_appointment_ids(i));
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Finished inserting ' || v_count || ' payments!');
END;
/
COMMIT;

DROP SEQUENCE payment_seq;
CREATE SEQUENCE payment_seq
  START WITH 1
  INCREMENT BY 1;

select * from payment;

DELETE FROM PAYMENT WHERE payment_id between 235 and 400;

