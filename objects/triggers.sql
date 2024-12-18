DELIMITER //

CREATE TRIGGER after_evento_update
AFTER UPDATE ON Evento
FOR EACH ROW
BEGIN
    INSERT INTO Historial_Evento (evento_id, descripcion, accion)
    VALUES (NEW.evento_id, 'El evento ha sido actualizado', 'modificación');
END //

DELIMITER ;