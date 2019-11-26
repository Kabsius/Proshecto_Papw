DROP DATABASE esausPapw;

CREATE DATABASE esausPapw;

-- Preguntar el detalle de como hacer lo de borrador. 

USE esausPapw;

-- select* from usuario;

	

CREATE TABLE USUARIO(
id_Usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre varchar(255) not null,
apellidoP varchar (255) not null,
apellidoM varchar (255) not null,
correo varchar(255) not null unique,
telefono int(80) not null unique,
celular int (80) not null unique,

nombreUsuario varchar(255) not null unique,
passwordUsuario varchar (255) not null,

imagen_usuario mediumblob,

presupuesto int (80) default 0,
nivel int (2) not null 
);



CREATE TABLE CATEGORIA(
id_categoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
categoria varchar(255) not null unique
);

CREATE TABLE PRODUCTO(
id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_categoria int,
id_usuario int,
nombre_producto varchar (255) not null,
cantidad int(80) not null,
precio float not null,
oferta float,
video varchar(500),
imagen mediumblob,
imagen2 mediumblob,
imagen3 mediumblob, 

descripcion varchar(255) not null,
p_fecha datetime default now(),
valoracion float default 0,
activo tinyint default 1,
Foreign key(id_categoria) references CATEGORIA (id_categoria),
Foreign key(id_usuario) references USUARIO (id_usuario)
);




Create table COMENTARIO(
id_comentario int not null auto_increment primary key,
id_usuario int,
id_producto int,
comentario varchar(255) not null,
coment_date datetime not null,
foreign key (id_usuario) REFERENCES USUARIO (id_usuario),
foreign key (id_producto) REFERENCES PRODUCTO(id_producto)
);


CREATE TABLE HISTORIAL(
id_historial int not null auto_increment primary key,
id_usuario int,
precio float not null,
producto_comprado varchar(255) not  null,
cantidad int (80) not null,
fecha_compra datetime not null,

FOREIGN KEY (id_usuario) REFERENCES USUARIO (id_usuario)
);


CREATE TABLE CARRITO(
id_carrito int not null auto_increment primary key,
usuario int not null,
fecha_compra datetime not null,
estatus int,
formaPafo varchar(45) default "Tarjeta de credito",
FOREIGN KEY (usuario) REFERENCES USUARIO (id_Usuario)
);

CREATE TABLE DetalleCarrito
(
	id int not null auto_increment primary key,
    carrito int not null,
    producto int,
    cantidad int,
    precio double,
    FOREIGN KEY (carrito) REFERENCES CARRITO(id_carrito),
    foreign key (producto) REFERENCES PRODUCTO(id_producto)
);




CREATE VIEW coment as
select producto.id_producto, producto.nombre_producto, producto.cantidad, producto.precio, producto.video , producto.imagen , 
producto.imagen2, producto.imagen3, producto.oferta, producto.valoracion, producto.descripcion, producto.p_fecha,
categoria.categoria, categoria.id_categoria 
from producto
inner join categoria on producto.id_categoria= categoria.id_categoria;   
describe usuario;
-- Call Agre_usua('joe','asdfasf', 'afasd', 'sdfasa@afasdf.com','8154','5485', 'Casa','1184','',10,'0')

select * from comentario;


DROP PROCEDURE Agre_usua
-- Stores de agregado
Delimiter //
Create Procedure Agre_usua(
in Snombre varchar(255), in SapellidoP varchar(255), in SapellidoM varchar(255), in Scorreo varchar(255), in Stelefono int(80),
in Scelular int(80), in SnombreUsuario varchar(255), in SpasswordUsuario varchar(255),in Simagen_usuario mediumblob)
begin
insert into USUARIO (nombre, apellidoP, apellidoM, correo, telefono, celular, nombreUsuario, passwordUsuario, imagen_usuario, presupuesto, nivel)
value
(Snombre , SapellidoP , SapellidoM ,  Scorreo,  Stelefono, Scelular , SnombreUsuario, SHA2(SpasswordUsuario,256), Simagen_usuario, 0, 2);
end;
//
-- call Agre_prod(1, 1, "oxxo", 999, 125.5, 116, '', '', '', '',"Esto es una detallada descripcion del asunto");
 
 -- describe usuario;

