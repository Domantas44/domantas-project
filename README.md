# Pet grooming salon

# 1. Overview
The purpose of this data model is to create a working data system where a Pet grooming salon can store, retrieve, and analyze data that has accumulated while doing business. 
The tables were chosen according to similar businesses and their working principles.
This data model should cover most of the average needs of a grooming salon.

# 2. Entity definitions (Tables)
In total there are 9 data tables in which business data is going to be stored:

* customers;
* groomers;
* services;
* pets;
* appointments;
* payments;
* service_inventory;
* groomers_schedule;
* appointment_service
* service_inventory;


CUSTOMERS TABLE
|COLUMN_NAME  | DATA_TYPE         | NULLABLE | DATA_DEFAULT                             
|-------------|-------------------|----------|--------
| CUSTOMER_ID | NUMBER            | No       | "SYSTEM"."CUSTOMERS_SEQ"."NEXTVAL"  
| FIRST_NAME  | VARCHAR2(20 BYTE) | No       | (null)           
| LAST_NAME   | VARCHAR2(20 BYTE) | Yes      | (null)     
| PHONE       | NUMBER            | No       | (null)                                                     
| EMAIL       | VARCHAR(200 BYTE) | NO       | (null)   

    TABLE PURPOSE
Customers table stores data about first and last name of the customer, their phone number and email.

    TABLE STRUCTURE
In the "customers" table above there are listed column names and data types. "Nullable" means if the data must be entered or not and the default data.
Every customer can be identified by their primary key column "CUSTOMER_ID". The id's are automatically generated once new client is added, this can be seen as "SYSTEM"."CUSTOMERS_SEQ"."NEXTVAL" this creates a sequence which generates only unique numbers for customer_id column.

    DATA TYPES
"VARCHAR2" is data type used for variable character(or symbol) length in another words text or symbols.
"NUMBER" is self-explanatory.


GROOMERS TABLE
| COLUMN_NAME     | DATA_TYPE         | NULLABLE | DATA_DEFAULT                   
|-----------------|-------------------|----------|--------------------------------
| GROOMER_ID      | NUMBER            | No       | "SYSTEM"."GROOMERS_SEQ"."NEXTVAL" 
| FIRST_NAME      | VARCHAR2(20 CHAR) | No       | (null)                         
| LAST_NAME       | VARCHAR2(20 CHAR) | No       | (null)                         
| STATUS          | VARCHAR2(20 BYTE) | No       | (null)                         
| SALARY          | NUMBER            | No       | (null)                         
| EMAIL           | VARCHAR2(20 BYTE) | No       | (null)                         
| PHONE           | NUMBER            | No       | (null)                         
| BIRTH_DATE      | DATE              | Yes      | (null)                         
| ADDRESS         | VARCHAR2(20 CHAR) | Yes      | (null)                         
| CREATED_BY      | VARCHAR2(20 BYTE) | Yes      | (null)                         
| CREATION_DATE   | DATE              | Yes      | SYSDATE                        
| LAST_UPDATED_BY | VARCHAR2(20 BYTE) | Yes      | (null)                         
| LAST_UPDATE     | DATE              | Yes      | SYSDATE                                                

    TABLE PURPOSE
Groomers table stores data about first and last name of the groomer (employee), groomer status, salary, email, phone, birth date and address.

    TABLE STRUCTURE
Every groomer can be identified by their primary key column "GROOMER_ID" and the same sequence ID creating logic will continue throughout the data model. 
The table also automatically logs information about when groomer was added to the database, when was this information updated and by whom.

    DATA TYPES
"VARCHAR2 BYTE AND CHAR Difference - "BYTE" counts how much space each letter or symbol takes in memory, which works well for English and numbers. "CHAR" counts the actual number of letters, which is better for other languages where a single letter can take more space sometimes up to 4 bytes. So when importing data you cannot surpass the amount that is specified.
"DATE" is self-explanatory.
DATA_DEFAULT "SYSDATE" logs system date (current time)


