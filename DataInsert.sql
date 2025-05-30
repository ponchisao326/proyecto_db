-- Datos de ejemplo
-- Categorías
INSERT INTO categorias (nombre, descripcion) VALUES
('Electrónica', 'Dispositivos electrónicos'),
('Ropa', 'Prendas de vestir'),
('Libros', 'Libros y revistas');

-- Productos
INSERT INTO productos (nombre, descripcion, precio, id_categoria, stock) VALUES
('Smartphone', 'Teléfono inteligente', 299.99, 1, 50),
('Laptop', 'Ordenador portátil', 799.99, 1, 30),
('Camiseta', 'Camiseta de algodón', 15.00, 2, 100),
('Libro de SQL', 'Aprende SQL desde cero', 25.50, 3, 40);

-- Clientes
INSERT INTO clientes (nombre, email, telefono, direccion) VALUES
('Juan Pérez', 'juan@example.com', '600123456', 'Calle Real 1'),
('María López', 'maria@example.com', '600654321', 'Avenida Central 45'),
('Carlos Ruiz', 'carlos@example.com', '600987654', 'Plaza Mayor 10');

-- Pedidos
INSERT INTO pedidos (id_cliente, fecha_pedido, estado, total) VALUES
(1, '2024-06-01 10:00:00', 'Pendiente', 0),
(2, '2024-06-02 12:30:00', 'Pendiente', 0);

-- Detalles de pedido
INSERT INTO detalles_pedido (id_pedido, id_producto, cantidad, precio) VALUES
(1, 1, 2, 299.99),   -- 2 Smartphones
(1, 3, 5, 15.00),    -- 5 Camisetas
(2, 2, 1, 799.99),   -- 1 Laptop
(2, 4, 3, 25.50);    -- 3 Libros de SQL