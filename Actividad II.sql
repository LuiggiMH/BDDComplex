/* TRIGGERS */
/* Crear un trigger que cada vez que se actualice el numero de creditos de una asignatura y es 0 los prerequisitos se vuelvan nulos*/

DELIMITER $$
create trigger tr_act_prerequisitos
before update on asignatura
for each row
begin
if new.num_creditos='0' then set new.prerequisitos= null;
end if;
end $$
DELIMITER ;

drop trigger tr_act_prerequisitos;
select * from universidad.asignatura;


/* Crear un trigger el cual indique que si la nota final es igual o mayorque 7 en estado indique Aprobado caso contrario Reprobado*/

alter table notas add column estado varchar(30);

DELIMITER $$
create trigger tr_estado_notas
before insert on notas
for each row
begin
if new.nota_final>='7' then set new.estado= 'Aprobado';
elseif
new.nota_final<'7' then set new.estado='Reprobado';
end if;
end $$
DELIMITER ;

/* PROCEDIMIENTOS ALMACENADOS */
/* Crear un procedimiento almacenado que a partir del código del departamento liste sus asignaturas.*/
DELIMITER $$
CREATE PROCEDURE sp_listaaAsignatura(in codigo_departamento int)
BEGIN
	SELECT a.nombre
    FROM asignatura a 
    inner join `departamento` d
    on d.id=a.id_departamento
    where codigo_departamento= a.id_departamento;
END $$
DELIMITER ;

call sp_listaaAsignatura (2);

/* Crear un procedimiento que nos muestre el nombre y apellido de los estudiantes de acuerdo al genero*/

DELIMITER $$
create procedure mostrarEstudiantes(generoprod enum('Masculino', 'Femenino'))
BEGIN
select concat (nombre, ' ', apellido) as 'Nombre Completo'
from alumno
where generoprod = genero;
END;

call mostrarEstudiantes ('Femenino');

/* Crear un procedimiento almacenado que muestre el número de provincias de acuerdo al codigo de territorio. */

DELIMITER $$
create procedure numMaterias (materias int)
BEGIN
select count(*) as 'Numero de materias'
from asignatura
where id_profesor=materias
group by id_profesor;
END;

call numMaterias (1);

/* VISTAS */

/* Crear una vista que permita ver el codigo y el nombre de la asignatura de cada profesor */

create view vistaProfesores
as
select a.codigo as Codigo, a.nombre as Asignatura, concat(p.nombre, ' ', p.apellido) as Profesor
from asignatura a
inner join profesor p
on a.id_profesor=p.id;

select * from vistaProfesores;

/* Crear una vista que muestre las asignaturas  del departamento de Ciencias Literarias. */

create view vistaDepartamentos
as
select a.nombre as Nombre_Asignatura
from asignatura a
inner join departamento d
on a.id_departamento=d.id
where d.nombre='Ciencias Literarias';

select *from vistaDepartamentos;

/* Crear una vista que muestre el nombre del alumno, la asignatura y su nota final */

create view vistaNotas
as
select concat(a.nombre, ' ', a.apellido) as Nombre, m.nombre as Asignatura, n.nota_final as Nota
from alumno as a
inner join notas n
on a.id=n.id_alumno
inner join asignatura m
on m.codigo=n.codigo_asignatura
where nota_final>=7;

select *from vistaNotas;