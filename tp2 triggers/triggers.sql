-- show databases;
use negocioweb;
show tables;
select * from articulos;

-- *********************************************
-- ************| CONTROL DE TABLAS |************
-- *********************************************
drop table if exists control_tablas;

create table control_tablas(
	id int auto_increment primary key,
    tabla varchar(30) not null,
    accion enum('insert','delete','update') not null,
    fecha date not null,
    hora time not null,
    usuario varchar(20),
    terminal varchar(100),
    idRegistro int not null
);

-- *********************************************
-- *****************| INSERT |******************
-- *********************************************
drop trigger if exists TR_Articulos_Insert;

delimiter //
create trigger TR_Articulos_Insert
	after insert
    on articulos for each row
    begin
		insert into control_tablas (tabla,accion,fecha,hora,usuario,terminal,idRegistro) 
        values 
        ('articulos','insert',current_date(),current_time(),current_user(), 
			(select user()),new.id);
    end;
// delimiter ;

-- *********************************************
-- *****************| UPDATE |******************
-- *********************************************
drop trigger if exists TR_Articulos_Update;

delimiter //
create trigger TR_Articulos_Update
	after update
    on articulos for each row
    begin
		insert into control_tablas (tabla,accion,fecha,hora,usuario,terminal,idRegistro) 
        values 
        ('articulos','update',current_date(),current_time(),current_user(), 
			(select user()),new.id);
    end;
// delimiter ;

-- *********************************************
-- ******************| DELETE |*******************
-- *********************************************
drop table if exists TR_Articulos_Delete;

delimiter //
create trigger TR_Articulos_Delete
	after delete
    on articulos for each row
    begin
		insert into control_tablas (tabla,accion,fecha,hora,usuario,terminal,idRegistro) 
        values 
        ('articulos','delete',current_date(),current_time(),current_user(), 
			(select user()),old.id);
    end;
// delimiter ;

-- *********************************************
-- ******************| TEST |*******************
-- *********************************************
call SP_Articulos_Insert('Pedigree','Carne','PRENDA','CANINO',400,800,10,5,15,'sin',true);
UPDATE articulos SET descripcion = "pescado", stock="5" WHERE id = 4; 
call SP_Articulos_Delete(4);
select * from control_tablas;
select * from articulos;
show databases;