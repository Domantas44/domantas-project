DECLARE
  v_pet_names SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Bella','Charlie','Max','Luna','Rocky','Lucy','Cooper','Daisy','Milo','Bailey','Sadie','Buddy','Molly','Bear','Stella','Duke','Lily','Toby','Zoe','Jack');
  v_types SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Dog','Cat','Rabbit','Guinea Pig','Hamster','Ferret');

  v_dog_breeds SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Labrador Retriever','Poodle','Bulldog','Beagle','Shih Tzu','Corgi','Pug','Golden Retriever','Boxer','Dachshund');
  v_cat_breeds SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Persian','Siamese','Maine Coon','Russian Blue','Ragdoll','British Shorthair','Bengal','Sphynx','Scottish Fold','Abyssinian');
  v_rabbit_breeds SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Holland Lop','Netherland Dwarf','Mini Rex','Lionhead','Flemish Giant','English Angora','Dutch','Rex','Mini Lop','Harlequin');
  v_guinea_breeds SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('American','Abyssinian','Peruvian','Silkie','Teddy','Texel','White Crested','Coronet','Sheltie','Rex');
  v_hamster_breeds SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Syrian','Dwarf Campbell','Dwarf Winter White','Roborovski','Chinese','Russian Dwarf','Siberian','Albino','Golden','Black Bear');
  v_ferret_breeds SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Standard','Albino','Sable','Black Sable','Champagne','Chocolate','Cinnamon','Silver','Blaze','Panda');

  v_desc_options SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
    '', 'Very friendly.', 'Aggressive.', 'Shy.', 'Needs special care.', 'Playful.',
    'Calm.', 'Energetic.', 'Older pet.', 'Young and active.', 'Prefers quiet.',
    'Good with other pets.', 'Rescue animal.', 'Recently adopted.'
  );

  TYPE t_id_array IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  v_customer_ids t_id_array;
  v_count NUMBER := 0;
  v_type_idx NUMBER;
  v_breed VARCHAR2(50);
  v_desc VARCHAR2(255);
  v_pets_per_customer NUMBER;
  v_pet_idx NUMBER := 0;
BEGIN
  -- Diagnostic: verify SELECT is pulling customer IDs
  FOR rec IN (SELECT customer_id FROM customer WHERE customer_id IS NOT NULL) LOOP
    v_count := v_count + 1;
    v_customer_ids(v_count) := rec.customer_id;
    DBMS_OUTPUT.PUT_LINE('Collected customer_id: ' || rec.customer_id);
  END LOOP;

  -- Exit early if no customers found
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No customer records found.');
    RETURN;
  END IF;

  FOR i IN 1..v_count LOOP
    v_pets_per_customer := TRUNC(DBMS_RANDOM.VALUE(1, 3)); -- 1 or 2 pets

    FOR j IN 1..v_pets_per_customer LOOP
      v_pet_idx := ((i-1)*2 + j);
      v_type_idx := MOD(v_pet_idx-1, v_types.COUNT) + 1;

      CASE v_types(v_type_idx)
        WHEN 'Dog' THEN v_breed := v_dog_breeds(MOD(v_pet_idx-1, v_dog_breeds.COUNT)+1);
        WHEN 'Cat' THEN v_breed := v_cat_breeds(MOD(v_pet_idx-1, v_cat_breeds.COUNT)+1);
        WHEN 'Rabbit' THEN v_breed := v_rabbit_breeds(MOD(v_pet_idx-1, v_rabbit_breeds.COUNT)+1);
        WHEN 'Guinea Pig' THEN v_breed := v_guinea_breeds(MOD(v_pet_idx-1, v_guinea_breeds.COUNT)+1);
        WHEN 'Hamster' THEN v_breed := v_hamster_breeds(MOD(v_pet_idx-1, v_hamster_breeds.COUNT)+1);
        ELSE v_breed := v_ferret_breeds(MOD(v_pet_idx-1, v_ferret_breeds.COUNT)+1);
      END CASE;

      v_desc := v_desc_options(TRUNC(DBMS_RANDOM.VALUE(1, v_desc_options.COUNT + 1)));

      INSERT INTO pet (
        pet_id, customer_id, pet_name, pet_type, pet_breed, description
      ) VALUES (
        pet_seq.NEXTVAL,
        v_customer_ids(i),
        v_pet_names(MOD(v_pet_idx-1, v_pet_names.COUNT)+1),
        v_types(v_type_idx),
        SUBSTR(v_breed, 1, 50),
        v_desc
      );

      DBMS_OUTPUT.PUT_LINE('Inserted pet for customer_id: ' || v_customer_ids(i));
    END LOOP;
  END LOOP;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Processed ' || v_count || ' customers and inserted pets successfully.');
END;
COMMIT;
/
