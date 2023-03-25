# 📊 SQL: Fashion Shop Analysis

## Introduction
<details> 
<summary>
Click here for the introduction
</summary>
	  
**👩🏻‍💼 THE SITUATION** 

You've been hired as a consultant for a small local fashion retailer. They currently do not store any informaiton on inventory, sales, or payments digitally and thus have difficulty with managing their inventory, gaining insights into top selling products, and understanding customr preferences to stay competitive in the market.

**📈 THE BRIEF**

You have been asked to create a logical plan for a database where the shop can keep product, sales, and payment information. After your logical plan is approved by the shop, you are asked to create the database, populate it with customer data, and use SQL queries to answer several business questions.

**✏️ THE OBJECTIVE**

Use SQL to:
- Create an Entity Relationship Diagram for a relational model that includes information about products, sales, and payments.
- Create tables for the relational model and populate them with data
- Use SQL queries to gain insights into the business.
	
</details> 
	
***

## Entity Relationship Diagram
<details> 
<summary>
Click here for the Entity Relationship Diagram! 👋🏻
</summary>
	
<kbd><img src="https://github.com/beatriz-fc-leitao/SQL_projects/blob/main/final_ERD.png" width="750" height="480"></kbd>

</details> 
	
***

## Creating Product Tables
<details> 
<summary>
Click here to see the creation of the product related tables in the model! 👋🏻
</summary>
	
** PRODUCT TABLE **
```sql
CREATE TABLE PRODUCT(
   PRODUCT_ID BIGINT NOT NULL,
   TYPE_ID BIGINT NOT NULL,
   SIZE_CODE CHAR(2),
   COLOR_CODE CHAR (6),
   PRODUCT_NAME VARCHAR(40) NOT NULL,
   BRAND_ID BIGINT NOT NULL, 
   GENDER_ID BIGINT NOT NULL,
   DESCRIPTION VARCHAR(100) NOT NULL,
   PRIMARY KEY (PRODUCT_ID)
);
```
	
** BRAND TABLE **
```sql
CREATE TABLE BRAND(
   BRAND_ID BIGINT NOT NULL,
   BRAND_NAME VARCHAR(40) NOT NULL,
   EMAIL VARCHAR(40),
   PRIMARY KEY (BRAND_ID)
);
```
	
** COLOR TABLE **
```sql
CREATE TABLE COLOR(
   COLOR_CODE CHAR(6) NOT NULL,
   COLOR_NAME VARCHAR(20) NOT NULL,
   PRIMARY KEY (COLOR_CODE)
);
```	

** CATEGORY TABLE **
```sql
CREATE TABLE CATEGORY(
   CATEGORY_ID BIGINT NOT NULL,
   CATEGORY_NAME VARCHAR(40) NOT NULL,
   PRIMARY KEY (CATEGORY_ID)
);
```

** SIZE TABLE **
```sql
CREATE TABLE SIZE(
   SIZE_CODE CHAR(2) NOT NULL,
   DESCRIPTION VARCHAR(40) NOT NULL,
   PRIMARY KEY (SIZE_CODE)
);
```
	
** TYPE TABLE **
```sql
CREATE TABLE TYPE(
   TYPE_ID BIGINT NOT NULL,
   TYPE_NAME VARCHAR(40) NOT NULL,
   CATEGORY_ID BIGINT,
   PRIMARY KEY (TYPE_ID)
);
```
	
** GENDER TABLE **
```sql
CREATE TABLE GENDER(
   GENDER_ID BIGINT NOT NULL,
   GENDER_NAME VARCHAR(40) NOT NULL,
   PRIMARY KEY (GENDER_ID)
);
```	
	
</details> 
	
***

## Creating Ticket/Receipt tables
<details> 
<summary>
Click here to see the creation of the ticket / receipt related tables in the model! 👋🏻
</summary>
	
** TICKET TABLE **
```sql
CREATE TABLE TICKET(
   TICKET_ID BIGINT NOT NULL AUTO_INCREMENT,
   TIMEPLACED TIMESTAMP NOT NULL,
   EMPLOYEE_ID INTEGER NOT NULL,
   CUSTOMER_ID INTEGER NOT NULL,
   TOTAL_PRODUCT DECIMAL(20,5) NOT NULL,
   TOTAL_TAX DECIMAL(20,5) NOT NULL,
   TOTAL_ORDER DECIMAL(20,5) NOT NULL,
   CCPAYMENT_ID BIGINT NOT NULL,
   PRIMARY KEY (TICKET_ID)
);
```
	
** TICKET_ITEM TABLE **
```sql
CREATE TABLE TICKET_ITEM(
   TICKET_ID BIGINT NOT NULL,
   NUMSEQ SMALLINT NOT NULL,
   PRODUCT_ID BIGINT NOT NULL,
   QUANTITY SMALLINT NOT NULL,
   PRICE DECIMAL(20,5) NOT NULL,
   TAX_AMOUNT DECIMAL(20,5) NOT NULL,
   PRODUCT_AMOUNT DECIMAL(20,5) NOT NULL,
   PRIMARY KEY (TICKET_ID, NUMSEQ)
);
```
	
** EMPLOYEE TABLE **
```sql
CREATE TABLE EMPLOYEE(
   EMPLOYEE_ID INT NOT NULL,
   FIRSTNAME VARCHAR(40) NOT NULL,
   LASTNAME VARCHAR(40) NOT NULL,
   DOB DATE,
   EMAIL VARCHAR(40),
   PHONENO VARCHAR(20),
   PRIMARY KEY (EMPLOYEE_ID)
);
```	

