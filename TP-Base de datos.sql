
CREATE TABLE Documentos (
    cod_documento INT PRIMARY KEY,
    descripcion VARCHAR(100)
);

CREATE TABLE Oficinas (
    cod_oficina INT PRIMARY KEY,
    codigo_director INT,
    descripcion VARCHAR(100)
);

CREATE TABLE Empleados (
    cod_empleado INT PRIMARY KEY,
    apellido VARCHAR(50),
    nombre VARCHAR(50),
    fecha_nacimiento DATE,
    num_doc VARCHAR(20),
    cod_jefe INT,
    cod_oficina INT,
    cod_documento INT,
    FOREIGN KEY (cod_jefe) REFERENCES Empleados(cod_empleado),
    FOREIGN KEY (cod_oficina) REFERENCES Oficinas(cod_oficina),
    FOREIGN KEY (cod_documento) REFERENCES Documentos(cod_documento)
);

CREATE TABLE Datos_contratos (
    cod_empleado INT PRIMARY KEY,
    fecha_contrato DATE,
    cuota DECIMAL(10,2),
    ventas DECIMAL(10,2),
    FOREIGN KEY (cod_empleado) REFERENCES Empleados(cod_empleado)
);

CREATE TABLE Fabricantes (
    cod_fabricante INT PRIMARY KEY,
    razon_social VARCHAR(100)
);

CREATE TABLE Listas (
    cod_lista INT PRIMARY KEY,
    descripcion VARCHAR(100),
    ganancia DECIMAL(5,2)
);

CREATE TABLE Productos (
    cod_producto INT PRIMARY KEY,
    descripcion VARCHAR(100),
    precio DECIMAL(10,2),
    cantidad_stock INT,
    punto_reposicion INT,
    cod_fabricante INT,
    FOREIGN KEY (cod_fabricante) REFERENCES Fabricantes(cod_fabricante)
);


CREATE TABLE Precios (
    cod_producto INT,
    cod_lista INT,
    precio DECIMAL(10,2),
    PRIMARY KEY (cod_producto, cod_lista),
    FOREIGN KEY (cod_producto) REFERENCES Productos(cod_producto),
    FOREIGN KEY (cod_lista) REFERENCES Listas(cod_lista)
);


CREATE TABLE Clientes (
    cod_cliente INT PRIMARY KEY,
    cod_lista INT,
    razon_social VARCHAR(100),
    FOREIGN KEY (cod_lista) REFERENCES Listas(cod_lista)
);


CREATE TABLE Pedidos (
    cod_pedido INT PRIMARY KEY,
    fecha_pedido DATE,
    cod_empleado INT,
    cod_cliente INT,
    FOREIGN KEY (cod_empleado) REFERENCES Empleados(cod_empleado),
    FOREIGN KEY (cod_cliente) REFERENCES Clientes(cod_cliente)
);


CREATE TABLE Detalle_pedidos (
    cod_pedido INT,
    numero_linea INT,
    cod_producto INT,
    cantidad INT,
    PRIMARY KEY (cod_pedido, numero_linea),
    FOREIGN KEY (cod_pedido) REFERENCES Pedidos(cod_pedido),
    FOREIGN KEY (cod_producto) REFERENCES Productos(cod_producto)
);



INSERT INTO Documentos VALUES 
(1, 'DNI'),
(2, 'Pasaporte');

INSERT INTO Oficinas VALUES 
(1, NULL, 'Central Buenos Aires'),
(2, 2, 'Sucursal Córdoba'),
(3, 3, 'Sucursal Rosario'),
(4, NULL, 'Sucursal Mendoza');

INSERT INTO Empleados VALUES 
(1, 'Gómez', 'María', '1985-05-10', '12345678', NULL, 1, 1),
(2, 'Pérez', 'Juan', '1979-03-20', '87654321', 1, 2, 2),
(3, 'Martínez', 'Ana', '1990-12-01', '34567890', 1, 3, 1),
(4, 'López', 'Carlos', '1980-07-15', '45678901', 2, 2, 2),
(5, 'Fernández', 'María', '1992-08-30', '23456789', 1, 3, 1),
(6, 'Rodríguez', 'Mario', '1983-04-04', '78901234', 3, 1, 1);

INSERT INTO Datos_contratos VALUES 
(1, '2008-01-15', 40000, 150000),
(2, '2005-06-20', 120000, 500000),
(3, '2015-03-10', 75000, 300000),
(4, '2011-11-05', 48000, 200000),
(5, '2013-09-18', 53000, 220000),
(6, '2003-04-12', 110000, 800000);


INSERT INTO Fabricantes VALUES 
(1, 'Fábrica Sur S.A.'),
(2, 'Tecnopro Ltda.'),
(3, 'Industria Norte');


INSERT INTO Listas VALUES 
(1, 'Minorista', 10.00),
(2, 'Mayorista', 20.00);

INSERT INTO Productos VALUES 
(1, 'Monitor 21"', 10000, 5, 10, 1),
(2, 'Teclado Mecánico', 5000, 30, 15, 1),
(3, 'Mouse Óptico', 2500, 8, 10, 2),
(4, 'Notebook 15"', 200000, 2, 5, 3),
(5, 'Disco SSD 1TB', 35000, 3, 4, 2);

INSERT INTO Precios VALUES 
(1, 1, 11000),
(2, 1, 5500),
(3, 1, 2700),
(4, 1, 210000),
(5, 1, 37000),
(1, 2, 10500),
(2, 2, 5200),
(3, 2, 2600),
(4, 2, 195000),
(5, 2, 34000);

INSERT INTO Clientes VALUES 
(1, 1, 'Lácteos del Sur'),
(2, 2, 'Logística Patagónica'),
(3, 1, 'Librería Central'),
(4, 2, 'MegaComputación');

INSERT INTO Pedidos VALUES 
(1, '2023-03-05', 1, 1),
(2, '2023-03-20', 2, 2),
(3, '2023-04-10', 3, 4),
(4, '2023-04-22', 2, 4),
(5, '2023-03-15', 4, 3);

INSERT INTO Detalle_pedidos VALUES 
(1, 1, 1, 1),
(1, 2, 2, 2),
(2, 1, 3, 5),
(3, 1, 4, 1),
(4, 1, 5, 1),
(5, 1, 3, 2),
(5, 2, 2, 1);

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


	




