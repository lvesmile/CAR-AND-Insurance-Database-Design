--TABLES
--Replace this with your table creations (including the history table).
DROP TABLE make CASCADE;
Drop table purchase_order CASCADE;
DROP TABLE free_account CASCADE;
DROP TABLE paid_Account CASCADE;
DROP TABLE salesperon_car_link CASCADE;
DROP TABLE Retail_salesperson_link CASCADE;
DROP TABLE insurance CASCADE;
DROP TABLE Insurance_type CASCADE;
DROP TABLE Salesperson CASCADE;
DROP TABLE loan CASCADE;
DROP TABLE Retail CASCADE;
DROP TABLE car CASCADE;
DROP TABLE Account CASCADE;
DROP TABLE balance_change CASCADE; 
DROP TABLE insurance_change CASCADE;

DROP SEQUENCE make_seq;
DROP SEQUENCE order_seq;
DROP SEQUENCE ins_type_seq;
DROP SEQUENCE free_acct_seq;
DROP SEQUENCE paid_aact_seq;
DROP SEQUENCE sale_car_link_seq;
DROP SEQUENCE retail_sale_link_seq;
DROP SEQUENCE insurance_seq;
DROP SEQUENCE salesperson_seq;
DROP SEQUENCE loan_seq;
DROP SEQUENCE retail_seq;
DROP SEQUENCE car_seq;
DROP SEQUENCE account_seq;
DROP SEQUENCE balance_seq;
DROP SEQUENCE ins_change_seq;

CREATE TABLE Account( 
Account_ID DECIMAL(12) NOT NULL PRIMARY KEY,
AccountName VARCHAR(32) NOT NULL, 
FirstName VARCHAR(32) NOT NULL,
LastName VARCHAR(32) NOT NULL,
AccountEmail VARCHAR(64) NOT NULL,
Zipcode DECIMAL(5) NOT NULL,
EncryptedPassword VARCHAR(32) NOT NULL,
AccountType CHAR(1) NOT NULL);

CREATE TABLE Paid_account(
RenewalDate DATE,
account_id DECIMAL(12) NOT NULL UNIQUE,
Balance DECIMAL(8,2) NOT NULL,
FOREIGN KEY (Account_ID) REFERENCES Account(Account_ID));

CREATE TABLE free_account(
account_id DECIMAL(12) NOT NULL,
FOREIGN KEY (Account_ID) REFERENCES Account(Account_ID));

CREATE TABLE Retail(
retail_id decimal(12) NOT NULL PRIMARY KEY,
RetailName VARCHAR(128) NOT NULL,
RetailLocation VARCHAR(256) NOT NULL,
RetailPhone DECIMAL(10) NOT NULL,
Description VARCHAR(2560) NOT NULL);

CREATE TABLE Salesperson(
salesperson_id DECIMAL(12) NOT NULL PRIMARY KEY,
SalespersonPhone DECIMAL(12) NOT NULL,
SalespersonFirstName VARCHAR(32) NOT NULL,
SalesperonLastName VARCHAR(32) NOT NULL);

CREATE TABLE Retail_Salesperson_link (
retail_salesperson_link_id DECIMAL(12) NOT NULL PRIMARY KEY,
salesperson_id DECIMAL(12) NOT NULL,
Retail_id DECIMAL(12) NOT NULL,
FOREIGN KEY (salesperson_id) REFERENCES Salesperson(salesperson_id),
FOREIGN KEY (retail_id) REFERENCES Retail(retail_id));

CREATE TABLE Loan(
loan_id DECIMAL(12) NOT NULL PRIMARY KEY,
FinanceCompany VARCHAR(64) NOT NULL,
Annual_rate DECIMAL(4,2) NOT NULL,
FinanceCharge DECIMAL(8,2) NOT NULL,
AmountFinanced DECIMAL(8,2) NOT NULL,
TotalPayment DECIMAL(8,2) NOT NULL,
DownPayment DECIMAL(8,2) NOT NULL,
Total_sale_price DECIMAL(8,2) NOT NULL,
salesperson_id DECIMAL(12) NOT NULL,
FOREIGN KEY (salesperson_id) REFERENCES Salesperson(salesperson_id));

CREATE TABLE Make(
make_id DECIMAL(12) NOT NULL PRIMARY KEY,
make_name VARCHAR(64) NOT NULL);

CREATE TABLE purchase_order(
OrderNumber DECIMAL(12) NOT NULL PRIMARY KEY,
Schedule_date DATE NOT NULL,
retail_id DECIMAL(12) NOT NULL,
Account_ID DECIMAL(12) NOT NULL,
FOREIGN KEY (retail_id) REFERENCES retail(retail_id),
FOREIGN KEY (Account_ID) REFERENCES Account(Account_ID));

CREATE TABLE insurance_type(
insurance_id DECIMAL(12) NOT NULL PRIMARY KEY,
insurance_name VARCHAR(64) NOT NULL,
Insurance_phone DECIMAL(10) NOT NULL);

CREATE TABLE Insurance(
Policy_Number DECIMAL(12) NOT NULL PRIMARY KEY,
insurance_id DECIMAL(12) NOT NULL,
Effective_Date DATE NOT NULL,
Expiration_Date DATE NOT NULL,
FOREIGN KEY (insurance_id) REFERENCES insurance_type(insurance_id)); 

