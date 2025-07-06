-- Mock data for service table
DECLARE
  v_services SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Bath','Haircut','Nail Trim','Ear Cleaning','Teeth Brushing','Flea Treatment','De-shedding','Puppy Groom','Senior Groom','Medicated Bath','De-matting','Anal Gland Expression','Pawdicure','Blueberry Facial','Sanitary Trim','Full Groom','Express Groom','Hand Stripping','Show Groom','Seasonal Special');
BEGIN
  FOR i IN 1..100 LOOP
    INSERT INTO service (
      service_id, service_name, price, description
    ) VALUES (
      service_seq.nextval,
      v_services(MOD(i-1, v_services.COUNT)+1) || ' ' || i,
      TRUNC(DBMS_RANDOM.VALUE(15, 120)),
      'Professional ' || v_services(MOD(i-1, v_services.COUNT)+1) || ' for pets. Service code ' || i
    );
  END LOOP;
END;
/