Delimiter //
Create Procedure  Agre_prod( 
in sid_usuario int (11) , in sid_categoria int (11),
in snombre_producto varchar(255), in scantidad int(80), in sprecio float, in soferta float,
in svideo varchar(500), in simagen mediumblob, in simagen2 mediumblob, in simagen3 mediumblob, 
in sdescripcion varchar(255)
)
begin
insert into PRODUCTO( id_usuario, id_categoria,nombre_producto, cantidad, precio, oferta ,video, imagen, imagen2, imagen3, descripcion)
value
(sid_usuario, sid_categoria, snombre_producto, scantidad, sprecio, soferta, svideo, simagen, simagen2, simagen3, sdescripcion);
end;
//

Delimiter //
Create Procedure agre_carrito (in sprecio float, in sproducto_comprado varchar(255), in scantidad int (80))
begin
insert into carrito ( precio, producto_comprado, cantidad, fecha_compra) value ( sprecios, producto_comprado, scantidad, now());
end;
//




-- Busquedas por Nombre, descripcion, categoria, fecha, oferta y precio
DELIMITER //
CREATE PROCEDURE busqueda (in tipo int(11), in busqueda varchar(255), in bus_int float(11))
begin
CASE tipo
when 1 THEN
select nombre_producto, cantidad,precio, imagen, categoria, oferta  from coment 
where  nombre_producto like CONCAT(busqueda,'%') order by nombre_producto asc;
when 2 THEN
select nombre_producto, cantidad,precio, imagen, categoria, oferta  from coment
where  descripcion like CONCAT(busqueda,'%');
when 3 THEN
select  nombre_producto, cantidad,precio, imagen, categoria, oferta  from coment
where  categoria like CONCAT(busqueda,'%') order by categoria asc;
when 4 THEN
select  nombre_producto, cantidad,precio, imagen, categoria, oferta  from coment
where  p_fecha  like CONCAT(bus_int,'%') order by p_fecha asc;
when 5 THEN
select  nombre_producto, cantidad,precio, imagen, categoria, oferta  from coment
where  oferta like CONCAT(bus_int,'%') order by oferta asc;
when 6 THEN
select  nombre_producto, cantidad,precio, imagen, categoria, oferta  from coment
where  precio like CONCAT(bus_int,'%') order by precio asc;
end case;
end;
//
-- select* from producto;

-- Call Store_articulo(2,1);

	


Delimiter //
-- Procedure Ordenamiento, listado y seleccion de articulo
CREATE PROCEDURE Store_articulo (in sopcion int(11),in sid_producto int(11))
-- 1=Caja de comentarios. 2= Listado por categoria. 3= Seleccion de un articulo
begin

CASE sopcion
-- Ver comentarios
when 1 
then select producto.nombre_producto,comentario.comentario, comentario.coment_date, usuario.nombre  from producto
inner join  comentario on producto.id_producto = comentario.id_producto
inner join usuario on comentario.id_Usuario = usuario.id_Usuario
where producto.id_producto= sid_producto
order by comentario.coment_date asc;
-- Ver producto ordenado por categoria. 1-PG, 2-PM, 3-PCH
when 2  
then select nombre_producto, cantidad,precio, imagen, categoria, oferta 
from coment where id_categoria=sid_producto order by precio asc;

-- Ver especificaciones del producto (click en el producto)
when 3 
then select nombre_producto, cantidad, precio, video, imagen, imagen2, imagen3, oferta, valoracion 
from coment where id_producto=sid_producto;

end case;

end; 
//

-- MEGA STORE PROCEDURE SHINGON  DE UPDATE MAMALON WEBENCIA TOTAL PL

-- Procedure de actualizar productos.
-- CALL Actua_producto(2,1,"",450,1.5,1.5,"","","","","");
-- Primer parametro es opcion, Segundo es el id del producto y los demas ya van modifcando uno a uno
Delimiter //
CREATE PROCEDURE Actua_producto( in opcion int,
in sid_producto int, in snombre_producto varchar(255) , in scantidad int (80),in sprecio float, in soferta float, in svideo mediumblob,
in simagen mediumblob, in simagen2 mediumblob, in simagen3 mediumblob, in sdescripcion varchar(255)
)
begin
CASE opcion
-- Nombre
WHEN 1 THEN
UPDATE PRODUCTO
SET 
nombre_producto= snombre_producto,
cantidad= cantidad, 
precio= precio,
oferta= oferta,
video=  video,
imagen= imagen,
imagen2= imagen2,
imagen3= imagen3,
descripcion= descripcion
where id_producto= sid_producto;
 -- Cantidad
