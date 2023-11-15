-- 1.
-- monto_total 
SELECT
   i.id_item,
   --i.cantidad,
   --p.precio_unitario,
   --e.tipo_envio,
   CASE
   	WHEN e.tipo_envio = 'envio rapido' THEN  i.cantidad * p.precio_unitario + 400
   	WHEN e.tipo_envio = 'envio normal a domicilio' THEN i.cantidad * p.precio_unitario + 200
   	WHEN e.tipo_envio = 'envio a correo' THEN i.cantidad * p.precio_unitario + 150
   	WHEN e.tipo_envio = 'retiro en sucursal' THEN i.cantidad * p.precio_unitario
   END AS monto
FROM
   item AS i
INNER JOIN producto AS p ON (i.producto = p.numero_articulo)
INNER JOIN item_envio AS ie ON (ie.item  = i.id_item) 
INNER JOIN envio AS e ON (e.id_envio = ie.envio);


-- calificacion promedio
CREATE VIEW getCalificacionPromedio AS
SELECT 
	p.numero_articulo,
	-- count(r.calificacion)AS cantidad,
	CASE 
		WHEN avg(r.calificacion) IS NULL THEN 0.00
		ELSE avg(r.calificacion)
	END AS promedio
FROM producto AS p
LEFT JOIN resenia AS r ON (p.numero_articulo = r.producto)
GROUP BY p.numero_articulo
ORDER BY p.numero_articulo ASC;

-- 2.
-- Carrito 

CREATE VIEW montos_item AS  — esta vista sirve para obtener total de item
SELECT
    i.pedido,
	CASE
   	 WHEN e.tipo_envio = 'envio rapido' THEN  i.cantidad * p.precio_unitario + 400
   	 WHEN e.tipo_envio = 'envio normal a domicilio' THEN i.cantidad * p.precio_unitario + 200
   	 WHEN e.tipo_envio = 'envio a correo' THEN i.cantidad * p.precio_unitario + 150
   	 WHEN e.tipo_envio = 'retiro en sucursal' THEN i.cantidad * p.precio_unitario
	END AS monto  –momento hardcoder
FROM
	item AS i
INNER JOIN producto AS p ON (i.producto = p.numero_articulo)
INNER JOIN item_envio AS ie ON (ie.item  = i.id_item)  
INNER JOIN envio AS e ON (e.id_envio = ie.envio)
GROUP BY monto, i.pedido
ORDER by pedido ASC;

-- aca obtengo el resumen del ‘carrito’
SELECT
    mi.pedido, SUM(mi.monto) AS monto_pedido_final,
    e.tipo_envio,
    p.fecha_pedido,
    pa.apellido,
    pa.nombre
FROM montos_item AS mi
INNER JOIN envio AS e ON (mi.pedido = e.id_envio)
INNER JOIN pedido AS p ON (p.numero_de_pedido = mi.pedido)
INNER JOIN particular AS pa ON (pa.usuario = p.particular)
GROUP BY  mi.pedido, e.tipo_envio , p.fecha_pedido, pa.apellido, pa.nombre
ORDER BY mi.pedido;



-- 3.
-- preguntas recursivas

WITH RECURSIVE PreguntasRecursivas AS (
  SELECT
    pr.pregunta
  FROM pregunta_respuesta pr
  WHERE pr.pregunta = :id_inicial

  UNION ALL

  SELECT
    pr.pregunta,
    pr.respuesta
  FROM pregunta_respuesta pr
  INNER JOIN PreguntasRecursivas prr ON pr.pregunta = prr.respuesta
)
SELECT 
	p.preguntas_del_producto AS pregunta,
	r.preguntas_del_producto AS respuesta
FROM PreguntasRecursivas pr
INNER JOIN pregunta p ON (pr.pregunta = p.id_pregunta)
INNER JOIN pregunta r ON (pr.respuesta = r.id_pregunta);

-- 4.
-- ver tipos de usuarios
SELECT 
	u.numero_cliente,
	e.nombre_fantasia  AS empresa,
	concat_ws(' ', p.nombre, p.apellido) AS particular
FROM usuario AS u
	LEFT JOIN empresa AS e ON (u.numero_cliente = e.usuario)
	LEFT JOIN particular AS p ON (u.numero_cliente = p.usuario);

-- 5.
-- Cantidad de productos vendidos por usuario
SELECT
	u.numero_cliente,
	u.correo_electronico,
	CASE 
		WHEN e.usuario IS NOT NULL AND p.usuario IS NULL THEN e.nombre_fantasia
		WHEN p.usuario IS NOT NULL AND e.usuario IS NULL THEN concat_ws(' ', p.nombre, p.apellido)
	END AS nombre,
	CASE 
		WHEN e.usuario IS NOT NULL AND p.usuario IS NULL THEN e.cuit 
		WHEN p.usuario IS NOT NULL AND e.usuario IS NULL THEN p.dni 
	END AS "DNI/CUIT",
	CASE 
		WHEN ppu.cantidad_productos IS NULL THEN 0
		ELSE ppu.cantidad_productos
	END,
	ppu.productos_publicados,
	ppu.cantidad_vendido,
	ppu.total_vendido
