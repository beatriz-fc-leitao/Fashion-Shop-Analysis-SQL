# 👚 SQL: Fashion Shop Analysis 👕

## Introduction
	  
**👩🏻‍💼 THE SITUATION** 

You've been hired as a consultant for a small local fashion retailer. They currently do not store any informaiton on inventory, sales, or payments digitally and thus have difficulty with managing their inventory, gaining insights into top selling products, and understanding customr preferences to stay competitive in the market.

**📈 THE BRIEF**

You have been asked to create a logical plan for a database where the shop can keep product, sales, and payment information. After your logical plan is approved by the shop, you are asked to create the database, populate it with customer data, and use SQL queries to answer several business questions.

**✏️ THE OBJECTIVE**

Use SQL to:
- Create an Entity Relationship Diagram for a relational model that includes information about products, sales, and payments.
- Create tables for the relational model and populate them with data
- Use SQL queries to gain insights into the business.
		
***

## Entity Relationship Diagram
<details> 
<summary>
Click here for the Entity Relationship Diagram! 📉
</summary>
	
<kbd><img src="https://github.com/beatriz-fc-leitao/SQL_projects/blob/main/final_ERD.png" width="750" height="480"></kbd>

</details> 
	
***

## Create Product Tables
<details> 
<summary>
Click here to see the creation of the product related tables in the model! 👚
</summary>
	
**PRODUCT TABLE**
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
	
**BRAND TABLE**
```sql
CREATE TABLE BRAND(
   BRAND_ID BIGINT NOT NULL,
   BRAND_NAME VARCHAR(40) NOT NULL,
   EMAIL VARCHAR(40),
   PRIMARY KEY (BRAND_ID)
);
```
	
**COLOR TABLE**
```sql
CREATE TABLE COLOR(
   COLOR_CODE CHAR(6) NOT NULL,
   COLOR_NAME VARCHAR(20) NOT NULL,
   PRIMARY KEY (COLOR_CODE)
);
```	

**CATEGORY TABLE**
```sql
CREATE TABLE CATEGORY(
   CATEGORY_ID BIGINT NOT NULL,
   CATEGORY_NAME VARCHAR(40) NOT NULL,
   PRIMARY KEY (CATEGORY_ID)
);
```

**SIZE TABLE**
```sql
CREATE TABLE SIZE(
   SIZE_CODE CHAR(2) NOT NULL,
   DESCRIPTION VARCHAR(40) NOT NULL,
   PRIMARY KEY (SIZE_CODE)
);
```
	
**TYPE TABLE**
```sql
CREATE TABLE TYPE(
   TYPE_ID BIGINT NOT NULL,
   TYPE_NAME VARCHAR(40) NOT NULL,
   CATEGORY_ID BIGINT,
   PRIMARY KEY (TYPE_ID)
);
```
	
**GENDER TABLE**
```sql
CREATE TABLE GENDER(
   GENDER_ID BIGINT NOT NULL,
   GENDER_NAME VARCHAR(40) NOT NULL,
   PRIMARY KEY (GENDER_ID)
);
```	
	
</details> 
	
***

## Create Ticket/Receipt tables
<details> 
<summary>
Click here to see the creation of the ticket / receipt related tables in the model! 🧾
</summary>
	
**TICKET TABLE**
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
	
**TICKET_ITEM TABLE**
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
	
**EMPLOYEE TABLE**
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

**CUSTOMER TABLE**
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

## Create Payment Tables
<details> 
<summary>
Click here to see the creation of the payment related tables in the model! 💰
</summary>
	
**CC PAYMENT TABLE**
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
	
**CC CARD TABLE**
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
	
**CC PAYMENT TYPE TABLE**
```sql
CREATE TABLE CCPAYMENT_TYPE (
   CCTYPE CHAR(2) NOT NULL,
   DESCRIPTION VARCHAR(40) NOT NULL,
   PRIMARY KEY (CCTYPE)
);
```	

