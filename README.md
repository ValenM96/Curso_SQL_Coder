# Sistema de Gestión de Salones de Eventos

## Descripción del Proyecto

Este proyecto implementa un sistema de gestión para un negocio de salones de eventos, permitiendo organizar, planificar y administrar diferentes tipos de eventos en dos salones: "Espacio Tigre" y "5500 Figueroa". La base de datos permite almacenar información sobre eventos, tipos de eventos, clientes, ventas, servicios adicionales, personal de ventas especializado, y registros de catering, entre otros.

Este sistema está diseñado para optimizar la gestión y organización de los eventos sociales y corporativos realizados en los salones, facilitando la asignación de personal, el control de los costos de catering y la facturación, entre otras tareas. También permite mantener un historial detallado de modificaciones y actualizaciones realizadas a los eventos, asegurando un registro transparente y completo.

## Objetivo

El objetivo principal de este sistema es **facilitar la administración de eventos y brindar una visión detallada de las operaciones del negocio** mediante una base de datos relacional en SQL. Al implementar este sistema, se resuelven problemas comunes en la gestión de eventos, como la dificultad de hacer seguimiento a los costos asociados, controlar la asignación de personal y mantener una organización clara de los datos del cliente y las facturas.

## Problemas que Resuelve

1. **Centralización de Datos**: Almacena y organiza toda la información relacionada con eventos, clientes, facturas, servicios y personal en una única base de datos.
2. **Seguimiento Financiero**: Calcula los costos de catering y servicios adicionales automáticamente, proporcionando claridad en la facturación y en los ingresos generados.
3. **Historial de Cambios**: Registra las modificaciones en los eventos, permitiendo llevar un historial de los cambios importantes.
4. **Consultas Eficientes**: Permite realizar consultas detalladas sobre eventos, ventas y clientes, mejorando la visibilidad y el control de la información del negocio.
5. **Asignación de Personal**: Facilita la organización del equipo de ventas asignado para cada evento, diferenciando las vendedoras especializadas en eventos y en catering.

## Estructura de la Base de Datos

La base de datos se compone de las siguientes tablas:

1. **Salon**: Almacena información sobre los salones de eventos.
2. **Tipo_Evento**: Define los tipos de eventos que se pueden realizar (sociales y corporativos).
3. **Vendedora**: Contiene información de las vendedoras asignadas, especializadas en eventos o en catering.
4. **Evento**: Registra detalles específicos de cada evento, como el salón, el tipo de evento, la vendedora asignada y el cliente.
5. **Cliente**: Contiene la información de los clientes que contratan los eventos.
6. **Catering**: Almacena los detalles y costos del servicio de catering asociado a cada evento.
7. **Factura**: Registra la facturación y el estado de pago de cada evento.
8. **Servicio_Adicional**: Contiene servicios adicionales que pueden ser contratados para un evento.
9. **Evento_Servicio**: Relaciona los servicios adicionales con los eventos, permitiendo especificar cantidad y costo.
10. **Historial_Evento**: Guarda un registro de las modificaciones realizadas en cada evento.

## Funcionalidades

### Funciones Implementadas

- **Función `calcular_costo_total(evento_id)`**: Calcula el costo total del catering de un evento específico.
- **Función `calcular_costo_evento(evento_id)`**: Calcula el costo total de un evento incluyendo catering y servicios adicionales.

### Vistas

- **Vista `EventosPorSalon`**: Muestra los eventos organizados por salón, incluyendo el nombre, fecha y tipo de evento.
- **Vista `CostoTotalEvento`**: Proporciona el costo total de cada evento (catering + servicios adicionales) utilizando la función `calcular_costo_evento`.
- **Vista `DetalleEvento`**: Detalla información de cada evento, mostrando el cliente, salón y fecha del evento.

### Triggers

- **Trigger `after_evento_update`**: Registra automáticamente en `Historial_Evento` cualquier modificación realizada a un evento, guardando una descripción y la acción de modificación.

## Requisitos Previos

Para ejecutar este proyecto de base de datos, se necesita:

- **MySQL Server**: Instalar [MySQL Server](https://dev.mysql.com/downloads/mysql/) para poder crear y administrar la base de datos.
- **MySQL Workbench**: Instalar [MySQL Workbench](https://dev.mysql.com/downloads/workbench/) para gestionar el diseño y realizar consultas en la base de datos de manera visual.
- **Herramienta de Modelado** (opcional): Se recomienda MySQL Workbench para la creación y visualización del diagrama E-R de la base de datos.

## Instrucciones de Instalación

1. **Descarga**: Clona el repositorio o descarga los archivos SQL en tu computadora local.
2. **Configuración de la Base de Datos**: Abre MySQL Workbench y ejecuta el script SQL en el archivo `eventos_sens.sql` para crear las tablas y cargar datos iniciales.
3. **Ejecución de Consultas**: Usa las consultas SQL proporcionadas en este README o en los archivos del repositorio para interactuar con los datos de la base y verificar la funcionalidad del sistema.

## Diagrama E-R

El diagrama entidad-relación (E-R) es fundamental para comprender las relaciones en la base de datos. Las relaciones principales son:

- **Evento** y **Salon**: Cada evento está vinculado a un salón específico.
- **Evento** y **Cliente**: Cada evento está asociado a un cliente.
- **Evento** y **Catering**: Cada evento puede tener un servicio de catering asociado.
- **Evento** y **Servicio_Adicional**: Se relacionan para registrar los servicios adicionales contratados en cada evento.

El diagrama E-R está disponible en formato de archivo dentro del repositorio y también se puede visualizar en MySQL Workbench.

---

**Autor**: [Valentin Meyer]
