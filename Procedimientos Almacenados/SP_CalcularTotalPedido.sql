DROP PROCEDURE IF EXISTS SP_CalcularTotalPedido;
DELIMITER $$
CREATE PROCEDURE SP_CalcularTotalPedido(
    IN p_id_pedido INT,
    OUT p_total DECIMAL(10,2)
)
BEGIN
    DECLARE v_cantidad INT;
    DECLARE v_precio DECIMAL(10,2);
    DECLARE v_subtotal DECIMAL(10,2) DEFAULT 0;
    DECLARE count_pedido INT DEFAULT 0;
    DECLARE done BOOLEAN DEFAULT FALSE;

    -- Cursor para recorrer los detalles del pedido
    DECLARE cur_detalles CURSOR FOR
        SELECT cantidad, precio
        FROM detalles_pedido
        WHERE id_pedido = p_id_pedido;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Verificar que el pedido existe
    SELECT COUNT(*) INTO count_pedido
    FROM pedidos
    WHERE id_pedido = p_id_pedido;

    -- Si no existe el pedido, lanzar un error
    IF count_pedido = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Pedido no encontrado';
    END IF;

    OPEN cur_detalles;
    SET p_total = 0;

    -- Recorrer los detalles del pedido y calcular el total
    read_loop: LOOP
        FETCH cur_detalles INTO v_cantidad, v_precio;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET v_subtotal = v_cantidad * v_precio;
        SET p_total = p_total + v_subtotal;
    END LOOP;

    CLOSE cur_detalles;

    -- Actualizar el total en la tabla pedidos
    UPDATE pedidos SET total = p_total
    WHERE id_pedido = p_id_pedido;
END $$
DELIMITER ;

-- Ejemplo de llamada al procedimiento
CALL SP_CalcularTotalPedido(1, @total);

SELECT @total AS Total_Pedido;