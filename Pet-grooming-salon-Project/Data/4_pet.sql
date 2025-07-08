-- Mock data for pet table
DECLARE
  v_pet_names SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Bella','Charlie','Max','Luna','Rocky','Lucy','Cooper','Daisy','Milo','Bailey','Sadie','Buddy','Molly','Bear','Stella','Duke','Lily','Toby','Zoe','Jack');
  v_types SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Dog','Cat','Rabbit','Guinea Pig','Hamster','Ferret');
  -- Breeds for each type, aligned by index
  v_dog_breeds SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Labrador Retriever','Poodle','Bulldog','Beagle','Shih Tzu','Corgi','Pug','Golden Retriever','Boxer','Dachshund');
  v_cat_breeds SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Persian','Siamese','Maine Coon','Russian Blue','Ragdoll','British Shorthair','Bengal','Sphynx','Scottish Fold','Abyssinian');
  v_rabbit_breeds SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Holland Lop','Netherland Dwarf','Mini Rex','Lionhead','Flemish Giant','English Angora','Dutch','Rex','Mini Lop','Harlequin');
  v_guinea_breeds SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('American','Abyssinian','Peruvian','Silkie','Teddy','Texel','White Crested','Coronet','Sheltie','Rex');
  v_hamster_breeds SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Syrian','Dwarf Campbell','Dwarf Winter White','Roborovski','Chinese','Russian Dwarf','Siberian','Albino','Golden','Black Bear');
  v_ferret_breeds SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Standard','Albino','Sable','Black Sable','Champagne','Chocolate','Cinnamon','Silver','Blaze','Panda');
  v_desc_options SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
    '', -- empty
    'Very friendly.',
    'Aggressive.',
    'Shy.',
    'Needs special care.',
    'Playful.',
    'Calm.',
    'Energetic.',
    'Older pet.',
    'Young and active.',
    'Prefers quiet.',
    'Good with other pets.',
    'Rescue animal.',
    'Recently adopted.'
  );

  TYPE t_id_array IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  v_customer_ids t_id_array;
  v_count NUMBER := 0;
  v_type_idx NUMBER;
  v_breed VARCHAR2(20);
  v_desc VARCHAR2(255);
BEGIN
  -- Fetch all valid customer_ids into an array
  FOR rec IN (SELECT customer_id FROM customer) LOOP
    v_count := v_count + 1;
    v_customer_ids(v_count) := rec.customer_id;
  END LOOP;

  FOR i IN 1..v_count LOOP
    v_type_idx := MOD(i-1, v_types.COUNT) + 1;
    -- Pick breed according to type
    IF v_types(v_type_idx) = 'Dog' THEN
      v_breed := v_dog_breeds(MOD(i-1, v_dog_breeds.COUNT)+1);
    ELSIF v_types(v_type_idx) = 'Cat' THEN
      v_breed := v_cat_breeds(MOD(i-1, v_cat_breeds.COUNT)+1);
    ELSIF v_types(v_type_idx) = 'Rabbit' THEN
      v_breed := v_rabbit_breeds(MOD(i-1, v_rabbit_breeds.COUNT)+1);
    ELSIF v_types(v_type_idx) = 'Guinea Pig' THEN
      v_breed := v_guinea_breeds(MOD(i-1, v_guinea_breeds.COUNT)+1);
    ELSIF v_types(v_type_idx) = 'Hamster' THEN
      v_breed := v_hamster_breeds(MOD(i-1, v_hamster_breeds.COUNT)+1);
    ELSE -- Ferret
      v_breed := v_ferret_breeds(MOD(i-1, v_ferret_breeds.COUNT)+1);
    END IF;

    -- Randomly pick a description (sometimes empty)
    v_desc := v_desc_options(TRUNC(DBMS_RANDOM.VALUE(1, v_desc_options.COUNT+1)));

    INSERT INTO pet (
      pet_id, customer_id, pet_name, pet_type, pet_breed, description
    ) VALUES (
      pet_seq.nextval,
      v_customer_ids(i),
      v_pet_names(MOD(i-1, v_pet_names.COUNT)+1),
      v_types(v_type_idx),
      SUBSTR(v_breed, 1, 20),
      v_desc
    );
  END LOOP;
END;
/