CREATE TABLE Car(
Car_id DECIMAL(12) NOT NULL PRIMARY KEY,
make_id DECIMAL(12) NOT NULL,
Policy_Number DECIMAL(12) NOT NULL,
OrderNumber DECIMAL(12) NOT NULL,
Loan_ID DECIMAL(12) NOT NULL,
Model VARCHAR(64) NOT NULL,
Listing_Price DECIMAL(8,2) NOT NULL,
ModelYear DECIMAL(4) NOT NULL,
VIN VARCHAR(17) NOT NULL,
Available_date DATE NOT NULL,
Mileage DECIMAL(6) NOT NULL,
ExteriorColor VARCHAR(64) NOT NULL,
InteriorColor VARCHAR(64) NOT NULL,
BodyType VARCHAR(64) NOT NULL,
FOREIGN KEY (make_id) REFERENCES Make(make_id),
FOREIGN KEY (loan_id) REFERENCES Loan(loan_id),
FOREIGN KEY (Policy_Number) REFERENCES Insurance(Policy_Number),
FOREIGN KEY (OrderNumber) REFERENCES purchase_order(OrderNumber));

CREATE TABLE salesperon_car_link(
salesperson_car_link_id DECIMAL(12) NOT NULL PRIMARY KEY,
car_id DECIMAL(12) NOT NULL,
Salesperson_id Decimal(12) NOT NULL,
FOREIGN KEY (car_id) REFERENCES Car(car_id),
FOREIGN KEY (salesperson_id) REFERENCES Salesperson(salesperson_id));

--history table 
CREATE TABLE Balance_Change(
balance_id DECIMAL(12) NOT NULL PRIMARY KEY,
old_balance DECIMAL(8,2) NOT NULL,
new_balance DECIMAL(8,2) NOT NULL,
account_id DECIMAL(12) NOT NULL,
changed_date DATE,
FOREIGN KEY (account_id) REFERENCES paid_account(account_id));


CREATE TABLE Insurance_Change(
Insurance_Change_id DECIMAL(12) NOT NULL PRIMARY KEY,
policy_Number DECIMAL(12) NOT NULL,
old_insurance_id DECIMAL(12) NOT NULL,
new_insurance_id DECIMAL(12) NOT NULL,
Old_effective_Date DATE,
new_effective_date DATE,
old_expiration_date DATE,
new_expiration_date DATE,
changed_on Date,
FOREIGN KEY (Policy_Number) References insurance(Policy_number));

--SEQUENCES
--Replace this with your sequence creations (including the one for the history table).
CREATE SEQUENCE make_seq START WITH 1;
CREATE SEQUENCE order_seq START WITH 1;
CREATE SEQUENCE ins_type_seq START WITH 1;
CREATE SEQUENCE free_acct_seq START WITH 1;
CREATE SEQUENCE paid_aact_seq START WITH 1;
CREATE SEQUENCE sale_car_link_seq START WITH 1;
CREATE SEQUENCE retail_sale_link_seq START WITH 1;
CREATE SEQUENCE insurance_seq START WITH 1;
CREATE SEQUENCE salesperson_seq START WITH 1;
CREATE SEQUENCE loan_seq START WITH 1;
CREATE SEQUENCE retail_seq START WITH 1;
CREATE SEQUENCE car_seq START WITH 1;
CREATE SEQUENCE account_seq START WITH 1;
CREATE SEQUENCE balance_seq START WITH 1;
CREATE SEQUENCE ins_change_seq;

--INDEXES
CREATE UNIQUE INDEX paidacctIdx ON Paid_account(account_id);

CREATE UNIQUE INDEX freeacctIdx on Free_account(account_id);

CREATE INDEX RSLSIdx on retail_salesperson_link(salesperson_id);

CREATE INDEX RSLRIdx on retail_salesperson_link(retail_id);

CREATE INDEX loansaleIdx on loan(salesperson_id);

CREATE INDEX orderretailIdx on Purchase_order(retail_id);

CREATE INDEX insIdx on Insurance(insurance_id);

CREATE INDEX carmakeIdx on Car(make_id);

CREATE UNIQUE INDEX carloanIdx on Car(loan_id);

CREATE UNIQUE INDEX carpolicyIdx on Car(policy_number);

CREATE INDEX carorderIdx on Car(OrderNumber);

CREATE INDEX SCLCIdx ON salesperon_car_link(car_id);

CREATE INDEX SCLSIdx ON salesperon_car_link(salesperson_id);

--Query driven index 

CREATE INDEX caryearIdx ON car(modelyear);

CREATE INDEX PaidrenewalIdx on Paid_account(Renewaldate);

CREATE INDEX balanceIdx on paid_account(Balance);

--STORED PROCEDURES
--FIRST USE CASE 
--Free_account and account
CREATE OR REPLACE PROCEDURE addFreeAccount(Account_ID IN DECIMAL, AccountName IN VARCHAR, FirstName IN VARCHAR, 
										   LastName IN VARCHAR, AccountEmail IN VARCHAR,
										   Zipcode IN DECIMAL,EncryptedPassword IN VARCHAR,AccountType IN CHAR)
AS
$proc$
BEGIN
INSERT INTO account
VALUES(account_id, accountname, firstname, lastname, accountemail, zipcode, encryptedpassword, accounttype);

INSERT INTO free_account
VALUES (account_id);
END;
$proc$ LANGUAGE plpgsql;

