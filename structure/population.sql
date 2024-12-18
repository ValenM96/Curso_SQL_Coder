USE eventos_sens;

INSERT INTO Salon (nombre, ubicacion) VALUES 
('Espacio Tigre', 'Av. Libertador 1234'),
('5500 Figueroa', 'Figueroa 5500');

INSERT INTO Tipo_Evento (nombre_tipo) VALUES 
('evento social'),
('evento corporativo');

-- Kiria Catering vendedoras
INSERT INTO Vendedora (nombre, especialidad) VALUES 
('Aldana Martinez', 'catering'),
('Victoria Hualde', 'catering');

-- Vendedoras para Espacio Tigre
INSERT INTO Vendedora (nombre, especialidad) VALUES 
('Maria Rodriguez', 'Evento Social'),
('Laura Gonzalez', 'Evento Corporativo');

-- Vendedoras para 5500 Figueroa
INSERT INTO Vendedora (nombre, especialidad) VALUES 
('Ana Perez', 'Evento social'),
('Carla Sanchez', 'Evento Corporativo');

INSERT INTO Cliente (nombre, email, telefono, direccion) VALUES 
('Juan Pérez', 'juan.perez@email.com', '1155667788', 'Av. Corrientes 1234'),
('María García', 'maria.garcia@email.com', '1144332211', 'Belgrano 456'),
('Carlos Rodríguez', 'carlos.rodriguez@email.com', '1166778899', 'Palermo 789'),
('Ana Martínez', 'ana.martinez@email.com', '1133445566', 'Recoleta 234'),
('Luis González', 'luis.gonzalez@email.com', '1177889900', 'San Telmo 567'),
('Sofía López', 'sofia.lopez@email.com', '1122334455', 'Puerto Madero 890'),
('Diego Fernández', 'diego.fernandez@email.com', '1199001122', 'Belgrano R 345'),
('Laura Torres', 'laura.torres@email.com', '1188776655', 'Vicente López 678'),
('Roberto Sánchez', 'roberto.sanchez@email.com', '1144556677', 'San Isidro 901'),
('Valentina Díaz', 'valentina.diaz@email.com', '1133221144', 'Palermo Soho 234'),
('Martín Álvarez', 'martin.alvarez@email.com', '1166990033', 'Recoleta 567'),
('Lucía Moreno', 'lucia.moreno@email.com', '1177445599', 'Belgrano 890'),
('Alejandro Ruiz', 'alejandro.ruiz@email.com', '1199332211', 'San Telmo 456'),
('Carolina Herrera', 'carolina.herrera@email.com', '1155443322', 'Puerto Madero 789'),
('Mateo Gómez', 'mateo.gomez@email.com', '1188990077', 'Palermo 345');

INSERT INTO Servicio_Adicional (nombre, descripcion, costo) VALUES 
('Fotografía', 'Servicio profesional de fotografía para eventos', 25000.00),
('Música en vivo', 'Banda en vivo para amenizar el evento', 50000.00),
('Decoración', 'Decoración completa del salón', 35000.00),
('Catering premium', 'Menú gourmet para eventos exclusivos', 60000.00),
('Iluminación', 'Sistema de iluminación profesional', 20000.00),
('DJ', 'Servicio de DJ profesional', 30000.00),
('Pastel personalizado', 'Torta de diseño especial', 15000.00),
('Coctel de bienvenida', 'Bebidas y aperitivos de recepción', 18000.00),
('Video', 'Grabación profesional del evento', 40000.00),
('Photobooth', 'Cabina de fotos con props', 22000.00),
('Animación infantil', 'Entretenimiento para niños', 12000.00),
('Arreglos florales', 'Centros de mesa y decoración floral', 28000.00),
('Transporte', 'Servicio de transporte para invitados', 45000.00),
('Personal de protocolo', 'Anfitriones y coordinadores', 35000.00),
('Kit de bienvenida', 'Obsequios personalizados para invitados', 10000.00);

INSERT INTO Role (role_name) VALUES ('admin');
INSERT INTO Role (role_name) VALUES ('vendedora');

INSERT INTO Catering (evento_id, vendedora_id, descripcion, costo) VALUES 
((SELECT MAX(evento_id) FROM Evento), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Aldana Martinez'), 
 'Servicio de catering gourmet para eventos especiales', 75000.00);
 
INSERT INTO Evento (salon_id, tipo_evento_id, vendedora_id, cliente_id, nombre_evento, fecha) VALUES 
-- Social Eventos
(1, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Social'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Maria Rodriguez'), 
 1, 'Cumpleaños de Juan', '2024-03-15'),

(2, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Social'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Ana Perez'), 
 2, 'Fiesta de 15 de María', '2024-04-20'),

(1, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Social'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Sofia Torres'), 
 3, 'Aniversario de Carlos', '2024-05-10'),

(2, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Social'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Paula Martinez'), 
 4, 'Boda de Ana', '2024-06-05'),

(1, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Social'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Valentina Lopez'), 
 5, 'Despedida de Soltero de Luis', '2024-07-12'),

-- Corporate Events
(1, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Corporativo'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Laura Gonzalez'), 
 6, 'Conferencia Anual Tech', '2024-03-25'),

