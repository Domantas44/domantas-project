-- Mock data for pet table
DECLARE
  v_pet_names SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Bella','Charlie','Max','Luna','Rocky','Lucy','Cooper','Daisy','Milo','Bailey','Sadie','Buddy','Molly','Bear','Stella','Duke','Lily','Toby','Zoe','Jack');
  v_types SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Dog','Cat','Rabbit','Bird','Guinea Pig','Hamster','Ferret','Turtle','Lizard','Fish');
  v_breeds SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Labrador','Poodle','Bulldog','Beagle','Persian','Siamese','Maine Coon','Parakeet','Cockatiel','Goldfish','Betta','Syrian','Dwarf','Abyssinian','Holland Lop','Russian Blue','Shih Tzu','Corgi','Pug','Ragdoll');
BEGIN
  FOR i IN 1..100 LOOP
    INSERT INTO pet (
      pet_id, customer_id, pet_name, pet_type, pet_breed, description
    ) VALUES (
      pet_seq.nextval,
      MOD(i-1, 100) + 1,
      v_pet_names(MOD(i-1, v_pet_names.COUNT)+1),
      v_types(MOD(i-1, v_types.COUNT)+1),
      v_breeds(MOD(i-1, v_breeds.COUNT)+1),
      'Friendly ' || v_types(MOD(i-1, v_types.COUNT)+1) || ' named ' || v_pet_names(MOD(i-1, v_pet_names.COUNT)+1)
    );
  END LOOP;
END;
/
