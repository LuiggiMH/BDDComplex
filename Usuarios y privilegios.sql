/*USUARIOS Y PRIVILEGIOS*/
use mysql;

select user from user;


select user, password from user;
create user 'bibliotecario1'@'localhost' identified by '202312';


/*asignamos privilegios*/
grant select, insert, update on biblioteca.usuario to 'bibliotecario1'@'localhost';

create user 'admin_biblioteca'@'localhost' identified by '202312';

/*asignamos privilegios en toda la base y puede asignar privilegios a otros usuarios*/
grant all privileges on biblioteca.* to 'admin_biblioteca'@'localhost' with grant option;

create user 'bibliotecario2'@'localhost' identified by '202312';

revoke update on biblioteca.usuario from 'bibliotecario1'@'localhost';

/*conocer que privilegios tiene bibliotecario2*/
show grants for 'bibliotecario2'@'localhost';