WHEN 2 THEN
UPDATE PRODUCTO
SET 
nombre_producto= nombre_producto,
cantidad= scantidad, 
precio= precio,
oferta= oferta,
video=  video,
imagen= imagen,
imagen2= imagen2,
imagen3= imagen3,
descripcion= descripcion
where id_producto= sid_producto;
-- Precio
WHEN 3 THEN
UPDATE PRODUCTO
SET 
nombre_producto= nombre_producto,
cantidad= cantidad, 
precio= sprecio,
oferta= oferta,
video=  video,
imagen= imagen,
imagen2= imagen2,
imagen3= imagen3,
descripcion= descripcion
where id_producto= sid_producto;
-- Oferta
WHEN 4 THEN
UPDATE PRODUCTO
SET 
nombre_producto= nombre_producto,
cantidad= cantidad, 
precio= precio,
oferta= soferta,
video=  video,
imagen= imagen,
imagen2= imagen2,
imagen3= imagen3,
descripcion= descripcion
where id_producto= sid_producto;
-- Video
WHEN 5 THEN
UPDATE PRODUCTO
SET 
nombre_producto= nombre_producto,
cantidad= cantidad, 
precio= precio,
oferta= oferta,
video=  svideo,
imagen= imagen,
imagen2= imagen2,
imagen3= imagen3,
descripcion= descripcion
where id_producto= sid_producto;
-- imagen
WHEN 6 THEN
UPDATE PRODUCTO
SET 
nombre_producto= nombre_producto,
cantidad= cantidad, 
precio= precio,
oferta= oferta,
video=  video,
imagen= simagen,
imagen2= imagen2,
imagen3= imagen3,
descripcion= descripcion
where id_producto= sid_producto;
-- imagen2
WHEN 7 THEN
UPDATE PRODUCTO
SET 
nombre_producto= nombre_producto,
cantidad= cantidad, 
precio= precio,
oferta= oferta,
video=  video,
imagen= imagen,
imagen2= simagen2,
imagen3= imagen3,
descripcion= descripcion
where id_producto= sid_producto;
-- imagen 3
WHEN 8 THEN
UPDATE PRODUCTO
SET 
nombre_producto= nombre_producto,
cantidad= cantidad, 
precio= precio,
oferta= oferta,
video=  video,
imagen= imagen,
imagen2= imagen2,
imagen3= simagen3,
descripcion= descripcion
where id_producto= sid_producto;
-- descripcion
WHEN 9 THEN
UPDATE PRODUCTO
SET 
nombre_producto= nombre_producto,
cantidad= cantidad, 
precio= precio,
oferta= oferta,
video=  video,
imagen= imagen,
imagen2= imagen2,
imagen3= imagen3,
descripcion= sdescripcion
where id_producto= sid_producto;

end case;

end;
-- select* from producto;
-- Trigger Cuando el producto sea comprado

DELIMITER //
CREATE TRIGGER Compra_articulo
AFTER INSERT ON historial
FOR EACH ROW

begin

UPDATE PRODUCTO
SET 
cantidad = (cantidad - @total)
where nombre_producto= new.producto_comprado;
end;
//

describe usuario;
-- Validaciones Store Procedure
Delimiter //
CREATE PROCEDURE ini_ses(in snom varchar (255), in spass varchar(255))
begin
select nombre, passwordUsuario, correo, apellidoM, apellidoP, nombreUsuario, id_Usuario from usuario where nombre= snom and passwordUsuario = sha2(spass,256);
end;

//

CALL ini_ses("Jose Esau", "A1111");

-- select* from usuario;
-- Maestra telefono 81 11 1605 78

-- Inserccion de datos base

-- javascript para la condicion de cantidad.

-- insert into historial ( precio, producto_comprado, cantidad, fecha_compra)
-- value (125.0, "Petroleo", 25, now())

insert into categoria(categoria) value("Pasteles Grandes");

insert into categoria(categoria) value("Pasteles Medianos");

insert into categoria(categoria) value("Pasteles Pequeños");

insert into usuario (nombre, apellidoP, apellidoM, correo, telefono, celular, nombreUsuario, passwordUsuario, nivel) 
value("Jose Esau", "Rodriguez", "Ramos", "correin@hotmail.com", "148484", "48484", "Kabsius",SHA2('A1111',256), 1);