(2, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Corporativo'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Carla Sanchez'), 
 7, 'Lanzamiento de Producto', '2024-04-15'),

(2, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Corporativo'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Lucia Fernandez'), 
 8, 'Seminario de Innovación', '2024-05-20'),

(1, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Corporativo'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Julia Diaz'), 
 9, 'Reunión Anual de Ejecutivos', '2024-06-18'),

(2, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Corporativo'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Martina Ruiz'), 
 10, 'Workshop de Desarrollo', '2024-07-22'),

-- Additional Mixed Events
(1, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Social'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Camila Garcia'), 
 11, 'Fiesta de Compromiso', '2024-08-07'),

(2, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Corporativo'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Catalina Morales'), 
 12, 'Congreso Internacional', '2024-08-15'),

(1, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Social'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Isabella Navarro'), 
 13, 'Graduación', '2024-09-03'),

(2, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Corporativo'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Victoria Romero'), 
 14, 'Presentación Corporativa', '2024-09-20'),

(1, (SELECT tipo_evento_id FROM Tipo_Evento WHERE nombre_tipo = 'Evento Social'), 
 (SELECT vendedora_id FROM Vendedora WHERE nombre = 'Maria Rodriguez'), 
 15, 'Fiesta de Fin de Año', '2024-12-31');
 
INSERT INTO Factura (evento_id, fecha_emision, monto_total, estado) VALUES 
(16, '2024-03-10', 95000.00, 'pagado'),
(17, '2024-04-15', 110000.00, 'pendiente'),
(18, '2024-05-05', 105000.00, 'pagado'),
(19, '2024-05-30', 125000.00, 'pendiente'),
(20, '2024-07-05', 85000.00, 'pagado'),
(21, '2024-03-20', 150000.00, 'pagado'),
(22, '2024-04-10', 130000.00, 'pendiente'),
(23, '2024-05-15', 140000.00, 'pagado'),
(24, '2024-06-10', 120000.00, 'pendiente'),
(25, '2024-07-15', 160000.00, 'pagado'),
(26, '2024-08-02', 95000.00, 'pendiente'),
(27, '2024-08-10', 180000.00, 'pagado'),
(28, '2024-09-01', 100000.00, 'pendiente'),
(29, '2024-09-15', 135000.00, 'pagado'),
(30, '2024-12-25', 140000.00, 'pendiente');

INSERT INTO Evento_Servicio (evento_id, servicio_id, cantidad) VALUES 
-- Event 1: Cumpleaños de Juan
(16, 1, 1), -- Fotografía
(16, 6, 1), -- DJ
(16, 10, 1), -- Photobooth

-- Event 2: Fiesta de 15 de María
(17, 2, 1), -- Música en vivo
(17, 3, 1), -- Decoración
(17, 7, 1), -- Pastel personalizado

-- Event 3: Aniversario de Carlos
(18, 4, 1), -- Catering premium
(18, 8, 1), -- Coctel de bienvenida
(18, 12, 1), -- Arreglos florales

-- Event 4: Boda de Ana
(19, 1, 1), -- Fotografía
(19, 9, 1), -- Video
(19, 3, 1), -- Decoración

-- Event 5: Despedida de Soltero de Luis
(20, 6, 1), -- DJ
(20, 10, 1), -- Photobooth
(20, 8, 1), -- Coctel de bienvenida

-- Corporate Events
(21, 5, 1), -- Iluminación
(21, 14, 2), -- Personal de protocolo
(22, 11, 1), -- Animación infantil
(23, 13, 1), -- Transporte
(24, 15, 1), -- Kit de bienvenida
(25, 2, 1); -- Música en vivo

INSERT INTO Historial_Evento (evento_id, descripcion, fecha, accion) VALUES 
(16, 'Evento de cumpleaños creado inicialmente', '2024-02-20 10:00:00', 'actualización'),
(17, 'Confirmación de detalles de la fiesta de 15', '2024-03-15 14:30:00', 'modificación'),
(18, 'Cambio de ubicación del aniversario', '2024-04-10 11:45:00', 'modificación'),
(19, 'Detalles de la boda finalizados', '2024-05-01 09:15:00', 'actualización'),
(20, 'Ajustes en la lista de invitados de la despedida', '2024-06-20 16:00:00', 'modificación'),
(21, 'Preparación de la conferencia anual', '2024-03-01 13:30:00', 'actualización'),
(22, 'Confirmación de proveedores para lanzamiento', '2024-04-05 10:45:00', 'modificación'),
(23, 'Detalles del seminario de innovación', '2024-05-10 15:20:00', 'actualización'),
(24, 'Cambios en la agenda de la reunión ejecutiva', '2024-06-10 11:00:00', 'modificación'),
(25, 'Planificación inicial del workshop', '2024-07-01 14:15:00', 'actualización'),
(26, 'Detalles de la fiesta de compromiso', '2024-07-25 16:30:00', 'modificación'),
(27, 'Preparación del congreso internacional', '2024-08-01 10:00:00', 'actualización'),
(28, 'Coordinación de la graduación', '2024-08-20 13:45:00', 'modificación'),
(29, 'Detalles de la presentación corporativa', '2024-09-10 11:30:00', 'actualización'),
(30, 'Planificación de la fiesta de fin de año', '2024-11-15 15:00:00', 'modificación');
