

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- 1
SELECT 
	descripcion 
FROM 
	oficinas;

-- 2
SELECT 
  descripcion,
  precio AS precio_costo,
  ROUND(precio * 1.21, 2) AS precio_con_iva
FROM productos;

-- 3
SELECT 
  nombre,
  apellido,
  fecha_nacimiento,
  TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) AS edad
FROM 
	empleados;

-- 4
SELECT 
	apellido, nombre 
FROM 
	empleados 
WHERE 
	cod_jefe IS NOT NULL;

-- 5
SELECT 
	* 
FROM 
	empleados 
WHERE 
	nombre = 'Maria' ORDER BY apellido ASC;

-- 6
SELECT 
	razon_social 
FROM 
	clientes 
WHERE 
	razon_social LIKE "L%";

-- 7
SELECT 
	cod_pedido, fecha_pedido 
FROM 
	pedidos 
ORDER BY 
	(fecha_pedido) DESC;

-- 8
SELECT 
	* 
FROM 
	oficinas 
WHERE 
	codigo_director IS NULL;

-- 9
SELECT 
	* 
FROM 
	precios 
ORDER BY (precio) ASC LIMIT 4;

-- 10
SELECT cod_empleado, cuota FROM datos_contratos ORDER BY (cuota) DESC LIMIT 3;

-- Multitablas--

-- 1
SELECT 
  productos.descripcion,
  fabricantes.razon_social,
  productos.cantidad_stock
FROM 
  productos, fabricantes
WHERE 
  productos.cod_fabricante = fabricantes.cod_fabricante ORDER BY fabricantes.razon_social ASC, productos.descripcion ASC;

-- 2

SELECT 
  pedidos.cod_pedido,
  pedidos.fecha_pedido,
  empleados.apellido,
  clientes.razon_social
FROM 
  pedidos, empleados, clientes
WHERE 
  pedidos.cod_empleado = empleados.cod_empleado AND pedidos.cod_cliente = clientes.cod_cliente;
	
-- 3

SELECT 
  empleados.apellido,
  datos_contratos.cuota,
  oficinas.descripcion AS oficinas
FROM 
  empleados, datos_contratos, oficinas
WHERE 
  empleados.cod_empleado = datos_contratos.cod_empleado AND empleados.cod_oficina = oficinas.cod_oficina ORDER BY datos_contratos.cuota DESC;

-- 4

SELECT 
	distinct	clientes.razon_social
FROM
	clientes, pedidos
WHERE 
	pedidos.cod_cliente = clientes.cod_cliente AND MONTH(pedidos.fecha_pedido) = 4;

-- 5
SELECT
	DISTINCT productos.descripcion
FROM 
	productos, pedidos, detalle_pedidos
WHERE 
	productos.cod_producto = detalle_pedidos.cod_producto AND detalle_pedidos.cod_pedido = pedidos.cod_pedido AND MONTH(pedidos.fecha_pedido) = 3;

-- 6 

SELECT
	e.apellido,
	e.nombre,
	dc.fecha_contrato,
	TIMESTAMPDIFF(YEAR, dc.fecha_contrato, CURDATE()) AS años_contratado
FROM
	empleados e, datos_contratos dc
WHERE
	e.cod_empleado = dc.cod_empleado AND TIMESTAMPDIFF(YEAR, dc.fecha_contrato, CURDATE()) > 10 ORDER BY años_contratado DESC;	

-- 7

SELECT
	c.cod_cliente,
	c.razon_social
FROM
	clientes c, listas l
WHERE
	c.cod_lista = l.cod_lista AND l.descripcion = "Mayorista"
	ORDER BY (c.razon_social) ASC;
	
-- 8

SELECT
	DISTINCT c.razon_social,
	p.descripcion 
FROM
	clientes c, productos p, pedidos pe, detalle_pedidos dp
WHERE
	c.cod_cliente = pe.cod_cliente AND pe.cod_pedido = dp.cod_pedido AND p.cod_producto = dp.cod_producto
	ORDER BY p.descripcion, c.razon_social ASC 
	
-- 9 
SELECT 
	f.razon_social, 
	p.descripcion, 
	(p.punto_reposicion - p.cantidad_stock) AS cantidad_comprar
FROM 
	productos AS p , fabricantes AS f  
WHERE 
	p.cod_fabricante = f.cod_fabricante	AND p.cantidad_stock < p.punto_reposicion	ORDER BY f.razon_social, p.descripcion;

-- 10

SELECT
	e.apellido, 
	e.nombre,
	e.fecha_nacimiento,
	e.cod_empleado,
	dc.cuota
FROM
	empleados e, datos_contratos dc
WHERE 
	cuota < 50000 OR cuota > 100000;

-- Las otras 6 preguntas

-- 1

SELECT MAX(cantidad) AS cantidad_maxima
FROM ITEM_VENTAS;

-- 2

SELECT SUM(cantidad) AS total_unidades_vendidas
FROM ITEM_VENTAS
WHERE codigo_producto = 3;

-- 3

SELECT 
  p.nombre_producto,
  SUM(iv.cantidad) AS total_vendida
FROM PRODUCTOS p, ITEM_VENTAS iv
WHERE p.codigo_producto = iv.codigo_producto
GROUP BY p.nombre_producto
ORDER BY total_vendida DESC;

-- 4

SELECT 
  p.nombre_producto,
  SUM(iv.cantidad) AS total
FROM 
  PRODUCTOS p, ITEM_VENTAS iv
WHERE 
  p.codigo_producto = iv.codigo_producto
GROUP BY 
  p.nombre_producto
HAVING 
  total > 30
ORDER BY 
  p.nombre_producto;

-- 5

SELECT 
  codigo_cliente,
  COUNT(numero_factura) AS cantidad_compras
FROM 
  VENTAS
GROUP BY 
  codigo_cliente
ORDER BY 
  cantidad_compras DESC;

-- 6

SELECT 
  iv.codigo_producto,
  AVG(iv.cantidad) AS promedio_unidades_vendidas
FROM 
  ITEM_VENTAS iv, VENTAS v
WHERE 
  iv.numero_factura = v.numero_factura
  AND v.codigo_cliente = 1
GROUP BY 
  iv.codigo_producto;


	




