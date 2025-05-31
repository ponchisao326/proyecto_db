-- Vista para obtener las estadísticas de ventas
CREATE VIEW V_EstadisticasVentas AS
SELECT
    YEAR(p.fecha_pedido)  AS anio, -- Año del pedido
    MONTH(p.fecha_pedido) AS mes, -- Mes del pedido
    COUNT(p.id_pedido) AS total_pedidos, -- Total de pedidos realizados en el mes
    COALESCE(SUM(p.total), 0) AS total_ingresos -- Total de ingresos generados en el mes
FROM
    pedidos p
GROUP BY
    YEAR(p.fecha_pedido),
    MONTH(p.fecha_pedido);

-- Consulta de ejemplo para obtener las estadísticas de ventas
SELECT * FROM V_EstadisticasVentas;