insert into producto (id_categoria, id_usuario, nombre_producto, cantidad, precio, descripcion) values (1,1, "Gas", 150, 350, "asadf");
insert into producto (id_categoria, id_usuario, nombre_producto, cantidad, precio, descripcion) values (1,1, "Tortillas", 15, 50, "asadf");
insert into producto (id_categoria, id_usuario, nombre_producto, cantidad, precio, descripcion) values (1,1, "Gasolina", 10, 30, "asadf");

insert into producto (id_categoria, id_usuario, nombre_producto, cantidad, precio) values (2,1, "Petroleo", 70, 858);
insert into producto (id_categoria, id_usuario, nombre_producto, cantidad, precio) values (2,1, "Petroleos", 80, 858);
insert into producto (id_categoria, id_usuario, nombre_producto, cantidad, precio) values (2,1, "Petro", 10, 88);

ini_sesinsert into comentario (id_usuario, id_producto,  comentario, coment_date) value(1, 2,"primero",now());
insert into comentario (id_usuario, id_producto,  comentario, coment_date) value(1, 2,"segundo",now());
insert into comentario (id_usuario, id_producto,  comentario, coment_date) value(1, 1,"primero",now());



DESCRIBE usuario;
DESCRIBE CARRITO;
DESCRIBE CATEGORIA;
DESCRIBE COMENTARIO;
DESCRIBE HISTORIAL;
DESCRIBE PRODUCTO;



DELIMITER %%
CREATE PROCEDURE spGetImage
(
	id int,
    tipo int,
    numero int
)
BEGIN
	CASE tipo
		WHEN 1 THEN 
			CASE numero
				WHEN 1 THEN SELECT imagen FROM producto WHERE id_producto = id;
                WHEN 2 THEN SELECT imagen2 FROM producto WHERE id_producto = id;
                WHEN 3 THEN SELECT imagen3 FROM producto WHERE id_producto = id;
            END CASE;
        WHEN 2 THEN
			SELECT imagen_usuario FROM usuario WHERE id_Usuario = id;
	END CASE;
END;
%%


DELIMITER &&
CREATE PROCEDURE spGetVideo
(
	id int
)
BEGIN
	SELECT video FROM producto WHERE id_producto = id;
END;
&&


DELIMITER //
CREATE PROCEDURE spDetallesArticulo
(
	id int
)
BEGIN
	SELECT pd.id_producto, pd.nombre_producto, ct.categoria, pd.descripcion, pd.oferta, pd.valoracion, pd.precio, pd.cantidad, pd.video
    FROM producto pd
    JOIN categoria ct ON ct.id_categoria = pd.id_categoria
    WHERE pd.id_producto = id;
END;
//


DELIMITER $$
CREATE PROCEDURE spComentar
(
	usuario int,
    producto int,
    txtComentario varchar(255)
)
 BEGIN
	INSERT INTO comentario (id_usuario, id_producto, comentario, coment_date) VALUES (usuario, producto, txtComentario, NOW());
 END;
$$

DELIMITER !!
CREATE PROCEDURE spVerComentarios
(
	id int
)
BEGIN
	SELECT us.nombreUsuario, cm.coment_date, cm.comentario from comentario cm
	JOIN usuario us ON cm.id_usuario = us.id_Usuario
	WHERE cm.id_producto = id
	ORDER BY cm.coment_date DESC;
END;
!!


DELIMITER !!
CREATE PROCEDURE spValoracionArticulo
(
	id int,
    estrellas double
)
BEGIN
    UPDATE producto SET valoracion = estrellas WHERE id_producto = id;
END;
!!


DELIMITER !!
CREATE PROCEDURE spAdminArticulos
(

)
BEGIN
   SELECT pd.id_producto, pd.nombre_producto, ct.categoria, pd.descripcion, pd.precio, pd.cantidad, DATE(pd.p_fecha) fecha
	FROM producto pd 
	JOIN categoria ct ON ct.id_categoria = pd.id_categoria
    WHERE pd.activo = 1;
END;
!!

DELIMITER !!
CREATE PROCEDURE spEliminarProducto
(
	id int
)
BEGIN
	UPDATE producto SET activo = 0 WHERE id_producto = id;
END;
!!



