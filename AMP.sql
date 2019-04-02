CREATE DATABASE IF NOT EXISTS Agile;
USE Agile;

DROP table IF EXISTS Driver;



CREATE TABLE Subscription(
	subID int NOT NULL AUTO_INCREMENT, 
    Customer_Id int,
	subFreq VARCHAR(20),
    active boolean,
     pubID int,
    archive boolean,
	PRIMARY KEY (subID),
    FOREIGN KEY (Customer_id) REFERENCES customer_details  (Customer_id),
    FOREIGN KEY (pubID) REFERENCES Publication  (pubID) ON delete cascade);

	
    
    CREATE TABLE Docket(
	DocketID int NOT NULL AUTO_INCREMENT, 
    DriverID int,
    Delivered boolean,
    OrderID int,
     archive boolean,
	PRIMARY KEY (DocketID),
  FOREIGN KEY (DriverID) REFERENCES Driver (DriverID),
    FOREIGN KEY (OrderID) REFERENCES Orders (OrderID)
  );
    

CREATE TABLE Driver(

DriverID int NOT NULL AUTO_INCREMENT, 
Driver_Name VARCHAR(15),
Driver_Password VARCHAR(20),
 archive boolean,
PRIMARY KEY (DriverID)

);
    
    CREATE TABLE customer_details (
  Customer_id INTEGER AUTO_INCREMENT NOT NULL,
  Customer_Name varchar(40) NOT NULL,
  Customer_Address varchar(80) NOT NULL,
  Customer_Contact varchar(11) NOT NULL,
  Customer_Age INTEGER NOT NULL,
   archive boolean,
  PRIMARY KEY (Customer_id)
);

  CREATE TABLE DeliveryArea (
  DeliveryAreaID INTEGER AUTO_INCREMENT ,
  DeliveryAreaAddress varchar(40) NOT NULL,
   DriverID	INTEGER ,
  Customer_id INTEGER ,
   archive boolean,
  FOREIGN KEY (DriverID) REFERENCES Driver (DriverID) ON DELETE CASCADE,
   FOREIGN KEY (Customer_id) REFERENCES customer_details  (Customer_id) ON DELETE CASCADE,
    PRIMARY KEY (DeliveryAreaID)
);

CREATE TABLE Orders (
OrderID INTEGER AUTO_INCREMENT ,
Customer_ID int,
PublicationID int,
subID int,
 archive boolean,
foreign key(Customer_ID) references customer_details(Customer_ID) ON DELETE CASCADE,
foreign key(PublicationID) references Publication(pubID) ON DELETE CASCADE,
foreign key(subID) references Subscription(subID) ON DELETE CASCADE,
 PRIMARY KEY (OrderID)

);


    
CREATE TABLE Publication(
pubID int NOT NULL AUTO_INCREMENT,
pubName VARCHAR(30),
pubCost double,
archive boolean,
PRIMARY KEY (pubID));

CREATE VIEW dview
AS SELECT DocketID, a.OrderId, b.customer_address, c.pubName, d.subFreq
FROM docket, orders a, customer_details b, publication c, subscription d;

CREATE VIEW suView
AS SELECT DeliveryAreaID, a.Customer_Name, b.pubName, c.Delivered
FROM deliveryarea, customer_details a, publication b, docket c WHERE Delivered = 1;
