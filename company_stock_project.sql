/* COMPANY STOCK PROJECT DESCRIPTION

This project uses data from 3 fictional companies: 
	a.	'IE Merchant' (IEG01.csv)
	b.	'IE Exclusive Club' (IEG02.csv)
	c.	'IE International Souvenirs' (IEG03.csv). 

The CSV files attached each contain one company’s stock prices between August 11th and 15th and are comprised of the following columns:
	•	Company: company ID
	•	Snapdate: date on which instance occured
	•	Snaptime: start time of instance (*each instance has a duration of 15 minutes)
	•	Openprice: opening stock value at beginning of instance (all values use a precision of 8 & a scale of 4)
	•	Highprice: highest price of stock during instance 
	•	Lowprice: lowest price of stock during instance
	•	Closeprice: closing stock value & the end of instance
	•	Volume: volume of stocks handled during instance

The project includes DDL & DML statements to create tables and queries from the given data. 
These allow for exploration & summarization of the data. 
The project is separated into the 10 questions / sections below.
 */

/* QUESTION 1
Create table STOCK to store all stock file contents (IEG01.csv, IEG02.csv, IEG03.csv). 
Show DDL used to create table.
 */

CREATE TABLE STOCK (
	COMPANY CHAR(5) NOT NULL,
	SNAPDATE DATE NOT NULL,
	SNAPTIME TIME NOT NULL,
	OPENPRICE DECIMAL(8,4),
	HIGHPRICE DECIMAL(8,4),
	LOWPRICE DECIMAL(8,4),
	CLOSEPRICE DECIMAL(8,4),
	VOLUME BIGINT,
	PRIMARY KEY (COMPANY, SNAPDATE, SNAPTIME)
);

/* QUESTION 2
Load data from each CSV file into the STOCK table. 
For each company show the sum of the average open price, high price, low price, & close price, the average volume, and the number of records included in the table.
 */

SELECT COMPANY, AVG(OPENPRICE) + AVG(HIGHPRICE) + AVG(LOWPRICE) 
+ AVG(CLOSEPRICE) AS SUM_AVERAGES, AVG(VOLUME) AS AVERAGE_VOLUME, 
COUNT(COMPANY) AS RECORD_COUNT
FROM STOCKS
GROUP BY COMPANY

/* QUESTION 3
Show the maximum and the minimum stock values for each company. 
Also include the number of rows and the total stock traded volume per company.
 */

SELECT 
	COMPANY, 
	max(HIGHPRICE) AS MAX, 
	min(LOWPRICE) AS MIN,
	count(*) AS TOTAL_COUNT, 
	SUM(VOLUME) AS TOTAL_VOLUME
FROM STOCKS
GROUP BY COMPANY

/* QUESTION 4
The output of question 3 shows that each company has a different record count, which implies that some companies shave more time periods than other. 
Create an output showing these differences for the date August 11th  that fulfills the following requirements:
	a.	Only show those time periods with information for one or two companies, not those with all three companies.
	b.	If a company has no data for a time period, show a NULL value but, if a company has data show the word ‘OK’.
	c.	Order the output by time in ascending order.
 */

SELECT DISTINCT 
	a.SNAPDATE, 
	a.SNAPTIME, 
	b.IEG01, 
	c.IEG02, 
	d.IEG03 
FROM STOCK AS a
	LEFT JOIN
		(SELECT SNAPDATE, SNAPTIME, 'OK' AS IEG01 FROM STOCK WHERE company = 'IEG01') AS b 
			ON (a.snapdate = b.snapdate AND a.snaptime = b.snaptime)
	LEFT JOIN 
		(SELECT SNAPDATE, SNAPTIME, 'OK' AS IEG02 FROM STOCK WHERE company = 'IEG02') AS c 
			ON (a.snapdate = c.snapdate AND a.snaptime = c.snaptime)
	LEFT JOIN
		(SELECT SNAPDATE, SNAPTIME, 'OK' AS IEG03 FROM STOCK WHERE company = 'IEG03') AS d 
			ON (a.snapdate = d.snapdate AND a.snaptime = d.snaptime)
WHERE 
	a.SNAPDATE = '2022-08-11' AND 
	(IEG01 IS NULL OR IEG02 IS NULL OR IEG03 IS NULL)
ORDER BY SNAPTIME

/* QUESTION 5
Show the number of times when the opening price is higher, lower, or equal to the closing price for each company.
 */

SELECT 
	COMPANY, 
	count(CASE WHEN CLOSEPRICE < OPENPRICE THEN OPENPRICE END) AS DECREASE,
	count(CASE WHEN CLOSEPRICE > OPENPRICE THEN OPENPRICE END) AS INCREASE, 
	count(CASE WHEN OPENPRICE = CLOSEPRICE THEN OPENPRICE END) AS NOCHANGE
FROM STOCKS 
GROUP BY COMPANY;

/* QUESTION 6
Create a summary daily stock price table, DAILY including a summary row per day and company.
 */

CREATE TABLE DAILY (
COMPANY CHAR(5) NOT NULL,
SNAPDATE DATE NOT NULL,
HIGHPRICE DECIMAL(8,4),
LOWPRICE DECIMAL(8,4),
VOLUME INT
);

