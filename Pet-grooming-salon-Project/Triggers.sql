--General syntax
/* 
 CREATE [OR REPLACE ] TRIGGER trigger_name  
{BEFORE | AFTER | INSTEAD OF }  
{INSERT [OR] | UPDATE [OR] | DELETE}  
[OF col_name]  
ON table_name  
[REFERENCING OLD AS o NEW AS n]  
[FOR EACH ROW]  
WHEN (condition)   
DECLARE 
   Declaration-statements 
BEGIN  
   Executable-statements 
EXCEPTION 
   Exception-handling-statements 
END; 
*/


CREATE OR REPLACE TRIGGER groomers_log
BEFORE INSERT OR UPDATE ON groomers
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by := USER;
        :NEW.creation_date := SYSDATE;
    ELSIF UPDATING THEN
        :NEW.last_updated_by := USER;
        :NEW.last_update := SYSDATE;
    END IF;
END;

CREATE OR REPLACE TRIGGER appointments_log
BEFORE INSERT OR UPDATE ON appointments
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by := USER;
        :NEW.creation_date := SYSDATE;
    ELSIF UPDATING THEN
        :NEW.last_updated_by := USER;
        :NEW.last_update := SYSDATE;
    END IF;
END;

CREATE OR REPLACE TRIGGER payments_log
BEFORE INSERT OR UPDATE ON payments
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by := USER;
        :NEW.creation_date := SYSDATE;
    ELSIF UPDATING THEN
        :NEW.last_updated_by := USER;
        :NEW.last_update := SYSDATE;
    END IF;
END;

CREATE OR REPLACE TRIGGER groomer_schedule_log
BEFORE INSERT OR UPDATE ON groomer_schedule
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by := USER;
        :NEW.creation_date := SYSDATE;
    ELSIF UPDATING THEN
        :NEW.last_updated_by := USER;
        :NEW.last_update := SYSDATE;
    END IF;
END;

CREATE OR REPLACE TRIGGER service_inventory_log
BEFORE INSERT OR UPDATE ON service_inventory
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by := USER;
        :NEW.creation_date := SYSDATE;
    ELSIF UPDATING THEN
        :NEW.last_updated_by := USER;
        :NEW.last_update := SYSDATE;
    END IF;
END;
