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