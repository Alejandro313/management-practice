/*

	Host: kesavan.db.elephantsql.com
	Port: 5432
	BD: kwugovfe
	User: kwugovfe
	Pass: e3SF33nVwgZkZjAOzjT4Bs8MHuWcyfD6
	Url: postgres://kwugovfe:e3SF33nVwgZkZjAOzjT4Bs8MHuWcyfD6@kesavan.db.elephantsql.com/kwugovfe

*/
-- drop database if exists negocioWeb;
-- create database negocioWeb;
-- use negocioWeb;

drop table if exists detalles;
drop table if exists facturas;
drop table if exists clientes;
drop table if exists direcciones;
drop table if exists articulos;

create table direcciones(
	id serial primary key,
	calle varchar(120) not null,
    numero int not null,
    piso varchar(12),
    depto varchar(12),
    torre varchar(12),
    codigoPostal varchar(12) not null,
    ciudad varchar(50) not null default 'CABA',
    provincia varchar(50) default 'CABA',
    pais varchar(50) default 'Argentina'
);



alter table direcciones
	add constraint CK_DireccionesNumero
    check (numero>=0);
 
create table clientes(
	id serial primary key,
    nombre varchar(20) not null,
    apellido varchar(20) not null,
    fenaci date not null,
    tipoDocumento char(4) default 'DNI' not null,
    numeroDocumento char(8) not null,
    telefono varchar(16),
    email varchar(50),
    idDireccion int not null,
    comentarios varchar(255)
);

alter table clientes
	add constraint UQ_ClientesTipoNumero
    unique(tipoDocumento,numeroDocumento);

alter table clientes
	add constraint FK_ClientesDirecciones
    foreign key (idDireccion)
    references direcciones(id);

alter table clientes 
	add constraint CK_ClientesNombre
	check (char_length(nombre)>=2);
    
-- alter table clientes
-- 	add constraint CK_ClientesFenaci
--  check (fenaci <= current_date());

-- insert into direcciones(calle,numero,codigoPostal) values ('Larrea',-1,'1065');
-- select version();

create table articulos(
	id serial primary key,
    nombre varchar(40) not null,
    descripcion varchar(150) not null,
    tipo varchar(25),
    especieRecomendada varchar(25) not null,
    costo float8 not null,
    precio float8 not null,
    stock int not null,
    stockMinimo int not null,
    stockMaximo int not null,
    comentarios varchar(255),
    activo boolean default(true)
);

alter table articulos
	add constraint CK_ArticulosCosto
    check (costo>=0);

alter table articulos
	add constraint CK_ArticulosPrecio
    check (precio>=costo);

alter table articulos
	add constraint CK_ArticulosStock
    check (stock>=0);

alter table articulos
	add constraint CK_ArticulosStockMinimo
    check (stockMinimo>0);

alter table articulos
	add constraint CK_ArticulosStockMaximo
    check (stockMaximo>=stockMinimo);

create table facturas(
	id serial primary key,
    letra char(1) not null,
    numero int not null,
    fecha date not null,
    hora time not null,
	medioPago  varchar(12) default 'EFECTIVO' not null,
    idCliente int not null,
    comentarios varchar(255)
);

alter table facturas
	add constraint FK_Facturas_Clientes
    foreign key(idCliente)
    references clientes(id);
    
alter table facturas 
	add constraint CK_FacturasNumero
    check(numero>0);

alter table facturas
	add constraint UQ_FacturasLetraNumero
    unique(letra,numero);
   
alter table facturas 
	add constraint CK_FacturasMediPago
	check (medioPago in ('EFECTIVO','MERCADOPAGO','TARJETA','DEBITO'));

create table detalles(
	id serial primary key,
    idFactura int not null,
    idArticulo int not null,
    cantidad int not null,
    precioVenta float8 not null
);

alter table detalles
	add constraint FK_Detalles_Facturas
    foreign key(idFactura)
    references facturas(id);

alter table detalles
	add constraint FK_Detalles_Articulos
    foreign key(idArticulo)
    references articulos(id);

alter table detalles
	add constraint UQ_DetallesIdFacturaIdArticulo
    unique(idFactura,idArticulo);

alter table detalles
	add constraint CK_DetallesCantidad
    check (cantidad>0);

alter table detalles
	add constraint CK_DetallesPrecioVenta
    check (precioVenta>=0);