--Paid_Account and account 
CREATE OR REPLACE PROCEDURE addPaidAccount(Account_ID IN DECIMAL, RenewalDate IN DATE, AccountName IN VARCHAR, FirstName IN VARCHAR, 
										   LastName IN VARCHAR, AccountEmail IN VARCHAR, Zipcode IN DECIMAL,
										   EncryptedPassword IN VARCHAR,AccountType IN CHAR, Balance in DECIMAL)
AS
$proc$
BEGIN
	INSERT INTO account
	VALUES(account_id, accountname, firstname, lastname, accountemail, zipcode, encryptedpassword, accounttype);

	INSERT INTO paid_account
	VALUES(RenewalDate, account_id, Balance);
END;
$proc$ LANGUAGE plpgsql;

--SECOND USE CASE 
--RETAIL 
CREATE OR REPLACE PROCEDURE AddRetail(retail_id IN decimal, RetailName IN VARCHAR, 
									  RetailLocation IN VARCHAR, RetailPhone IN DECIMAL, Description IN VARCHAR)
AS
$proc$
BEGIN
INSERT INTO retail
VALUES(retail_id, RetailName, RetailLocation, RetailPhone, Description);
END;
$proc$ LANGUAGE plpgsql;

--SALESPERSON
CREATE OR REPLACE PROCEDURE addSalesperson(salesperson_id IN DECIMAL,SalespersonPhone IN DECIMAL, 
										   SalespersonFirstName IN VARCHAR, SalesperonLastName IN VARCHAR)
AS
$proc$
BEGIN
INSERT INTO salesperson
VALUES(salesperson_id, SalespersonPhone, SalespersonFirstName, SalesperonLastName);
END;
$proc$ LANGUAGE plpgsql;

--Third USE CASE
--INSRUANCE_TYPE and Insurance 
CREATE OR REPLACE PROCEDURE AddInsType(insurance_id IN DECIMAL, insurance_name IN VARCHAR, Insurance_phone IN DECIMAL, 
									   Policy_Number In DECIMAL, Effective_Date IN DATE, Expiration_Date IN DATE)
AS
$proc$
BEGIN
INSERT INTO insurance_type
VALUES(insurance_id , insurance_name , Insurance_phone);

INSERT INTO insurance
VALUES(insurance_id, Policy_Number, Effective_Date, Expiration_Date);
END;
$proc$ LANGUAGE plpgsql;

--FOURTH USE CASE 
--LOAN
CREATE OR REPLACE PROCEDURE AddLoan(loan_id IN DECIMAL, FinanceCompany IN VARCHAR,Annual_rate IN DECIMAL,
									FinanceCharge IN DECIMAL, AmountFinanced IN DECIMAL, TotalPayment IN DECIMAL,
									DownPayment IN DECIMAL, Total_sale_price IN DECIMAL, salesperson_id IN DECIMAL)
AS
$proc$
BEGIN
INSERT INTO loan
VALUES(loan_id, FinanceCompany, Annual_rate, FinanceCharge, AmountFinanced, TotalPayment, DownPayment, Total_sale_price, salesperson_id);
END;
$proc$ LANGUAGE plpgsql;

--FIFTH USE CASE 
--MAKE
CREATE OR REPLACE PROCEDURE addMake(make_id IN DECIMAL, make_name IN VARCHAR)
AS
$proc$
BEGIN
INSERT INTO make
VALUES(make_id, make_name);
END;
$proc$ LANGUAGE plpgsql;

--CAR
CREATE OR REPLACE PROCEDURE AddCar(Car_id IN DECIMAL, make_id IN DECIMAL, Policy_Number IN DECIMAL,
								   OrderNumber IN DECIMAL, Loan_ID IN DECIMAL, Model IN VARCHAR, Listing_Price IN DECIMAL, ModelYear IN DECIMAL,
								   VIN IN VARCHAR, Available_date IN DATE, Mileage IN DECIMAL, ExteriorColor IN VARCHAR,
								   InteriorColor IN VARCHAR, BodyType IN VARCHAR)
AS
$proc$
BEGIN
INSERT INTO car
VALUES(Car_id, make_id, Policy_Number, OrderNumber,Loan_ID, Model, Listing_Price,
	   ModelYear, VIN, Available_date, Mileage, ExteriorColor, InteriorColor, BodyType);
END;
$proc$ LANGUAGE plpgsql;
--INSERTS
--Replace this with the inserts necessary to populate your tables.
----AddFreeAccount
START TRANSACTION;
DO
 $$BEGIN
	CALL AddFreeAccount(nextval('account_seq'), 'edwardc', 'Edward', 'Cullen', 'edwarc@gmail.com', 10012, 'edddwww34', 'F');
	CALL AddFreeAccount(nextval('account_seq'), 'bellas', 'Bella', 'Swan', 'bella@gmail.com', 21209, 'bellla21', 'F');
	CALL AddFreeAccount(nextval('account_seq'), 'jacobb', 'Jacob', 'Black', 'jblack@gmail.com', 10012, 'jablack009', 'F');
	CALL AddFreeAccount(nextval('account_seq'), 'alicec', 'Alice', 'Greene', 'aliceg@gmail.com', 95233, 'allliceggg', 'F');
	CALL AddFreeAccount(nextval('account_seq'), 'rosalieha', 'Rosalie', 'Hale', 'rhale@gmail.com', 95828, 'halerossa22', 'F');
	CALL AddFreeAccount(nextval('account_seq'), 'jasperh', 'Jasper', 'Hale', 'jasperh@gmail.com', 10012, 'jasper22111','F');
	CALL AddFreeAccount(nextval('account_seq'), 'peterfa', 'peter', 'Facinelli', 'perterf@gmail.com', 95828, 'perperper11', 'F');
	CALL AddFreeAccount(nextval('account_seq'), 'victoriall', 'Victoria', 'Lefevre', 'lefevrev@gmail.com', 10012, 'victorialef', 'F');
	CALL AddFreeAccount(nextval('account_seq'), 'billb', 'Billy', 'Burke', 'billbb@gmail.com', 11234, 'billbill919', 'F');
	CALL AddFreeAccount(nextval('account_seq'), 'emmettl', 'Emmett', 'Lutz', 'emmettl@gmail.com', 95828, 'emmiittt000', 'F');
 END$$;
