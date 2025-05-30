DROP TRIGGER IF EXISTS TRG_ControlStock;
DELIMITER $$
CREATE TRIGGER TRG_ControlStock
    BEFORE INSERT ON detalles_pedido
    FOR EACH ROW
BEGIN
    DECLARE v_stock_actual INT;

    -- Verificar el stock del producto
    SELECT stock INTO v_stock_actual FROM productos
    WHERE id_producto = NEW.id_producto;

    -- Verificar si el stock es suficiente
    IF v_stock_actual IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Producto no encontrado';
    ELSEIF v_stock_actual < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Stock insuficiente';
    END IF;
END $$

DELIMITER ;