** CUSTOMER TABLE **
```sql
CREATE TABLE CUSTOMER(
   CUSTOMER_ID INT NOT NULL,
   FIRSTNAME VARCHAR(40) NOT NULL,
   LASTNAME VARCHAR(40) NOT NULL,
   DOB DATE,
   EMAIL VARCHAR(40),
   PHONENO VARCHAR(20),
   PRIMARY KEY (CUSTOMER_ID)
);
```
	
</details> 
	
***

## Creating Payment Tables
<details> 
<summary>
Click here to see the creation of the payment related tables in the model! 👋🏻
</summary>
	
** CC PAYMENT TABLE **
```sql
CREATE TABLE CCPAYMENT (
   CCPAYMENT_ID BIGINT NOT NULL AUTO_INCREMENT,
   CCPAYTRAN_ID BIGINT,
   EXPECTED_AMOUNT DECIMAL(20,5) NOT NULL,
   APPROVING_AMOUNT	DECIMAL(20,5),
   APPROVED_AMOUNT DECIMAL(20,5),
   CCPAYMENT_STATE CHAR(1) NOT NULL,
   TIMECREATED TIMESTAMP NOT NULL,
   TIMEUPDATED TIMESTAMP,
   TIMEEXPIRED TIMESTAMP,
   PRIMARY KEY (CCPAYMENT_ID)
);
```
	
** CC CARD TABLE **
```sql
CREATE TABLE CCPAYMENT_CARD (
   CCPAYMENT_ID BIGINT NOT NULL,
   PAYMENT_TYPE CHAR(2) NOT NULL,
   IS_ENCRYPT CHAR(1) NOT NULL,
   CARD_NUMBER VARCHAR(64) NOT NULL,
   BANKNAME VARCHAR(64) NOT NULL,
   CCEXPDATE CHAR(6) NOT NULL,
   CCENTRY_METHOD VARCHAR(20) NOT NULL,
   PRIMARY KEY (CCPAYMENT_ID)
);
```
	
** CC PAYMENT TYPE TABLE **
```sql
CREATE TABLE CCPAYMENT_TYPE (
   CCTYPE CHAR(2) NOT NULL,
   DESCRIPTION VARCHAR(40) NOT NULL,
   PRIMARY KEY (CCTYPE)
);
```	

** PAYMENT STATE TABLE **
```sql
CREATE TABLE CCPAYMENT_STATE (
   CCSTATE CHAR(1) NOT NULL,
   DESCRIPTION VARCHAR(40) NOT NULL,
   PRIMARY KEY (CCSTATE)
);
```

** CC METHOD TABLE **
```sql
CREATE TABLE CCENTRY_METHOD (
   CCMETHOD CHAR(1) NOT NULL,
   DESCRIPTION VARCHAR(40) NOT NULL,
   PRIMARY KEY (CCMETHOD)
);
```
	
</details> 

***

## Creating Relationships between Tables
<details> 
<summary>
Click here to see the code used to create relationships between each table to build the model! 👋🏻
</summary>

```sql
#ALTERING PRODUCT TABLE
ALTER TABLE PRODUCT 
   ADD FOREIGN KEY (TYPE_ID) REFERENCES TYPE(TYPE_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE PRODUCT 
   ADD FOREIGN KEY (COLOR_CODE) REFERENCES COLOR(COLOR_CODE)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE PRODUCT 
   ADD FOREIGN KEY (GENDER_ID) REFERENCES GENDER(GENDER_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE PRODUCT 
   ADD FOREIGN KEY (SIZE_CODE) REFERENCES SIZE(SIZE_CODE)
   ON UPDATE CASCADE ON DELETE RESTRICT;
   
ALTER TABLE PRODUCT 
   ADD FOREIGN KEY (BRAND_ID) REFERENCES BRAND(BRAND_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;
   
#ALTERING TYPE TABLE
ALTER TABLE TYPE 
   ADD FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;
   
#ALTER TICKET_ITEM TABLE
ALTER TABLE TICKET_ITEM 
   ADD FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE TICKET_ITEM 
   ADD FOREIGN KEY (TICKET_ID) REFERENCES TICKET(TICKET_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;
   
#ALTER TICKET TABLE
ALTER TABLE TICKET
   ADD FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE TICKET
   ADD FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE TICKET
   ADD FOREIGN KEY (CCPAYMENT_ID) REFERENCES CCPAYMENT(CCPAYMENT_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;
   
#ALTER CCPAYMENT TABLE
ALTER TABLE CCPAYMENT 
   ADD FOREIGN KEY (CCPAYMENT_STATE)
   REFERENCES CCPAYMENT_STATE (CCSTATE);
   
#ALTER CCPAYMENT_CARD TABLE
ALTER TABLE CCPAYMENT_CARD 
   ADD FOREIGN KEY (CCENTRY_METHOD)
   REFERENCES CCENTRY_METHOD (CCMETHOD);

ALTER TABLE CCPAYMENT_CARD 
   ADD FOREIGN KEY (PAYMENT_TYPE)
   REFERENCES CCPAYMENT_TYPE (CCTYPE);
   
ALTER TABLE CCPAYMENT_CARD 
   ADD FOREIGN KEY (CCPAYMENT_ID)
   REFERENCES CCPAYMENT (CCPAYMENT_ID);
```
	
</details> 

***
	
## Viewing Tables
<details> 
<summary>
Click here to see the final tables in the model! 👋🏻
</summary>

** PRODUCT TABLE
<kbd><img src="https://github.com/beatriz-fc-leitao/SQL_projects/blob/main/final_ERD.png" width="750" height="480"></kbd>

<details>

***