DELIMITER //
CREATE PROCEDURE spPrespuestos
(
	cliente int
)
BEGIN
	CASE cliente
		WHEN 1 THEN
			SELECT ct.id_carrito, u.nombreUsuario, u.id_Usuario, DATE(ct.fecha_compra) fecha, 
				CASE ct.estatus
					WHEN 1 THEN "Solicitado"
					WHEN 2 THEN "Confirmado"
					WHEN 3 THEN "Comprado"
					WHEN 4 THEN "Rechazado"
				END AS estado
			FROM carrito ct
			JOIN usuario u ON ct.usuario = u.id_usuario
			WHERE ct.estatus > 0;
		ELSE
			SELECT ct.id_carrito, u.nombreUsuario, u.id_Usuario, DATE(ct.fecha_compra) fecha, 
				CASE ct.estatus
					WHEN 1 THEN "Solicitado"
					WHEN 2 THEN "Confirmado"
					WHEN 4 THEN "Rechazado"
				END AS estado
			FROM carrito ct
			JOIN usuario u ON ct.usuario = u.id_usuario
			WHERE ct.estatus >  0 AND ct.estatus <>  3 AND u.id_Usuario = cliente;
		END CASE;
END;
//



-- ESTADOS:
-- 0: Carrito
-- 1: Presupuesto Solicitado
-- 2: Presupuesto confirmado
-- 3: Comprado
-- 4: Rechazado por el cliente
--
DELIMITER &&
CREATE PROCEDURE spUpdateEstatusCarrito
(
	estado int,
    id int,
    us_id int
)
BEGIN
	UPDATE carrito SET estatus = estado WHERE id_carrito = id AND usuario = us_id;
END;
&&

DELIMITER &&
CREATE PROCEDURE spConfirmarPresupuestoAdmin
(
	estado int,
    id int
   
)
BEGIN
	UPDATE carrito SET estatus = 2 WHERE id_carrito = id;
END;
&&



DELIMITER $$
CREATE PROCEDURE spAgregarCarrito
(
	usuario int,
    producto int,
    cantidad int
)
BEGIN
	DECLARE carrito INT;
    DECLARE idCar INT;
    SELECT COUNT(*) INTO carrito FROM carrito WHERE usuario = usuario AND estatus = 0;
    IF carrito < 1 THEN
		INSERT INTO carrito (usuario, fecha_compra, estatus) VALUES (usuario, NOW(), 0);
		SELECT last_insert_id() INTO idCar;
        INSERT INTO detallecarrito (carrito, producto, cantidad, precio) VALUES (idCar, producto, cantidad, 0.00);
    ELSE
		SELECT id_carrito INTO idCar FROM carrito WHERE usuario = usuario AND estatus = 0;
        INSERT INTO detallecarrito (carrito, producto, cantidad, precio) VALUES (idCar, producto, cantidad, 0.00);
    END IF;
END;
$$


DELIMITER //
CREATE PROCEDURE spEliminarDeCarrito
(
	prod int,
    car int
)
BEGIN
	DELETE FROM detallecarrito WHERE carrito = car AND producto = prod;
END;
//

DELIMITER //
CREATE PROCEDURE spUpdateCantidad
(
	prod int,
    car int,
    cant int
)
BEGIN
	UPDATE detallecarrito SET cantidad = cant WHERE carrito = car AND producto = prod;
END;
//





DELIMITER //
CREATE PROCEDURE spRealizarCompra
(
	idCarrito int,
    formaPag varchar(45)
)
BEGIN
	UPDATE carrito SET estatus = 3, formaPago = formaPag WHERE id_carrito = idCarrito;
END;
//





DELIMITER //
CREATE PROCEDURE spHistorialCompras
(
	cliente int
)
BEGIN
	
			SELECT ct.id_carrito, u.nombreUsuario, u.id_Usuario, DATE(ct.fecha_compra) fecha, SUM(dc.precio * dc.cantidad) total, ct.formaPago
			FROM carrito ct
            JOIN detallecarrito dc ON ct.id_carrito = dc.carrito
			JOIN usuario u ON ct.usuario = u.id_usuario
			WHERE ct.estatus = 3 AND ct.usuario = cliente
            GROUP BY ct.id_carrito;
		
END;

DELIMITER //
CREATE PROCEDURE spDetalleCompra
(
	id int
)
BEGIN
			SELECT pto.id_producto, pto.nombre_producto, dc.cantidad, dc.precio,(dc.precio * dc.cantidad) total
			FROM carrito ct
            JOIN detallecarrito dc ON ct.id_carrito = dc.carrito
			JOIN producto pto ON pto.id_producto = dc.producto
			WHERE ct.estatus = 3 AND dc.carrito = id;		
