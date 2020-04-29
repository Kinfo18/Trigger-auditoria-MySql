create database cellphonestore;
use cellphonestore;

drop table if exists distribuidor cascade;
drop table if exists auditoria cascade;
drop table if exists marca cascade;
drop table if exists celular cascade;
drop table if exists caracteristicas cascade;

--------------------------------------------------------------------------------------------------------------------------

create table distribuidor(
	dis_nit integer primary key not null,
	dis_nombre varchar(30),
	dis_direccion varchar(30),
	dis_contacto varchar(20)
);

create table auditoria_distribuidor(
	au_dis_id int primary key auto_increment,
	au_dis_nit_new integer, au_dis_nit_old integer,
    au_dis_nombre_new varchar(30), au_dis_nombre_old varchar(30),
    au_dis_direccion_new varchar(30),  au_dis_direccion_old varchar(30),
    au_dis_contacto_new varchar(20), au_dis_contacto_old varchar(20),
    usuario varchar(90),
    fecha date,
    hora time,
    condicion varchar(100)
);

delimiter %%
create trigger insertar after insert on distribuidor
for each row
begin 
	insert into auditoria_distribuidor(au_dis_nit_new, au_dis_nombre_new, au_dis_direccion_new, au_dis_contacto_new, usuario, fecha, hora, condicion)
    values(new.dis_nit, new.dis_nombre, new.dis_direccion, new.dis_contacto, user(), curdate(), curtime(), 'Insertado');
end %%
delimiter ;

delimiter %%
create trigger actualizar after update on distribuidor
for each row
begin 
	insert into auditoria_distribuidor(au_dis_nit_new,  au_dis_nit_old, au_dis_nombre_new, au_dis_nombre_old, au_dis_direccion_new, au_dis_direccion_old, au_dis_contacto_new, au_dis_contacto_old, usuario, fecha, hora, condicion)
    values(new.dis_nit, old.dis_nit, new.dis_nombre,  old.dis_nombre, new.dis_direccion,  old.dis_direccion, new.dis_contacto,  old.dis_contacto, user(), curdate(), curtime(), 'Actualizado');
end %%
delimiter ;

delimiter %%
create trigger eliminar after delete on distribuidor
for each row
begin    
	insert into auditoria_distribuidor(au_dis_nit_old, au_dis_nombre_old, au_dis_direccion_old, au_dis_contacto_old, usuario, fecha, hora, condicion)
    values(old.dis_nit, old.dis_nombre, old.dis_direccion, old.dis_contacto, user(), curdate(), curtime(), 'Eliminado');
end %%
delimiter ;

--------------------------------------------------------------------------------------------------------------------------
create table caracteristicas(
	car_id integer primary key not null,
    car_procesador varchar(100),
    car_ram varchar(10),
    car_rom varchar(10),
    car_bateria varchar(10)
);

create table auditoria_caracteristicas(
	au_car_cod int primary key auto_increment,
    au_car_id_new integer, au_car_id_old integer,
    au_car_proce_new varchar(100), au_car_proce_old varchar(100),
    au_car_ram_new varchar(10), au_car_ram_old varchar(10),
    au_car_rom_new varchar (10), au_car_rom_old varchar (10),
    au_car_bateria_new varchar(10), au_car_bateria_old varchar(10),
    usuario varchar(90),
    fecha date,
    hora time,
    condicion varchar(100)
);

delimiter %%
create trigger insertar_car after insert on caracteristicas
for each row
begin 
	insert into auditoria_caracteristicas(au_car_id_new, au_car_proce_new, au_car_ram_new, au_car_rom_new, au_car_bateria_new, usuario, fecha, hora, condicion)
    values(new.car_id, new.car_procesador, new.car_ram, new.car_rom, new.car_bateria, user(), curdate(), curtime(), 'Insertado');
end %%
delimiter ;

delimiter %%
create trigger actualizar_car after update on caracteristicas
for each row
begin 
	insert into auditoria_caracteristicas(au_car_id_new, au_car_id_old, au_car_proce_new, au_car_proce_old, au_car_ram_new, au_car_ram_old, au_car_rom_new, au_car_rom_old, au_car_bateria_new, au_car_bateria_old, usuario, fecha, hora, condicion)
    values(new.car_id, old.car_id, new.car_procesador, old.car_procesador, new.car_ram, old.car_ram, new.car_rom, old.car_rom, new.car_bateria, old.car_bateria, user(), curdate(), curtime(), 'Actualizado');