**PAYMENT STATE TABLE**
```sql
CREATE TABLE CCPAYMENT_STATE (
   CCSTATE CHAR(1) NOT NULL,
   DESCRIPTION VARCHAR(40) NOT NULL,
   PRIMARY KEY (CCSTATE)
);
```

**CC METHOD TABLE**
```sql
CREATE TABLE CCENTRY_METHOD (
   CCMETHOD CHAR(1) NOT NULL,
   DESCRIPTION VARCHAR(40) NOT NULL,
   PRIMARY KEY (CCMETHOD)
);
```
	
</details> 

***

## Create Relationships Between Tables
<details> 
<summary>
Click here to see the code used to create relationships between each table to build the model! 𝌠
</summary>

**Creating relationships between product tables**
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
```

**Creating relationships between ticket/receipt tables**
```sql   
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
```
	
**Creating relationships between payment tables**
```sql
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
	
## View Tables
<details> 
<summary>
Click here to see the a preview of the final tables in the model! 𝌠
</summary>

<br>
Below you can see a preview (first 3 rows) of each final table. The full tables can be found as CSV files in this repo. The data was inserted directly into each table using SQL insert statements.

```sql
# General structure for data inserts
INSERT INTO <TABLE NAME> VALUES
(data);
```

** PRODUCT TABLE**
|PRODUCT_ID|TYPE_ID  |SIZE_CODE|COLOR_CODE|PRODUCT_NAME|BRAND_ID|GENDER_ID|DESCRIPTION        |
|----------|---------|---------|----------|------------|--------|---------|-------------------|
|2039      |10001335 |M        |009933    |Trousers    |86010900|30003891 |sustainable        |
|8500      |10001334 |L        |ffff00    |Skirt       |86010700|30004039 |Made with love     |
|9850      |100001350|L        |000000    |Waistcoat   |86010500|30003891 |Made with love     |

**BRAND TABLE**
|BRAND_ID|BRAND_NAME|EMAIL|
|--------|----------|-----|
|86010100|GAP       |contact@gap.com|
|86010200|American Eagle|contact@ae.com|
|86010300|HM        |contact@hm.com|

**COLOR TABLE**
|COLOR_CODE|COLOR_NAME|
|----------|----------|
|000000    |Black     |
|0000b3    |Blue      |
|009933    |Green     |

**CATEGORY TABLE**
|CATEGORY_ID|CATEGORY_NAME|
|-----------|-------------|
|67010300   |Lower Body Wear/Bottoms|
|67010800   |Upper Body Wear/Tops|
	

**SIZE TABLE**
|SIZE_CODE|DESCRIPTION|
|---------|-----------|
|L        |Large      |
|M        |Medium     |
|S        |Small      |

**TYPE TABLE**
|TYPE_ID|TYPE_NAME|CATEGORY_ID|
|-------|---------|-----------|
|10001334|Skirts   |67010300   |
|10001335|Trousers/Shorts|67010300   |
|10001352|Shirts/Blouses/Polo Shirts/T-shirts|67010800   |
	
**GENDER TABLE**
|GENDER_ID|GENDER_NAME|
|---------|-----------|
|30003891 |FEMALE     |
|30004039 |MALE       |
|30004340 |UNISEX     |

**TICKET TABLE**
|TICKET_ID|TIMEPLACED|EMPLOYEE_ID|CUSTOMER_ID|TOTAL_PRODUCT|TOTAL_TAX|TOTAL_ORDER|CCPAYMENT_ID|
|---------|----------|-----------|-----------|-------------|---------|-----------|------------|
|36701285 |2022-01-09 11:00:18|3          |1          |4.00000      |22.56000 |163.56000  |355501500143|
|48937606 |2022-04-02 17:01:15|3          |2          |3.00000      |12.00800 |87.05800   |178691081716|
|53957703 |2022-05-22 14:02:34|4          |3          |1.00000      |37.10400 |269.00400  |72857319254 |

