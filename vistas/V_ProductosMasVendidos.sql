-- Vista para obtener los productos más vendidos
CREATE VIEW V_ProductosMasVendidos AS
SELECT
    p.id_producto, -- ID del producto
    p.nombre, -- Nombre del producto
    COALESCE(SUM(dp.cantidad), 0) AS total_vendido -- Total vendido del producto. Coalesce para manejar productos sin ventas
FROM
    productos p
    LEFT JOIN detalles_pedido dp ON p.id_producto = dp.id_producto
GROUP BY
    p.id_producto,
    p.nombre;

-- Consulta para obtener los productos más vendidos
SELECT *
FROM V_ProductosMasVendidos
ORDER BY total_vendido DESC;
