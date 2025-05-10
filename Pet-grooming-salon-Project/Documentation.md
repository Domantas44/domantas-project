# Pet grooming salon documentation

# 1. Overview
The purpose of this data model is to create working data system where
Pet grooming salon could store/retrieve/analyze data 
that has accumulated while doing business.

# 2. Entity definitions (tables)
In total there are 9 data tables in which business data is going to be stored:

customers;
groomers;
service_inventory;
pets;
appointments;
payments;
services;
service_items;

                CUSTOMERS TABLE
 Column Name | Data Type         | Nullable | Default                             
-------------|-------------------|----------|--------
 CUSTOMER_ID | NUMBER            | No       | "SYSTEM"."CUSTOMERS_SEQ"."NEXTVAL"  
 FIRST_NAME  | VARCHAR2(20 BYTE) | No       | (null)           
 LAST_NAME   | VARCHAR2(20 BYTE) | No       | (null)     
 PHONE       | NUMBER            | No       | (null)                                                     
 EMAIL       | VARCHAR(200 BYTE) | Yes      | (null)   

    TABLE PURSPOSE
Customers table stores data about first and last name of the customer, their phone number and email.
    TABLE STRUCTURE
In the "customers" table above there are listed column names and data types. "Nullable" means if the data must be entered or not and the default data.
Every customer can be identified by their primary key column "CUSTOMER_ID". The id's are automatically generated once new client is added, this can be seen as "SYSTEM"."CUSTOMERS_SEQ"."NEXTVAL" this creates a sequence which generates only unique numbers for customer_id column.
    DATA TYPES
"VARCHAR2" is data type used for variable character(or symbol) length in another words text or symbols.
"NUMBER" is self-explanatory.

                GROOMERS TABLE
 COLUMN_NAME     | DATA_TYPE         | NULLABLE | DATA_DEFAULT                   
-----------------|-------------------|----------|--------------------------------
 GROOMER_ID      | NUMBER            | No       | "SYSTEM"."GROOMERS_SEQ"."NEXTVAL" 
 FIRST_NAME      | VARCHAR2(20 CHAR) | No       | (null)                         
 LAST_NAME       | VARCHAR2(20 CHAR) | No       | (null)                         
 STATUS          | VARCHAR2(20 BYTE) | No       | (null)                         
 SALARY          | NUMBER            | No       | (null)                         
 EMAIL           | VARCHAR2(20 BYTE) | No       | (null)                         
 PHONE           | NUMBER            | No       | (null)                         
 BIRTH_DATE      | DATE              | No       | (null)                         
 ADDRESS         | VARCHAR2(20 CHAR) | Yes      | (null)                         
 CREATION_DATE   | DATE              | No       | SYSDATE                        
 LAST_UPDATED_BY | VARCHAR2(20 BYTE) | Yes      | (null)                         
 LAST_UPDATE     | DATE              | Yes      | SYSDATE                              

    TABLE PURPOSE
Groomers table stores data about first and last name of the groomer (employee), groomer status, salary, email, phone, birth date and address.
The table also logs information about when groomer was added to the database
    TABLE STRUCTURE
Every groomer can be identified by their primary key column "GROOMER_ID" and the same sequence ID creating logic will continue throughout the data model. 
    DATA TYPES
"DATE" is self-explanatory.

            SERVICE_INVENTORY TABLE
 Column Name | Data Type          | Nullable | Default                            
-------------|--------------------|----------|------------------------------------
 ITEM_ID     | NUMBER             | No       | "SYSTEM"."ITEMS_SEQ"."NEXTVAL"      
 ITEM_NAME   | VARCHAR2(50 BYTE)  | No       | (null)                             
 UNIT        | NUMBER             | No       | (null)                             
 UNIT_PRICE  | NUMBER             | No       | (null)                             

    TABLE PURPOSE
Service_inventory table stores data about what items are stored in the inventory for the services that your Grooming salon provides.
It consists of item_id, item_name, unit and unit_price
    DATA TYPES
NUMBER as well as DATE is self-explanatory.

            PETS TABLE
 Column Name | Data Type          | Nullable | Default                          
-------------|--------------------|----------|----------------------------------
 PET_ID      | NUMBER             | No       | "SYSTEM"."PETS_SEQ"."NEXTVAL"     
 CUSTOMER_ID | NUMBER             | No       | (null)                           
 PET_NAME    | VARCHAR2(20 BYTE)  | No       | (null)        
 PET_TYPE    | VARCHAR(20 BYTE)   | No       | (null)      
 PET_BREED   | VARCHAR2(20 BYTE)  | Yes      | (null)  
 DESCRIPTION | VARCHAR2(255 BYTE) | Yes      | (null)  

    TABLE PURPOSE
Pets table stores data about customers pets, it consists of pet_id, customer_id that shows which customer_id has which pet, pets name, type and it's breed.
    DATA TYPES
            APPOINTMENTS TABLE
 Column Name          | Data Type   | Nullable | Default Value                     
----------------------|-------------|----------|---------------------------------
 APPOINTMENT_ID       | NUMBER      | No       | "SYSTEM"."APPOINTMENTS_SEQ"."NEXTVAL"      
 CUSTOMER_ID          | NUMBER      | No       | (null)                            
 GROOMER_ID           | NUMBER      | No       | (null)                            
 PET_ID               | NUMBER      | No       | (null)                            
 APPOINTMENT_DATE     | DATE        | No       | (null)                            
 APPOINTMENT_CANCELLED| NUMBER(1)   | No       | 0                     
 PAYMENT_ID           | NUMBER      | Yes      | (null)    

    TABLE PURPOSE
This is the main table where appointments will be recorded.
    DATA TYPES
appointment_cancelled column logs whether single appointment was cancelled or not. 
1 = True it was cancelled 0 = False it was not cancelled, if it was not registered the Default is logged as 0 = Not cancelled. 

