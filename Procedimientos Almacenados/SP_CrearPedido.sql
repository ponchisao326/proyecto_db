DROP PROCEDURE IF EXISTS SP_CrearPedido;
DELIMITER $$
CREATE PROCEDURE SP_CrearPedido(
    IN p_id_cliente INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE cliente_count INT DEFAULT 0;
    DECLARE producto_count INT DEFAULT 0;
    DECLARE v_stock_actual INT;
    DECLARE v_precio DECIMAL(10,2);
    DECLARE v_id_pedido INT;
    DECLARE v_total DECIMAL(10,2) DEFAULT 0;

    -- Verificar cliente
    SELECT COUNT(*) INTO cliente_count FROM clientes WHERE id_cliente = p_id_cliente;
    IF cliente_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Cliente no encontrado';
    END IF;

    -- Verificar producto
    SELECT COUNT(*) INTO producto_count FROM productos WHERE id_producto = p_id_producto;
    IF producto_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Producto no encontrado';
    END IF;

    -- Verificar cantidad
    IF p_cantidad <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Cantidad inválida';
    END IF;

    -- Obtener stock y precio actual
    SELECT stock, precio INTO v_stock_actual, v_precio
    FROM productos
    WHERE id_producto = p_id_producto;

    -- Verificar stock
    IF v_stock_actual < p_cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Stock insuficiente. Disponible: ';
    END IF;

    -- Crear registro en PEDIDOS
    INSERT INTO pedidos (id_cliente, fecha_pedido, estado, total)
    VALUES (p_id_cliente, NOW(), 'Pendiente', 0);

    SET v_id_pedido = LAST_INSERT_ID();

    -- Agregar a DETALLES_PEDIDO
    INSERT INTO detalles_pedido (id_pedido, id_producto, cantidad, precio)
    VALUES (v_id_pedido, p_id_producto, p_cantidad, v_precio);

    -- Actualizar stock
    UPDATE productos
    SET stock = stock - p_cantidad
    WHERE id_producto = p_id_producto;

    -- Calcular total
    SET v_total = p_cantidad * v_precio;

    -- Actualizar total en PEDIDOS
    UPDATE pedidos
    SET total = v_total
    WHERE id_pedido = v_id_pedido;

    -- Mensaje de éxito
    SELECT CONCAT('Pedido creado exitosamente. ID: ', v_id_pedido, ' | Total: $', v_total) AS Resultado;
END $$
DELIMITER ;