### SERVICES TABLE
| COLUMN_NAME | DATA_TYPE         | NULLABLE | DATA_DEFAULT                   
|-------------|-------------------|----------|--------------------------------
| SERVICE_ID  | NUMBER            | No       | "SYSTEM"."SERVICES_SEQ"."NEXTVAL" 
| SERVICE_NAME| VARCHAR2(20 BYTE) | No       | (null)                         
| PRICE       | NUMBER            | No       | (null)                         
| DESCRIPTION | VARCHAR2(200 BYTE)| No       | (null)                           

TABLE PURPOSE 
The table stores data about all the services that grooming salon provides.

### PETS TABLE
| COLUMN_NAME | DATA_TYPE          | NULLABLE | DATA_DEFAULT                          
|-------------|--------------------|----------|----------------------------------
| PET_ID      | NUMBER             | No       | "SYSTEM"."PETS_SEQ"."NEXTVAL"     
| CUSTOMER_ID | NUMBER             | No       | (null)                           
| PET_NAME    | VARCHAR2(20 BYTE)  | No       | (null)        
| PET_TYPE    | VARCHAR(20 BYTE)   | No       | (null)      
| PET_BREED   | VARCHAR2(20 BYTE)  | Yes      | (null)  
| DESCRIPTION | VARCHAR2(255 BYTE) | Yes      | (null)  

    TABLE PURPOSE
Pets table stores data about customers pets, it consists of pet_id, customer_id that shows which customer_id has which pet, pets name, type and it's breed.


### APPOINTMENTS TABLE
| COLUMN_NAME          | DATA_TYPE   | NULLABLE | DATA_DEFAULT                     
|----------------------|-------------|----------|----------------------------------
| APPOINTMENT_ID       | NUMBER           | No       | "SYSTEM"."APPOINTMENTS_SEQ"."NEXTVAL" 
| CUSTOMER_ID          | NUMBER           | No       | (null)                           
| GROOMER_ID           | NUMBER           | No       | (null)                           
| PET_ID               | NUMBER           | No       | (null)                           
| APPOINTMENT_DATE     | DATE             | No       | (null)                           
| APPOINTMENT_CANCELLED| CHAR(1)          | Yes      | 'N'                                
| PAYMENT_ID           | NUMBER           | Yes      | (null)                           
| CREATION_DATE        | DATE             | No       | SYSDATE                          
| LAST_UPDATED_BY      | VARCHAR2(20 BYTE)| Yes      | (null)                           
| LAST_UPDATE          | DATE             | Yes      | SYSDATE  

    TABLE PURPOSE
This is the main table where appointments will be recorded. 

    DATA TYPES
appointment_cancelled column logs whether single appointment was cancelled or not. 
Y = True, it was cancelled N = False, it was not cancelled, if it was not registered the Default is logged as N = Not cancelled. 

### PAYMENTS TABLE
| COLUMN_NAME     | DATA_TYPE        | NULLABLE | DATA_DEFAULT                   
|-----------------|------------------|----------|--------------------------------
| PAYMENT_ID      | NUMBER           | No       | "SYSTEM"."PAYMENTS_SEQ"."NEXTVAL" 
| AMOUNT          | NUMBER           | No       | (null)                         
| PAYMENT_DATE    | DATE             | No       | (null)                         
| APPOINTMENT_ID  | NUMBER           | No       | (null)                         
| PAYMENT_METHOD  | VARCHAR2(10 BYTE)| No       | (null)                         
| CREATED_BY      | VARCHAR2(20 BYTE)| Yes      | (null)                         
| CREATION_DATE   | DATE             | Yes      | SYSDATE                        
| LAST_UPDATED_BY | VARCHAR2(20 BYTE)| Yes      | (null)                         
| LAST_UPDATE     | DATE             | Yes      | SYSDATE           

    TABLE PURPOSE
Payments table stores data everything about the payments - payment amount, method, date, who and when updated the last info about the payment.


