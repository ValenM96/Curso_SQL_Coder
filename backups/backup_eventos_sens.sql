CREATE DATABASE  IF NOT EXISTS `eventos_sens` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `eventos_sens`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: eventos_sens
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `catering`
--

DROP TABLE IF EXISTS `catering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catering` (
  `catering_id` int NOT NULL AUTO_INCREMENT,
  `evento_id` int DEFAULT NULL,
  `vendedora_id` int DEFAULT NULL,
  `descripcion` text,
  `costo` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`catering_id`),
  KEY `evento_id` (`evento_id`),
  KEY `vendedora_id` (`vendedora_id`),
  CONSTRAINT `catering_ibfk_1` FOREIGN KEY (`evento_id`) REFERENCES `evento` (`evento_id`),
  CONSTRAINT `catering_ibfk_2` FOREIGN KEY (`vendedora_id`) REFERENCES `vendedora` (`vendedora_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catering`
--

LOCK TABLES `catering` WRITE;
/*!40000 ALTER TABLE `catering` DISABLE KEYS */;
INSERT INTO `catering` VALUES (1,NULL,1,'Servicio de catering gourmet para eventos especiales',75000.00);
/*!40000 ALTER TABLE `catering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `cliente_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`cliente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Juan Pérez','juan.perez@email.com','1155667788','Av. Corrientes 1234'),(2,'María García','maria.garcia@email.com','1144332211','Belgrano 456'),(3,'Carlos Rodríguez','carlos.rodriguez@email.com','1166778899','Palermo 789'),(4,'Ana Martínez','ana.martinez@email.com','1133445566','Recoleta 234'),(5,'Luis González','luis.gonzalez@email.com','1177889900','San Telmo 567'),(6,'Sofía López','sofia.lopez@email.com','1122334455','Puerto Madero 890'),(7,'Diego Fernández','diego.fernandez@email.com','1199001122','Belgrano R 345'),(8,'Laura Torres','laura.torres@email.com','1188776655','Vicente López 678'),(9,'Roberto Sánchez','roberto.sanchez@email.com','1144556677','San Isidro 901'),(10,'Valentina Díaz','valentina.diaz@email.com','1133221144','Palermo Soho 234'),(11,'Martín Álvarez','martin.alvarez@email.com','1166990033','Recoleta 567'),(12,'Lucía Moreno','lucia.moreno@email.com','1177445599','Belgrano 890'),(13,'Alejandro Ruiz','alejandro.ruiz@email.com','1199332211','San Telmo 456'),(14,'Carolina Herrera','carolina.herrera@email.com','1155443322','Puerto Madero 789'),(15,'Mateo Gómez','mateo.gomez@email.com','1188990077','Palermo 345');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `costototalevento`
--

DROP TABLE IF EXISTS `costototalevento`;
/*!50001 DROP VIEW IF EXISTS `costototalevento`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `costototalevento` AS SELECT 
 1 AS `evento_id`,
 1 AS `nombre_evento`,
 1 AS `costo_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `detalleevento`
--

DROP TABLE IF EXISTS `detalleevento`;
/*!50001 DROP VIEW IF EXISTS `detalleevento`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `detalleevento` AS SELECT 
 1 AS `evento_id`,
 1 AS `nombre_evento`,
 1 AS `cliente`,
 1 AS `salon`,
 1 AS `fecha_evento`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento` (
  `evento_id` int NOT NULL AUTO_INCREMENT,
  `salon_id` int DEFAULT NULL,
  `tipo_evento_id` int DEFAULT NULL,
  `vendedora_id` int DEFAULT NULL,
  `nombre_evento` varchar(50) NOT NULL,
  `fecha` date DEFAULT NULL,
  `cliente_id` int DEFAULT NULL,
  PRIMARY KEY (`evento_id`),
  KEY `salon_id` (`salon_id`),
  KEY `tipo_evento_id` (`tipo_evento_id`),
  KEY `vendedora_id` (`vendedora_id`),
  KEY `cliente_id` (`cliente_id`),
  CONSTRAINT `evento_ibfk_1` FOREIGN KEY (`salon_id`) REFERENCES `salon` (`salon_id`),
  CONSTRAINT `evento_ibfk_2` FOREIGN KEY (`tipo_evento_id`) REFERENCES `tipo_evento` (`tipo_evento_id`),
  CONSTRAINT `evento_ibfk_3` FOREIGN KEY (`vendedora_id`) REFERENCES `vendedora` (`vendedora_id`),
  CONSTRAINT `evento_ibfk_4` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`cliente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES (16,1,1,5,'Cumpleaños de Juan','2024-03-15',1),(17,2,1,7,'Fiesta de 15 de María','2024-04-20',2),(18,1,1,NULL,'Aniversario de Carlos','2024-05-10',3),(19,2,1,NULL,'Boda de Ana','2024-06-05',4),(20,1,1,NULL,'Despedida de Soltero de Luis','2024-07-12',5),(21,1,2,6,'Conferencia Anual Tech','2024-03-25',6),(22,2,2,8,'Lanzamiento de Producto','2024-04-15',7),(23,2,2,NULL,'Seminario de Innovación','2024-05-20',8),(24,1,2,NULL,'Reunión Anual de Ejecutivos','2024-06-18',9),(25,2,2,NULL,'Workshop de Desarrollo','2024-07-22',10),(26,1,1,NULL,'Fiesta de Compromiso','2024-08-07',11),(27,2,2,NULL,'Congreso Internacional','2024-08-15',12),(28,1,1,NULL,'Graduación','2024-09-03',13),(29,2,2,NULL,'Presentación Corporativa','2024-09-20',14),(30,1,1,5,'Fiesta de Fin de Año','2024-12-31',15);
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento_servicio`
--

DROP TABLE IF EXISTS `evento_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento_servicio` (
  `evento_id` int NOT NULL,
  `servicio_id` int NOT NULL,
  `cantidad` int DEFAULT '1',
  PRIMARY KEY (`evento_id`,`servicio_id`),
  KEY `servicio_id` (`servicio_id`),
  CONSTRAINT `evento_servicio_ibfk_1` FOREIGN KEY (`evento_id`) REFERENCES `evento` (`evento_id`),
  CONSTRAINT `evento_servicio_ibfk_2` FOREIGN KEY (`servicio_id`) REFERENCES `servicio_adicional` (`servicio_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento_servicio`
--

LOCK TABLES `evento_servicio` WRITE;
/*!40000 ALTER TABLE `evento_servicio` DISABLE KEYS */;
INSERT INTO `evento_servicio` VALUES (16,1,1),(16,6,1),(16,10,1),(17,2,1),(17,3,1),(17,7,1),(18,4,1),(18,8,1),(18,12,1),(19,1,1),(19,3,1),(19,9,1),(20,6,1),(20,8,1),(20,10,1),(21,5,1),(21,14,2),(22,11,1),(23,13,1),(24,15,1),(25,2,1);
/*!40000 ALTER TABLE `evento_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `eventosporsalon`
--

DROP TABLE IF EXISTS `eventosporsalon`;
/*!50001 DROP VIEW IF EXISTS `eventosporsalon`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `eventosporsalon` AS SELECT 
 1 AS `salon`,
 1 AS `nombre_evento`,
 1 AS `fecha`,
 1 AS `tipo_evento`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura` (
  `factura_id` int NOT NULL AUTO_INCREMENT,
  `evento_id` int DEFAULT NULL,
  `fecha_emision` date DEFAULT NULL,
  `monto_total` decimal(10,2) DEFAULT NULL,
  `estado` enum('pendiente','pagado','cancelado') DEFAULT NULL,
  PRIMARY KEY (`factura_id`),
  KEY `evento_id` (`evento_id`),
  CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`evento_id`) REFERENCES `evento` (`evento_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
INSERT INTO `factura` VALUES (16,16,'2024-03-10',95000.00,'pagado'),(17,17,'2024-04-15',110000.00,'pendiente'),(18,18,'2024-05-05',105000.00,'pagado'),(19,19,'2024-05-30',125000.00,'pendiente'),(20,20,'2024-07-05',85000.00,'pagado'),(21,21,'2024-03-20',150000.00,'pagado'),(22,22,'2024-04-10',130000.00,'pendiente'),(23,23,'2024-05-15',140000.00,'pagado'),(24,24,'2024-06-10',120000.00,'pendiente'),(25,25,'2024-07-15',160000.00,'pagado'),(26,26,'2024-08-02',95000.00,'pendiente'),(27,27,'2024-08-10',180000.00,'pagado'),(28,28,'2024-09-01',100000.00,'pendiente'),(29,29,'2024-09-15',135000.00,'pagado'),(30,30,'2024-12-25',140000.00,'pendiente'),(31,20,'2024-11-26',70000.00,'pendiente');
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_evento`
--

DROP TABLE IF EXISTS `historial_evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_evento` (
  `historial_id` int NOT NULL AUTO_INCREMENT,
  `evento_id` int DEFAULT NULL,
  `descripcion` text,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `accion` enum('modificación','cancelación','actualización') DEFAULT NULL,
  PRIMARY KEY (`historial_id`),
  KEY `evento_id` (`evento_id`),
  CONSTRAINT `historial_evento_ibfk_1` FOREIGN KEY (`evento_id`) REFERENCES `evento` (`evento_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_evento`
--

LOCK TABLES `historial_evento` WRITE;
/*!40000 ALTER TABLE `historial_evento` DISABLE KEYS */;
INSERT INTO `historial_evento` VALUES (1,16,'Evento de cumpleaños creado inicialmente','2024-02-20 13:00:00','actualización'),(2,17,'Confirmación de detalles de la fiesta de 15','2024-03-15 17:30:00','modificación'),(3,18,'Cambio de ubicación del aniversario','2024-04-10 14:45:00','modificación'),(4,19,'Detalles de la boda finalizados','2024-05-01 12:15:00','actualización'),(5,20,'Ajustes en la lista de invitados de la despedida','2024-06-20 19:00:00','modificación'),(6,21,'Preparación de la conferencia anual','2024-03-01 16:30:00','actualización'),(7,22,'Confirmación de proveedores para lanzamiento','2024-04-05 13:45:00','modificación'),(8,23,'Detalles del seminario de innovación','2024-05-10 18:20:00','actualización'),(9,24,'Cambios en la agenda de la reunión ejecutiva','2024-06-10 14:00:00','modificación'),(10,25,'Planificación inicial del workshop','2024-07-01 17:15:00','actualización'),(11,26,'Detalles de la fiesta de compromiso','2024-07-25 19:30:00','modificación'),(12,27,'Preparación del congreso internacional','2024-08-01 13:00:00','actualización'),(13,28,'Coordinación de la graduación','2024-08-20 16:45:00','modificación'),(14,29,'Detalles de la presentación corporativa','2024-09-10 14:30:00','actualización'),(15,30,'Planificación de la fiesta de fin de año','2024-11-15 18:00:00','modificación');
/*!40000 ALTER TABLE `historial_evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'admin'),(2,'vendedora');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salon`
--

DROP TABLE IF EXISTS `salon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salon` (
  `salon_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `ubicacion` varchar(100) NOT NULL,
  PRIMARY KEY (`salon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salon`
--

LOCK TABLES `salon` WRITE;
/*!40000 ALTER TABLE `salon` DISABLE KEYS */;
INSERT INTO `salon` VALUES (1,'Espacio Tigre','Av. Libertador 1234'),(2,'5500 Figueroa','Figueroa 5500');
/*!40000 ALTER TABLE `salon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicio_adicional`
--

DROP TABLE IF EXISTS `servicio_adicional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicio_adicional` (
  `servicio_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `costo` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`servicio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicio_adicional`
--

LOCK TABLES `servicio_adicional` WRITE;
/*!40000 ALTER TABLE `servicio_adicional` DISABLE KEYS */;
INSERT INTO `servicio_adicional` VALUES (1,'Fotografía','Servicio profesional de fotografía para eventos',25000.00),(2,'Música en vivo','Banda en vivo para amenizar el evento',50000.00),(3,'Decoración','Decoración completa del salón',35000.00),(4,'Catering premium','Menú gourmet para eventos exclusivos',60000.00),(5,'Iluminación','Sistema de iluminación profesional',20000.00),(6,'DJ','Servicio de DJ profesional',30000.00),(7,'Pastel personalizado','Torta de diseño especial',15000.00),(8,'Coctel de bienvenida','Bebidas y aperitivos de recepción',18000.00),(9,'Video','Grabación profesional del evento',40000.00),(10,'Photobooth','Cabina de fotos con props',22000.00),(11,'Animación infantil','Entretenimiento para niños',12000.00),(12,'Arreglos florales','Centros de mesa y decoración floral',28000.00),(13,'Transporte','Servicio de transporte para invitados',45000.00),(14,'Personal de protocolo','Anfitriones y coordinadores',35000.00),(15,'Kit de bienvenida','Obsequios personalizados para invitados',10000.00);
/*!40000 ALTER TABLE `servicio_adicional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_evento`
--

DROP TABLE IF EXISTS `tipo_evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_evento` (
  `tipo_evento_id` int NOT NULL AUTO_INCREMENT,
  `nombre_tipo` varchar(50) NOT NULL,
  PRIMARY KEY (`tipo_evento_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_evento`
--

LOCK TABLES `tipo_evento` WRITE;
/*!40000 ALTER TABLE `tipo_evento` DISABLE KEYS */;
INSERT INTO `tipo_evento` VALUES (1,'evento social'),(2,'evento corporativo');
/*!40000 ALTER TABLE `tipo_evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `usuario_id` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`usuario_id`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'CarlaGomez','carla.gomez@ejemplo.com','contraseña_hasheada',2);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendedora`
--

DROP TABLE IF EXISTS `vendedora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendedora` (
  `vendedora_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `especialidad` enum('evento','catering','evento social','evento corporativo') NOT NULL,
  PRIMARY KEY (`vendedora_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedora`
--

LOCK TABLES `vendedora` WRITE;
/*!40000 ALTER TABLE `vendedora` DISABLE KEYS */;
INSERT INTO `vendedora` VALUES (1,'Aldana Martinez','catering'),(2,'Victoria Hualde','catering'),(5,'Maria Rodriguez','evento social'),(6,'Laura Gonzalez','evento corporativo'),(7,'Ana Perez','evento social'),(8,'Carla Sanchez','evento corporativo');
/*!40000 ALTER TABLE `vendedora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vendedorasespecializadas`
--

DROP TABLE IF EXISTS `vendedorasespecializadas`;
/*!50001 DROP VIEW IF EXISTS `vendedorasespecializadas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vendedorasespecializadas` AS SELECT 
 1 AS `nombre`,
 1 AS `especialidad`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `costototalevento`
--

/*!50001 DROP VIEW IF EXISTS `costototalevento`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `costototalevento` AS select `e`.`evento_id` AS `evento_id`,`e`.`nombre_evento` AS `nombre_evento`,`calcular_costo_evento`(`e`.`evento_id`) AS `costo_total` from `evento` `e` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `detalleevento`
--

/*!50001 DROP VIEW IF EXISTS `detalleevento`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `detalleevento` AS select `e`.`evento_id` AS `evento_id`,`e`.`nombre_evento` AS `nombre_evento`,`c`.`nombre` AS `cliente`,`s`.`nombre` AS `salon`,`e`.`fecha` AS `fecha_evento` from ((`evento` `e` join `cliente` `c` on((`e`.`cliente_id` = `c`.`cliente_id`))) join `salon` `s` on((`e`.`salon_id` = `s`.`salon_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `eventosporsalon`
--

/*!50001 DROP VIEW IF EXISTS `eventosporsalon`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `eventosporsalon` AS select `s`.`nombre` AS `salon`,`e`.`nombre_evento` AS `nombre_evento`,`e`.`fecha` AS `fecha`,`t`.`nombre_tipo` AS `tipo_evento` from ((`evento` `e` join `salon` `s` on((`e`.`salon_id` = `s`.`salon_id`))) join `tipo_evento` `t` on((`e`.`tipo_evento_id` = `t`.`tipo_evento_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vendedorasespecializadas`
--

/*!50001 DROP VIEW IF EXISTS `vendedorasespecializadas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vendedorasespecializadas` AS select `vendedora`.`nombre` AS `nombre`,`vendedora`.`especialidad` AS `especialidad` from `vendedora` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-17 21:45:34
