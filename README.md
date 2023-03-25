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
	
** PRODUCT TABLE
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
	
** BRAND TABLE
```sql
CREATE TABLE BRAND(
   BRAND_ID BIGINT NOT NULL,
   BRAND_NAME VARCHAR(40) NOT NULL,
   EMAIL VARCHAR(40),
   PRIMARY KEY (BRAND_ID)
);
```
	
** COLOR TABLE
```sql
CREATE TABLE COLOR(
   COLOR_CODE CHAR(6) NOT NULL,
   COLOR_NAME VARCHAR(20) NOT NULL,
   PRIMARY KEY (COLOR_CODE)
);
```	

** CATEGORY TABLE
```sql
CREATE TABLE CATEGORY(
   CATEGORY_ID BIGINT NOT NULL,
   CATEGORY_NAME VARCHAR(40) NOT NULL,
   PRIMARY KEY (CATEGORY_ID)
);
```

** SIZE TABLE
```sql
CREATE TABLE SIZE(
   SIZE_CODE CHAR(2) NOT NULL,
   DESCRIPTION VARCHAR(40) NOT NULL,
   PRIMARY KEY (SIZE_CODE)
);
```
	
** TYPE TABLE
```sql
CREATE TABLE TYPE(
   TYPE_ID BIGINT NOT NULL,
   TYPE_NAME VARCHAR(40) NOT NULL,
   CATEGORY_ID BIGINT,
   PRIMARY KEY (TYPE_ID)
);
```
	
** GENDER TABLE
```sql
CREATE TABLE GENDER(
   GENDER_ID BIGINT NOT NULL,
   GENDER_NAME VARCHAR(40) NOT NULL,
   PRIMARY KEY (GENDER_ID)
);
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


