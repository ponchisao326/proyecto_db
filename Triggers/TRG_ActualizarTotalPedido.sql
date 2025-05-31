DROP TRIGGER IF EXISTS TRG_ActualizarTotalPedido;
DELIMITER $$
CREATE TRIGGER TRG_ActualizarTotalPedido
    AFTER INSERT ON detalles_pedido
    FOR EACH ROW
BEGIN
    DECLARE v_cantidad INT DEFAULT 0;
    DECLARE v_precio DECIMAL(10, 2) DEFAULT 0;
    DECLARE v_total DECIMAL(10, 2) DEFAULT 0;
    DECLARE v_total_actual DECIMAL(10, 2) DEFAULT 0;

    -- Asigna los valores de la nueva fila a las variables
    SET v_cantidad = NEW.cantidad;
    SET v_precio = NEW.precio;

    -- Valida que la cantidad sea mayor a 0
    IF v_cantidad <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La cantidad no puede ser menor a 1';
    END IF;

    -- Valida que el precio sea mayor a 0
    IF v_precio <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: El precio no puede ser menor a 1';
    END IF;

    -- Obtiene el total actual del pedido
    SELECT total INTO v_total_actual FROM pedidos WHERE pedidos.id_pedido = NEW.id_pedido;

    -- Calcula el nuevo total sumando el subtotal del detalle insertado
    SET v_total = v_total_actual + (v_cantidad * v_precio);

    -- Actualiza el total en la tabla pedidos
    UPDATE pedidos SET total = v_total WHERE id_pedido = NEW.id_pedido;
END $$
DELIMITER ;