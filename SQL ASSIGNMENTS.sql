--ASSignment 1 
create table customer (id int primary key ,firstname varchar(40) not null , lastname varchar(40), city varchar(40), country varchar(40), phone varchar(20)  )

create table ordert(id int primary key , orderdate datetime not null, ordernumber nvarchar(10) ,customerid int , totalamount decimal)

create table orderitem(id int primary key, orderid int ,productid int, unitprice decimal , quantity int )

create table product(id int primary key , productname varchar(50), unitprice decimal , pacakge nvarchar(20))

alter table order add constraint fk_order_customerid foreign key(customerid) references cutomer(id)
alter table order add constraint fk_orderitem_orderid foreign key(orderid) references ordert(id)
alter table order add constraint fk_orderitem_productid foreign key(productid) references product(id)

select *from customer
select *from ordert;
select *from orderitem
select * from product


--Assignment 2
--.write a query to display Country whose name starts with A or I
select country from customer where country like 'A%' OR country like 'i%'

--.write a query to display whose name of customer whose third character is i/h
select firstname from customer where firstname like '__h%'

--Display the details from Customer table who is from country Germany
select * from customer where country ='america'

--Display the  full name of the employee --
select concat(firstname , lastname) from customer

--Display the   customer details  who has Fax number--
alter table customer add fax int 
update customer set fax=1234 where id=1
select *from customer where fax=1234

--Display the   customer details  who has Fax is not null
select * from customer where fax is not null

--display the customer details whose name holds second letter as U
select * from customer where firstname like '_s%'

--select order Details where unit price is greater than 10 and less than 50
select *from orderitem where unitprice >10 AND unitprice< 50

--order details which contain shipping date arragnge by order by date 
select orderdate  as shipping_date from ordert order by orderdate asc

-- Print the orders shipped by ship name 'La corned'abondance' between 2 dates(Choose dates of your choice)
select * from ordert where orderdate between '2020-11-11 ' AND '2021-12-12'

create table product_supply(prod_id int , order_id int ,prod_name varchar(30),categoryname varchar(30),price decimal, discount decimal,supplier_name varchar(50) )

insert into product_supply values(1555, 4455,'prod_1','seafood',450.3, 10.2, 'fleshyfoods')
insert into product_supply values(1556, 4456,'prod_2','chinese',452.3, 10.2, 'flycurry')
insert into product_supply values(1557, 4457,'prod_3','coco-cola',455.3, 10.2, 'exotic liquids')
insert into product_supply values(1558, 4458,'prod_4','limca',420.3, 10.2, 'exotic liquids')



--Print the products supplied by 'Exotic Liquids'
select *from product_supply where supplier_name='exotic liquids'

--print the average quantity ordered for every product

select avg(quantity) from orderitem group by id

--Print the bill for a given order id .bill should contain Productname, Categoryname,price after discount
select prod_name, categoryname, (price-discount ) as bill_amount from product_supply where order_id='4455'

--Print the Total price of orders which have the products supplied by 'Exotic Liquids' 
 select sum(price) as 'Total_price' from product_supply where supplier_name='exotic liquids' 
 
alter table product_supply add shipping_company varchar(40)

update product_supply set shipping_company='xyz' where supplier_name='exotic liquids'

--Print the Total price of orders which have the products supplied by 'Exotic Liquids' if the price is > 50 and also print it by Shipping company's Name
  select sum(price) as 'Total_price' from product_supply where supplier_name='exotic liquids' 
         ----------------incomplete-------------
alter table product_supply add availability_status varchar(40)
update product_supply set availability_status='out of stock' where supplier_name='exotic liquids'



--write a query to get most expense and least expense product list
select top(1) prod_name , price from product_supply order by desc 
select top(1) prod_name , price from product_supply order by  price 

-- display employee detail who joined recently 
select top(1) * from ordert order by orderdate desc

-- create shipping table
create table ShippingDetails(
ship_id int primary key,
reference_number varchar(30) NOT NULL,
shipping_date datetime NOT NULL,
ship_name varchar(20),
is_operating binary,
Shipping_Comapany varchar(20),
order_id int FOREIGN KEY REFERENCES Ordert(id)
);

