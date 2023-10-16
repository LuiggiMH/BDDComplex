create database biblioteca;
use biblioteca;

create table autor(
codigo varchar(10) not null,
nombre varchar(45) not null,
apellido varchar(45) not null,
constraint primary key (codigo)
)engine=InnoDB;

create table libro(
id int not null auto_increment,
codigo varchar(5) not null,
isbn int unique,
titulo varchar(45) not null,
editorial varchar(45) not null,
paginas int unsigned,
check (paginas>=200),
constraint primary key (id, codigo)
)engine=InnoDB;

create table usuario(
id int not null auto_increment,
codigo varchar(10) not null,
nombre varchar(45) not null,
apellido varchar(45) not null,
direccion varchar(45) not null,
telefono varchar(10) not null,
tipo enum ('Estudiante', 'Administrativo', 'Docente', 'Externo') default 'Estudiante',
constraint primary key (id, codigo)
)engine=InnoDB;

create table ejemplar(
codigo varchar(5) not null,
id_libro int,
codigo_libro varchar(5),
localización varchar(30),
constraint primary key (codigo, id_libro, codigo_libro),
constraint fk_id_libro foreign key (id_libro, codigo_libro) references libro(id, codigo)
on update cascade on delete restrict
)engine=InnoDB;

create table ficha_libro(
codigo_autor varchar(10) not null,
id_libro int not null,
codigo_libro varchar(5) not null,
genero varchar(20),
constraint primary key (codigo_autor, id_libro, codigo_libro),
constraint fk_codigo_autor foreign key (codigo_autor) references autor(codigo)
on update cascade on delete restrict,
constraint fk_libro foreign key (id_libro, codigo_libro) references libro(id,codigo)
on update cascade on delete restrict
)engine=InnoDB;

create table prestamo(
id int not null auto_increment,
id_usuario int not null,
codigo_usuario varchar (10) not null,
codigo_ejemplar varchar (5) not null,
fecha_prestamo date not null,
fecha_devolucion date,
dias_transcurridos int generated always as(datediff(fecha_devolucion, fecha_prestamo)) stored,
constraint primary key (id, id_usuario, codigo_usuario, codigo_ejemplar),
constraint fk_usuario foreign key (id_usuario, codigo_usuario) references usuario(id,codigo)
on update cascade on delete restrict,
constraint fk_ejemplar foreign key (codigo_ejemplar) references ejemplar(codigo)
on update cascade on delete restrict
)engine=InnoDB;

insert into autor (codigo, nombre, apellido) values('A100', 'Isabel', 'Allende');

