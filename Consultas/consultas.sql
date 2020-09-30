

/*------------------------------------------- CONSULTAS ------------------------------*/

/*1.-------------------*/
SELECT * FROM(
SELECT p.nombre, p.telefono, ped.id_pedido, ped.total
FROM persona p, pedido ped
WHERE p.id_persona = ped.fk_id_persona
AND p.fk_id_tipo = 2
ORDER BY ped.total DESC)
WHERE ROWNUM <= 4
;

/*2.-------------------*/
SELECT * FROM
(SELECT persona.nombre, cliente.total_compras FROM
(SELECT p.id_persona, SUM(ped.total) as total_compras
FROM persona p, pedido ped
WHERE p.id_persona = ped.fk_id_persona
AND p.fk_id_tipo = 1
GROUP BY(p.id_persona)) cliente , persona
WHERE persona.id_persona = cliente.id_persona
ORDER BY (cliente.total_compras) DESC)
WHERE ROWNUM <= 1
;   /*  Allistair Mcguire  -  47,110.22 */


/* 3. ---------------------------------------- */
select ciudad.nombre, pedido.id_pedido, pedido.total
from pedido, ciudad, persona, codigoPostal
WHERE pedido.fk_id_persona = persona.id_persona
AND persona.fk_cod_postal = codigoPostal.numero_codigo
AND codigoPostal.fk_id_ciudad = ciudad.id_ciudad;
/* anda F */

/* 4. ----------------------------------------------*/
SELECT * FROM(
SELECT per.id_persona, per.nombre, cli.cant_pedida, cli.suma_tot
FROM(
select SUM((ped.total / prod.precio)) AS cant_pedida , per.id_persona, SUM(ped.total) AS suma_tot
from persona per, producto prod, pedido ped, categoriaProd cat
where ped.fk_id_persona = per.id_persona
and ped.fk_id_producto = prod.id_producto
and prod.fk_categoria = cat.id_cat
and cat.descripcion = 'Cheese'
GROUP BY per.id_persona) cli, persona per
WHERE per.id_persona = cli.id_persona
AND per.fk_id_tipo = 1
ORDER BY cli.cant_pedida DESC)
WHERE ROWNUM <= 5
;
/*
select  SUM((ped.total / prod.precio)), per.nombre
from persona per, producto prod, pedido ped, categoriaProd cat
where ped.fk_id_persona = per.id_persona
and ped.fk_id_producto = prod.id_producto
and prod.fk_categoria = cat.id_cat
and cat.descripcion = 'Cheese'
and per.nombre = 'Ignacia Delgado'
GROUP BY per.nombre
;


select  per.nombre, prod.nombre , cat.descripcion, ped.total, (ped.total / prod.precio) AS cantidad
from persona per, producto prod, pedido ped, categoriaProd cat
where ped.fk_id_persona = per.id_persona
and ped.fk_id_producto = prod.id_producto
and prod.fk_categoria = cat.id_cat
and cat.descripcion = 'Cheese'
and per.nombre = 'Ignacia Delgado'
;*/

/* 5. -----------------------------------------------------*/
/*EXTRACT(MONTH FROM per.fecha_registro),*/
SELECT per.nombre, EXTRACT(MONTH FROM per.fecha_registro) AS mes
FROM(
SELECT per.id_persona,  SUM(ped.total) AS total_compra
FROM persona per, pedido ped
WHERE per.id_persona = ped.fk_id_persona
GROUP BY per.id_persona 
ORDER BY total_compra DESC) cli , persona per
WHERE per.id_persona = cli.id_persona
; 

/* 6. ---------------------------------------------------------*/
SELECT  MAX(total_categoria) AS maxim, MIN(total_categoria) AS mini FROM(
select cat.descripcion , sum(total) AS total_categoria
from pedido, producto, categoriaProd cat
where pedido.fk_id_producto = producto.id_producto
and producto.fk_categoria = cat.id_cat
GROUP BY cat.descripcion
ORDER BY total_categoria DESC) cli;

/* Anda f x2 */

/* 7. -----------------------------------------------------*/

SELECT * FROM(
SELECT per.id_persona, per.nombre, prov.cant_vendida, prov.suma_tot
FROM(
select SUM((ped.total / prod.precio)) AS cant_vendida , per.id_persona, SUM(ped.total) AS suma_tot
from persona per, producto prod, pedido ped, categoriaProd cat
where ped.fk_id_persona = per.id_persona
and ped.fk_id_producto = prod.id_producto
and prod.fk_categoria = cat.id_cat
and cat.descripcion = 'Fresh Vegetables'
GROUP BY per.id_persona) prov, persona per
WHERE per.id_persona = prov.id_persona
AND per.fk_id_tipo = 2
ORDER BY prov.cant_vendida DESC)
WHERE ROWNUM <= 5
;

/*  8. -------------------------------------------------------*/

