# Pet grooming salon

# 1. Overview
The purpose of this data model is to create a working data system where a Pet grooming salon can store, retrieve and analyze data that has accumulated while doing business. 
The tables were chosen according to similar businesses and their working principles.
This data model should cover most of the average needs of a grooming salon.

# 2. Entity definitions (Tables)
In total there are 10 data tables in which business data is going to be stored:
 
* customer;
* groomer;
* service;
* pet;
* appointment;
* payment;
* groomer_schedule;
* appointment_service
* service_inventory;
* appointment_notification;

###### Explanation structure is not the same in every table, because some things will become clear from the first table further down, so there is no need to explain some of the things two or more times

CUSTOMER TABLE
|COLUMN_NAME  | DATA_TYPE         | NULLABLE | DATA_DEFAULT                             
|-------------|-------------------|----------|--------
| CUSTOMER_ID | NUMBER            | No       | "SYSTEM"."CUSTOMER_SEQ"."NEXTVAL"  
| FIRST_NAME  | VARCHAR2(20 CHAR) | No       | (null)           
| LAST_NAME   | VARCHAR2(20 CHAR) | Yes      | (null)     
| PHONE       | VARCHAR2(20 CHAR) | No       | (null)                                                     
| EMAIL       | VARCHAR(200 CHAR) | NO       | (null)   

### Table Overview

* This table stores customer contact information: first and last name, phone and email. Its a key point for identifying customers across the data system.

**Structure**
 
* Each customer is identified by the primary key column CUSTOMER_ID, which is automatically generated using the sequence CUSTOMERS_SEQ. This ensures every ID is unique.

* The "Nullable" column tells whether a value must be entered.

**Data types**

* "VARCHAR2" is data type used for variable length text.
"NUMBER" is used for numeric values.


### GROOMER TABLE
| COLUMN_NAME     | DATA_TYPE         | NULLABLE | DATA_DEFAULT                   
|-----------------|-------------------|----------|--------------------------------
| GROOMER_ID      | NUMBER            | No       | "SYSTEM"."GROOMER_SEQ"."NEXTVAL" 
| FIRST_NAME      | VARCHAR2(20 CHAR) | No       | (null)                         
| LAST_NAME       | VARCHAR2(20 CHAR) | No       | (null)                                               
| SALARY          | NUMBER            | No       | (null)                         
| EMAIL           | VARCHAR2(20 CHAR) | No       | (null)                         
| PHONE           | VARCHAR2(20 CHAR) | No       | (null)                         
| BIRTH_DATE      | DATE              | Yes      | (null)                         
| ADDRESS         | VARCHAR2(20 CHAR) | Yes      | (null)             
| GROOMER_STATUS  | VARCHAR2(20 CHAR) | No       | 'Available'             
| CREATED_BY      | VARCHAR2(20 CHAR) | No       | (null)                         
| CREATION_DATE   | DATE              | No       | (null)                       
| LAST_UPDATED_BY | VARCHAR2(20 CHAR) | Yes      | (null)                         
| LAST_UPDATE     | DATE              | Yes      | (null)    

### Table Overview


This table stores all necessary data about a groomer, including audit columns.
It helps manage groomer schedules and availability.

**Structure**

* Each groomer can be identified by their primary key column "GROOMER_ID" and the same sequence creating logic will continue throughout the data model. 
* The table also automatically logs information about when groomer was added to the database, when was this information updated and by who.

**Data types**

* "DATE" date and time values.
* DATA_DEFAULT "SYSDATE" logs system date (current time)


### SERVICE TABLE
| COLUMN_NAME | DATA_TYPE         | NULLABLE | DATA_DEFAULT                   
|-------------|-------------------|----------|--------------------------------
| SERVICE_ID  | NUMBER            | No       | "SYSTEM"."SERVICE_SEQ"."NEXTVAL" 
| SERVICE_NAME| VARCHAR2(20 CHAR) | No       | (null)                         
| PRICE       | NUMBER            | No       | (null)                         
| DESCRIPTION | VARCHAR2(200 CHAR)| No       | (null)                           

### Table Overview

The table stores data about all the services that grooming salon provides.
Each service has a unique name and a set price with description.

