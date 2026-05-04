create  DATABASE JOINS_IN_SQL;
-- CREATING A TABLE NAMED CUSTOMERS
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Country VARCHAR(50)
);

-- CREATING A TABLE NAMED ORDERS
drop table orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


INSERT INTO Customers (CustomerID, CustomerName, Country)
VALUES
(1, 'John Doe', 'USA'),
(2, 'Jane Smith', 'UK'),
(3, 'David Brown', 'Canada'),
(4, 'Emily White', 'Australia'),
(5, 'Michael Green', 'USA'),
(6, 'Anna Taylor', 'USA'),
(7, 'Robert King', 'UK'),
(8, 'Laura Wilson', 'Australia'),
(9, 'James Davis', 'Canada'),
(10, 'Sophia Harris', 'USA'),
(11, 'Chris Evans', 'Australia'),
(12, 'Jessica Adams', 'Canada'),
(13, 'Lucas Black', 'USA'),
(14, 'Olivia Walker', 'UK'),
(15, 'Nathan Scott', 'USA'),
(16, 'Emma Stone', 'Australia'),
(17, 'Daniel Lewis', 'UK'),
(18, 'Sophia Clark', 'Canada'),
(19, 'Liam Johnson', 'Australia'),
(20, 'Amelia Brown', 'USA');

-- INSERTING VALUES INTO TABLE ORDERS
INSERT INTO Orders (OrderID, OrderDate, CustomerID, Amount)
VALUES
(101, '2025-01-10', 1, 250.75),
(102, '2025-01-15', 2, 320.00),
(103, '2025-01-20', 3, 450.50),
(104, '2025-02-01', 1, 120.90),
(105, '2025-02-05', 2, 310.50),
(106, '2025-02-10', NULL, 299.99),
(107, '2025-02-15', 4, 400.25),
(108, '2025-02-20', 5, 150.00),
(109, '2025-02-25', 7, 500.75),
(110, '2025-03-01', 6, 225.50),
(111, '2025-03-05', 9, 600.00),
(112, '2025-03-10', NULL, 450.00),
(113, '2025-03-12', 8, 350.00),
(114, '2025-03-15', 11, 520.75),
(115, '2025-03-18', 12, 310.50),
(116, '2025-03-20', 15, 230.99),
(117, '2025-03-22', 13, 150.20),
(118, '2025-03-25', 14, 475.65),
(119, '2025-03-26', 15, 540.90),
(120, '2025-03-28', NULL, 299.00),  -- Another order without a customer
(121, '2025-03-29', 17, 405.50),
(122, '2025-03-29', NULL, 675.00),  -- Another order without a customer
(123, '2025-03-29', 19, 850.00),
(124, '2025-03-29', 20, 399.99);


select * from customers;
select * from orders;

 --   Find the list of all customers who have placed at least one order.

select c.customername from customers c inner join orders o on c.customerid = o.customerid

--    Find the total amount of all orders placed by each customer.

select c.customername ,sum(o.amount) from customers c inner join orders o on c.customerid = o.customerid group by c.CUSTOMERNAME

--    Find the details of orders placed by customers from the USA.
select  c.country,o.orderid,o.orderdate,o.amount from customers c inner join orders o on c.customerid = o.customerid where c.country = 'USA'

-- Get the total amount spent by each customer who has placed more than one order. 
--  Show customer name, country, number of orders, and total amount spent. 
--Sort by total amount in descending order.

select c.customername,sum(amount) as Total_Spend from customers c inner join orders o on c.customerid = o.customerid group by c.customername
order by Total_Spend DESC

-- Write a query to get the customer name and country where.
--Customers Whose Names Contain 'son'.
--Also the first name in customer name ends with 'ra'.

select customername,split_part(customername,' ',1) from customers where customername like ('%son%') and customername like ('%ra');

--Display customer name, country, and total amount spent (only if it exceeds 500) for customers from UK and USA.

select c.customername,sum(amount) as spend from customers c inner join orders o on c.customerid = o.customerid
where startswith(c.customername,'J')
group by c.customername having  sum(o.amount) >500  ;

startswith()

 -- Write a SQL query to get the customer names you have placed atleast 1 order.   

select c.customername ,o.orderid,count(o.orderid) from customers c inner join orders o on c.customerid = o.customerid
group by c.customername,o.orderid


--Write a sql query to print the total number of orders for each customer from usa even if they have not 
   -- placed any orders. Sort the customers based on the count of their orders
select c.customername,count(o.orderid) from customers c left join orders o on c.customerid = o.customerid 
group by c.customername order by count(o.orderid) Desc



-- Write a sql query to retrive the customer id, customer name, as well as country. 
   -- Classify the customers as different categorical values such as "Premium customer" if the 
   -- total number of orders is more than or equal to 4, "Normal Customer" if the total number of order is in range 1-3. 
  --  Else opportunity if the total number of order is 0


select c.customername,count(o.orderid),case when count(o.orderid) >=4 then 'Premium Customer'
when count(o.orderid) between 1 and 3 then 'Normal Customer'
Else 'Opportunity' end  as Category
from customers c left join orders o on c.customerid = o.customerid 
group by c.customername order by count(o.orderid) Desc

  --  Find the list of customers who have placed atleast one order
select c.customername,count(orderid) as counts from customers c inner join orders o on c.customerid = o.customerid group by c.customername

    

--    Find the total number of orders for each customer from USA, including customers who haven't placed any orders.    
    --Sort the customers based on the count of their orders in ASC.
select c.customername,c.country,count(orderid) as counts from customers c left join orders o on c.customerid = o.customerid 
group by c.customername,c.country having count(orderid) = 0 and c.country = 'USA';

select * from customers;