-- monto_total 
SELECT
    i.id_item,
    -- i.cantidad,
    -- p.precio_unitario,
    -- e.tipo_envio,
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


-- ver tipos de usuarios
SELECT 
	u.numero_cliente,
	e.nombre_fantasia  AS empresa,
	concat_ws(' ', p.nombre, p.apellido) AS particular
FROM usuario AS u
	LEFT JOIN empresa AS e ON (u.numero_cliente = e.usuario)
	LEFT JOIN particular AS p ON (u.numero_cliente = p.usuario);
