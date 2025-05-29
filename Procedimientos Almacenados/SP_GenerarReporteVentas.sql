DROP PROCEDURE IF EXISTS SP_GenerarReporteVentas;
DELIMITER $$
CREATE PROCEDURE SP_GenerarReporteVentas(IN p_fecha_inicio DATE, IN p_fecha_fin DATE)
BEGIN
    SELECT
        p.ID_Pedido AS 'ID PEDIDO',
        p.ID_Cliente AS 'ID CLIENTE',
        p.Fecha_Pedido AS 'FECHA PEDIDO',
        p.Estado AS 'ESTADO',
        p.Total AS 'TOTAL'
    FROM pedidos p
    WHERE p.Fecha_Pedido BETWEEN p_fecha_inicio AND p_fecha_fin
    ORDER BY p.Fecha_Pedido DESC;
END $$
DELIMITER ;

CALL SP_GenerarReporteVentas('2024-01-01', '2024-12-31');