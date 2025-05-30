DROP PROCEDURE IF EXISTS SP_ActualizarStock;
DELIMITER $$
CREATE PROCEDURE SP_ActualizarStock(IN p_id_producto INT, IN p_cantidad INT)
BEGIN
    DECLARE count_product INT DEFAULT 0;

    -- Verificar existencia del producto
    SELECT COUNT(*) INTO count_product
        FROM productos
        WHERE id_producto = p_id_producto;
    IF count_product = 0 THEN
       SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Error: Producto no encontrado';
    END IF;

    -- Verificar que la cantidad sea mayor a 0
    IF p_cantidad <= 0 THEN
       SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Error: La cantidad no puede ser menor o igual a 0';
    END IF;

    -- Actualizar el stock del producto
    UPDATE productos
    SET stock = p_cantidad
    WHERE id_producto = p_id_producto;

    SELECT 'Stock Actualizado' AS Resultado;
END $$
DELIMITER ;

CALL SP_ActualizarStock(1, 5);