DECLARE
  TYPE t_id_array IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  v_service_ids t_id_array;
  v_items       SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
    'Shampoo','Conditioner','Nail Clippers','Brush','Comb','Ear Cleaner','Toothpaste','Towel','Scissors',
    'Cologne','Flea Spray','De-shedding Tool','Bandana','Bow','Dryer','Table','Apron','Gloves','Cotton Balls','Treats'
  );
  v_created_bys SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('admin','system','user1','user2');

  v_count NUMBER := 0;
BEGIN
  -- Load valid service IDs
  FOR rec IN (SELECT service_id FROM service) LOOP
    v_count := v_count + 1;
    v_service_ids(v_count) := rec.service_id;
  END LOOP;

  -- Safety check
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No services found. Aborting inventory insert.');
    RETURN;
  END IF;

  -- Insert inventory records linked to services
  FOR i IN 1..100 LOOP
    INSERT INTO service_inventory (
      service_inventory_id,
      item_name,
      quantity,
      unit_price,
      service_id,
      created_by,
      creation_date
    ) VALUES (
      service_inventory_seq.NEXTVAL,
      v_items(MOD(i - 1, v_items.COUNT) + 1) || ' #' || i,
      TRUNC(DBMS_RANDOM.VALUE(1, 50)),
      TRUNC(DBMS_RANDOM.VALUE(2, 30)),
      v_service_ids(MOD(i - 1, v_count) + 1),
      v_created_bys(MOD(i - 1, v_created_bys.COUNT) + 1),
      SYSDATE - MOD(i, 180)
    );

    DBMS_OUTPUT.PUT_LINE('Inventory item #' || i || ' added for service ID ' || v_service_ids(MOD(i - 1, v_count) + 1));
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Finished inserting 100 service inventory items!');
END;
/
COMMIT;

