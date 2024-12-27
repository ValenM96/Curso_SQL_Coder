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

CREATE VIEW IngresosPorVendedora AS
SELECT 
    v.nombre AS vendedora, 
    SUM(f.monto_total) AS ingreso_total
FROM Vendedora v
JOIN Evento e ON v.vendedora_id = e.vendedora_id
JOIN Factura f ON e.evento_id = f.evento_id
GROUP BY v.nombre;