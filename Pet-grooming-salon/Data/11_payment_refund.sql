DECLARE
  TYPE t_id_array IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  v_payment_ids t_id_array;
  v_reasons SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
    'Service not as expected',
    'Pet illness',
    'Scheduling error',
    'Duplicate payment',
    'Customer request',
    'Other'
  );
  v_created_bys SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
    'admin',
    'system',
    'user1',
    'user2'
  );

  v_count NUMBER := 0;
BEGIN
  -- Load actual payment IDs
  FOR rec IN (SELECT payment_id FROM payment) LOOP
    v_count := v_count + 1;
    v_payment_ids(v_count) := rec.payment_id;
  END LOOP;

  -- Safety check
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No payments found. Aborting refund insert.');
    RETURN;
  END IF;

  -- Insert refunds for valid payments
  FOR i IN 1..LEAST(v_count, 100) LOOP
    INSERT INTO payment_refund (
      refund_id,
      payment_id,
      refund_amount,
      refund_reason,
      created_by,
      creation_date
    ) VALUES (
      refund_seq.NEXTVAL,
      v_payment_ids(i),
      TRUNC(DBMS_RANDOM.VALUE(5, 50)),
      v_reasons(MOD(i - 1, v_reasons.COUNT) + 1),
      v_created_bys(MOD(i - 1, v_created_bys.COUNT) + 1),
      SYSDATE - MOD(i, 90)
    );

    DBMS_OUTPUT.PUT_LINE('Refund added for payment ID ' || v_payment_ids(i));
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Finished inserting mock refunds for ' || LEAST(v_count, 100) || ' payments!');
END;
/
COMMIT;

