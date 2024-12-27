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
CREATE TRIGGER after_factura_insert
AFTER INSERT ON Factura
FOR EACH ROW
BEGIN
    INSERT INTO LogFacturas (factura_id, fecha, monto_total)
    VALUES (NEW.factura_id, NEW.fecha_emision, NEW.monto_total);
END //
DELIMITER ;