end %%
delimiter ;

delimiter %%
create trigger eliminar_car after delete on caracteristicas
for each row
begin    
	insert into auditoria_caracteristicas(au_car_id_new, au_car_proce_new, au_car_ram_new, au_car_rom_new, au_car_bateria_new, usuario, fecha, hora, condicion)
    values(old.car_id, old.car_procesador, old.car_ram, old.car_rom, old.car_bateria, user(), curdate(), curtime(), 'Eliminado');
end %%
delimiter ;

--------------------------------------------------------------------------------------------------------------------------
create table marca(
	mar_referen integer primary key,
    mar_nombre varchar(30),
    mar_origen varchar(30),
    mar_fecha_fund date,
    dis_nit integer,
    
    foreign key (dis_nit) references distribuidor (dis_nit) on delete cascade on update cascade
);

create table auditoria_marca(
	au_id int primary key auto_increment,
    au_mar_referen_new integer, au_mar_referen_old integer,
    au_mar_nombre_new varchar(30), au_mar_nombre_old varchar(30),
    au_mar_origen_new varchar(30), au_mar_origen_old varchar(30),
    au_mar_fecfun_new date, au_mar_fecfun_old date,
    au_dis_nit_new integer,  au_dis_nit_old integer,
    usuario varchar(90),
    fecha date,
    hora time,
    condicion varchar(100)
);

delimiter %%
create trigger insertar_mar after insert on marca
for each row
begin 
	insert into auditoria_marca(au_mar_referen_new, au_mar_nombre_new, au_mar_origen_new, au_mar_fecfun_new, au_dis_nit_new, usuario, fecha, hora, condicion)
    values(new.mar_referen, new.mar_nombre, new.mar_origen, new.mar_fecha_fund, new.dis_nit, user(), curdate(), curtime(), 'Insertado');
end %%
delimiter ;

delimiter %%
create trigger actualizar_mar after update on marca
for each row
begin 
	insert into auditoria_marca(au_mar_referen_new, au_mar_referen_old, au_mar_nombre_new, au_mar_nombre_old, au_mar_origen_new, au_mar_origen_old, au_mar_fecfun_new, au_mar_fecfun_old, au_dis_nit_new,  au_dis_nit_old,  usuario, fecha, hora, condicion)
    values(new.mar_referen, old.mar_referen, new.mar_nombre, old.mar_nombre, new.mar_origen, old.mar_origen, new.mar_fecha_fund, old.mar_fecha_fund, new.dis_nit, old.dis_nit, user(), curdate(), curtime(), 'Actualizado');
end %%
delimiter ;

delimiter %%
create trigger eliminar_mar after delete on marca
for each row
begin    
	insert into auditoria_marca(au_mar_referen_new, au_mar_nombre_new, au_mar_origen_new, au_mar_fecfun_new, au_dis_nit_new, usuario, fecha, hora, condicion)
    values(old.mar_referen,old.mar_nombre,old.mar_origen,old.mar_fecha_fund,old.dis_nit, user(), curdate(), curtime(), 'Eliminado');
end %%
delimiter ;

--------------------------------------------------------------------------------------------------------------------------
create table celular(
	cel_imei integer primary key,
    cel_modelo varchar(50),
    cel_precio float,
    cel_cantidad int,
    mar_referen integer,
    car_id integer,
    
    foreign key (mar_referen) references marca (mar_referen) on delete cascade on update cascade,
    foreign key (car_id) references caracteristicas (car_id) on delete cascade on update cascade
);

drop trigger actualizar_cel
drop table auditoria_celular
create table auditoria_celular(
	au_cel int primary key auto_increment,
    au_cel_imei_new integer, au_cel_imei_old integer,
    au_cel_modelo_new varchar(50), au_cel_modelo_old varchar(50),
    au_cel_precio_new float, au_cel_precio_old float,
	au_cel_cantidad_new int, au_cel_cantidad_old int,
    au_mar_referen_new integer, au_mar_referen_old integer,
	au_car_id_new integer, au_car_id_old integer,
    usuario varchar(90),
    fecha date,
    hora time,
    condicion varchar(100)
);