**TICKET ITEM TABLE**
|TICKET_ID|NUMSEQ   |PRODUCT_ID|QUANTITY|PRICE  |TAX_AMOUNT|PRODUCT_AMOUNT|
|---------|---------|----------|--------|-------|----------|--------------|
|36701285 |1        |645158    |2       |70.50000|11.28000  |141.00000     |
|48937606 |2        |202412    |1       |75.05000|12.00800  |75.05000      |
|53957703 |3        |9850      |2       |115.95000|18.55200  |231.90000     |

**EMPLOYEE TABLE**
|EMPLOYEE_ID|FIRSTNAME|LASTNAME|DOB|EMAIL  |PHONENO  |
|-----------|---------|--------|---|-------|---------|
|1          |Carlos   |Lopez   |1992-01-01|c.lopez@store.com|34615824328|
|2          |Maria    |Salim   |1989-03-29|m.salim@store.com|34670561337|
|3          |Sami     |Omari   |1970-02-23|s.omari@store.com|34655870193|

**CUSTOMER TABLE**
|CUSTOMER_ID|FIRSTNAME|LASTNAME|DOB|EMAIL  |PHONENO  |
|-----------|---------|--------|---|-------|---------|
|1          |Emilia   |Kenny   |1995-05-02|e.kenny@gmail.com|34615824324|
|2          |Ivanna   |Ovens   |1982-05-19|ivanna.o@hotmail.com|34673561237|
|3          |Mariana  |Rea     |1979-01-11|m.rea79@gmail.com|34653870093|

**CCPAYMENT TABLE**
|CCPAYMENT_ID|CCPAYTRAN_ID|EXPECTED_AMOUNT|APPROVING_AMOUNT|APPROVED_AMOUNT|CCPAYMENT_STATE|TIMECREATED        |TIMEUPDATED        |TIMEEXPIRED        |
|------------|------------|---------------|----------------|---------------|---------------|-------------------|-------------------|-------------------|
|8305929187  |330749321073|1782.31680     |1782.31680      |1782.31680     |2              |2022-03-18 15:03:23|2022-03-18 15:03:59|2022-03-18 15:05:15|
|16837199743 |277654323148|662.36000      |662.36000       |662.36000      |2              |2022-05-20 10:33:32|2022-05-20 10:34:31|2022-05-20 10:36:21|
|23671563807 |127187561115|154.28000      |154.28000       |154.28000      |2              |2022-01-27 12:30:49|2022-01-27 12:32:21|2022-01-27 12:33:11|

**CC CARD TABLE**
|CCPAYMENT_ID|PAYMENT_TYPE|IS_ENCRYPT|CARD_NUMBER|BANKNAME|CCEXPDATE|CCENTRY_METHOD     |
|------------|------------|----------|-----------|--------|---------|-------------------|
|8305929187  |AM          |Y         |344491990131977|Santander|21       |2                  |
|16837199743 |MC          |Y         |5500380688224633|Caixabank|19       |2                  |
|23671563807 |VS          |Y         |4539110207988444|Santander|21       |0                  |

**CC PAYMENT TYPE TABLE**
|CCTYPE|DESCRIPTION|
|------|-----------|
|AM    |American Express|
|BK    |Other bank card|
|MC    |MasterCard |
	
**CC PAYMENT STATE TABLE**
|CCSTATE|DESCRIPTION|
|-------|-----------|
|0      |new        |
|1      |approving  |
|2      |approved   |
	
** CCENTRY METHOD TABLE**
|CCMETHOD|DESCRIPTION|
|--------|-----------|
|0       |Swiping    |
|1       |Dipping    |
|2       |Contactless|
	
</details>

***
## Business Questions & Insights
<details> 
<summary>
Click here to see business insigths gained from the model! 📊
</summary>

<br>

In this section, I defined 5 business questions and answered them using SQL queries. The main objective leverage the model and the data to help the fashion shop make informed decisions, improve sales, and stay ahead of their competition. You can find the questions below

