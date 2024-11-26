USE eventos_sens;

DELIMITER //

CREATE PROCEDURE calcular_ingreso_salon (IN salon INT, OUT ingreso_total DECIMAL(10, 2))
BEGIN
    SELECT SUM(f.monto_total) 
    INTO ingreso_total
    FROM Factura f
    JOIN Evento e ON f.evento_id = e.evento_id
    WHERE e.salon_id = salon;
END //

DELIMITER ;


CALL calcular_ingreso_salon(1, @ingreso_total);
SELECT @ingreso_total AS 'Ingreso Total';

DELIMITER //

CREATE PROCEDURE ObtenerInformacionEvento(IN eventoID INT)
BEGIN
    -- Información básica del evento
    SELECT 
        e.evento_id, 
        e.nombre_evento, 
        e.fecha, 
        s.nombre AS salon, 
        t.nombre_tipo AS tipo_evento, 
        v.nombre AS vendedora, 
        c.nombre AS cliente, 
        c.email AS cliente_email, 
        c.telefono AS cliente_telefono
    FROM Evento e
    JOIN Salon s ON e.salon_id = s.salon_id
    JOIN Tipo_Evento t ON e.tipo_evento_id = t.tipo_evento_id
    JOIN Vendedora v ON e.vendedora_id = v.vendedora_id
    JOIN Cliente c ON e.cliente_id = c.cliente_id
    WHERE e.evento_id = eventoID;

    -- Servicios adicionales para el evento
    SELECT 
        es.servicio_id, 
        sa.nombre AS servicio, 
        es.cantidad, 
        sa.costo, 
        (sa.costo * es.cantidad) AS costo_total
    FROM Evento_Servicio es
    JOIN Servicio_Adicional sa ON es.servicio_id = sa.servicio_id
    WHERE es.evento_id = eventoID;
    
END //

DELIMITER ;

CALL ObtenerInformacionEvento(20);

DELIMITER //

CREATE PROCEDURE GenerarFacturaEvento(IN eventoID INT)
BEGIN
    DECLARE monto_total DECIMAL(10, 2) DEFAULT 0;
    
    -- Calcular el monto total sumando los servicios adicionales
    SELECT SUM(sa.costo * es.cantidad) INTO monto_total
    FROM Evento_Servicio es
    JOIN Servicio_Adicional sa ON es.servicio_id = sa.servicio_id
    WHERE es.evento_id = eventoID;
    
    -- Insertar una nueva factura para el evento
    INSERT INTO Factura (evento_id, fecha_emision, monto_total, estado)
    VALUES (eventoID, CURDATE(), monto_total, 'pendiente');
    
END //

DELIMITER ;

CALL GenerarFacturaEvento(20);


