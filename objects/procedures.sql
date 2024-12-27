USE eventos_sens;

DROP PROCEDURE IF EXISTS calcular_ingreso_salon;

DELIMITER //

CREATE PROCEDURE calcular_ingreso_salon (
    IN p_salon_id INT, 
    OUT p_ingreso_total DECIMAL(10, 2)
)
BEGIN
    -- Declarar una variable para verificar la existencia del salón
    DECLARE salon_existe INT DEFAULT 0;

    -- Verificar si el salón existe
    SELECT COUNT(*) INTO salon_existe 
    FROM Salon 
    WHERE salon_id = p_salon_id;

    -- Validar que el salón exista
    IF salon_existe = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El ID del salón no existe.';
    END IF;

    -- Calcular el ingreso total del salón
    SELECT 
        IFNULL(SUM(f.monto_total), 0) 
    INTO p_ingreso_total
    FROM Factura f
    JOIN Evento e ON f.evento_id = e.evento_id
    WHERE e.salon_id = p_salon_id;
END //

DELIMITER ;


CALL calcular_ingreso_salon(1, @ingreso_total);
SELECT @ingreso_total;

DROP PROCEDURE IF EXISTS ObtenerInformacionEvento;

DELIMITER //

CREATE PROCEDURE ObtenerInformacionEvento (
    IN p_evento_id INT
)
BEGIN
    -- Declarar una variable para verificar la existencia del evento
    DECLARE evento_existe INT DEFAULT 0;

    -- Verificar si el evento existe
    SELECT COUNT(*) INTO evento_existe 
    FROM Evento 
    WHERE evento_id = p_evento_id;

    -- Validar que el evento exista
    IF evento_existe = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El ID del evento no existe.';
    END IF;

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
    WHERE e.evento_id = p_evento_id;

    -- Servicios adicionales para el evento
    SELECT 
        es.servicio_id, 
        sa.nombre AS servicio, 
        es.cantidad, 
        sa.costo, 
        (sa.costo * es.cantidad) AS costo_total
    FROM Evento_Servicio es
    JOIN Servicio_Adicional sa ON es.servicio_id = sa.servicio_id
    WHERE es.evento_id = p_evento_id;
END //

DELIMITER ;

CALL ObtenerInformacionEvento(20);

DROP PROCEDURE IF EXISTS GenerarFacturaEvento;

DELIMITER //

