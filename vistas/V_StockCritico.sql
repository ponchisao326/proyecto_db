CREATE VIEW V_StockCritico AS
SELECT
    p.id_producto, -- ID del producto
    p.nombre AS nombre_producto, -- Nombre del producto
    p.stock, -- Stock actual del producto
    c.nombre AS nombre_categoria -- Nombre de la categoría del producto
FROM
    productos p
    JOIN categorias c ON p.id_categoria = c.id_categoria
WHERE
    p.stock <= 5;

-- Consulta para obtener los productos con stock crítico
SELECT * FROM V_StockCritico;