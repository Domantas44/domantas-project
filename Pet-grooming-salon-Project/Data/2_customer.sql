DECLARE
  v_first_names  SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('John','Emily','Michael','Sarah','David','Jessica','Daniel','Ashley','Matthew','Amanda','James','Jennifer','Joshua','Elizabeth','Andrew','Megan','Joseph','Lauren','Christopher','Hannah',
'Ryan','Nicole','Brandon','Rachel','Tyler','Brittany','Zachary','Samantha','Justin','Stephanie','Anthony','Amber','Jonathan','Rebecca','Austin','Courtney','Nicholas','Danielle','Christian','Kaitlyn',
'Benjamin','Melissa','Adam','Kayla','Alexander','Victoria','Kyle','Alexis','Kevin','Taylor','Thomas','Allison','Jason','Haley','Aaron','Brooke','Eric','Katherine','Cameron','Natalie','Sean','Erin',
'Jacob','Christine','Dylan','Morgan','Nathan','Shelby','Patrick','Michelle','Jeremy','Chelsea','Trevor','Jasmine','Jordan','Laura','Brian','Kristen','Stephen','Maria','Mark','Katie','Gregory','Olivia',
'Paul','Andrea','Travis','Angela','Shawn','Abigail','George','Lindsey','Jared','Vanessa','Evan','Julia','Ian','Caitlin','Peter','Monica'
);
  v_last_names   SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('Smith','Johnson','Williams','Brown','Jones','Garcia','Miller','Davis','Martinez','Hernandez',
'Lopez','Gonzalez','Wilson','Anderson','Thomas','Taylor','Moore','Jackson','Martin','Lee',
'Perez','Thompson','White','Harris','Sanchez','Clark','Ramirez','Lewis','Robinson','Walker',
'Young','Allen','King','Wright','Scott','Torres','Nguyen','Hill','Flores','Green',
'AdAMS','Nelson','Baker','Hall','Rivera','Campbell','Mitchell','Carter','Roberts','Gomez',
'Phillips','Evans','Turner','Diaz','Parker','Cruz','Edwards','Collins','Reyes','Stewart',
'Morris','Morales','Murphy','Cook','Rogers','Gutierrez','Ortiz','Morgan','Cooper','Peterson',
'Bailey','Reed','Kelly','Howard','Ramos','Kim','Cox','Ward','Richardson','Watson',
'Brooks','Chavez','Wood','James','Bennett','Gray','Mendoza','Ruiz','Hughes','Price'
);
  v_phone_templates SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
    '+3706',      -- Lithuania
    '+4915',      -- Germany
    '+4477',      -- UK
    '+336',       -- France
    '+3934',      -- Italy
    '+3712',      -- Latvia
    '+4851',      -- Poland
    '+3584',      -- Finland
    '+4670',      -- Sweden
    '+3546'       -- Iceland
  );
BEGIN
  FOR i IN 1..1000 LOOP
    DECLARE
      fname VARCHAR2(50);
      lname VARCHAR2(50);
    BEGIN
      fname := v_first_names(TRUNC(DBMS_RANDOM.VALUE(1, v_first_names.COUNT+1)));
      lname := v_last_names(TRUNC(DBMS_RANDOM.VALUE(1, v_last_names.COUNT+1)));
      INSERT INTO customer (customer_id, first_name, last_name, phone, email)
      VALUES (
        customer_seq.nextval,
        fname,
        lname,
        v_phone_templates(MOD(i-1, v_phone_templates.COUNT)+1) || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(100000,999999))),
        LOWER(fname) || '.' || LOWER(lname) || i || '.' || TRUNC(DBMS_RANDOM.VALUE(10000,99999)) || '@example.com'
      );
    END;
  END LOOP;
END;
COMMIT;
/