insert into ShippingDetails values(121,'1233','2002-12-12',concat('titanic',char(39),'marinobuddy'),1,'comp 1 ',101),
								  (122,'1243','2001-12-12',concat('seaship',char(39),'navtrav'),0,'comp2',102),
								  (123,'1233','2005-12-12',concat('titanic1',char(39),'marinobuddy'),1,'compa3',103

--Print the orders shipped by ship name 'La corned'abondance' between 2 dates(Choose dates of your choice)

Select * from ordert where id in (select order_id from ShippingDetails where (ship_name=concat('titanic',char(39),'marinobuddy')) 
and Shipping_date between '2000-12-12' and '2002-12-12');

--Print all the Shipping company name and the ship names if they are operational
Select Shipping_Comapany ,ship_name from ShippingDetails where is_operating=1

--Assignment 3
--write a query to display the orders placed by customer with phone number 030-0074321
SELECT ordert.ordernumber, customer.id, customer.firstname, customer.Phone
FROM ordert, customer
WHERE ordert.customerid = customer.Id
AND customer.phone='1234567890';

--2. fetching all the products which are available under Category ‘Seafood’.
SELECT * FROM product_supply WHERE categoryname='SeaFood'
select * from product_supply

--Display the orders placed by customers not in London
select * From Ordert INNER Join Customer ON Ordert.CustomerId = Customer.id 
and Customer.Country != 'London';

--selects all the order which are placed for the product Chai.
select * From Ordert where id = (Select OrderId from OrderItem Inner Join Product ON OrderItem.ProductId = Product.id and ProductName= 'prod1')

--Write a query to display the name , department name and rating of any given employee
Create table employee (ename varchar(30), deptid int,rating int )
create table dept (deptid int primary key , dept_name varchar(30))
Alter table employee  add constraint fk_emp_deptid foreign key (deptid) references dept(deptid)

insert into employee values('ashlesha ',101,10);
insert into dept values(101 ,'developement')

SELECT e.ename AS emp_name, d.dept_name AS dept_name, e.rating FROM Employee e INNER JOIN Dept d
ON e.deptid=d.deptid;


--Assignment 4
--Print the Total price of orders which have the products supplied by 'Exotic Liquids' if the price is > 50 and also print it by Shipping company's Name
 SELECT SUM(Price) As Total,Categoryname  FROM product_supply  GROUP BY supplier_name
having supplier_name ='exotic liquids' and Price >50;


 -- display employee detail who joined recently 
select top(1) * from ordert order by orderdate desc

--Display the employee details whose joined at first
select top(1) * from ordert order by orderdate asc

--Write a query to get most expense and least expensive Product list (name and unit price).
select top(1) prod_name , price from product_supply order by desc 
select top(1) prod_name , price from product_supply order by  price 

--display the product that are out of stock
select prod_name from product_supply where availability_status='out of stock'

--Display the list of products whose unitinstock is less than unitonorder
alter table Product add unitinstock int, unitonorder int;
update Product set unitinstock=12,unitonorder=24;
SELECT * FROM Product WHERE unitinstock<unitonorder;

--Display list of categories and suppliers who supply products within those categories
alter table Product add category varchar(20),suppiler varchar(20);
update Product set category='shell' ,suppiler='Sup1' where id=1555;
update Product set category='food' ,suppiler='Sup2' where id=1556;
update Product set category='food' ,suppiler='Sup2' where id=1557;
insert into Product values (1558,'prod4',48.5,'pakaged ',13,12,'shell','sup3');
select category ,suppiler from Product order by category;

--Display complete list of customers, the OrderID and date of any orders they have made
select c.id,c.FirstName,c.LastName,o.id as 'Order_id',o.OrderDate from customer as c left join Ordert as o on c.id=o.customerid;


--Write  query that determines the customer who has placed the maximum number of orders
select * from Customer where id in 
(select customerid from Ordert group by customerid having count(id)=
(select top 1 COUNT(id) from Ordert group by customerid order by 1 desc)
);

--Display the customerid whose name has substring ‘RA’
update Customer set FirstName='RAJ' where id in (2,4);
select id from Customer where FirstName like '%RA%';


--Display the first word of all the company name
insert into ShippingDetails values(124,'1234','2002-12-12',concat('titanic',char(39),'marnobuddy'),1,'comp4 ',104)
update ShippingDetails set Shipping_Comapany='FirstName Comapany' where ship_id in (121,122,123);
select substring(Shipping_Comapany,1,charindex(' ',Shipping_Comapany)) as 'NAME' from ShippingDetails;
 select * from ShippingDetails






