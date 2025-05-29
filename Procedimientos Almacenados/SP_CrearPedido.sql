DROP PROCEDURE IF EXISTS SP_CrearPedido;
DELIMITER $$
CREATE PROCEDURE SP_CrearPedido(IN p_id_cliente INT, IN p_id_producto INT, IN p_cantidad INT)
BEGIN
    DECLARE cliente_count  INT DEFAULT 0;
    DECLARE producto_count INT DEFAULT 0;

    -- Verificar que el cliente exista
    SELECT COUNT(*) INTO cliente_count
      FROM clientes
     WHERE id_cliente = p_id_cliente;
    IF cliente_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Cliente no encontrado (ID inválido)';
    END IF;

    SELECT COUNT(*) INTO producto_count
      FROM productos
     WHERE id_producto = p_id_producto;
    IF producto_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Producto no encontrado (ID inválido)';
    END IF;

    IF p_cantidad <= 0 THEN
       SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Error: La cantidad no puede ser menor o igual a 0';
    END IF;

    UPDATE pedidos SET;

    -- TODO: Preguntar por este procedure. Que hago con el p_id_producto
END $$
DELIMITER ;