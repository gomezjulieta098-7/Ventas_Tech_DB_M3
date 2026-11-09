-- M4 - Datos adicionales de practica (ventas 11 a 60)
-- Datos simulados para analizar ventas entre 2024 y 2025.
-- Primero ejecutar el script del M3, que crea las tablas y carga las ventas 1 a 10.
-- Luego ejecutar ESTE archivo UNA SOLA VEZ sobre esa base recien creada.
-- Si ya tenes las 60 ventas cargadas, NO lo ejecutes nuevamente.

USE Ventas_Tech_DB;
GO

-- Comprobacion de seguridad: solo cargar sobre las 10 ventas originales.
IF (SELECT COUNT(*) FROM ventas) = 10
BEGIN
INSERT INTO ventas
(id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta)
VALUES
(11, 1, 1, 2, 1200.00, '2024-01-10'),
(12, 2, 3, 2, 450.00, '2024-01-20'),
(13, 3, 4, 3, 120.00, '2024-02-15'),
(14, 4, 5, 2, 130.00, '2024-02-25'),
(15, 5, 6, 4, 95.00, '2024-06-12'),
(16, 1, 2, 5, 25.00, '2024-09-18'),
(17, 2, 1, 1, 1200.00, '2025-01-10'),
(18, 3, 3, 2, 450.00, '2025-01-22'),
(19, 4, 4, 2, 120.00, '2025-03-14'),
(20, 5, 5, 3, 130.00, '2025-03-26'),
(21, 1, 6, 2, 95.00, '2025-06-11'),
(22, 2, 2, 4, 25.00, '2025-09-19'),
(23, 2, 3, 1, 450.00, '2024-04-05'),
(24, 5, 2, 4, 25.00, '2024-05-06'),
(25, 3, 1, 3, 1200.00, '2024-07-07'),
(26, 1, 6, 2, 95.00, '2024-08-05'),
(27, 4, 5, 1, 130.00, '2024-10-06'),
(28, 2, 4, 4, 120.00, '2024-11-07'),
(29, 5, 3, 3, 450.00, '2024-12-05'),
(30, 3, 2, 2, 25.00, '2025-02-06'),
(31, 1, 1, 1, 1200.00, '2025-04-07'),
(32, 4, 6, 4, 95.00, '2025-05-05'),
(33, 2, 5, 3, 130.00, '2025-07-06'),
(34, 5, 4, 2, 120.00, '2025-08-07'),
(35, 3, 3, 1, 450.00, '2025-10-05'),
(36, 1, 2, 4, 25.00, '2025-11-06'),
(37, 4, 1, 3, 1200.00, '2025-12-07'),
(38, 2, 6, 2, 95.00, '2024-04-13'),
(39, 5, 5, 1, 130.00, '2024-05-14'),
(40, 3, 4, 4, 120.00, '2024-07-15'),
(41, 1, 3, 3, 450.00, '2024-08-13'),
(42, 4, 2, 2, 25.00, '2024-10-14'),
(43, 2, 1, 1, 1200.00, '2024-11-15'),
(44, 5, 6, 4, 95.00, '2024-12-13'),
(45, 3, 5, 3, 130.00, '2025-02-14'),
(46, 1, 4, 2, 120.00, '2025-04-15'),
(47, 4, 3, 1, 450.00, '2025-05-13'),
(48, 2, 2, 4, 25.00, '2025-07-14'),
(49, 5, 1, 3, 1200.00, '2025-08-15'),
(50, 3, 6, 2, 95.00, '2025-10-13'),
(51, 1, 5, 1, 130.00, '2025-11-14'),
(52, 4, 4, 4, 120.00, '2025-12-15'),
(53, 2, 3, 3, 450.00, '2024-04-21'),
(54, 5, 2, 2, 25.00, '2024-05-22'),
(55, 3, 1, 1, 1200.00, '2024-07-23'),
(56, 1, 6, 4, 95.00, '2024-08-21'),
(57, 4, 5, 3, 130.00, '2024-10-22'),
(58, 2, 4, 2, 120.00, '2024-11-23'),
(59, 5, 3, 1, 450.00, '2024-12-21'),
(60, 3, 2, 4, 25.00, '2025-02-22');
END
ELSE
BEGIN
    PRINT 'No se agregaron ventas: la base no tiene exactamente las 10 ventas originales.';
END;

-- Verificacion final
SELECT COUNT(*) AS cantidad_ventas,
       SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas;

SELECT YEAR(fecha_venta) AS anio,
       MONTH(fecha_venta) AS mes,
       SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
ORDER BY anio, mes;
