# Pet grooming salon

# 1. Overview
The purpose of this data model is to create a working data system where a Pet grooming salon can store, retrieve and analyze data that has accumulated while doing business. 
The tables were chosen according to similar businesses and their working principles.
This data model should cover most of the average needs of a grooming salon.

# 2. Entity definitions (Tables)
In total there are 10 data tables in which business data is going to be stored:
 
* customers;
* groomers;
* services;
* pets;
* appointments;
* payments;
* groomers_schedule;
* appointment_service
* service_inventory;
* appointment_notification;

###### Explanation structure is not the same in every table, because some things will become clear from the first table further down, so there is no need to explain some of the things two or more times

CUSTOMERS TABLE
|COLUMN_NAME  | DATA_TYPE         | NULLABLE | DATA_DEFAULT                             
|-------------|-------------------|----------|--------
| CUSTOMER_ID | NUMBER            | No       | "SYSTEM"."CUSTOMERS_SEQ"."NEXTVAL"  
| FIRST_NAME  | VARCHAR2(20 BYTE) | No       | (null)           
| LAST_NAME   | VARCHAR2(20 BYTE) | Yes      | (null)     
| PHONE       | VARCHAR2(20 BYTE) | No       | (null)                                                     
| EMAIL       | VARCHAR(200 BYTE) | NO       | (null)   

### Table Overview

* This table stores customer contact information: first and last name, phone and email.

**Structure**
 
* "Nullable" indicates if the data must be entered or not.
* Every customer can be identified by their primary key column "CUSTOMER_ID". The id's are automatically generated once new client is added, this can be seen as "SYSTEM"."CUSTOMERS_SEQ"."NEXTVAL" this creates a sequence which generates only unique numbers for customer_id column.

**Data types**

* "VARCHAR2" is data type used for variable length text.
"NUMBER" for numeric values.


GROOMERS TABLE
| COLUMN_NAME     | DATA_TYPE         | NULLABLE | DATA_DEFAULT                   
|-----------------|-------------------|----------|--------------------------------
| GROOMER_ID      | NUMBER            | No       | "SYSTEM"."GROOMERS_SEQ"."NEXTVAL" 
| FIRST_NAME      | VARCHAR2(20 CHAR) | No       | (null)                         
| LAST_NAME       | VARCHAR2(20 CHAR) | No       | (null)                         
| STATUS          | VARCHAR2(20 BYTE) | No       | (null)                         
| SALARY          | NUMBER            | No       | (null)                         
| EMAIL           | VARCHAR2(20 BYTE) | No       | (null)                         
| PHONE           | VARCHAR2(20 BYTE) | No       | (null)                         
| BIRTH_DATE      | DATE              | Yes      | (null)                         
| ADDRESS         | VARCHAR2(20 CHAR) | Yes      | (null)                         
| CREATED_BY      | VARCHAR2(20 BYTE) | Yes      | (null)                         
| CREATION_DATE   | DATE              | Yes      | SYSDATE                        
| LAST_UPDATED_BY | VARCHAR2(20 BYTE) | Yes      | (null)                         
| LAST_UPDATE     | DATE              | Yes      | SYSDATE    

### Table Overview


Groomers table stores all the neccessary data about the groomer.

**Structure**

* Each groomer can be identified by their primary key column "GROOMER_ID" and the same sequence creating logic will continue throughout the data model. 
* The table also automatically logs information about when groomer was added to the database, when was this information updated and by whom.

**Data types**

* VARCHAR2 BYTE/CHAR Difference - BYTE limits storage based on the number of bytes used (works best with English and numbers). CHAR limits storage based on the number of characters (better for multilingual data). So when importing data you cannot surpass the lenght that is specified.
* "DATE" date and time values.
* DATA_DEFAULT "SYSDATE" logs system date (current time)


### SERVICES TABLE
| COLUMN_NAME | DATA_TYPE         | NULLABLE | DATA_DEFAULT                   
|-------------|-------------------|----------|--------------------------------
| SERVICES_ID | NUMBER            | No       | "SYSTEM"."SERVICES_SEQ"."NEXTVAL" 
| SERVICE_NAME| VARCHAR2(20 BYTE) | No       | (null)                         
| PRICE       | NUMBER            | No       | (null)                         
| DESCRIPTION | VARCHAR2(200 BYTE)| No       | (null)                           

### Table Overview


The table stores data about all the services that grooming salon provides.

