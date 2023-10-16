create database universidad;
use universidad;

create table alumno(
id int not null auto_increment,
niu int not null,
nombre varchar(45) not null,
apellido varchar(45) not null,
cedula int not null,
edad int not null,
genero enum('Masculino', 'Femenino') not null,
constraint primary key (id, niu)
)engine=InnoDB;

create table departamento(
id int not null auto_increment,
nombre varchar(45) not null,
constraint primary key (id)
)engine=InnoDB;

create table profesor(
id int not null auto_increment,
id_departamento int not null,
nombre varchar(45) not null,
apellido varchar(45) not null,
cedula int not null,
edad int not null,
genero enum('Masculino', 'Femenino') not null,
constraint primary key (id, id_departamento),
constraint fk_id_departamento foreign key (id_departamento) references departamento(id)
on update cascade on delete restrict
)engine=InnoDB;

create table asignatura(
codigo int not null auto_increment,
id_profesor int not null,
id_departamento int not null,
nombre varchar(45) not null,
num_creditos int not null,
descripcion varchar(45) not null,
prerequisitos int not null,
constraint primary key (codigo, id_profesor, id_departamento),
constraint fk_id_profesor foreign key (id_profesor) references profesor(id)
on update cascade on delete restrict,
constraint fk_departamento foreign key (id_departamento) references departamento(id)
on update cascade on delete restrict,
constraint fk_requisitos foreign key (prerequisitos) references asignatura(codigo)
on update cascade on delete restrict
)engine=InnoDB;

create table notas(
id_alumno int not null,
niu_alumno int not null,
codigo_asignatura int not null,
nota_final int not null,
constraint primary key (id_alumno, niu_alumno, codigo_asignatura),
constraint fk_alumno foreign key (id_alumno, niu_alumno) references alumno(id,niu)
on update cascade on delete restrict,
constraint fk_cod_asignatura foreign key (codigo_asignatura ) references asignatura(codigo)
on update cascade on delete restrict
)engine=InnoDB;