/**** Advanced Level *****/

/*1. Select customer name together with each order the customer made*/

select c.CustomerName , o.OrderID 
from customers c
inner join orders o
on c.CustomerID = o.CustomerID ;

/*2. Select order id together with name of employee who handled the order*/

select o.OrderID , e.FirstName , e.LastName 
from orders o
inner join employees e
on o.EmployeeID = e.EmployeeID ;

/*3. Select customers who did not placed any order yet*/

select c.CustomerName , o.OrderID 
from customers c
inner join orders o
on c.CustomerID = o.CustomerID ;

/*4. Select order id together with the name of products*/

select p.ProductName , o.OrderID
from products p
inner join order_details d
on p.ProductID = d.ProductID
inner join orders o
on d.OrderID = o.OrderID;

/*5. Select products that no one bought*/

select p.ProductName , d.Quantity
from products p
inner join order_details d
on p.ProductID = d.ProductID
where d.Quantity is null;

# another answer

select p.ProductName, od.OrderID from products p
left join order_details od
on p.ProductID = od.ProductID
where od.OrderID is null;

/*6. Select customer together with the products that he bought*/

select c.CustomerName , p.ProductName
from customers c
inner join orders o
on c.CustomerID = o.CustomerID
inner join order_details d
on o.OrderID = d.OrderID
inner join products p
on d.ProductID = p.ProductID ;

/*7. Select product names together with the name of corresponding category*/

select p.ProductName , c.CategoryName
from products p
inner join categories c
on p.CategoryID = c.CategoryID ;

/*8. Select orders together with the name of the shipping company*/

select o.OrderID , s.ShipperName
from orders o
inner join shippers s
on o.ShipperID = s.ShipperID ;

/*9. Select customers with id greater than 50 together with each order they made*/

select c.CustomerID ,c.CustomerName , o.OrderID
from customers c
inner join orders o
on c.CustomerID = o.CustomerID
where c.CustomerID > 50 ;

/*10. Select employees together with orders with order id greater than 10400*/

select * from employees e
inner join orders o
on e.EmployeeID = o.EmployeeID
where o.OrderID > 10400 ;

# Another Answer

select e.FirstName , e.LastName , o.OrderID
from employees e
inner join orders o
on e.EmployeeID = o.EmployeeID 
where o.OrderID > 10400 ;

/************ Expert Level ************/

/*1. Select the most expensive product*/

select max(Price) from products;

/*2. Select the second most expensive product*/

select Price
from products
order by Price desc
limit 1 offset 1 ;

# another answer

select Price from products
order by Price desc
limit 1 , 1 ;

/*3. Select name and price of each product, sort the result by price in decreasing order*/

select ProductName , Price
from products
order by Price desc ;

/*4. Select 5 most expensive products*/

select Price 
from products
order by Price desc
limit 5 ;

/*5. Select 5 most expensive products without the most expensive (in final 4 products)*/

select Price 
from products
order by Price desc
limit 4 offset 1;

/*6. Select name of the cheapest product */

select ProductName
from products
order by Price asc
limit 1;

/*7. Select number of employees with LastName that starts with 'D'*/

select count(EmployeeID) 
as number_of_employees
from employees
where LastName
like "D%" ;

/* BONUS : same question for Customer this time */


/*9. Select customer name together with the number of orders made by the corresponding customer 
sort the result by number of orders in decreasing order*/

select c.CustomerName ,count(o.OrderID) as num_of_orders
from customers c
inner join orders o
on c.CustomerID = o.CustomerID
group by c.CustomerName 
order by num_of_orders desc;

/*10. Add up the price of all products*/

select sum(Price) as Price_of_All_Products from products ;

/*11. Select orderID together with the total price of  that Order, order the result by total price of order in increasing order*/

select o.OrderID , sum(p.Price) as total_price
from products p 
inner join order_details d
on p.ProductID = d.ProductID 
inner join orders o
on d.OrderID = o.OrderID
group by o.OrderID
order by total_price asc;

/*12. Select customer who spend the most money*/

select c.CustomerName 
from customers c 
inner join orders o
on c.CustomerID = o.CustomerID
inner join order_details d
on o.OrderID = d.OrderID
inner join products p
on d.ProductID = p.ProductID
group by c.CustomerName
order by   sum(p.Price) desc
limit 1;

/*13. Select customer who spend the most money and lives in Canada*/

select c.CustomerName
from customers c 
inner join orders o
on c.CustomerID = o.CustomerID
inner join order_details d
on o.OrderID = d.OrderID
inner join products p
on d.ProductID = p.ProductID
where c.Country = 'Canada'
group by c.CustomerName
order by sum(p.Price) desc
limit 1;

/*14. Select customer who spend the second most money*/

select c.CustomerName 
from customers c 
inner join orders o
on c.CustomerID = o.CustomerID
inner join order_details d
on o.OrderID = d.OrderID
inner join products p
on d.ProductID = p.ProductID
group by c.CustomerName
order by   sum(p.Price) desc
limit 1 offset 1;

/*15. Select shipper together with the total price of proceed orders*/

select s.ShipperName , sum(p.Price) as total_Price
from shippers s
inner join orders o
on s.ShipperID = o.ShipperID
inner join order_details d
on o.OrderID = d.OrderID
inner join products p
on d.ProductID = p.ProductID
group by s.ShipperName ;
