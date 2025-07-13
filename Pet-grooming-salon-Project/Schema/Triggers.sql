CREATE OR REPLACE TRIGGER groomer_log
BEFORE INSERT OR UPDATE ON groomer
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

CREATE OR REPLACE TRIGGER appointment_log
BEFORE INSERT OR UPDATE ON appointment
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

CREATE OR REPLACE TRIGGER payment_log
BEFORE INSERT OR UPDATE ON payment
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


CREATE OR REPLACE TRIGGER payment_refund_log
BEFORE INSERT OR UPDATE ON payment_refund
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