FROM usuario AS u
LEFT JOIN particular as p ON (u.numero_cliente = p.usuario)
LEFT JOIN empresa as e ON (u.numero_cliente = e.usuario)
LEFT JOIN (
	SELECT 
		ppu.usuario,
		count(ppu.producto) AS cantidad_productos,
		array_agg(concat(ppu.producto,' - ',p.descripcion_producto)) AS productos_publicados,
		array_agg(
			CASE 
				WHEN i.cantidad_vendido IS NULL THEN 0
				ELSE i.cantidad_vendido
			END
		) AS cantidad_vendido,
		sum(i.cantidad_vendido) AS total_vendido
	FROM pregunta_producto_usuario as ppu
	LEFT JOIN producto AS p ON (ppu.producto = p.numero_articulo)
	LEFT JOIN (
		SELECT 
			p.numero_articulo,
			count(i.id_item) AS cantidad_vendido
		FROM producto AS p 
		LEFT JOIN item AS i ON (p.numero_articulo = i.producto)
		INNER JOIN pedido AS p2 ON (i.pedido = p2.numero_de_pedido)
		GROUP BY p.numero_articulo
		ORDER BY p.numero_articulo ASC
	) AS i ON (p.numero_articulo = i.numero_articulo)
	WHERE pregunta = 0
	GROUP BY ppu.usuario
) AS ppu ON (u.numero_cliente = ppu.usuario)
ORDER BY u.numero_cliente ASC;


-- ====================================================================
-- 6.
-- producto detallado
SELECT
   p.numero_articulo,
   p.precio_unitario AS precio,
   p.detalle AS nombre_producto,
   p.descripcion_producto,
   concat(u.numero_cliente,' - ',u.nombre) AS vendedor,
   p.es_nuevo,
   p.stock,
   CASE
       WHEN i.cantidad_vendido IS NULL THEN 0
       ELSE i.cantidad_vendido
   END,
   cp.promedio AS calificacion,
   CASE
       WHEN count(c.nombre) != 0 THEN array_agg(c.nombre)
       ELSE null
   END AS categorias,
   p2.cantidad_preguntas,
   p2.preguntas,
   count(r.resenia_producto) AS cantidad_resenias,
   CASE
       WHEN count(r.resenia_producto) != 0 THEN array_agg(r.resenia_producto)
       ELSE null
   END AS resenias
FROM producto p
-- traemos los usuarios publicadores
LEFT JOIN (
   SELECT *
   FROM pregunta_producto_usuario
   WHERE pregunta = 0
) AS ppu ON (p.numero_articulo = ppu.producto)
-- traemos el nombre y tipo de usuario
LEFT JOIN (
   SELECT
       u2.*,
       CASE
           WHEN e.usuario IS NOT NULL AND p.usuario IS NULL THEN e.nombre_fantasia
           WHEN p.usuario IS NOT NULL AND e.usuario IS NULL THEN concat_ws(' ', p.nombre, p.apellido)
       END AS nombre
   FROM usuario AS u2
       LEFT JOIN empresa AS e ON (u2.numero_cliente = e.usuario)
       LEFT JOIN particular AS p ON (u2.numero_cliente = p.usuario)
) AS u ON (ppu.usuario = u.numero_cliente)
-- traemos el promedio de la calificacion
LEFT JOIN getCalificacionPromedio AS cp ON (p.numero_articulo = cp.numero_articulo)
-- traemos todas las resenias del producto
LEFT JOIN resenia AS r ON (p.numero_articulo = r.producto)
-- traemos todas las preguntas del producto
LEFT JOIN (
   SELECT
       p.numero_articulo,
       count(p2.id_pregunta) AS cantidad_preguntas,
       CASE
           WHEN count(p2.preguntas_del_producto) != 0 THEN array_agg(
                   CASE
                       WHEN p2.id_pregunta != 0 THEN concat(p2.id_pregunta, ' - ', p2.preguntas_del_producto)
                   END
               )
           ELSE null
       END AS preguntas
   FROM producto p
   LEFT JOIN pregunta_producto_usuario AS ppu ON (p.numero_articulo = ppu.producto)
   LEFT JOIN (
       SELECT *
       FROM pregunta
       WHERE id_pregunta != 0
   ) AS p2 ON (ppu.pregunta = p2.id_pregunta)
   GROUP BY p.numero_articulo
   ORDER BY p.numero_articulo ASC
) AS p2 ON (ppu.producto = p2.numero_articulo)
-- tabla intermedia con categoria
LEFT JOIN producto_categoria AS pc ON (p.numero_articulo = pc.producto)
-- traemos las categorias del producto
LEFT JOIN categoria AS c ON (pc.categoria = c.id_categoria)
-- traemos la cantidad de productos vendidos
LEFT JOIN (
   SELECT
       p.numero_articulo,
       count(i.id_item) AS cantidad_vendido
   FROM producto AS p
   LEFT JOIN item AS i ON (p.numero_articulo = i.producto)
   INNER JOIN pedido AS p2 ON (i.pedido = p2.numero_de_pedido)
   GROUP BY p.numero_articulo
   ORDER BY p.numero_articulo ASC
) AS i ON (p.numero_articulo = i.numero_articulo)
GROUP BY
   p.numero_articulo,
   u.numero_cliente,
   u.nombre,
   cp.promedio,
   p2.cantidad_preguntas,
   p2.preguntas,
   i.cantidad_vendido
ORDER BY p.numero_articulo;