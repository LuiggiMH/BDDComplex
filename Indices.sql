/*INDICES*/
use northwind;
show indexes from orders;
select* from orders;
show indexes from customers;
/*Mostrar el nombre del cliente, fecha de pedido de los pedidos que fueron enviados en la embarcacion 'Hanari Carnes'*/
/*SIN INDICE RECORRE 97 FILAS Y CON INDICE 15 FILAS*/
EXPLAIN
select c.CompanyName, o.OrderDate
from orders o
inner join customers c
on o.CustomerID=c.CustomerID
where o.ShipName='Hanari Carnes';

create index idx_ShipName on orders(ShipName);
