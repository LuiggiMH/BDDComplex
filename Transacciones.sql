use biblioteca;

/*CREAR LA TABLA EMPLEADO EN BIBLIOTECA EL CAMPO TOTAL SALARIO= SALARIO+COMISION*/

create table empleado(
id int not null auto_increment,
ci varchar(10) not null,
nombre varchar(30) not null,
apellido varchar(30) not null,
salario decimal(6,2),
comision int,
total_salario decimal(10,2) generated always as(salario+(salario*comision/100)) stored,
constraint primary key(id)
)engine=InnoDB;

select* from empleado;

show variables like'%autocommit%';
set autocommit=0;

/*ACTUALIZAR LA COMISION A 10 DEL EMPLEADO CON ID=2 */
start transaction;
update empleado set comision=10 where id=2;
commit;
/*rollback;*/

/*TRANSACCION DENTRO DE UN PROCEDIMIENTO ALMACENADO*/
DELIMITER $$
CREATE PROCEDURE cambio_comisiones(in codigo_empleado int, in comision_empleado int)
BEGIN
	start transaction;
    if exists(select* from empleado where id=codigo_empleado) then 
		if comision_empleado<=10 then
        update empleado set comision=comision_empleado where id=codigo_empleado;
		commit;
        end if;
	else
		select 'Codigo del empleado incorrecto'as 'mensaje';
        rollback;
	end if;
	
end $$
DELIMITER ;

call cambio_comisiones(2,8);

call cambio_comisiones(3,10);