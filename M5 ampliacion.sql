USE Ventas_Tech_DB;
GO

-- Ampliacion del modelo de datos para el M5

-- Crear tabla de territorios
CREATE TABLE territorios (
    id_territorio INT PRIMARY KEY,
    region VARCHAR(50),
    zona VARCHAR(50)
);

-- Cargar los territorios

INSERT INTO territorios
(id_territorio, region, zona)
VALUES
(1, 'CABA', 'Comercial'),
(2, 'CABA', 'Céntrica'),
(3, 'CABA', 'Educativa'),
(4, 'CABA', 'Barrio'),
(5, 'AMBA', 'Comercial'),
(6, 'AMBA', 'Céntrica'),
(7, 'AMBA', 'Educativa'),
(8, 'AMBA', 'Barrio');


-- Agregar territorio a las ventas

ALTER TABLE ventas
ADD id_territorio INT NULL;

UPDATE ventas
SET id_territorio = 1
WHERE id_venta IN (1, 9, 17, 25, 33, 41, 49, 57);

UPDATE ventas
SET id_territorio = 2
WHERE id_venta IN (2, 10, 18, 26, 34, 42, 50, 58);

UPDATE ventas
SET id_territorio = 3
WHERE id_venta IN (3, 11, 19, 27, 35, 43, 51, 59);

UPDATE ventas
SET id_territorio = 4
WHERE id_venta IN (4, 12, 20, 28, 36, 44, 52, 60);

UPDATE ventas
SET id_territorio = 5
WHERE id_venta IN (5, 13, 21, 29, 37, 45, 53);

UPDATE ventas
SET id_territorio = 6
WHERE id_venta IN (6, 14, 22, 30, 38, 46, 54);

UPDATE ventas
SET id_territorio = 7
WHERE id_venta IN (7, 15, 23, 31, 39, 47, 55);

UPDATE ventas
SET id_territorio = 8
WHERE id_venta IN (8, 16, 24, 32, 40, 48, 56);


-- Relacionar ventas con territorios

ALTER TABLE ventas
ADD CONSTRAINT FK_ventas_territorios
FOREIGN KEY (id_territorio)
REFERENCES territorios(id_territorio);

-- Agregar clientes sin compras

INSERT INTO clientes
(id_cliente, nombre, email, ciudad, fecha_registro)
VALUES
(6, 'Lucia Fernandez', 'lucia.fernandez@ejemplo.com', 'CABA', '2025-04-10'),
(7, 'Martin Lopez', 'martin.lopez@ejemplo.com', 'Moron', '2025-05-15');


-- Agregar productos sin ventas

INSERT INTO productos
(id_producto, nombre_producto, id_categoria, precio, stock, activo)
VALUES
(7, 'Webcam HD', 1, 85.00, 10, 1),
(8, 'Parlantes Bluetooth', 1, 150.00, 15, 1);