### SERVICE_INVENTORY TABLE
| COLUMN_NAME    | DATA_TYPE         | NULLABLE | DATA_DEFAULT               
|----------------|-------------------|----------|----------------------------
| ITEM_ID        | NUMBER            | No       | "SYSTEM"."ITEMS_SEQ"."NEXTVAL" 
| ITEM_NAME      | VARCHAR2(50 CHAR) | No       | (null)                    
| UNIT           | NUMBER            | No       | (null)                     
| UNIT_PRICE     | NUMBER            | No       | (null)                     
| CREATION_DATE  | DATE              | No       | SYSDATE                    
| CREATED_BY     | VARCHAR2(20 BYTE) | Yes      | (null)                     
| LAST_UPDATED_BY| VARCHAR2(20 BYTE) | Yes      | (null)                     
| LAST_UPDATE    | DATE              | Yes      | SYSDATE                                    

    TABLE PURPOSE
Service_inventory table stores data about what items are stored in the inventory for the services that your Grooming salon provides.
It consists of item_id, item_name, unit and unit_price.

### GROOMERS_SCHEDULE TABLE
| COLUMN_NAME     | DATA_TYPE         | NULLABLE | DATA_DEFAULT                     
|-----------------|-------------------|----------|----------------------------------
| SCHEDULE_ID     | NUMBER            | No       | "SYSTEM"."GROOMER_SCHEDULE_SEQ"."NEXTVAL" 
| GROOMER_ID      | NUMBER            | No       | (null)                           
| APPOINTMENT_ID  | NUMBER            | No       | (null)                           
| START_TIME      | DATE              | No       | (null)                           
| END_TIME        | DATE              | No       | (null)                           
| STATUS          | VARCHAR2(20 BYTE) | Yes      | 'Available'                      
| NOTES           | VARCHAR2(255 BYTE)| Yes      | (null)                           
| CREATED_BY      | VARCHAR2(20 BYTE) | Yes      | (null)                           
| CREATION_DATE   | DATE              | Yes      | SYSDATE                          
| LAST_UPDATED_BY | VARCHAR2(20 BYTE) | Yes      | (null)                           
| LAST_UPDATE     | DATE              | Yes      | SYSDATE    

    TABLE PURPOSE
The Groomers_schedule table stores data about groomers worktime, availability of the groomer, when the appointment was started and when it was finished.

### APPOINTMENT_SERVICE TABLE
| COLUMN_NAME   | DATA_TYPE | NULLABLE | DATA_DEFAULT 
|---------------|-----------|----------|--------------
| APPOINTMENT_ID| NUMBER    | No       | (null)       
| SERVICE_ID    | NUMBER    | No       | (null)       

This is called "Junction table", it is used to connect "appointments" and "services" tables with foreign keys.
This enables multiple services per appointment.
More about relationships and its quirks is explained in Relationships part.

### SERVICE_INVENTORY TABLE
| COLUMN_NAME     | DATA_TYPE         | NULLABLE | DATA_DEFAULT               
|-----------------|-------------------|----------|----------------------------
| ITEM_ID         | NUMBER            | No       | "SYSTEM"."ITEMS_SEQ"."NEXTVAL" 
| ITEM_NAME       | VARCHAR2(100 CHAR)| No       | (null)                     
| QUANTITY        | NUMBER            | No       | (null)                     
| SERVICE_ID      | NUMBER            | No       | (null)                     
| CREATED_BY      | VARCHAR2(20 BYTE) | Yes      | (null)                     
| CREATION_DATE   | DATE              | Yes      | SYSDATE                    
| LAST_UPDATED_BY | VARCHAR2(20 BYTE) | Yes      | (null)                     
| LAST_UPDATE     | DATE              | Yes      | SYSDATE                    

    TABLE PURPOSE
The table stores inventory item data for the services that the salon provides.

# Relationships
![This is an alt text.](https://raw.githubusercontent.com/Domantas44/domantas-project/refs/heads/main/Pet-grooming-salon-Project/Relationships%20visualized.png?token=GHSAT0AAAAAADCDPA4NQUBVNQ5KEWWELSDI2BAZCOA)

To be continued..


