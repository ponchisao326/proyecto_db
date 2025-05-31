# Sistema de Gestión de Base de Datos para E-Commerce

## Descripción

Este proyecto implementa un sistema completo de gestión de base de datos para una tienda online, utilizando SQL, procedimientos almacenados, triggers y vistas. Permite la administración eficiente de productos, clientes, pedidos y reportes de ventas.

---

## Estructura del Proyecto

- **TableCreation.sql**: Script de creación de todas las tablas y relaciones.
- **DataInsert.sql**: Inserción de datos de ejemplo para pruebas.
- **Procedimientos Almacenados/**: Scripts de procedimientos almacenados:
    - `SP_RegistrarCliente.sql`
    - `SP_CrearPedido.sql`
    - `SP_ActualizarStock.sql`
    - `SP_CalcularTotalPedido.sql`
    - `SP_GenerarReporteVentas.sql`
- **Triggers/**: Scripts de triggers:
    - `TRG_ControlStock.sql`
    - `TRG_ActualizarTotalPedido.sql`
    - `TRG_RegistroHistorico.sql`
    - `TRG_NotificacionStockBajo.sql`
- **Vistas/**: Scripts de vistas:
    - `V_ProductosMasVendidos.sql`
    - `V_ClientesPreferenciales.sql`
    - `V_EstadisticasVentas.sql`
    - `V_StockCritico.sql`
- **Deletions/deletionsanddrops.sql**: Script para eliminar datos y tablas (útil para testing).

---

## Funcionalidades

### Procedimientos Almacenados

- **SP_RegistrarCliente**: Registra un nuevo cliente validando el email.
- **SP_CrearPedido**: Crea un pedido, verifica stock y actualiza inventario.
- **SP_ActualizarStock**: Actualiza el stock de un producto.
- **SP_CalcularTotalPedido**: Calcula y actualiza el total de un pedido.
- **SP_GenerarReporteVentas**: Genera un reporte de ventas por rango de fechas.

### Triggers

- **TRG_ControlStock**: Verifica stock antes de insertar en detalles de pedido.
- **TRG_ActualizarTotalPedido**: Actualiza el total del pedido tras agregar detalles.
- **TRG_RegistroHistorico**: Registra cambios de precio en productos.
- **TRG_NotificacionStockBajo**: Genera alerta cuando el stock es bajo.

### Vistas

- **V_ProductosMasVendidos**: Lista productos más vendidos.
- **V_ClientesPreferenciales**: Muestra clientes con mayor gasto y número de pedidos.
- **V_EstadisticasVentas**: Estadísticas mensuales de ventas.
- **V_StockCritico**: Productos con stock crítico.

---

## Pruebas

Puedes utilizar los ejemplos de llamadas a procedimientos y consultas incluidas en cada script para probar la funcionalidad del sistema.