/* QUESTION 7
Load the daily summary table with each day’s highest and lowest stock price, and the total volume traded for each given company and date.
 */

INSERT INTO DAILY 
SELECT 
	COMPANY,
	SNAPDATE,
	MAX(HIGHPRICE),
	MIN(LOWPRICE),
	SUM(VOLUME)
FROM STOCKS
GROUP BY COMPANY, SNAPDATE

SELECT * FROM DAILY 

/* QUESTION 8
Create a table COMPANY in the database containing all three companies. 
Include at least 5 columns with descriptive attributes for each company. 
Populate the table with data.
 */

CREATE TABLE COMPANY (
ID CHAR(5) NOT NULL,
NAME VARCHAR(40) NOT NULL,
STREET VARCHAR(40),
BUILDING_NUMBER VARCHAR(5),
CITY VARCHAR(20),
STATE VARCHAR(20),
COUNTRY VARCHAR(20),
FISCAL_ID VARCHAR(10),
EMPLOYEE_COUNT INT,
STOCKS INT
);

INSERT INTO COMPANY VALUES
('IEG01', 'IE Merchant','Maria de Molina', '32B', 'Madrid', NULL, 'Spain', 'B83812345', 12, 100000),
('IEG02', 'IE Exclusive Club', 'Marble Street', '250', 'Hartford', 'Connecticut', 'United States', 'X234-123', 25, 248000),
('IEG03', 'IE International Souvenirs', NULL, NULL, 'Shanghai', NULL, 'China', NULL, NULL, NULL);

/* QUESTION 9
Define referential integrity rules between all three tables (STOCK, DAILY, COMPANY) that consider the following rules:
	a.	Whenever a company is removed from the COMPANY table, all its dependent data should also be removed automatically from the DAILY and STOCK tables.
	b.	Whenever data for a specific company and date is removed from DAILY, all its dependent data should also be removed automatically from the STOCK table.
 */

--AddING PKs to COMPANY & DAILY table 
ALTER TABLE COMPANY 
ADD PRIMARY KEY (ID)

ALTER TABLE DAILY 
ADD PRIMARY KEY (COMPANY, SNAPDATE)

--Adding FKs to all tables
ALTER TABLE DAILY 
ADD FOREIGN KEY (COMPANY)
REFERENCES COMPANY(ID)
ON DELETE CASCADE 

ALTER TABLE STOCKS 
ADD FOREIGN KEY (COMPANY, SNAPDATE)
REFERENCES DAILY(COMPANY, SNAPDATE)
ON DELETE CASCADE 

ALTER TABLE STOCKS 
ADD FOREIGN KEY (COMPANY)
REFERENCES company(ID)
ON DELETE CASCADE

/* QUESTION 10
Execute the deletes below, explain if they cause any side effects and verify that data is correctly removed from all dependent tables. 
Show the number of rows per company for each of these dependent tables. 
	a.	Remove all rows IEG03 for the date August 11th at 9 o’clock AM from the STOCK table.
	b.	Remove all rows IEG03 for the date August 10th from the STOCK table.
	c.	Remove row IEG03 for the date August 11th from the DAILY table.
	d.	Remove row IEG03 from the COMPANY table.
 */

DELETE FROM STOCKS
WHERE COMPANY = 'IEG03' AND SNAPDATE = '2022-08-11' AND SNAPTIME = '09:00:00';

-- No rows were removed because there are no rows in the STOCK table in which the company is IEG03, the date is August 11th, and the time is 09:00. 
-- There were no side effects on any of the other two tables.

DELETE FROM STOCKS
WHERE COMPANY = 'IEG03' AND SNAPDATE = '2022-08-10'

-- Removed all 38 rows in STOCK table for which the company was IEG03 and the date was August 10th, leaving the stock table with 534 rows (186 rows for IEG01, 194 rows for IEG02, 154 rows for IEG03). 
-- There were no side effects on any of the other two tables.

DELETE FROM DAILY
WHERE COMPANY = 'IEG03' AND SNAPDATE = '2022-08-11'

-- Deleted 1 row in the DAILY table for which company was IEG03 and the date was August 11th, leaving the DAILY table with 14 rows (5 rows for IEG01, 5 rows for IEG02, 2 rows for IEG03). 
-- All 37 dependent rows in stock table were also deleted, leaving the STOCK table with 497 rows (186 rows for IEG01, 194 rows for IEG02, 117 rows for IEG03).

DELETE FROM COMPANY
WHERE ID = 'IEG03'

-- Deleted 1 row in the COMPANY table, in which the ID was IEG03, leaving the COMPANY table with 2 rows (1 row for IEG01, 1 row for IEG02). 
-- All 4 dependent rows in the DAILY table were also deleted, leaving the DAILY table with 10 rows (5 rows for IEG01, 5 rows for IEG02, 0 rows for IEG03). 
-- All 117 dependent rows in the STOCK table were also deleted, leaving the STOCK table with 380 rows (186 rows for IEG01, 194 rows for IEG02, 0 rows for IEG03).




