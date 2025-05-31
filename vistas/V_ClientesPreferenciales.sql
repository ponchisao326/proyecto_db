-- Muestra cada cliente con su total gastado y número de pedidos
CREATE VIEW V_ClientesPreferenciales AS
SELECT
    c.id_cliente, -- ID del cliente
    c.nombre, -- Nombre del cliente
    c.email, -- Email del cliente
    COUNT(p.id_pedido) AS num_pedidos, -- Número de pedidos realizados por el cliente
    COALESCE(SUM(p.total), 0) AS total_gastado -- Total gastado por el cliente
FROM
    clientes c
        LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY
    c.id_cliente,
    c.nombre,
    c.email;

-- Consulta de ejemplo para obtener los clientes preferenciales
SELECT * FROM V_ClientesPreferenciales;