use northwind;

/*1.Mostrar el nombre completo de los empleados que son Representantes de Ventas.*/
select* from employees;
select concat(LastName, FirstName) as 'Nombre empleado' 
from employees
where Title='Sales Representative';

/*2.Mostrar el nombre del producto y la cantidad por unidad, del producto con el precio más alto*/
select* from products;

select ProductName as 'Producto', QuantityPerUnit 'Cantidad por unidad', UnitPrice
from products
where UnitPrice= (select max(UnitPrice)from products) ;

/*3.Se desea conocer el nombre del proveedor que suministra el producto que tiene más unidades en stock que el producto "Konbu".*/
select * from products;
select *from suppliers;

select s.CompanyName
from products p
inner join suppliers s 
on p.SupplierId=s.SupplierId
where p.UnitsInStock > (select UnitsInStock from products where ProductName='Konbu');

/*4.Mostrar el nombre del producto, el nombre y dirección del proveedor, además de la categoría a la que pertenecen los productos cuya medida está dada en kg.*/

/*5.Generar un reporte con el nombre de producto, el precio unitario y las cantidades en stock, de todos los productos que se vengan de USA.*/

/*6.Mostrar la categoría del producto con el id 33 */
select c.CategoryName
from categories c
inner join products p
on c.CategoryID=p.CategoryID
where p.ProductID= 33;

/*7.Generar un reporte que muestre el nombre del proveedor y cuántos productos suministra.  */
select s.CompanyName, count(*) as '# Productos'
from products p
inner join suppliers s
on p.SupplierID= s.SupplierID
group by s.CompanyName;

/*8.Mostrar el nombre del proveedor de los productos con menos unidades en stock.*/
select s.CompanyName
from suppliers s
inner join products p
on p.SupplierID= s.SupplierID
where p.UnitsInStock= (select min(UnitsInStock)from products);

/*9.Se desea conocer la fecha del envío, el código del empleado y el nombre del cliente del pedido 10607.*/
select o.ShippedDate, e.EmployeeID, c.CompanyName
from employees e
inner join orders o
on e.EmployeeID=o.EmployeeID
inner join customers c
on o.CustomerID=c.CustomerID
where o.OrderID=10607;

/*10.Mostrar el número de pedidos atendidos por empleado.*/
select e.FirstName, e.LastName, count(o.OrderId)
from employees e
inner join orders o
on e.EmployeeID= o.EmployeeID
group by o.EmployeeID;
/*TRIGGERS*/
/*11.Crear un trigger que lleve un registro de los datos actualizados en la tabla usuario de la base de datos biblioteca.*/
use biblioteca_complexivo;
select * from biblioteca_complexivo.usuario;
select * from biblioteca_complexivo.log_usuario;

create table log_usuario(
codigo_antiguo varchar(10),
nombre_antiguo varchar(45),
direccion_antiguo varchar (45),
codigo_nuevo varchar(10),
nombre_nuevo varchar(45),
direccion_nuevo varchar (45),
fecha_actualizacion timestamp default current_timestamp,
usuario varchar(30)
);

/*creamos el trigger*/
DELIMITER $$
create trigger tr_control_usuario
	after update  on usuario
	for each row
	begin 
		insert into log_usuario(codigo_antiguo,nombre_antiguo,direccion_antiguo,
		codigo_nuevo,nombre_nuevo, direccion_nuevo,usuario)
		values(old.codigo, concat(old.nombre, " ", old.apellido), old.direccion,
		new.codigo, concat(new.nombre, " ", new.apellido), new.direccion, current_user());
	end $$
DELIMITER ;



/*12.Crear un trigger que cada vez que se inserte un nuevo préstamo y la fecha de devolución sea nulo escriba ‘Pendiente de entrega’.*/
select*from biblioteca_complexivo.prestamo;
select*from biblioteca_complexivo.libro;
select*from biblioteca_complexivo.ejemplar;
select*from biblioteca_complexivo.usuario;

alter table prestamo add column estado varchar(30)

DELIMITER $$
create trigger tr_control_prestamo
	before insert  on prestamo
	for each row
	begin 
		if new.fecha_devolucion is null then set new.estado='Pendiente de entrega';
        end if ;
	end $$
DELIMITER ;


/*13.Trigger que controle que todos los pedidos que tengan una cantidad de productos superior a 10 reciban un descuento del 2% de manera automática.*/

/*14.Crear un procedimiento almacenado (ejercicio1) que a partir del código de un Pedido me muestre el id del cliente, la fecha de envío y la ciudad de envío, en caso de no existir en número de pedido me muestre una alerta que el número de pedido no existe.*/

/*15.Crear un procedimiento almacenado que a partir del código del pedido liste los productos y la cantidad adquirida por producto.*/

/*16.Crear un procedimiento almacenado que a partir de código de pedido muestre el total a pagar más iva.*/