### PET TABLE
| COLUMN_NAME | DATA_TYPE          | NULLABLE | DATA_DEFAULT                          
|-------------|--------------------|----------|----------------------------------
| PET_ID      | NUMBER             | No       | "SYSTEM"."PET_SEQ"."NEXTVAL"     
| CUSTOMER_ID | NUMBER             | No       | (null)                           
| PET_NAME    | VARCHAR2(20 CHAR)  | No       | (null)        
| PET_TYPE    | VARCHAR(20 CHAR)   | No       | (null)      
| PET_BREED   | VARCHAR2(20 CHAR)  | Yes      | (null)  
| DESCRIPTION | VARCHAR2(255 CHAR) | Yes      | (null)  

### Table Overview

Pets table stores data about customers pets, it consists of pet_id, customer_id that shows which customer_id owns which pet, pets name, type, breed and the description about that pet.


### APPOINTMENT TABLE
| COLUMN_NAME          | DATA_TYPE        | NULLABLE | DATA_DEFAULT                     
|----------------------|------------------|----------|----------------------------------
| APPOINTMENT_ID       | NUMBER           | No       | "SYSTEM"."APPOINTMENT_SEQ"."NEXTVAL" 
| CUSTOMER_ID          | NUMBER           | No       | (null)
| GROOMER_SCHEDULE_ID | NUMBER            | No       | "SYSTEM"."GROOMER_SCHEDULE_SEQ"."NEXTVAL"                                                                                                 
| APPOINTMENT_CANCELLED| CHAR(1)          | Yes      | 'N'           
| CREATED_BY           | VARCHAR2(20 CHAR)| No       | (null)                                                 
| CREATION_DATE        | DATE             | No       | (null)                         
| LAST_UPDATED_BY      | VARCHAR2(20 CHAR)| Yes      | (null)                           
| LAST_UPDATE          | DATE             | Yes      | (null) 

### Table Overview

This is the main table where appointments will be recorded. 
It tracks which customer and pet the appointment is for and when it is scheduled to happen.

**Data types**

* appointment_cancelled column logs whether single appointment was cancelled or not. 
Y = True, it was cancelled N = False, it was not cancelled, if it was not registered the Default is logged as N = Not cancelled. 

### PAYMENT TABLE
| COLUMN_NAME     | DATA_TYPE        | NULLABLE | DATA_DEFAULT                   
|-----------------|------------------|----------|--------------------------------
| PAYMENT_ID      | NUMBER           | No       | "SYSTEM"."PAYMENT_SEQ"."NEXTVAL" 
| AMOUNT          | NUMBER           | No       | (null)                         
| PAYMENT_DATE    | DATE             | No       | SYSDATE                         
| APPOINTMENT_ID  | NUMBER           | No       | (null)                         
| PAYMENT_METHOD  | VARCHAR2(10 CHAR)| No       | (null)                         
| CREATED_BY      | VARCHAR2(20 CHAR)| No       | (null)                         
| CREATION_DATE   | DATE             | No       | (null)                     
| LAST_UPDATED_BY | VARCHAR2(20 CHAR)| Yes      | (null)                         
| LAST_UPDATE     | DATE             | Yes      | (null)           

### Table Overview

Payments table stores everything about the payments - payment amount, method, date, who and when updated the last info about the payment.

### PAYMENT_REFUND TABLE
| COLUMN_NAME     | DATA_TYPE        | NULLABLE | DATA_DEFAULT                   
|-----------------|------------------|----------|--------------------------------
| REFUND_ID       | NUMBER           | No       | "SYSTEM"."PAYMENT_SEQ"."NEXTVAL" 
| PAYMENT_ID      | NUMBER           | No       | (null)                         
| REFUND_AMOUNT   | DATE             | No       | (null)                         
| REFUND_REASON   | NUMBER           | No       | (null)                         
| CREATED_BY      | VARCHAR2(20 CHAR)| No       | (null)                         
| CREATION_DATE   | DATE             | No       | (null)                     
| LAST_UPDATED_BY | VARCHAR2(20 CHAR)| Yes      | (null)                         
| LAST_UPDATE     | DATE             | Yes      | (null)            

