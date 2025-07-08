-- Mock data for payment_refund table
DECLARE
  v_reasons SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Service not as expected','Pet illness','Scheduling error','Duplicate payment','Customer request','Other');
  v_created_bys SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('admin','system','user1','user2');
BEGIN
  FOR i IN 1..100 LOOP
    INSERT INTO payment_refund (
      refund_id, payment_id, refund_amount, refund_reason, created_by, creation_date
    ) VALUES (
      refund_seq.nextval,
      MOD(i-1, 100) + 1,
      TRUNC(DBMS_RANDOM.VALUE(5, 50)),
      v_reasons(MOD(i-1, v_reasons.COUNT)+1),
      v_created_bys(MOD(i-1, v_created_bys.COUNT)+1),
      SYSDATE - MOD(i, 90)
    );
  END LOOP;
END;
/
