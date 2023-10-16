select *from biblioteca.usuario;

/*11.	Crear un trigger que lleve un registro de los datos actualizados en la tabla usuario de la base de datos biblioteca.*/
use biblioteca;

create table log_usuario(
codigo_antiguo varchar(10),
nombre_antiguo varchar(45),
direccion_antiguo varchar(45),
codigo_nuevo varchar(10),
nombre_nuevo varchar(45),
direccion_nuevo varchar(45),
fecha_actualizacion timestamp default current_timestamp,
usuario varchar(30)
)engine=InnoDB;

DELIMITER $$
create trigger tr_control_usuario
after update on usuario
for each row
begin
insert into log_usuario(codigo_antiguo, nombre_antiguo, direccion_antiguo, codigo_nuevo, nombre_nuevo, direccion_nuevo, usuario)
values (old.codigo, concat(old.nombre, " ", old.apellido), old.direccion,
new.codigo, concat(new.nombre, " ", new.apellido), new.direccion, current_user());
end $$
DELIMITER ;

/*12.	Crear un trigger que cada vez que se inserte un nuevo préstamo y la fecha de devolución sea nulo escriba ‘Pendiente de entrega’.*/
select *from biblioteca.prestamo;
alter table prestamo add column estado varchar(30);

DELIMITER $$
create trigger tr_control_prestamo
before insert on prestamo
for each row
begin
if new.fecha_devolucion is null then set new.estado='Pendiente Entrega';
end if;
end $$
DELIMITER ;

select *from biblioteca.libro;
select *from biblioteca.ejemplar;
drop trigger tr_control_prestamo;