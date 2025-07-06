-- Mock data for payment table
DECLARE
  v_methods SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Cash','Card','Online','Voucher');
  v_created_bys SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('admin','system','user1','user2');
BEGIN
  FOR i IN 1..100 LOOP
    INSERT INTO payment (
      payment_id, amount, payment_date, appointment_id, payment_method, created_by, creation_date
    ) VALUES (
      payment_seq.nextval,
      TRUNC(DBMS_RANDOM.VALUE(20, 200)),
      SYSDATE - MOD(i, 180),
      MOD(i-1, 100) + 1,
      v_methods(MOD(i-1, v_methods.COUNT)+1),
      v_created_bys(MOD(i-1, v_created_bys.COUNT)+1),
      SYSDATE - MOD(i, 180)
    );
  END LOOP;
END;
/
