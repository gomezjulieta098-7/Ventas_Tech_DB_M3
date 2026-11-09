USE Ventas_Tech_DB;
GO

-- Consulta 1: detalle de ventas con datos de clientes, productos, categorias y territorios.
SELECT
    v.id_venta,
    v.fecha_venta,
    c.nombre AS cliente,
    c.ciudad,
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    t.region,
    t.zona,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
INNER JOIN territorios t
    ON v.id_territorio = t.id_territorio;

-- Consulta 2: clientes registrados que todavia no realizaron compras.
SELECT
    c.nombre AS cliente,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Consulta 3: productos del catalogo que todavia no tienen ventas.
SELECT
    p.nombre_producto AS producto,
    c.nombre_categoria AS categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
INNER JOIN categorias c
    ON p.id_categoria = c.id_categoria
WHERE v.id_venta IS NULL;

-- Consulta 4: UNION ALL para agrupar facturacion por canal simulado.

SELECT
    canal,
    SUM(total) AS total_facturado
FROM (
    SELECT
        cantidad * precio_unitario AS total,
        'Online' AS canal
    FROM ventas
    WHERE id_producto IN (1, 2, 3)

    UNION ALL

    SELECT
        cantidad * precio_unitario AS total,
        'Presencial' AS canal
    FROM ventas
    WHERE id_producto IN (4, 5, 6)
) AS resumen
GROUP BY canal;

