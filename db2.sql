--1
CREATE TABLE SALESMAN
(SALESMANID NUMBER(4),
SNAME VARCHAR(20),
CITY VARCHAR(20),
COMMISSION VARCHAR(20),
PRIMARY KEY (SALESMANID));

DESC SALESMAN;

--2
CREATE TABLE CUSTOMER
(CUSTOMERID NUMBER(4),
CUSTNAME VARCHAR(20),
CITY VARCHAR(20),
GRADE NUMBER(3),
PRIMARY KEY (CUSTOMERID),
SALESMANID REFERENCES SALESMAN(SALESMANID) ON DELETE SET NULL);

DESC CUSTOMER;

--3
CREATE TABLE ORDERS
(ORDNO NUMBER(5),
PURCHASEAMT NUMBER(10,2),
ORDDATE DATE,
PRIMARY KEY(ORDNO),
CUSTOMERID REFERENCES CUSTOMER(CUSTOMERID)ON DELETE CASCADE,
SALESMANID REFERENCES SALESMAN(SALESMANID) ON DELETE SET NULL);

DESC ORDERS;

--1
INSERT INTO SALESMAN VALUES(1000,'JOHN','BANGALORE','25%');
INSERT INTO SALESMAN VALUES(2000,'RAVI','BANGALORE','20%');
INSERT INTO SALESMAN VALUES(3000,'KUMAR','MYSORE','15%');
INSERT INTO SALESMAN VALUES(4000,'SMITH','DELHI','30%');
INSERT INTO SALESMAN VALUES(5000,'HARSHA','HYDERABAD','15%');

SELECT * FROM SALESMAN;

--2
INSERT INTO CUSTOMER VALUES(10,'PREETHI','BANGALORE',100,1000);
INSERT INTO CUSTOMER VALUES(11,'VIVEK','MANGALORE',300,1000);
INSERT INTO CUSTOMER VALUES(12,'BHASKAR','CHENNAI',400,2000);
INSERT INTO CUSTOMER VALUES(13,'CHETTAN','BANGALORE',200,2000);
INSERT INTO CUSTOMER VALUES(14,'MANISH','BANGALORE',400,3000);

SELECT * FROM CUSTOMER;

--3
INSERT INTO ORDERS VALUES(50,5000,'04-MAY-17',10,1000);
INSERT INTO ORDERS VALUES(51,450,'20-JAN-17',10,2000);
INSERT INTO ORDERS VALUES(52,1000,'24-FEB-17',13,2000);
INSERT INTO ORDERS VALUES(53,3500,'13-APR-17',14,3000);
INSERT INTO ORDERS VALUES(54,550,'09-MAR-17',12,2000);

SELECT * FROM ORDERS;



--QUERIES

-- QUERY 1

SELECT GRADE,COUNT(DISTINCT CUSTOMERID)
FROM CUSTOMER
GROUP BY GRADE
HAVING GRADE>(SELECT AVG(GRADE)
FROM CUSTOMER
WHERE CITY='BANGALORE');

-- QUERY 2

SELECT SALESMANID, NAME
FROM SALESMAN A
WHERE 1<(SELECT COUNT(*)
FROM CUSTOMER
WHERE SALESMANID=A.SALESMANID);

-- QUERY 3

SELECT SALESMAN.SALESMANID, NAME,CUSTNAME,COMMISSION
FROM SALESMAN,CUSTOMER
WHERE SALESMAN.CITY=CUSTOMER.CITY
UNION
SELECT SALESMANID,NAME,'NO MATCH',COMMISSION
FROM SALESMAN
WHERE NOT CITY=ANY
(SELECT CITY
FROM CUSTOMER)
ORDER BY 2 DESC;

-- QUERY 4

CREATE VIEW ELITSALESMAN AS
SELECT B.ORDDATE,A.SALESMANID,A.NAME
FROM SALESMAN A,ORDERS B
WHEREA.SALESMANID=B.SALESMANID
AND B.PURCHASEAMT=(SELECT MAX(PURCHASEAMT)
FROM ORDERS C
WHERE C.ORDDATE=B.ORDDATE);

SELECT * FROM ELITSALESMAN;

-- QUERY 5

DELETE FROM SALESMAN
WHERE SALESMANID=1000;

SELECT * FROM SALESMAN;