**Question 1: Which are the top 3 colors sold last season (summer 2022)?**
```sql
SELECT A.COLOR_NAME COLOR, COUNT(A.COLOR_NAME) NUMBER_ITEMS_SOLD
FROM COLOR A 
JOIN PRODUCT B ON (A.COLOR_CODE = B.COLOR_CODE)
JOIN TICKET_ITEM C ON (B.PRODUCT_ID = C.PRODUCT_ID)
JOIN TICKET D ON (C.TICKET_ID = D.TICKET_ID)
WHERE DATE(D.TIMEPLACED) BETWEEN '2022-06-21' AND '2022-09-23'
GROUP BY A.COLOR_NAME
ORDER BY 2 DESC
LIMIT 3;
```

|COLOR |NUMBER_ITEMS_SOLD|
|------|-----------------|
|Pink  |3                |
|Black |2                |
|Green |2                |

Here we see that pink, black, and green were the top 3 colors last season. The shop can use this information to optimize their inventory management Specifically, to capitalize on the popularity of these colors, the shop can focus on stocking up on more products that feature these colors in their upcoming collections. They can also highlight these colors in their marketing campaigns to appeal to their target audience's preferences. Moreover, they can consider creating exclusive promotions or discounts on items that come in these colors to drive sales and attract customers. In the future, they should monitor customer feedback and market trends to stay up to date on changing color preferences and adjust their strategies accordingly.

**Question 2: How much money was spent per credit card type?**
```sql
SELECT A.DESCRIPTION CREDIT_CARD_TYPE, ROUND(SUM(D.TOTAL_ORDER),2) AMOUNT_SPENT
FROM CCPAYMENT_TYPE A
JOIN CCPAYMENT_CARD B ON (A.CCTYPE = B.PAYMENT_TYPE)
JOIN CCPAYMENT C ON (B.CCPAYMENT_ID = C.CCPAYMENT_ID)
JOIN TICKET D ON (C.CCPAYMENT_ID = D.CCPAYMENT_ID)
GROUP BY A.DESCRIPTION;
```

|CREDIT_CARD_TYPE|AMOUNT_SPENT|
|----------------|------------|
|American Express|3350.58     |
|Other bank card |3774.98     |
|MasterCard      |3813.42     |
|Visa            |4279.19     |
	
Here we see that American Express was the credit card with which more money was spent on purchases at the shop followed by "Other bank card", then MasterCard, and finally Visa. The shop can leverage this insight to make informed decisions regarding their payment processing and marketing strategies. For instance, they can consider offering exclusive promotions or discounts to customers who use these payment methods to encourage their use. Additionally, they could collaborate with these banks to create co-branded marketing campaigns or offer loyalty or rewards programs to their mutual customers. By capitalizing on these popular payment methods, the shop can attract more customers and drive sales.

**Question 3: What is the average amount spent per type of clothes?**
```sql
SELECT D.TYPE_NAME TYPE_OF_CLOTHES, ROUND(AVG(A.TOTAL_ORDER),2) AVG_AMOUNT_SPENT
FROM TICKET A 
JOIN TICKET_ITEM B ON (A.TICKET_ID = B.TICKET_ID)
JOIN PRODUCT C ON (B.PRODUCT_ID = C.PRODUCT_ID)
JOIN TYPE D ON (C.TYPE_ID = D.TYPE_ID)
GROUP BY D.TYPE_NAME;
```

|TYPE_OF_CLOTHES |AVG_AMOUNT_SPENT|
|----------------|----------------|
|Skirts          |759.84          |
|Trousers/Shorts |613.45          |
|Shirts/Blouses/Polo Shirts/T-shirts|702.23          |
|Sweaters/Pullovers|439.63          |
|Jackets/Blazers/Cardigans/Waistcoats|579.61          |

Here we see that on avergae over the last season, customers spent the most money on skirts, followed by toursers/shorts, then shirt, then sweaters, and lastly jackets. The shop can leverage this information to optimize their inventory management, specifically, they can ensure that they have enough stock of the items for which most money was spent on, such as skirts and  trousers/shorts. Additionally, they can offer a wider variety of styles and colors in these categories to meet customer demand and appeal to a broader range of customers. They can also use these insights to inform their marketing and sales strategies by considering featuring items in the high-priced categories prominently in their marketing campaigns, and offering exclusive promotions or discounts on items in these categories to drive sales further.

