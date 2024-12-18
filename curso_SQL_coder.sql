DROP DATABASE IF EXISTS eventos_sens;
CREATE DATABASE eventos_sens; 
USE eventos_sens;

CREATE TABLE Salon (
    salon_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL
);

CREATE TABLE Tipo_Evento (
    tipo_evento_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo VARCHAR(50) NOT NULL
);

CREATE TABLE Vendedora (
    vendedora_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    especialidad ENUM('evento', 'catering') NOT NULL
);

CREATE TABLE Evento (
    evento_id INT PRIMARY KEY AUTO_INCREMENT,
    salon_id INT,
    tipo_evento_id INT,
    vendedora_id INT,
    nombre_evento VARCHAR(50) NOT NULL,
    fecha DATE,
    FOREIGN KEY (salon_id) REFERENCES Salon(salon_id),
    FOREIGN KEY (tipo_evento_id) REFERENCES Tipo_Evento(tipo_evento_id),
    FOREIGN KEY (vendedora_id) REFERENCES Vendedora(vendedora_id)
);

CREATE TABLE Catering (
    catering_id INT PRIMARY KEY AUTO_INCREMENT,
    evento_id INT,
    vendedora_id INT,
    descripcion TEXT,
    costo DECIMAL(10, 2),
    FOREIGN KEY (evento_id) REFERENCES Evento(evento_id),
    FOREIGN KEY (vendedora_id) REFERENCES Vendedora(vendedora_id)
);

CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(15),
    direccion VARCHAR(150)
);

ALTER TABLE Evento ADD COLUMN cliente_id INT;
ALTER TABLE Evento ADD FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id);

CREATE TABLE Factura (
    factura_id INT PRIMARY KEY AUTO_INCREMENT,
    evento_id INT,
    fecha_emision DATE,
    monto_total DECIMAL(10, 2),
    estado ENUM('pendiente', 'pagado', 'cancelado'),
    FOREIGN KEY (evento_id) REFERENCES Evento(evento_id)
);

CREATE TABLE Servicio_Adicional (
    servicio_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    costo DECIMAL(10, 2)
);

CREATE TABLE Evento_Servicio (
    evento_id INT,
    servicio_id INT,
    cantidad INT DEFAULT 1,
    PRIMARY KEY (evento_id, servicio_id),
    FOREIGN KEY (evento_id) REFERENCES Evento(evento_id),
    FOREIGN KEY (servicio_id) REFERENCES Servicio_Adicional(servicio_id)
);

CREATE TABLE Historial_Evento (
    historial_id INT PRIMARY KEY AUTO_INCREMENT,
    evento_id INT,
    descripcion TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    accion ENUM('modificación', 'cancelación', 'actualización'),
    FOREIGN KEY (evento_id) REFERENCES Evento(evento_id)
);

-- Crear tabla de roles
CREATE TABLE Role (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

-- Crear tabla de usuarios
CREATE TABLE Usuario (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES Role(role_id)
);

-- Listar todos los eventos en un salón específico
SELECT nombre_evento, fecha 
FROM Evento 
WHERE salon_id = 1;

-- Ordenar eventos por fecha
SELECT nombre_evento, fecha 
FROM Evento 
ORDER BY fecha;

-- Mostrar los eventos junto con la vendedora asignada
SELECT e.nombre_evento, e.fecha, v.nombre AS vendedora
FROM Evento e
JOIN Vendedora v ON e.vendedora_id = v.vendedora_id
ORDER BY e.fecha;

-- Obtener el total de costo de catering por cada salón
SELECT s.nombre AS salon, SUM(c.costo) AS total_catering
FROM Salon s
JOIN Evento e ON s.salon_id = e.salon_id
JOIN Catering c ON e.evento_id = c.evento_id
GROUP BY s.nombre;

SELECT s.nombre AS salon, MONTH(f.fecha_emision) AS mes, SUM(f.monto_total) AS total_ingresos
FROM Factura f
JOIN Evento e ON f.evento_id = e.evento_id
JOIN Salon s ON e.salon_id = s.salon_id
GROUP BY s.nombre, mes;

SELECT v.nombre AS vendedora, t.nombre_tipo AS tipo_evento, COUNT(e.evento_id) AS total_eventos
FROM Evento e
JOIN Vendedora v ON e.vendedora_id = v.vendedora_id
JOIN Tipo_Evento t ON e.tipo_evento_id = t.tipo_evento_id
GROUP BY v.nombre, t.nombre_tipo;


DELIMITER //

CREATE FUNCTION calcular_costo_total(evento INT) 
RETURNS DECIMAL(10, 2) 
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(costo) INTO total
    FROM Catering
    WHERE evento_id = evento;
    RETURN total;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER after_evento_update
AFTER UPDATE ON Evento
FOR EACH ROW
BEGIN
    INSERT INTO Historial_Evento (evento_id, descripcion, accion)
    VALUES (NEW.evento_id, 'El evento ha sido actualizado', 'modificación');
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION calcular_costo_evento(evento INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE catering_total DECIMAL(10, 2) DEFAULT 0;
    DECLARE servicio_total DECIMAL(10, 2) DEFAULT 0;

    SELECT COALESCE(SUM(c.costo), 0) INTO catering_total
    FROM Catering c
    WHERE c.evento_id = evento;

    SELECT COALESCE(SUM(sa.costo * es.cantidad), 0) INTO servicio_total
    FROM Evento_Servicio es
    JOIN Servicio_Adicional sa ON es.servicio_id = sa.servicio_id
    WHERE es.evento_id = evento;

    RETURN catering_total + servicio_total;
END //

DELIMITER ;



CREATE VIEW EventosPorSalon AS
SELECT s.nombre AS salon, e.nombre_evento, e.fecha, t.nombre_tipo AS tipo_evento
FROM Evento e
JOIN Salon s ON e.salon_id = s.salon_id
JOIN Tipo_Evento t ON e.tipo_evento_id = t.tipo_evento_id;

CREATE VIEW VendedorasEspecializadas AS
SELECT nombre, especialidad
FROM Vendedora;

CREATE VIEW CostoTotalEvento AS
SELECT e.evento_id, e.nombre_evento, calcular_costo_evento(e.evento_id) AS costo_total
FROM Evento e;

CREATE VIEW DetalleEvento AS
SELECT e.evento_id, e.nombre_evento, c.nombre AS cliente, s.nombre AS salon, e.fecha AS fecha_evento
FROM Evento e
JOIN Cliente c ON e.cliente_id = c.cliente_id
JOIN Salon s ON e.salon_id = s.salon_id;