delimiter %%
create trigger insertar_cel after insert on celular
for each row
begin 
	insert into auditoria_celular(au_cel_imei_new, au_cel_modelo_new, au_cel_precio_new, au_cel_cantidad_new, au_mar_referen_new, au_car_id_new, usuario, fecha, hora, condicion)
    values(new.cel_imei, new.cel_modelo, new.cel_precio, new.cel_cantidad, new.mar_referen, new.car_id, user(), curdate(), curtime(), 'Insertado');
end %%
delimiter ;

delimiter %%
create trigger actualizar_cel after update on celular
for each row
begin 
	insert into auditoria_celular(au_cel_imei_new, au_cel_imei_old, au_cel_modelo_new, au_cel_modelo_old, au_cel_precio_new, au_cel_precio_old, au_cel_cantidad_new, au_cel_cantidad_old, au_mar_referen_new, au_mar_referen_old, au_car_id_new, au_car_id_old, usuario, fecha, hora, condicion)
    values(new.cel_imei, old.cel_imei, new.cel_modelo, old.cel_modelo, new.cel_precio, old.cel_precio, new.cel_cantidad, old.cel_cantidad, new.mar_referen, old.mar_referen, new.car_id, old.car_id, user(), curdate(), curtime(), 'Actualizado');
end %%
delimiter ;

delimiter %%
create trigger eliminar_cel after delete on celular
for each row
begin    
	insert into auditoria_celular(au_cel_imei_new, au_cel_modelo_new, au_cel_precio_new, au_cel_cantidad_new, au_mar_referen_new, au_car_id_new, usuario, fecha, hora, condicion)
    values(old.cel_imei, old.cel_modelo, old.cel_precio, old.cel_cantidad, old.mar_referen, old.car_id, user(), curdate(), curtime(), 'Eliminado');
end %%
delimiter ;

create table ventas(
	ven_id integer primary key,
    ven_precio float,
    ven_cantidad int
);
--------------------------------------------------------------------------------------------------------------------------
insert into distribuidor
values
(485035372, 'Xiaomi Mi Home', 'Carrera 66 calle 24a', '902 220 250'),
(830028931, 'Samsung Electronics', 'Carrera 7 # 113 - 43', '01 8000 112 112'),
(845068451, 'Huawei Technologies', 'Carrera 68 A 24 B 10', '(1)3768600');

update distribuidor
set dis_nombre = 'Xiaomi Mi'
where dis_nit  = 485035372;

delete 
from distribuidor
where dis_nit  = 485035372;

insert into caracteristicas
values
( 1001, '"Kirin 740 2,3GHz', '4GB', '64GB', '3750mAh'),
( 1002, 'Qualcomm Snapdragon 630 1.8GHz', '4GB', '64GB', '4000mAh'),
( 1003, '"Kirin 710 2,2GHz', '4GB', '64GB', '4000mAh');

update caracteristicas
set car_ram = '3GB', car_rom = '32GB'
where car_id  = 1002;

delete 
from caracteristicas
where car_id  = 1002;

insert into marca
values
( 2001, 'Xiaomi', 'China', '2010-06-01', 485035372),
( 2002, 'Samsung s.a.s', 'Corea del Sur','1983-07-01', 830028931),
( 2003, 'Huawei s.a', 'China', '2006-10-01', 845068451);

update marca
set mar_fecha_fund = '1995-01-29'
where mar_referen  = 2001;

delete 
from marca
where mar_referen = 2003;

insert into celular
values
( 1234556,'Redmi note 5', 400000, 43,2001, 1002),
( 1324513,'Mate p20', 605000, 56,2003, 1001),
( 1315264, 'Y9 2019', 760000, 2,2003, 1003),
( 4653757, 'Samsung Galaxy Note A30', 1900000, 45,2002, 1002);

--------------------------------------------------------------------------------------------------------------------------

delimiter %%
create trigger ventas after insert on ventas
for each row
begin 
	update celular
    set celular.cel_cantidad = cel_cantidad - new.ven_cantidad
    where celular.cel_imei = new.ven_id;
end %%
delimiter ;

insert into ventas values (1315264, 760000, 1);
