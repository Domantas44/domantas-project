-- Mock data for service table
DECLARE
  v_services SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
    'Bath',
    'Haircut',
    'Nail Trim',
    'Ear Cleaning',
    'Teeth Brushing',
    'Flea Treatment',
    'De-shedding',
    'Puppy Groom',
    'Senior Groom',
    'Medicated Bath',
    'De-matting',
    'Pawdicure',
    'Blueberry Facial',
    'Sanitary Trim',
    'Full Groom',
    'Express Groom',
    'Hand Stripping',
    'Show Groom',
    'Seasonal Special'
  );
  v_desc SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
    'A gentle and thorough cleaning for your pet.',
    'Professional haircut tailored to your pet’s breed.',
    'Careful nail trimming to keep paws healthy.',
    'Gentle ear cleaning to prevent infections.',
    'Brushing to keep your pet’s teeth clean and healthy.',
    'Effective flea treatment for a pest-free pet.',
    'Reduces shedding and keeps coat healthy.',
    'Special grooming for puppies under 1 year.',
    'Gentle care for senior pets.',
    'Soothing medicated bath for sensitive skin.',
    'Removal of mats and tangles from fur.',
    'Deluxe paw and nail care.',
    'Refreshing blueberry facial for pets.',
    'Sanitary trim for hygiene and comfort.',
    'Complete grooming package for your pet.',
    'Quick grooming for pets on the go.',
    'Hand stripping for wire-haired breeds.',
    'Show-quality grooming for competitions.',
    'Special seasonal grooming package.'
  );
BEGIN
  FOR i IN 1..v_services.COUNT LOOP
    INSERT INTO service (
      service_id, service_name, price, description
    ) VALUES (
      service_seq.nextval,
      v_services(i),
      ROUND(DBMS_RANDOM.VALUE(15, 120) + DBMS_RANDOM.VALUE, 2),
      v_desc(i)
    );
  END LOOP;
END;
/

