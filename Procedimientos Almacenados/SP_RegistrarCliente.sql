DROP PROCEDURE IF EXISTS SP_RegistrarCliente;
DELIMITER $$
CREATE PROCEDURE SP_RegistrarCliente(IN p_nombre VARCHAR(100), IN p_email VARCHAR(100), IN p_telefono VARCHAR(15), IN p_direccion VARCHAR(200))
BEGIN

    IF p_email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Formato de email inválido';
    END IF;

    INSERT INTO clientes (nombre, email, telefono, direccion) VALUES
        (p_nombre, p_email, p_telefono, p_direccion);

    SELECT CONCAT('Insertado nuevo cliente con nombre: ', p_nombre, ', email: ', p_email, ', telefono: ', p_telefono, ', y direccion: ', p_direccion) AS Resultado;
END $$
DELIMITER ;

CALL SP_RegistrarCliente('Ana Pérez', 'ana@example.com', '34600123456', 'Calle Falsa 123');