COMMIT TRANSACTION;


--AddPaidAccount
START TRANSACTION;
DO
$$BEGIN
	CALL addPaidAccount(nextval('account_seq'), '10-2-2022', 'elizare', 'Elizabeth', 'Reaser', 'elreaser@gmail.com', 95233, 'elizabbbbeth', 'P', 30.55);
	CALL AddPaidAccount(nextval('account_seq'), '11-9-2022', 'jessica', 'Jessica', 'Stanley', 'Jessicas@gmail.com', 21209, 'jeesss122', 'P',76.22);
	CALL AddPaidAccount(nextval('account_seq'), '3-9-2023', 'camgi', 'Cam', 'Gigandet', 'camgig@gmail.com', 11234, 'cammmgggi2', 'P', 43.78);
	CALL AddPaidAccount(nextval('account_seq'), '4-11-2023', 'mikenew', 'Mike', 'Newton', 'miken@gmail.com', 95828, 'mikemike22', 'P', 59.77);
	CALL AddPaidAccount(nextval('account_seq'), '8-20-2023', 'angelaw', 'Angela', 'Weber', 'angelaw@gmail.com', 10012, 'angelawwww', 'P', 104.99);
	CALL AddPaidAccount(nextval('account_seq'), '10-29-2022', 'samul', 'Sam', 'Uley', 'samuley@gmail.com', 95233, 'sammejbs', 'P', 244.29);
	CALL AddPaidAccount(nextval('account_seq'), '1-21-2023', 'embryc', 'Embry', 'Call', 'calle@gmail.com', 11234, 'callmeemm212', 'P', 19.82);
	CALL AddPaidAccount(nextval('account_seq'), '11-19-2022', 'tylerc', 'Tyler', 'Crowley', 'tylerc@gmail.com', 95828, 'tyllerller', 'P', 33.62);
	CALL AddPaidAccount(nextval('account_seq'), '2-12-2023', 'ericy', 'Eric', 'Yorkie', 'ericy@gmail.com', 21209, 'ericycccyyy', 'P', 156.92);
	CALL AddPaidAccount(nextval('account_seq'), '10-25-2023', 'mattbu', 'Matt', 'Bushell', 'mattbu@gmail.com', 11234, 'mattbububuu', 'P', 24.29);
 END$$;
COMMIT TRANSACTION;

--addretail
START TRANSACTION;
DO
 $$BEGIN
	CALL AddRetail(nextval('retail_seq'), 'Select Auto Dealers Corp', '1543 Bushwick Ave, Brooklyn, NY 11207' , 7186847999, 'We are the best dealership in Brooklyn.');
	CALL AddRetail(nextval('retail_seq'), 'Elk Grove Kia', '8480 Laguna Grove Dr, Elk Grove, CA 95757', 9167531000, 'Enjoy The Highest Level of Customer Service throughout Buying & Owning Your Car. Stop By.');
	CALL AddRetail(nextval('retail_seq'), 'Reliable Chevrolet', '9901 Coors Blvd NW, Albuquerque, NM 87114', 5052162788, 'Your first choice of Chevrolet dealer in Albuquerque, New Mexico.');
	CALL AddRetail(nextval('retail_seq'), 'Preferred Auto Sales Pre-owned Superstore', '655 Pennsylvania Ave, Elizabeth, NJ 07201', 9082146999, 'Excellent service and nice staff.');
	CALL AddRetail(nextval('retail_seq'), 'Hudson Chrysler Jeep Dodge RAM', '625 NJ-440, Jersey City, NJ 07304', 5512275676, 'Amazing deals and willing to work on any budget.');
	CALL AddRetail(nextval('retail_seq'), 'Key Motors of South Burlington', '1675 Shelburne Rd, South Burlington, VT 05403', 8028158201, 'Great people, great price, and huge inventory.');
	CALL AddRetail(nextval('retail_seq'), 'AutoFair Ford in Manchester', '1475 S Willow St, Manchester, NH 03103', 8335019327, 'We know what you need.');
	CALL AddRetail(nextval('retail_seq'), 'Virginia Auto Trader Company', '2510 Lee Hwy, Arlington, VA 22201', 7035678383, 'used car dealer, cheap car for sales.');
	CALL AddRetail(nextval('retail_seq'),'Blasius of Attleboro', '800 Washington St, Attleboro, MA 02703', 5086390099, 'We are committed to finding the perfect vehicle for you at a price level that meets your specifications.');
	CALL AddRetail(nextval('retail_seq'), 'Antwerpen Certified Pre-Owned Center', '5717 Baltimore National Pike, Catonsville, MD 21228', 4107449383, 'Antwerpen Certified Pre-Owned Center is your destination for the best used cars.');
 END$$;
COMMIT TRANSACTION;

