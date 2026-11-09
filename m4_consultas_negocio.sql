USE Ventas_Tech_DB;
GO

-- CONSULTA 1: Resumen mensual de ventas
SELECT
    YEAR(fecha_venta) AS anio,
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) / COUNT(*) AS ticket_promedio
FROM ventas
GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
ORDER BY anio, mes;

-- CONSULTA 2: Cinco productos con mayor facturacion
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- CONSULTA 3: Clientes que realizaron mas de un pedido
SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY cantidad_pedidos DESC;

-- CONSULTA 4: Facturacion mensual comparada con el promedio mensual
SELECT
    anio,
    mes,
    total_mensual,
    CASE
        WHEN total_mensual > (
            SELECT AVG(total_mensual)
            FROM (
                SELECT
                    YEAR(fecha_venta) AS anio,
                    MONTH(fecha_venta) AS mes,
                    SUM(cantidad * precio_unitario) AS total_mensual
                FROM ventas
                GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
            ) AS promedio
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion
FROM (
    SELECT
        YEAR(fecha_venta) AS anio,
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_mensual
    FROM ventas
    GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
) AS resumen
ORDER BY anio, mes;

-- HALLAZGO 1: PRODUCTOS CON MAYOR FACTURACION
-- La Laptop Pro 15 fue el producto que mas facturo, con $21.600,seguida por el Monitor 4K 27, con $9.000
-- Ambos representaron aproximadamente el 78,5% de la facturacion de los 5 productos principales

-- HALLAZGO 2: CLIENTES RECURRENTES
-- Los cinco clientes realizaron mas de una compra.
-- El cliente 2 registro la mayor cantidad de pedidos (13),mientras que el cliente 5 fue el que mas gasto ($9.170)
-- Comprar mas veces no siempre significa gastar mas.

-- HALLAZGO 3: COMPARACION CON EL PROMEDIO MENSUAL
-- El promedio mensual de facturacion fue de $1.670.
-- Febrero de 2024 ($620) y febrero de 2025 ($540) estuvieron por debajo de ese promedio, mientras que Enero en ambos años estuvo por encima
--Estos datos simulados permiten investigar posibles patrones estacionales.
