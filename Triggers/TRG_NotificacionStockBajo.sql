DROP TRIGGER IF EXISTS TRG_NotificacionStockBajo;
DELIMITER $$
CREATE TRIGGER TRG_NotificacionStockBajo
    AFTER UPDATE ON productos
    FOR EACH ROW
BEGIN
    DECLARE v_stock_actual INT;
    DECLARE v_stock_minimo INT DEFAULT 5;

    SET v_stock_actual = NEW.stock;

    IF v_stock_actual < v_stock_minimo THEN
        INSERT INTO notificaciones_stock(id_producto, stock_actual, mensaje)
        VALUES (NEW.id_producto, v_stock_actual,
                CONCAT(
                'WARNING: El producto: ', NEW.nombre,
                'Se encuentra en bajo stock, articulos restantes: ', v_stock_actual)
                );
    END IF;
END $$
DELIMITER ;