--addSALESPERSON
START TRANSACTION;
DO
$$BEGIN
	CALL AddSalesperson(nextval('salesperson_seq'), 7186847977, 'Evan', 'Buckley');
	CALL AddSalesperson(nextval('salesperson_seq'), 9167531111, 'Athena', 'Grant');
	CALL AddSalesperson(nextval('salesperson_seq'), 5052168888, 'Howie', 'Han');
	CALL AddSalesperson(nextval('salesperson_seq'), 9082145678, 'Henrietta', 'Wilson');
	CALL AddSalesperson(nextval('salesperson_seq'), 5512276392, 'Abby', 'Clark');
	CALL AddSalesperson(nextval('salesperson_seq'), 8028158231, 'Bobby', 'Nash');
	CALL AddSalesperson(nextval('salesperson_seq'), 7035679182, 'Chris', 'Diaz');
	CALL AddSalesperson(nextval('salesperson_seq'), 5086398888, 'Maddie', 'Kendall');
	CALL AddSalesperson(nextval('salesperson_seq'), 3476569928, 'Jeffrey', 'Hudson');
	CALL AddSalesperson(nextval('salesperson_seq'), 9172022022, 'Lena', 'Bosko');
End$$;
COMMIT TRANSACTION;

--POPULATE Retail_Salesperson_link
Insert into Retail_Salesperson_link VALUES (nextval('retail_sale_link_seq'), (SELECT retail_id FROM retail WHERE RetailName='Select Auto Dealers Corp'), (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Evan'));
Insert into Retail_Salesperson_link VALUES(nextval('retail_sale_link_seq'), (SELECT retail_id FROM retail WHERE RetailName='Elk Grove Kia'), (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Athena'));
Insert into Retail_Salesperson_link VALUES(nextval('retail_sale_link_seq'), (SELECT retail_id FROM retail WHERE RetailName='Reliable Chevrolet'), (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Howie'));
Insert into Retail_Salesperson_link VALUES(nextval('retail_sale_link_seq'), (SELECT retail_id FROM retail WHERE RetailName='Preferred Auto Sales Pre-owned Superstore'), (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Henrietta'));
Insert into Retail_Salesperson_link VALUES(nextval('retail_sale_link_seq'), (SELECT retail_id FROM retail WHERE RetailName='Hudson Chrysler Jeep Dodge RAM'), (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Abby'));
Insert into Retail_Salesperson_link VALUES(nextval('retail_sale_link_seq'), (SELECT retail_id FROM retail WHERE RetailName='Key Motors of South Burlington'), (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Bobby'));
Insert into Retail_Salesperson_link VALUES(nextval('retail_sale_link_seq'), (SELECT retail_id FROM retail WHERE RetailName='Virginia Auto Trader Company'), (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Chris'));
Insert into Retail_Salesperson_link VALUES(nextval('retail_sale_link_seq'), (SELECT retail_id FROM retail WHERE RetailName='Preferred Auto Sales Pre-owned Superstore'), (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Maddie'));
Insert into Retail_Salesperson_link VALUES(nextval('retail_sale_link_seq'), (SELECT retail_id FROM retail WHERE RetailName='Blasius of Attleboro'), (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Jeffrey'));
Insert into Retail_Salesperson_link VALUES(nextval('retail_sale_link_seq'), (SELECT retail_id FROM retail WHERE RetailName='Antwerpen Certified Pre-Owned Center'), (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Lena'));

--populate purchase_order
Insert into purchase_order VALUES (nextval('order_seq'), '09-17-2022', (SELECT retail_id FROM retail WHERE RetailName='Select Auto Dealers Corp'), 
								   (SELECT account_id FROM account WHERE AccountName = 'edwardc'));
Insert into purchase_order VALUES(nextval('order_seq'), '07-19-2022', (SELECT retail_id FROM retail WHERE RetailName='Elk Grove Kia'), 
								  (SELECT account_id FROM account WHERE AccountName = 'bellas'));
Insert into purchase_order VALUES(nextval('order_seq'), '02-01-2022', (SELECT retail_id FROM retail WHERE RetailName='Reliable Chevrolet'), 
								  (SELECT account_id FROM account WHERE AccountName = 'jacobb'));
Insert into purchase_order VALUES(nextval('order_seq'), '08-12-2022', (SELECT retail_id FROM retail WHERE RetailName='Preferred Auto Sales Pre-owned Superstore'), 
								  (SELECT account_id FROM account WHERE AccountName = 'alicec'));
Insert into purchase_order VALUES(nextval('order_seq'), '03-24-2023', (SELECT retail_id FROM retail WHERE RetailName='Hudson Chrysler Jeep Dodge RAM'), 
								  (SELECT account_id FROM account WHERE AccountName = 'rosalieha'));
Insert into purchase_order VALUES(nextval('order_seq'), '01-01-2023', (SELECT retail_id FROM retail WHERE RetailName='Key Motors of South Burlington'), 
								  (SELECT account_id FROM account WHERE AccountName = 'angelaw'));
Insert into purchase_order VALUES(nextval('order_seq'), '01-23-2022', (SELECT retail_id FROM retail WHERE RetailName='Virginia Auto Trader Company'), 
								  (SELECT account_id FROM account WHERE AccountName = 'samul'));
Insert into purchase_order VALUES(nextval('order_seq'), '09-20-2022', (SELECT retail_id FROM retail WHERE RetailName='Preferred Auto Sales Pre-owned Superstore'), 
								  (SELECT account_id FROM account WHERE AccountName = 'tylerc'));
Insert into purchase_order VALUES(nextval('order_seq'), '07-18-2022', (SELECT retail_id FROM retail WHERE RetailName='Blasius of Attleboro'), 
								  (SELECT account_id FROM account WHERE AccountName = 'ericy'));
Insert into purchase_order VALUES(nextval('order_seq'), '10-23-2022', (SELECT retail_id FROM retail WHERE RetailName='Antwerpen Certified Pre-Owned Center'), 
								  (SELECT account_id FROM account WHERE AccountName = 'mattbu'));

--addInsType
START TRANSACTION;
DO
$$BEGIN
	CALL AddInsType(nextval('ins_type_seq'), 'Geico', 8002077847, nextval('insurance_seq'), '07-01-2021', '06-30-2022');
	CALL AddInsType(nextval('ins_type_seq'), 'StateFarm', 8007828332, nextval('insurance_seq'), '09-01-2021', '08-31-2022');
	CALL AddInsType(nextval('ins_type_seq'), 'AAA Insurance', 8006725246, nextval('insurance_seq'), '04-01-2021', '03-31-2022');
	CALL AddInsType(nextval('ins_type_seq'), 'Allstate', 8009011732, nextval('insurance_seq'), '09-01-2022', '08-31-2023');
	CALL AddInsType(nextval('ins_type_seq'), 'Kemper Auto', 8007821020, nextval('insurance_seq'), '07-01-2021', '06-30-2022');
	CALL AddInsType(nextval('ins_type_seq'), 'Progressive', 8886714405, nextval('insurance_seq'), '05-01-2021', '04-30-2022');
	CALL AddInsType(nextval('ins_type_seq'), 'Nationwide', 8776696877, nextval('insurance_seq'), '03-01-2021', '02-28-2022');
	CALL AddInsType(nextval('ins_type_seq'), 'Liberty Mutual', 8002908711, nextval('insurance_seq'), '10-01-2022', '09-30-2023');
	CALL AddInsType(nextval('ins_type_seq'), 'The Travelers Companies', 8008425075, nextval('insurance_seq'), '03-01-2021', '02-28-2022');
	CALL AddInsType(nextval('ins_type_seq'), 'USAA', 8005318722, nextval('insurance_seq'), '11-01-2021', '10-31-2022');
END$$;
COMMIT TRANSACTION;

--addloan
START TRANSACTION;
DO
$$BEGIN
	CALL AddLoan(nextval('loan_seq'), 'Carvana', 02.99, 3029.75, 27999.00, 31028.75, 5000.00, 36028.75, 4);
	CALL AddLoan(nextval('loan_seq'), 'LendingTree', 04.79, 5903.75, 30099.00, 34002.75, 6000.00, 42002.75, 1);
	CALL AddLoan(nextval('loan_seq'), 'OneMain Financial', 03.21, 4470.32, 29870.00, 34340.32, 4000.00, 38340.32, 2);
	CALL AddLoan(nextval('loan_seq'), 'MyAutoLoan', 01.99, 4907.33, 26990.00, 31897.33, 7000.00, 38897.33, 5);
	CALL AddLoan(nextval('loan_seq'), 'AutoLoanZoom', 02.59, 4001.50, 34079.00, 38080.50, 2000.00, 40080.50, 4);
	CALL AddLoan(nextval('loan_seq'), 'Toyota Financing', 05.77, 5304.84, 28099.00, 33403.84, 3000.00, 36403.84, 6);
	CALL AddLoan(nextval('loan_seq'), 'Car.Loan.Come', 06.44, 4470.32, 22000.00, 26470.32, 8000.00, 34470.32, 9);
	CALL AddLoan(nextval('loan_seq'), 'Bank of America', 03.99, 5400.77, 31000.00, 36400.77, 7000.00, 43400.77, 8);
	CALL AddLoan(nextval('loan_seq'), 'Chase Bank', 04.51, 3078.20, 23089.00, 26167.2, 6000.00, 32167.20, 3);
	CALL AddLoan(nextval('loan_seq'), 'US Bank', 06.00, 6778.94, 30100.00, 36878.94, 6000.00, 42878.94, 5);
END$$;
COMMIT TRANSACTION;

--addmake
START TRANSACTION;
DO
$$BEGIN
	CALL AddMake(nextval('make_seq'), 'Ford');
	CALL AddMake(nextval('make_seq'), 'Toyota');
	CALL AddMake(nextval('make_seq'), 'Honda');
	CALL AddMake(nextval('make_seq'), 'Hyundai');
	CALL AddMake(nextval('make_seq'), 'Nissan');
	CALL AddMake(nextval('make_seq'), 'Mercedes-Benz');
	CALL AddMake(nextval('make_seq'), 'Bayerische Motoren Werke AG');
	CALL AddMake(nextval('make_seq'), 'Lexus');
	CALL AddMake(nextval('make_seq'), 'Audi');
	CALL AddMake(nextval('make_seq'), 'Porsche');
End$$;
COMMIT TRANSACTION;

--AddCar
START TRANSACTION;
DO
$$BEGIN
	CALL AddCar(nextval('car_seq'), 1, 3, 1, 4, 'Escape', 31065, 2022,'1FMCU9F61NUB28311', '10-03-2022', 140, 'Oxford white', 'Dark Earth Gray', 'AWD SUV');
	CALL AddCar(nextval('car_seq'), 2, 5, 2, 3, '4 Runner', 45048, 2023, 'JTEMU5JR8P6099430', '09-08-2022', 40, 'Blue Metallic', 'Sand Beige', '4WD SUV');
	CALL AddCar(nextval('car_seq'), 3, 4, 3, 2, 'CR-V', 32110, 2022, '5J6RW2H51NL003751', '10-20-2022', 39, 'Pearl White', 'Ivory', 'AWD SUV');
	CALL AddCar(nextval('car_seq'), 4, 1, 4, 1, 'Kona', 29410, 2022, 'KM8K3CAB5PU939421', '9-03-2022', 10, 'Black', 'Luna white', 'AWD Crossover');
	CALL AddCar(nextval('car_seq'), 5, 2, 5, 5, 'Maxima', 29995, 2019, '1N4AA6AV5KC379258', '08-13-2022', 24076, 'Super Black', 'Charcoal', 'FWD Sedan');
	CALL AddCar(nextval('car_seq'), 6, 7, 6, 8, 'GLB 250', 42150, 2023, 'W1N4M4HB5NW258059', '11-22-2022', 69, 'Night Black', 'Black', '4Matic SUV');
	CALL AddCar(nextval('car_seq'), 7, 8, 7, 7, '540i', 36555, 2019, 'WBAJE5C51KWW11386', '10-13-2022', 74314, 'Alphine white', 'Black', 'RWD Sedan');
	CALL AddCar(nextval('car_seq'), 8, 9, 8, 6, 'GX 460', 44995, 2018, 'JTJJM7FX7J5208531', '03-17-2022', 20832, 'Starfire Pearl', 'Black', '4WD SUV');
	CALL AddCar(nextval('car_seq'), 9, 10, 9, 10, 'F5EBAY', 54235, 2022, 'WAU2AGF5XNN007255', '12-12-2022', 10, 'Glacier White Metallic', 'Rock Gray', 'AWD 2-door Convertible');
	CALL AddCar(nextval('car_seq'), 10, 6, 10, 9, 'Macan', 52991, 2018, 'WP1AB2A50JLB30475', '10-03-2022', 24683, 'Volcano Grey Metallic', 'Black', 'AWD SUV');
END$$;
COMMIT TRANSACTION;


--populate salesperon_car_link
INSERT INTO salesperon_car_link VALUES(nextval('sale_car_link_seq'), (SELECT car_id FROM Car where VIN = '1FMCU9F61NUB28311'), 
									   (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Evan'));
INSERT INTO salesperon_car_link VALUES(nextval('sale_car_link_seq'), (SELECT car_id FROM Car where VIN = 'JTEMU5JR8P6099430'), 
									   (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Athena'));
INSERT INTO salesperon_car_link VALUES(nextval('sale_car_link_seq'), (SELECT car_id FROM Car where VIN = '5J6RW2H51NL003751'), 
									   (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Howie'));
INSERT INTO salesperon_car_link VALUES(nextval('sale_car_link_seq'), (SELECT car_id FROM Car where VIN = 'KM8K3CAB5PU939421'), 
									   (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Henrietta'));
INSERT INTO salesperon_car_link VALUES(nextval('sale_car_link_seq'), (SELECT car_id FROM Car where VIN = '1N4AA6AV5KC379258'), 
									   (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Chris'));
INSERT INTO salesperon_car_link VALUES(nextval('sale_car_link_seq'), (SELECT car_id FROM Car where VIN = 'W1N4M4HB5NW258059'), 
									   (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Bobby'));
INSERT INTO salesperon_car_link VALUES(nextval('sale_car_link_seq'), (SELECT car_id FROM Car where VIN = 'WBAJE5C51KWW11386'), 
									   (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Evan'));
INSERT INTO salesperon_car_link VALUES(nextval('sale_car_link_seq'), (SELECT car_id FROM Car where VIN = 'JTJJM7FX7J5208531'), 
									   (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Athena'));
INSERT INTO salesperon_car_link VALUES(nextval('sale_car_link_seq'), (SELECT car_id FROM Car where VIN = 'WAU2AGF5XNN007255'), 
									   (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Howie'));
INSERT INTO salesperon_car_link VALUES(nextval('sale_car_link_seq'), (SELECT car_id FROM Car where VIN = 'WP1AB2A50JLB30475'), 
									   (SELECT Salesperson_id FROM Salesperson WHERE SalespersonFirstName= 'Athena'));


--TRIGGERS
--Replace this with your history table trigger.

--BALANCE_CHANGE
CREATE OR REPLACE FUNCTION BalanceChangeFunc()
RETURNS TRIGGER LANGUAGE plpgsql
AS $trigfunc$
BEGIN
	INSERT INTO balance_change(balance_id, old_balance, new_balance, account_id,changed_date)
	VALUES(nextval('balance_seq'), OLD.balance, NEW.balance, NEW.Account_id, NEW.RenewalDate);
RETURN NEW;
END;
$trigfunc$;

CREATE TRIGGER BalanceChangeTrigger
BEFORE UPDATE OF balance ON Paid_account
FOR EACH ROW
EXECUTE PROCEDURE BalanceChangeFunc();

SELECT * FROM Paid_account where account_id=15;

UPDATE paid_account
SET balance= 79.33, renewaldate = '07-20-2024'
WHERE account_id = 15;

SELECT * FROM balance_change;

--Insurance change

CREATE OR REPLACE FUNCTION InsuranceChangeFunc()
RETURNS TRIGGER LANGUAGE plpgsql
AS $trigfunc$
BEGIN
	INSERT INTO insurance_change
	VALUES(nextval('ins_change_seq'), NEW.Policy_number, OLD.insurance_id, NEW.insurance_id, OLD.effective_date, 
		   NEW.effective_date, OLD.expiration_date, NEW.expiration_date, CURRENT_DATE);
RETURN NEW;
END;
$trigfunc$;

CREATE TRIGGER InsuranceChangeTrigger
BEFORE UPDATE OF insurance_id, effective_date, expiration_date ON Insurance
FOR EACH ROW
EXECUTE PROCEDURE InsuranceChangeFunc();

select * from insurance 
Join insurance_type on insurance.insurance_id = insurance_type.insurance_id
where Policy_number=5;

UPDATE Insurance 
SET insurance_id = 8, effective_date = '07-01-2022', expiration_date='06-30-2023'
WHERE Policy_number = 5;

SELECT * FROM insurance_change;

select insurance_name, insurance.insurance_id, policy_number,effective_date, expiration_date
from insurance 
Join insurance_type on insurance.insurance_id = insurance_type.insurance_id
where Policy_number=5;

--QUERIES
--Replace this with your queries (including any queries used for data visualizations).

--Query 1: Which salesperson sold the most cars on our database?
--I used 'JOIN ... ON' to join 4 tables with associative relationships
--I order the resutl using DESC
SELECT salespersonFirstName, retailName, count(salesperon_car_link.Salesperson_id) as number_cars_sold
From salesperon_car_link
JOIN salesperson ON salesperson.salesperson_id = salesperon_car_link.salesperson_id
Join retail_salesperson_link on retail_salesperson_link.salesperson_id= Salesperson.salesperson_id
JOIN retail ON retail.retail_id = retail_salesperson_link.retail_id
Group by salespersonFirstName, retailName
Order by number_cars_sold DESC;

--Query 2: which customer has an expired or closed expired paid account? Which customer has a balance below $50?
--I define the expiration window for three months from October to December.
--using the interval '1 day' in those three month to find account that meet my query.
--also include customers with balance below $50

SELECT RenewalDate, Balance, AccountName, accountemail
from paid_account 
Join account ON account.account_id = paid_account.account_id
Where RenewalDate>= '10-01-2022'::date 
	AND RenewalDate < ('12-30-2022'::date + '1 day'::interval) 
	OR Balance <= 50 
GROUP BY RenewalDate, balance, AccountName, accountemail
Order by RenewalDate;


--QUERY 3: What is the price of an SUV from low to high in the most recent two years?
--the most recent two years are defined to be 2022 and 2023, using OR to show both required years.
--the car.bodyType must contain the word 'SUV'
--Used the ORDER BY ... ASC to show the price from low to high.
CREATE OR REPLACE VIEW new_suv_car AS
SELECT make, model, modelyear, bodyType, listing_price as price_low_to_high
From make
JOIN Car on Car.make_id = make.make_id
WHERE modelyear = 2023 OR modelyear=2022 
Group by make, model, modelyear, bodytype, price_low_to_high
HAVING car.bodytype LIKE '%SUV'
ORDER BY price_low_to_high ASC;

select * from new_suv_car;

--VISUALIZATION 1
select * from account;

SELECT zipcode, count(account_id) as number_of_customer
FROM account
GROUP BY zipcode
ORDER BY  zipcode;

SELECT cast(substring(cast(zipcode AS VARCHAR(5)), 1, 1) as integer) AS matchzip, 
		count(account_id) AS number_of_customer
from account
group by matchzip
order by number_of_customer DESC;

--Visualization 2

CREATE OR REPLACE PROCEDURE UpdateBalance(new_account_id IN DECIMAL, balance_new IN DECIMAL,
										  new_date IN DATE)
AS
$proc$
BEGIN
	UPDATE paid_account
	SET balance = balance_new, renewaldate = new_date
	WHERE account_id = new_account_id;
END;
$proc$ LANGUAGE plpgsql;

--INSERT DATA 
START TRANSACTION;
DO
$$BEGIN
	CALL UpdateBalance(11, 20.88, '11-03-2022');
	CALL UpdateBalance(11, 50.77, '12-30-2022');
	CALL UpdateBalance(12, 65.33, '12-03-2022');
	CALL UpdateBalance(12, 47.50, '02-01-2023');
	CALL UpdateBalance(13, 79.00, '08-21-2023');
	CALL UpdateBalance(13, 103.44, '11-03-2023');
	CALL UpdateBalance(14, 20.88, '06-20-2023');
	CALL UpdateBalance(14, 88.88, '12-13-2023');
	CALL UpdateBalance(14, 66.27, '12-24-2023');
	CALL UpdateBalance(15, 50.77, '10-08-2023');
	CALL UpdateBalance(16, 179.32, '12-19-2022');
	CALL UpdateBalance(16, 280.38, '01-29-2023');
	CALL UpdateBalance(16, 250.77, '11-03-2023');
	CALL UpdateBalance(17, 40.77, '12-24-2022');
	CALL UpdateBalance(18, 67.33, '12-30-2022');
	CALL UpdateBalance(19, 108.77, '11-03-2023');
	CALL UpdateBalance(19, 58.45, '01-23-2024');
	CALL UpdateBalance(20, 11.28, '11-24-2023');
END$$;
COMMIT TRANSACTION;

SELECT * FROM Balance_Change;

SELECT AVG(new_Balance - old_balance) as avg_balchange,
		changed_date
From balance_change
Group by changed_date
ORDER BY changed_date;