CREATE PROCEDURE GenerarFacturaEvento (
    IN p_evento_id INT
)
BEGIN
    -- Declarar variables
    DECLARE v_monto_total DECIMAL(10, 2) DEFAULT 0;
    DECLARE v_evento_existe INT DEFAULT 0;

    -- Verificar si el evento existe
    SELECT COUNT(*) INTO v_evento_existe 
    FROM Evento 
    WHERE evento_id = p_evento_id;

    -- Validar que el evento exista
    IF v_evento_existe = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El ID del evento no existe.';
    END IF;

    -- Verificar si ya existe una factura para este evento
    IF EXISTS (SELECT 1 FROM Factura WHERE evento_id = p_evento_id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Ya existe una factura para este evento.';
    END IF;

    -- Calcular el monto total sumando los servicios adicionales
    SELECT 
        IFNULL(SUM(sa.costo * es.cantidad), 0) 
    INTO v_monto_total
    FROM Evento_Servicio es
    JOIN Servicio_Adicional sa ON es.servicio_id = sa.servicio_id
    WHERE es.evento_id = p_evento_id;

    -- Validar que el monto total sea mayor a 0
    IF v_monto_total = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se pueden generar facturas sin monto total.';
    END IF;

    -- Insertar una nueva factura para el evento
    INSERT INTO Factura (evento_id, fecha_emision, monto_total, estado)
    VALUES (p_evento_id, CURDATE(), v_monto_total, 'pendiente');

    -- Devolver el ID de la factura generada
    SELECT LAST_INSERT_ID() AS factura_id;
END //

DELIMITER ;

CALL GenerarFacturaEvento();

DELIMITER //

DROP PROCEDURE IF EXISTS registrar_usuario;

CREATE PROCEDURE registrar_usuario(
    IN p_nombre_usuario VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_contrasena VARCHAR(255),
    IN p_role_id INT
)
BEGIN
    -- Declarar variables de control
    DECLARE v_usuario_existe INT DEFAULT 0;
    DECLARE v_email_existe INT DEFAULT 0;
    DECLARE v_role_existe INT DEFAULT 0;

    -- Validar que el rol exista
    SELECT COUNT(*) INTO v_role_existe
    FROM Role
    WHERE role_id = p_role_id;

    IF v_role_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El rol especificado no existe.';
    END IF;

    -- Validar que el email no esté ya registrado
    SELECT COUNT(*) INTO v_email_existe
    FROM Usuario
    WHERE email = p_email;

    IF v_email_existe > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El email ya está registrado.';
    END IF;

    -- Validar que el nombre de usuario no esté ya registrado
    SELECT COUNT(*) INTO v_usuario_existe
    FROM Usuario
    WHERE nombre_usuario = p_nombre_usuario;

    IF v_usuario_existe > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre de usuario ya existe.';
    END IF;

    -- Insertar un nuevo usuario
    INSERT INTO Usuario (nombre_usuario, email, contraseña, role_id)
    VALUES (p_nombre_usuario, p_email, p_contrasena, p_role_id);

    -- Devolver el ID del usuario recién insertado
    SELECT LAST_INSERT_ID() AS usuario_id;
END //

DELIMITER ;


-- Registrar un usuario con rol de vendedora
CALL registrar_usuario('CarlaGomez', 'carla.gomez@ejemplo.com', 'contraseña_hasheada', 2);

DROP PROCEDURE IF EXISTS login_usuario;

DELIMITER //

CREATE PROCEDURE login_usuario(
    IN p_email VARCHAR(100),
    IN p_contrasena VARCHAR(255)
)
BEGIN
    DECLARE v_usuario_id INT;
    DECLARE v_role_id INT;
    DECLARE v_nombre_usuario VARCHAR(100);

    -- Verificar si el correo electrónico y la contraseña coinciden
    SELECT usuario_id, role_id, nombre_usuario
    INTO v_usuario_id, v_role_id, v_nombre_usuario
    FROM Usuario
    WHERE email = p_email AND contraseña = p_contrasena;

    -- Manejar el caso de usuario no encontrado
    IF v_usuario_id IS NULL THEN
        SELECT 0 AS usuario_id, 
            NULL AS role_id, 
            'Credenciales inválidas' AS mensaje;
    ELSE
        -- Devolver información del usuario
        SELECT 
            v_usuario_id AS usuario_id, 
            v_role_id AS role_id, 
            v_nombre_usuario AS nombre_usuario,
            'Inicio de sesión exitoso' AS mensaje;
    END IF;
END //

DELIMITER ;

CALL login_usuario('carla.gomez@ejemplo.com', 'contraseña_hasheada');

DELIMITER //

DROP PROCEDURE IF EXISTS asignar_permiso_rol;

CREATE PROCEDURE asignar_permiso_rol(
    IN p_rol_id INT,
    IN p_permiso_id INT
)
BEGIN
    -- Validar que el rol exista
    IF NOT EXISTS (SELECT 1 FROM Role WHERE role_id = p_rol_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El rol especificado no existe.';
    END IF;

    -- Validar que el permiso exista
    IF NOT EXISTS (SELECT 1 FROM Permiso WHERE permiso_id = p_permiso_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El permiso especificado no existe.';
    END IF;

    -- Insertar la relación rol-permiso
    INSERT IGNORE INTO RolPermiso (rol_id, permiso_id)
    VALUES (p_rol_id, p_permiso_id);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE verificar_permiso_usuario(
    IN p_usuario_id INT,
    IN p_permiso_nombre VARCHAR(100)
)
BEGIN
    DECLARE v_permiso_existe INT;

    SELECT COUNT(*)
    INTO v_permiso_existe
    FROM Usuario u
    JOIN Role r ON u.role_id = r.role_id
    JOIN RolPermiso rp ON r.role_id = rp.rol_id
    JOIN Permiso p ON rp.permiso_id = p.permiso_id
    WHERE u.usuario_id = p_usuario_id
    AND p.permiso_nombre = p_permiso_nombre;

    IF v_permiso_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Acceso denegado. El usuario no tiene el permiso requerido.';
    END IF;

    SELECT 'Acceso permitido' AS mensaje;
END //

DELIMITER ;