**Question 4: Which brand results in the most profit?**
```sql
SELECT A.BRAND_NAME, ROUND(SUM(C.PRODUCT_AMOUNT),2) PROFIT
FROM BRAND A
JOIN PRODUCT B ON (A.BRAND_ID = B.BRAND_ID)
JOIN TICKET_ITEM C ON (B.PRODUCT_ID = C.PRODUCT_ID)
GROUP BY A.BRAND_NAME
ORDER BY 2 DESC
LIMIT 1;
```

|BRAND_NAME      |PROFIT |
|----------------|-------|
|Nautica         |3404.94|
	
Here we see that Nautica was the brand that generated the highest profit. Knowign this, the shop can continue to collaborate with Nautica and offer an increased range of Nautica lothing items to further increase sales and convert one-ff customers who purchased Nautica products to loyal recurring customers. If this pattern is observed again in the coming season, the shop could also renegotiate their contract with Nautica to make it more favourable. Additionally, the shop could also analyze the characteristics of the Nautica brand and its products to identify opportunities to expand their product offerings in a similar style or price range, as well as to adjust their pricing strategies to optimize revenue and profitability.
	
**Question 5: Which customer bought the largest number of female clothes?**
```sql
SELECT CONCAT(A.FIRSTNAME,' ',A.LASTNAME) CUSTOMER_NAME, SUM(C.QUANTITY) FEMALE_ITEMS_PURCHASED
FROM CUSTOMER A
JOIN TICKET B ON (A.CUSTOMER_ID = B.CUSTOMER_ID)
JOIN TICKET_ITEM C ON (B.TICKET_ID = C.TICKET_ID)
JOIN PRODUCT D ON (C.PRODUCT_ID = D.PRODUCT_ID)
JOIN GENDER E ON (D.GENDER_ID = E.GENDER_ID)
WHERE E.GENDER_NAME = 'FEMALE'
GROUP BY A.CUSTOMER_ID
ORDER BY 2 DESC
LIMIT 1;
```

|CUSTOMER_NAME   |FEMALE_ITEMS_PURCHASED|
|----------------|----------------------|
|Ivanna Ovens    |20                    |
	
Here we see that Ivanna Ovens was the customer who purchased the largest number of female clothes. Knowing this, the shop can use this insight to identify similar customers who are likely to make frequent purchases and tailor marketing campaigns and promotions to target them specifically. Also, they can offer exclusive perks and discounts to top customers like Ivanna, such as early access to new products or free shipping, to encourage them to continue shopping with the business. Lastly, the shop can could improve customer loyalty and satisfaction by providing excellent customer service and personalized recommendations based on past purchases. They can also reach out to top customers like Ivanna to gather feedback and insights on their shopping experiences, and use this information to make improvements and adjustments to their products and services.
	
</details>

***
	
## Conclusion
<details> 
<summary>
Click here to see the conclusion! 🔚
</summary>

<br>
	
In this project, I have created a normalized operational database for the little fashion shop. It is a relational database created using MySQL that contains data on shop products, sales, payments, employees, and customers. This database business value to the shop as they are now able to store their data digitally and leverage it to make informed business decisions regarding inventory management, product offerings, and sales and marketing strategies. 
	
Specifically, I found that the top three colors of the last season were pink, black, and green; American Express, "Other bank card", MasterCard, and Visa were the top banks with the most money spent; customers spent the most money on average on skirts, followed by trousers/shorts, shirts, sweaters, and jackets; Nautica was the brand that generated the most profit, and Ivanna Ovens was the top customer with the most purchases.

By leveraging these insights, the business can optimize their inventory management by ensuring that they have enough stock of the most popular products and brands. They can also use these insights to tailor their marketing campaigns and promotions to target the most profitable customer segments, such as top customers or those interested in high-priced categories. Additionally, they can use customer feedback and market trends to inform their product offerings and pricing strategies, ultimately improving their overall profitability and customer satisfaction!