### PETS TABLE
| COLUMN_NAME | DATA_TYPE          | NULLABLE | DATA_DEFAULT                          
|-------------|--------------------|----------|----------------------------------
| PETS_ID     | NUMBER             | No       | "SYSTEM"."PETS_SEQ"."NEXTVAL"     
| CUSTOMERS_ID| NUMBER             | No       | (null)                           
| PET_NAME    | VARCHAR2(20 BYTE)  | No       | (null)        
| PET_TYPE    | VARCHAR(20 BYTE)   | No       | (null)      
| PET_BREED   | VARCHAR2(20 BYTE)  | Yes      | (null)  
| DESCRIPTION | VARCHAR2(255 BYTE) | Yes      | (null)  

### Table Overview

Pets table stores data about customers pets, it consists of pet_id, customer_id that shows which customer_id has which pet, pets name, type, breed and the description about that pet.


### APPOINTMENTS TABLE
| COLUMN_NAME          | DATA_TYPE        | NULLABLE | DATA_DEFAULT                     
|----------------------|------------------|----------|----------------------------------
| APPOINTMENTS_ID      | NUMBER           | No       | "SYSTEM"."APPOINTMENTS_SEQ"."NEXTVAL" 
| CUSTOMERS_ID         | NUMBER           | No       | (null)                           
| GROOMERS_ID          | NUMBER           | No       | (null)                           
| PETS_ID              | NUMBER           | No       | (null)                           
| APPOINTMENT_DATE     | DATE             | No       | (null)                           
| APPOINTMENT_CANCELLED| CHAR(1)          | Yes      | 'N'           
| CREATED_BY           | VARCHAR2(20 BYTE)| Yes      | (null)                                                 
| CREATION_DATE        | DATE             | No       | SYSDATE                          
| LAST_UPDATED_BY      | VARCHAR2(20 BYTE)| Yes      | (null)                           
| LAST_UPDATE          | DATE             | Yes      | SYSDATE  

### Table Overview

This is the main table where appointments will be recorded. 

**Data types**

* appointment_cancelled column logs whether single appointment was cancelled or not. 
Y = True, it was cancelled N = False, it was not cancelled, if it was not registered the Default is logged as N = Not cancelled. 

### PAYMENTS TABLE
| COLUMN_NAME     | DATA_TYPE        | NULLABLE | DATA_DEFAULT                   
|-----------------|------------------|----------|--------------------------------
| PAYMENTS_ID     | NUMBER           | No       | "SYSTEM"."PAYMENTS_SEQ"."NEXTVAL" 
| AMOUNT          | NUMBER           | No       | (null)                         
| PAYMENT_DATE    | DATE             | No       | (null)                         
| APPOINTMENTS_ID | NUMBER           | No       | (null)                         
| PAYMENT_METHOD  | VARCHAR2(10 BYTE)| No       | (null)                         
| CREATED_BY      | VARCHAR2(20 BYTE)| Yes      | (null)                         
| CREATION_DATE   | DATE             | Yes      | SYSDATE                        
| LAST_UPDATED_BY | VARCHAR2(20 BYTE)| Yes      | (null)                         
| LAST_UPDATE     | DATE             | Yes      | SYSDATE           

### Table Overview

Payments table stores data everything about the payments - payment amount, method, date, who and when updated the last info about the payment.


### GROOMERS_SCHEDULE TABLE
| COLUMN_NAME         | DATA_TYPE         | NULLABLE | DATA_DEFAULT                     
|---------------------|-------------------|----------|----------------------------------
| GROOMERS_SCHEDULE_ID| NUMBER            | No       | "SYSTEM"."GROOMER_SCHEDULE_SEQ"."NEXTVAL" 
| GROOMERS_ID         | NUMBER            | No       | (null)                           
| APPOINTMENTS_ID     | NUMBER            | No       | (null)                           
| START_TIME          | DATE              | No       | (null)                           
| END_TIME            | DATE              | No       | (null)                           
| STATUS              | VARCHAR2(20 BYTE) | Yes      | 'Available'                      
| NOTES               | VARCHAR2(255 BYTE)| Yes      | (null)                           
| CREATED_BY          | VARCHAR2(20 BYTE) | Yes      | (null)                           
| CREATION_DATE       | DATE              | Yes      | SYSDATE                          
| LAST_UPDATED_BY     | VARCHAR2(20 BYTE) | Yes      | (null)                           
| LAST_UPDATE         | DATE              | Yes      | SYSDATE    

### Table Overview

The Groomers_Schedule table stores data about groomers worktime, availability of the groomer, when the appointment was started and when it was finished.

