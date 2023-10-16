/* USUARIOS Y PRIVILEGIOS */

/* Usuario Alumno */
create user 'Alumno'@'universidad' identified by '12345';
grant select, update on universidad.alumno to 'Alumno'@'universidad';
show grants for 'Alumno'@'universidad';

/* Usuario Profesor */
create user 'Profesor'@'universidad' identified by 'prof123';
grant select, insert, update on universidad.profesor to 'Profesor'@'universidad';
grant select, insert, update on universidad.notas to 'Profesor'@'universidad';
show grants for 'Profesor'@'universidad';

/* Usuario Administrador */
create user 'Administrador'@'universidad' identified by 'Admin';
grant all privileges on universidad.* to 'Administrador'@'universidad' with grant option;
show grants for 'Administrador'@'universidad';

/* INDICES */

/* indice que muestre las asignaturas que tienen numero de creditos de 3 */

select nombre as 'Asignatura'
from asignatura
where num_creditos='3';

create index idx_creditos on asignatura (num_creditos);

show index from asignatura;