END;




DELIMITER //
CREATE PROCEDURE spDetallePresupuestoCliente
(
	id int
)
BEGIN
			SELECT pto.id_producto, pto.nombre_producto, dc.cantidad, dc.precio,(dc.precio * dc.cantidad) total
			FROM carrito ct
            JOIN detallecarrito dc ON ct.id_carrito = dc.carrito
			JOIN producto pto ON pto.id_producto = dc.producto
			WHERE (ct.estatus = 1 OR ct.estatus = 2 OR ct.estatus = 4 ) AND dc.carrito = id;		
END;


DELIMITER //
CREATE PROCEDURE spDetallePresupuestoAdmin
(
	id int
)
BEGIN
			SELECT pto.id_producto, pto.nombre_producto, dc.cantidad, dc.precio,(dc.precio * dc.cantidad) total
			FROM carrito ct
            JOIN detallecarrito dc ON ct.id_carrito = dc.carrito
			JOIN producto pto ON pto.id_producto = dc.producto
			WHERE dc.carrito = id;		
END;



DELIMITER //
CREATE PROCEDURE spConfirmarPresupuesto
(
	idProducto int,
    idPresupuesto int,
    precioNuevo double
)
BEGIN
	UPDATE detallecarrito SET precio = precioNuevo WHERE producto = idProducto AND carrito	= idPresupuesto;
    
END;
//

DELIMITER &&
CREATE PROCEDURE spPresupuestoConfirmado
(
	estado int,
    id int
  
)
BEGIN
	UPDATE carrito SET estatus = estado WHERE id_carrito = id;
END;
&&


DELIMITER //
CREATE PROCEDURE spDetalleSolicitud
(
	id int
)
BEGIN
			SELECT pto.id_producto, pto.nombre_producto, dc.cantidad, ct.id_carrito
			FROM carrito ct
            JOIN detallecarrito dc ON ct.id_carrito = dc.carrito
			JOIN producto pto ON pto.id_producto = dc.producto
			WHERE ct.estatus = 0 AND ct.usuario = id;		
END;



DELIMITER %%
CREATE PROCEDURE spPaginaPrincipal()
BEGIN
	SELECT pd.id_producto, pd.nombre_producto, pd.descripcion, ct.categoria
    FROM producto pd
    JOIN categoria ct ON pd.id_categoria = ct.id_categoria
    WHERE pd.activo = 1
    ORDER BY pd.p_fecha DESC
    LIMIT 6;
END;
%%


DELIMITER %%
CREATE PROCEDURE spBusquedaChida
(
	tipo int,
    cat int,
    param varchar(50),
    fechaIni date,
    fechaFin date
)
BEGIN
	CASE tipo
		WHEN 1 THEN
			SELECT pd.id_producto, pd.nombre_producto, pd.descripcion, ct.categoria
			FROM producto pd
			JOIN categoria ct ON pd.id_categoria = ct.id_categoria
			WHERE pd.activo = 1 AND pd.id_categoria = cat;
		WHEN 2 THEN
			SELECT pd.id_producto, pd.nombre_producto, pd.descripcion, ct.categoria
			FROM producto pd
			JOIN categoria ct ON pd.id_categoria = ct.id_categoria
			WHERE pd.activo = 1 AND (pd.nombre_producto LIKE CONCAT('%',param,'%') OR pd.descripcion LIKE CONCAT('%',param,'%') OR ct.categoria LIKE CONCAT('%',param,'%')) ;
		WHEN 3 THEN
			SELECT pd.id_producto, pd.nombre_producto, pd.descripcion, ct.categoria
			FROM producto pd
			JOIN categoria ct ON pd.id_categoria = ct.id_categoria
			WHERE pd.activo = 1 AND pd.p_fecha BETWEEN CONCAT(fechaFin, ' 23:59:59') AND CONCAT(fechaIni,' 00:00:00');
		ELSE
			SELECT pd.id_producto, pd.nombre_producto, pd.descripcion, ct.categoria
			FROM producto pd
			JOIN categoria ct ON pd.id_categoria = ct.id_categoria
			WHERE pd.activo = 1;
		END CASE;
END;
%%