### APPOINTMENT_SERVICE TABLE
| COLUMN_NAME    | DATA_TYPE | NULLABLE | DATA_DEFAULT 
|----------------|-----------|----------|--------------
| APPOINTMENTS_ID| NUMBER    | No       | (null)       
| SERVICES_ID    | NUMBER    | No       | (null)       
### Table Overview
This is called "Junction table", it is used to connect "appointments" and "services" tables with foreign keys.
This enables multiple services per appointment as well as multiple appointments per service.

More about relationships and its quirks is explained in Relationships part.


### SERVICE_INVENTORY TABLE
| COLUMN_NAME         | DATA_TYPE         | NULLABLE | DATA_DEFAULT               
|---------------------|-------------------|----------|----------------------------
| SERVICE_INVENTORY_ID| NUMBER            | No       | "SYSTEM"."ITEMS_SEQ"."NEXTVAL" 
| ITEM_NAME           | VARCHAR2(50 CHAR) | No       | (null)   
| QUANTITY            |NUMBER             | No       | (null)                           
| UNIT_PRICE          | NUMBER            | No       | (null)       
| SERVICES_ID         | NUMBER            | No       | (null)     
| CREATION_DATE       | DATE              | No       | SYSDATE                    
| CREATED_BY          | VARCHAR2(20 BYTE) | Yes      | (null)                     
| LAST_UPDATED_BY     | VARCHAR2(20 BYTE) | Yes      | (null)                     
| LAST_UPDATE         | DATE              | Yes      | SYSDATE                                    

### Table Overview

Service_inventory table stores data about what items are stored in the inventory for the services that your Grooming salon provides. It consists of item_id, item_name, unit and unit_price.


### APPOINTMENT_NOTIFICATION TABLE
| COLUMN_NAME                | DATA_TYPE          | NULLABLE | DATA_DEFAULT                      
|----------------------------|--------------------|----------|-----------------------------------
| APPOINTMENT_NOTIFICATION_ID| NUMBER             | No       | "SYSTEM"."NOTIFICATION_SEQ"."NEXTVAL" 
| APPOINTMENTS_ID            | NUMBER             | No       | (null)                           
| NOTIFICATION_TEXT          | VARCHAR2(255 BYTE) | No       | (null)                            
| NOTIFICATION_DATE          | DATE               | Yes      | (null)                            
| NOTIFICATION_SENT          | DATE               | Yes      | (null)                            
| STATUS                     | CHAR(1)            | Yes      | 'N'                               

### Table Overview

This table is used for notifying the customer about the appointment.


# 3. Relationships (Schema)
![Grooming salon schema.](https://i.imgur.com/ProE3ZM.png)

The Grooming Salon schema can be seen in the visualization above.


###### For in-depth information, the schema can be seen in .vuerd.json file which leads to ERD Editor.

**What are relationships in data schema?**

Relationships are meaningful associations between tables that contain related information. Every data model must be linked together using relationships.  Almost every table has a primary key (a key identifier), for example, customer_id in customers table. This column is the main identifier used to navigate information from that table. When creating a relationship between two tables, a foreign key (the primary key from the other table) appears in one of the tables. This foreign key acts as a link between the two tables, allowing you to connect and retrieve information from both. 


There are 3 main relationship types:

* One-to-one. When each item in each table only appears once. For example (not this data model), each employee (employees table) can have only one company car (cars table) to use. 

![One-to-one.](https://i.imgur.com/Bm8AacG.png)

* One-to-many. When one item in one table can have a relationship to multiple items in another table. For example(this data model), one customer (customers table) can have multiple appointments (appointments table).

![One-to-many.](https://i.imgur.com/WaXnKUy.png)

* Many-to-many. When one or more items in one table can have a relationship to one or more items in another table. For example(not this data model), each order can have multiple products and each product can appear on many orders.

![Many-to-many.](https://i.imgur.com/10IWM7P.png)

Data relationships create connections between tables based on specific logic, ensuring data integrity and consistency. It allows joining data across tables, which can be represented for further business needs.

This Grooming Salon data model primarily features one-to-many relationships, with a single many-to-many relationship.

There could be a confusion where is that many-to-many relationship located, since relational databases does not allow to directly give a many-to-many relationship link between tables, it is solved by using junction table "appointment_service"

In simple terms, one appointment can have many services and one service can be a part of many different appointments. To fix this, junction table is used. This is used to clearly list which service happened during each appointment.