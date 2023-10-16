/*VISTAS*/
use northwind;
/*MOSTRAR EL NOMBRE DE LOS EMPLEADOS, EL TIEMPO DE SERVICIO Y EL SALARIO*/

create view vista_empleados as
	select concat(FirstName, "", LastName) as 'Empleado',
    timestampdiff(year,HireDate, curdate()) as 'Servicio',
    Salary as 'Salario'
    from employees;
    
select * from vista_empleados;

/*DE LA TABLA VIRTUAL EMPLEADOS, MOSTRAR EL SALARIO Y TIEMPO DE SERVICIO DEL EMPLEADO
NANCY DAVOLIO*/

select Salario, Servicio
from vista_empleados
where Empleado like '%Nancy%';

/*Mostrar nombre completo y tipo del usuario, el número de prestamos realizados, el total de número de 
días transacurridos, si el número de prestamos supera los 10 y el total de número de días transacurridos
es menor a 20, mostrar el mensaje de observación 'Bonificación' para todos los demás casos mostrar 
'Ninguno'*/
use biblioteca; 

create view vista_usuario as
select concat(u.nombre, " ", apellido) as 'Usuario', u.tipo as 'Tipo usuario',
count(p.id_usuario) as '# prestamos', sum(p.dias_trasncurridos) as 'Dias transcurridos',
(case
	when  count(p.id_usuario)>3 and sum(p.dias_trasncurridos)<5 then 'bonificacion'
	else 'ninguno'
end
)as 'Observacion'
from usuario u
inner join prestamo p
on u.id=p.id_usuario and u.codigo=p.codigo_usuario
group by p.id_usuario;

select* from vista_usuario;
