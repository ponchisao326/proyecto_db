DROP PROCEDURE IF EXISTS SP_CalcularTotalPedido;
DELIMITER $$
CREATE PROCEDURE SP_CalcularTotalPedido(IN p_id_pedido INT, OUT p_total DECIMAL(10,2))
BEGIN
    DECLARE v_total DECIMAL(10,2);
    DECLARE count_pedido INT DEFAULT 0;

    -- Verificar que el pedido existe
    SELECT COUNT(*) INTO count_pedido
        FROM pedidos
        WHERE id_pedido = p_id_pedido;
    IF count_pedido = 0 THEN
       SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Error: Pedido no encontrado';
    END IF;

    SELECT p.total INTO v_total FROM pedidos p
    WHERE p.id_pedido = p_id_pedido;

    SET p_total = v_total;
END $$
DELIMITER ;