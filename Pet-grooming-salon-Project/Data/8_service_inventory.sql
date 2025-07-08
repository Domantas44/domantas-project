-- Mock data for service_inventory table
DECLARE
  v_items SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Shampoo','Conditioner','Nail Clippers','Brush','Comb','Ear Cleaner','Toothpaste','Towel','Scissors','Cologne','Flea Spray','De-shedding Tool','Bandana','Bow','Dryer','Table','Apron','Gloves','Cotton Balls','Treats');
  v_created_bys SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('admin','system','user1','user2');
BEGIN
  FOR i IN 1..100 LOOP
    INSERT INTO service_inventory (
      service_inventory_id, item_name, quantity, unit_price, service_id, created_by, creation_date
    ) VALUES (
      service_inventory_seq.nextval,
      v_items(MOD(i-1, v_items.COUNT)+1) || ' ' || i,
      TRUNC(DBMS_RANDOM.VALUE(1, 50)),
      TRUNC(DBMS_RANDOM.VALUE(2, 30)),
      MOD(i-1, 100) + 1,
      v_created_bys(MOD(i-1, v_created_bys.COUNT)+1),
      SYSDATE - MOD(i, 180)
    );
  END LOOP;
END;
/
