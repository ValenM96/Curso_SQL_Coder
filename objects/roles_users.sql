INSERT INTO Permiso (permiso_nombre, descripcion) VALUES
('gestionar_usuarios', 'Permite agregar, modificar o eliminar usuarios.'),
('ver_ventas', 'Permite visualizar el historial de ventas.'),
('gestionar_inventario', 'Permite agregar o modificar productos en inventario.');

-- Permisos para admin
CALL asignar_permiso_rol(1, 1); -- gestionar_usuarios
CALL asignar_permiso_rol(1, 2); -- ver_ventas
CALL asignar_permiso_rol(1, 3); -- gestionar_inventario

-- Permisos para vendedora
CALL asignar_permiso_rol(2, 2); -- ver_ventas

CALL registrar_usuario('admin1', 'admin1@ejemplo.com', 'contraseña_hasheada', 1); -- Rol: admin
CALL registrar_usuario('vendedora1', 'vendedora1@ejemplo.com', 'contraseña_hasheada', 2); -- Rol: vendedora

