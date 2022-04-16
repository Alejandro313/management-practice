show databases;
drop database if exists negocioweb;
create database negocioweb;
use negocioweb;
show tables;

drop table if exists articulos;

/*
create table articulos(
	id int auto_increment primary key,
    nombre varchar(40) not null,
    descripcion varchar(150) not null,
    tipo enum('PRENDA','JUGUETE','ALIMENTO','SNACK','ACCESORIO','CORREAS','MEDICAMENTO'),
    especieRecomendada enum('CANINO','FELINO','AVE','PEZ','ROEDOR') not null,
    costo double not null,
    precio double not null,
    stock int not null,
    stockMinimo int not null,
    stockMaximo int not null,
    comentarios varchar(255),
    activo boolean default(true)
);
*/

select * from articulos;

-- *********************************************
-- *****************| INSERT |******************
-- *********************************************
drop procedure if exists SP_Articulos_Insert;
delimiter //
create procedure SP_Articulos_Insert(in 
		p_nombre varchar(20), 
        p_descripcion varchar(50),
		p_tipo enum('PRENDA','JUGUETE','ALIMENTO','SNACK','ACCESORIO','CORREAS','MEDICAMENTO'),
		p_especieRecomendada enum('CANINO','FELINO','AVE','PEZ','ROEDOR'),
        p_costo double,
        p_precio double,
        p_stock int,
        p_stockMinimo int,
        p_stockMaximo int,
        p_comentarios varchar(50),
        p_activo boolean
)
begin
		insert into articulos (nombre,descripcion,tipo,especieRecomendada,costo,precio,stock,stockMinimo,stockMaximo,comentarios,activo) 
		 	values 
            (p_nombre,p_descripcion,p_tipo,p_especieRecomendada,p_costo,p_precio,p_stock,p_stockMinimo,p_stockMaximo,p_comentarios,p_activo);
    end;
// delimiter ;

call SP_Articulos_Insert("CatShow","pollo",'ALIMENTO','FELINO',800,1200,7,2,20,null,true);
call SP_Articulos_Insert("Pedigree","Carne",'ALIMENTO','CANINO',900,1400,7,2,20,null,true);
call SP_Articulos_Insert("Collar","Azul",'ACCESORIO','CANINO',300,500,10,3,20,null,true);
select * from articulos;

-- *********************************************
-- *****************| TEST |******************
-- *********************************************
drop procedure if exists SP_testArticulos;
delimiter //
create procedure SP_testArticulos(in 
		id int,
        nombre varchar(20), 
        descripcion varchar(50),
		tipo enum('PRENDA','JUGUETE','ALIMENTO','SNACK','ACCESORIO','CORREAS','MEDICAMENTO'),
		especieRecomendada enum('CANINO','FELINO','AVE','PEZ','ROEDOR'),
        costo double,
        precio double,
        stock int,
        stockMinimo int,
        stockMaximo int,
        comentarios varchar(50),
        activo boolean)
	begin
		select id,nombre,descripcion,tipo,especieRecomendada,costo,precio,stock,stockMinimo,stockMaximo,comentarios,activo;
    end;
// delimiter ;

call SP_testArticulos(1,"CatShow","Carne",'ALIMENTO','FELINO',800,1200,7,2,20,null,true);
call SP_testArticulos(2,"Pedigree","Carne",'ALIMENTO','CANINO',900,1400,7,2,20,null,true);

-- *********************************************
-- *****************| UPDATE |******************
-- *********************************************
drop procedure if exists SP_Articulos_Update;

delimiter //
create procedure SP_Articulos_Update(in 
		P_id int,
		p_nombre varchar(20), 
        p_descripcion varchar(50),
		p_tipo enum('PRENDA','JUGUETE','ALIMENTO','SNACK','ACCESORIO','CORREAS','MEDICAMENTO'),
		p_especieRecomendada enum('CANINO','FELINO','AVE','PEZ','ROEDOR'),
        p_costo double,
        p_precio double,
        p_stock int,
        p_stockMinimo int,
        p_stockMaximo int,
        p_comentarios varchar(50),
        p_activo boolean
        )
	begin
		update articulos set nombre=p_nombre, descripcion=p_descripcion, tipo=p_tipo, especieRecomendada=p_especieRecomendada, 
			costo=p_costo, precio=p_precio, stock=p_stock, stockMinimo=p_stockMinimo,stockMaximo=p_stockMaximo, comentarios=p_comentarios,activo=p_activo
            where id=P_id;
		end;
// delimiter ;

call SP_Articulos_Update(
		1,
        (select nombre from articulos where id=1),
		(select descripcion from articulos where id=1),
        (select tipo from articulos where id=1),
		(select especieRecomendada from articulos where id=1),
        (select costo from articulos where id=1),
        (select precio from articulos where id=1),
        5,
        (select stockMinimo from articulos where id=1),
        (select stockMaximo from articulos where id=1),
        (select comentarios from articulos where id=1),
        (select activo from articulos where id=1)
);

select * from articulos;

-- *********************************************
-- *****************| DELETE |******************
-- *********************************************

drop procedure if exists SP_Articulos_Delete;

delimiter //
create procedure SP_Articulos_Delete(in P_id int)
	begin
		delete from articulos where id=P_id;
    end;
// delimiter ;

select * from articulos;

call SP_Articulos_Delete(3);