### Table Overview

Payment refund table stores data about the refunds in case a refund is needed for the customer - refund amount, reason and timing when it was recorded.


### GROOMER_SCHEDULE TABLE
| COLUMN_NAME         | DATA_TYPE         | NULLABLE | DATA_DEFAULT                     
|---------------------|-------------------|----------|----------------------------------
| GROOMER_SCHEDULE_ID | NUMBER            | No       | "SYSTEM"."GROOMER_SCHEDULE_SEQ"."NEXTVAL" 
| GROOMER_ID          | NUMBER            | No       | (null)                                    
| SERVICE_ID          | NUMBER            | No       | "SYSTEM"."SERVICE_SEQ"."NEXTVAL"         
| START_TIME          | DATE              | No       | (null)                           
| END_TIME            | DATE              | No       | (null)                                                
| NOTES               | VARCHAR2(255 CHAR)| Yes      | (null)                           
| CREATED_BY          | VARCHAR2(20 CHAR) | No       | (null)                           
| CREATION_DATE       | DATE              | No       | (null)                         
| LAST_UPDATED_BY     | VARCHAR2(20 CHAR) | Yes      | (null)                           
| LAST_UPDATE         | DATE              | Yes      | (null)   

### Table Overview

The Groomers_Schedule table stores data about groomers worktime, availability of the groomer, when the appointment was started and when it was finished. It helps to plan and track the work shifts for each groomer.

### APPOINTMENT_SERVICE TABLE
| COLUMN_NAME    | DATA_TYPE | NULLABLE | DATA_DEFAULT 
|----------------|-----------|----------|--------------
| APPOINTMENT_ID | NUMBER    | No       | (null)       
| SERVICE_ID     | NUMBER    | No       | (null)     
  
### Table Overview
This is called "Junction table", it is used to connect "appointments" and "services" tables with foreign keys.
This enables multiple services per appointment as well as multiple appointments per service.
It allows flexible service combinations for each customer visit.

More about relationships and its quirks is explained in Relationships part.


### SERVICE_INVENTORY TABLE
| COLUMN_NAME         | DATA_TYPE         | NULLABLE | DATA_DEFAULT               
|---------------------|-------------------|----------|----------------------------
| SERVICE_INVENTORY_ID| NUMBER            | No       | "SYSTEM"."ITEM_SEQ"."NEXTVAL" 
| ITEM_NAME           | VARCHAR2(50 CHAR) | No       | (null)   
| QUANTITY            | NUMBER            | No       | (null)                           
| UNIT_PRICE          | NUMBER            | No       | (null)       
| SERVICE_ID          | NUMBER            | No       | (null)     
| CREATION_DATE       | DATE              | No       | (null)                  
| CREATED_BY          | VARCHAR2(20 CHAR) | No       | (null)                     
| LAST_UPDATED_BY     | VARCHAR2(20 CHAR) | Yes      | (null)                     
| LAST_UPDATE         | DATE              | Yes      | (null)                                    

### Table Overview

Service_inventory table stores data about what items are stored in the inventory for the services that your Grooming salon provides. It consists of item_id, item_name, unit and unit_price. This table helps monitor product usage and inventory quantity.'


### APPOINTMENT_NOTIFICATION TABLE
| COLUMN_NAME                | DATA_TYPE          | NULLABLE | DATA_DEFAULT                      
|----------------------------|--------------------|----------|-----------------------------------
| APPOINTMENT_NOTIFICATION_ID| NUMBER             | No       | "SYSTEM"."NOTIFICATION_SEQ"."NEXTVAL" 
| APPOINTMENT_ID             | NUMBER             | No       | (null)                           
| NOTIFICATION_TEXT          | VARCHAR2(255 CHAR) | No       | (null)                            
| NOTIFICATION_DATE          | DATE               | Yes      | (null)                            
| NOTIFICATION_SENT          | DATE               | No       | SYSDATE                                                    

### Table Overview

This table is used for notifying the customer about the appointment.
It stores the message, when it was created and when it was sent.k


# 3. Relationships (Schema)
![Grooming salon schema.](https://i.imgur.com/UDswlNr.png)

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
