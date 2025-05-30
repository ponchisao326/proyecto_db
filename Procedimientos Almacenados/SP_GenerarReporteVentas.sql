DROP PROCEDURE IF EXISTS SP_GenerarReporteVentas;
DELIMITER $$
CREATE PROCEDURE SP_GenerarReporteVentas(IN p_fecha_inicio DATE, IN p_fecha_fin DATE)
BEGIN
    DECLARE v_total_ventas DECIMAL(10,2) DEFAULT 0;
    DECLARE v_total_pedidos INT DEFAULT 0;

    -- Verificar fechas
    IF p_fecha_inicio > p_fecha_fin THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: La fecha de inicio no puede ser mayor que la fecha de fin';
    END IF;

    -- Calcular total de ventas
    SELECT SUM(total) INTO v_total_ventas
    FROM pedidos
    WHERE fecha_pedido BETWEEN p_fecha_inicio AND p_fecha_fin;

    -- Contar total de pedidos
    SELECT COUNT(*) INTO v_total_pedidos
    FROM pedidos
    WHERE fecha_pedido BETWEEN p_fecha_inicio AND p_fecha_fin;

    SELECT
        v_total_ventas AS Total_Ventas,
        v_total_pedidos AS Total_Pedidos;

END $$
DELIMITER ;

-- Ejemplo de llamada al procedimiento
CALL SP_GenerarReporteVentas('2024-06-01', '2024-06-06');