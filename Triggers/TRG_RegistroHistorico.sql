DROP TRIGGER IF EXISTS TRG_RegistroHistorico;
DELIMITER $$
CREATE TRIGGER TRG_RegistroHistorico
    AFTER UPDATE ON productos
    FOR EACH ROW
BEGIN
    -- Verificar si el precio cambió
    IF OLD.precio <> NEW.precio THEN
        -- Insertar en la tabla de histórico
        INSERT INTO registro_historico (id_producto, precio_old, precio_new, fecha_cambio)
        VALUES ( OLD.id_producto, OLD.precio, NEW.precio, CURRENT_TIMESTAMP);
    END IF;
END $$
DELIMITER ;