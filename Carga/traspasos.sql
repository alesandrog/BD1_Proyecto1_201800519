/*---------------------------------------------------- TRASPASOS -----------------*/

/* TIPO PERSONA*/
INSERT INTO tipoPersona (tipo)
SELECT tipo FROM temporal GROUP BY tipo; /* 2 tipos */

SELECT * FROM tipoPersona;

/* REGION */
INSERT INTO region (nombre)
SELECT region FROM temporal GROUP BY region; /* 20 regiones */

/* CIUDAD */
INSERT INTO ciudad ( nombre, fk_id_region)
SELECT DISTINCT(ciudad), id_region FROM temporal , region where temporal.region = region.nombre; /* 22 ciudades */


/* COD POSTAL */
INSERT INTO codigoPostal(numero_codigo, fk_id_ciudad) 
SELECT DISTINCT(codigo_postal), id_ciudad FROM temporal, ciudad 
WHERE ciudad.nombre = temporal.ciudad;  /* 24 codigos postales */


/* CLIENTE */

INSERT INTO persona(nombre , correo, telefono, direccion, fecha_registro, fk_id_tipo, fk_cod_postal)
SELECT DISTINCT(nombre), correo, telefono, direccion, fecha_registro,id_tipo, id_codpostal 
FROM temporal, tipoPersona, codigoPostal
where tipoPersona.tipo = temporal.tipo
AND codigoPostal.numero_codigo = temporal.codigo_postal; /* 149 personas */


/* COMPANIA */
INSERT INTO compania(nombre, contacto, correo, telefono)
SELECT DISTINCT(nombre_compania), contacto_compania, correo_compania, telefono_compania from temporal; /* 100 companias */


/* CATEGORIA PRODUCTO */
INSERT INTO categoriaProd(descripcion)
SELECT DISTINCT(categoria_producto) FROM temporal; /* 19 categorias */


/* PRODUCTO */

INSERT INTO producto(nombre , precio, fk_categoria)
SELECT DISTINCT(producto), precio_unitario, id_cat 
FROM temporal, categoriaProd WHERE categoriaProd.descripcion = temporal.categoria_producto; /*200 productos*/

/* PEDIDO */

INSERT INTO pedido(fk_id_persona, fk_id_compania, fk_id_producto, total)
SELECT id_persona, id_compania, id_producto, (precio*cantidad) AS total_pedido from temporal,persona, compania, producto 
where persona.nombre = temporal.nombre 
AND compania.nombre = temporal.nombre_compania
AND producto.nombre = temporal.producto
;  /* 6107 pedidos */
