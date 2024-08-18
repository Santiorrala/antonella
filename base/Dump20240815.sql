-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: django_estetica
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `api_est_m_categoria`
--

DROP TABLE IF EXISTS `api_est_m_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_est_m_categoria` (
  `ca_codigo` bigint unsigned NOT NULL,
  `ca_nombre` varchar(100) DEFAULT NULL,
  `es_codigo_id` bigint unsigned NOT NULL,
  `ca_imagen` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ca_codigo`),
  KEY `api_est_m_categoria_es_codigo_id_4b848209` (`es_codigo_id`),
  CONSTRAINT `api_est_m_categoria_es_codigo_id_4b848209_fk_api_est_m` FOREIGN KEY (`es_codigo_id`) REFERENCES `api_est_m_especialidad` (`es_codigo`),
  CONSTRAINT `api_est_m_categoria_chk_1` CHECK ((`ca_codigo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_est_m_categoria`
--

LOCK TABLES `api_est_m_categoria` WRITE;
/*!40000 ALTER TABLE `api_est_m_categoria` DISABLE KEYS */;
INSERT INTO `api_est_m_categoria` VALUES (1,'Manicure',1,'manicure.png'),(2,'PEDICURE',1,'pedicure.png'),(3,'PELUQUERIA',2,'peluqueria.png'),(4,'CORTES',2,'cortes.png'),(5,'CEJAS Y PESTAÑAS',2,'cejas.png'),(6,'EVENTOS',2,'eventos.png'),(8,'DEPILACION',3,'depilacion.png'),(9,'SPA',3,'spa.png'),(10,'TRATAMIENTOS FACIALES',3,'facial.png');
/*!40000 ALTER TABLE `api_est_m_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_est_m_cita`
--

DROP TABLE IF EXISTS `api_est_m_cita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_est_m_cita` (
  `ci_codigo` bigint unsigned NOT NULL,
  `ci_fecha` date NOT NULL,
  `ci_hora` varchar(5) NOT NULL,
  `ci_estado` tinyint(1) NOT NULL,
  `ci_nota` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ci_codigo`),
  CONSTRAINT `api_est_m_cita_chk_1` CHECK ((`ci_codigo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_est_m_cita`
--

LOCK TABLES `api_est_m_cita` WRITE;
/*!40000 ALTER TABLE `api_est_m_cita` DISABLE KEYS */;
INSERT INTO `api_est_m_cita` VALUES (1,'2024-08-13','08:00',1,'cita 1 de las 8'),(2,'2024-08-13','08:00',1,'cita 2 de las 8'),(3,'2024-08-13','08:00',1,'cita 3 de las 8'),(4,'2024-08-13','09:00',1,'cita 1 de las 9'),(5,'2024-08-13','09:00',1,'cita 2 de las 9'),(6,'2024-08-13','15:00',1,'cita 2 de las 3'),(7,'2024-08-13','12:00',1,'Pendiente'),(8,'2024-08-13','18:00',3,'Cancelada'),(9,'2024-08-13','18:00',3,'Cancelada'),(10,'2024-08-15','08:00',1,'Pendiente');
/*!40000 ALTER TABLE `api_est_m_cita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_est_m_cita_servicio`
--

DROP TABLE IF EXISTS `api_est_m_cita_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_est_m_cita_servicio` (
  `cs_codigo` bigint unsigned NOT NULL,
  `em_codigo_id` bigint unsigned NOT NULL,
  `cl_codigo_id` bigint unsigned NOT NULL,
  `ci_codigo_id` bigint unsigned NOT NULL,
  `se_codigo_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`cs_codigo`),
  KEY `api_est_m_cita_servicio_ci_codigo_id_b70c0a91` (`ci_codigo_id`),
  KEY `api_est_m_cita_servicio_cl_codigo_id_68f49cce` (`cl_codigo_id`),
  KEY `api_est_m_cita_servicio_em_codigo_id_dc14b4bb` (`em_codigo_id`),
  KEY `api_est_m_cita_servicio_se_codigo_id_48f6b7cd` (`se_codigo_id`),
  CONSTRAINT `api_est_m_cita_servi_ci_codigo_id_b70c0a91_fk_api_est_m` FOREIGN KEY (`ci_codigo_id`) REFERENCES `api_est_m_cita` (`ci_codigo`),
  CONSTRAINT `api_est_m_cita_servi_cl_codigo_id_68f49cce_fk_api_est_m` FOREIGN KEY (`cl_codigo_id`) REFERENCES `api_est_m_cliente` (`cl_codigo`),
  CONSTRAINT `api_est_m_cita_servi_em_codigo_id_dc14b4bb_fk_api_est_m` FOREIGN KEY (`em_codigo_id`) REFERENCES `api_est_m_emplado` (`em_codigo`),
  CONSTRAINT `api_est_m_cita_servi_se_codigo_id_48f6b7cd_fk_api_est_m` FOREIGN KEY (`se_codigo_id`) REFERENCES `api_est_m_servicio` (`se_codigo`),
  CONSTRAINT `api_est_m_cita_servicio_chk_1` CHECK ((`cs_codigo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_est_m_cita_servicio`
--

LOCK TABLES `api_est_m_cita_servicio` WRITE;
/*!40000 ALTER TABLE `api_est_m_cita_servicio` DISABLE KEYS */;
INSERT INTO `api_est_m_cita_servicio` VALUES (1,1,1,1,1),(2,2,2,2,1),(3,3,3,3,1),(4,2,2,4,3),(5,2,2,6,1),(6,2,1,7,3),(7,2,1,8,1),(8,2,1,9,1),(9,1,1,10,4);
/*!40000 ALTER TABLE `api_est_m_cita_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_est_m_cliente`
--

DROP TABLE IF EXISTS `api_est_m_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_est_m_cliente` (
  `cl_codigo` bigint unsigned NOT NULL,
  `us_codigo_id` bigint unsigned NOT NULL,
  `cl_forma_pago` varchar(100) DEFAULT NULL,
  `cl_calificacion` bigint unsigned NOT NULL,
  PRIMARY KEY (`cl_codigo`),
  KEY `api_est_m_cliente_us_codigo_id_cf1d9ec4` (`us_codigo_id`),
  CONSTRAINT `api_est_m_cliente_us_codigo_id_cf1d9ec4_fk_api_est_m` FOREIGN KEY (`us_codigo_id`) REFERENCES `api_est_m_usuario` (`us_codigo`),
  CONSTRAINT `api_est_m_cliente_chk_1` CHECK ((`cl_codigo` >= 0)),
  CONSTRAINT `api_est_m_cliente_chk_3` CHECK ((`cl_calificacion` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_est_m_cliente`
--

LOCK TABLES `api_est_m_cliente` WRITE;
/*!40000 ALTER TABLE `api_est_m_cliente` DISABLE KEYS */;
INSERT INTO `api_est_m_cliente` VALUES (1,0,'efe',5),(2,5,'efe',5),(3,6,'efe',5);
/*!40000 ALTER TABLE `api_est_m_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_est_m_emplado`
--

DROP TABLE IF EXISTS `api_est_m_emplado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_est_m_emplado` (
  `em_codigo` bigint unsigned NOT NULL,
  `us_codigo_id` bigint unsigned NOT NULL,
  `em_especialidad` varchar(100) NOT NULL,
  `em_fecha_contrato` date DEFAULT NULL,
  `em_hora_entrada` varchar(100) NOT NULL,
  `em_hora_salida` varchar(100) NOT NULL,
  `em_imagen` varchar(100) NOT NULL,
  PRIMARY KEY (`em_codigo`),
  KEY `api_est_m_emplado_us_codigo_id_f9c1f274` (`us_codigo_id`),
  CONSTRAINT `api_est_m_emplado_us_codigo_id_f9c1f274_fk_api_est_m` FOREIGN KEY (`us_codigo_id`) REFERENCES `api_est_m_usuario` (`us_codigo`),
  CONSTRAINT `api_est_m_emplado_chk_1` CHECK ((`em_codigo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_est_m_emplado`
--

LOCK TABLES `api_est_m_emplado` WRITE;
/*!40000 ALTER TABLE `api_est_m_emplado` DISABLE KEYS */;
INSERT INTO `api_est_m_emplado` VALUES (1,1,'1','2024-08-01','08:00','12:00','foto1.png'),(2,2,'1','2024-08-02','09:00','13:00','foto2.png'),(3,3,'1','2024-08-01','11:00','17:00','foto3.png'),(4,4,'2','2024-08-01','12:00','18:00','foto4.png');
/*!40000 ALTER TABLE `api_est_m_emplado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_est_m_empleado_especialidad`
--

DROP TABLE IF EXISTS `api_est_m_empleado_especialidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_est_m_empleado_especialidad` (
  `ee_codigo` bigint unsigned NOT NULL,
  `es_codigo_id` bigint unsigned NOT NULL,
  `em_codigo_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`ee_codigo`),
  KEY `api_est_m_empleado_especialidad_em_codigo_id_6ee77e0b` (`em_codigo_id`),
  KEY `api_est_m_empleado_especialidad_es_codigo_id_31a5529c` (`es_codigo_id`),
  CONSTRAINT `api_est_m_empleado_e_em_codigo_id_6ee77e0b_fk_api_est_m` FOREIGN KEY (`em_codigo_id`) REFERENCES `api_est_m_emplado` (`em_codigo`),
  CONSTRAINT `api_est_m_empleado_e_es_codigo_id_31a5529c_fk_api_est_m` FOREIGN KEY (`es_codigo_id`) REFERENCES `api_est_m_especialidad` (`es_codigo`),
  CONSTRAINT `api_est_m_empleado_especialidad_chk_1` CHECK ((`ee_codigo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_est_m_empleado_especialidad`
--

LOCK TABLES `api_est_m_empleado_especialidad` WRITE;
/*!40000 ALTER TABLE `api_est_m_empleado_especialidad` DISABLE KEYS */;
INSERT INTO `api_est_m_empleado_especialidad` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4);
/*!40000 ALTER TABLE `api_est_m_empleado_especialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_est_m_especialidad`
--

DROP TABLE IF EXISTS `api_est_m_especialidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_est_m_especialidad` (
  `es_codigo` bigint unsigned NOT NULL,
  `es_nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`es_codigo`),
  CONSTRAINT `api_est_m_especialidad_chk_1` CHECK ((`es_codigo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_est_m_especialidad`
--

LOCK TABLES `api_est_m_especialidad` WRITE;
/*!40000 ALTER TABLE `api_est_m_especialidad` DISABLE KEYS */;
INSERT INTO `api_est_m_especialidad` VALUES (1,'MANICURISTA'),(2,'ESTILISTA'),(3,'COSMETOLOGA');
/*!40000 ALTER TABLE `api_est_m_especialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_est_m_servicio`
--

DROP TABLE IF EXISTS `api_est_m_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_est_m_servicio` (
  `se_codigo` bigint unsigned NOT NULL,
  `se_nombre` varchar(100) NOT NULL,
  `se_descripcion` varchar(100) DEFAULT NULL,
  `se_duracion` bigint unsigned NOT NULL,
  `se_precio` varchar(100) NOT NULL,
  `se_estado` tinyint(1) NOT NULL,
  `ca_codigo_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`se_codigo`),
  KEY `api_est_m_servicio_ca_codigo_id_86105572` (`ca_codigo_id`),
  CONSTRAINT `api_est_m_servicio_ca_codigo_id_86105572_fk_api_est_m` FOREIGN KEY (`ca_codigo_id`) REFERENCES `api_est_m_categoria` (`ca_codigo`),
  CONSTRAINT `api_est_m_servicio_chk_1` CHECK ((`se_codigo` >= 0)),
  CONSTRAINT `api_est_m_servicio_chk_2` CHECK ((`se_duracion` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_est_m_servicio`
--

LOCK TABLES `api_est_m_servicio` WRITE;
/*!40000 ALTER TABLE `api_est_m_servicio` DISABLE KEYS */;
INSERT INTO `api_est_m_servicio` VALUES (1,'PINTADA DE UÑAS','PINTADA DE UÑAS',1,'10 A 20 MINUTOS',1,1),(2,'PINTADA UÑAS DE PIES','PINTADA UÑAS DE PIES',1,'10 A 20 MINUTOS',1,1),(3,'ACRILICAS','UÑAS ACRILICAS',2,'10 A 20 MINUTOS',1,1),(4,'pies','pies',1,'1 a 2 dolar',1,2);
/*!40000 ALTER TABLE `api_est_m_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_est_m_usuario`
--

DROP TABLE IF EXISTS `api_est_m_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_est_m_usuario` (
  `us_codigo` bigint unsigned NOT NULL,
  `us_cedula` varchar(10) NOT NULL,
  `us_nombre` varchar(100) NOT NULL,
  `us_apellido` varchar(100) NOT NULL,
  `us_correo` varchar(100) NOT NULL,
  `us_telefono` varchar(10) NOT NULL,
  `us_clave` varchar(100) NOT NULL,
  `ro_codigo_id` bigint unsigned NOT NULL,
  `us_estado` tinyint(1) NOT NULL,
  `us_comentarios` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`us_codigo`),
  UNIQUE KEY `api_est_m_usuario_us_cedula_2ec7f147_uniq` (`us_cedula`),
  KEY `api_est_m_usuario_ro_codigo_id_c282e765` (`ro_codigo_id`),
  CONSTRAINT `api_est_m_usuario_ro_codigo_id_c282e765_fk_api_est_s` FOREIGN KEY (`ro_codigo_id`) REFERENCES `api_est_s_roles` (`ro_codigo`),
  CONSTRAINT `api_est_m_usuario_chk_1` CHECK ((`us_codigo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_est_m_usuario`
--

LOCK TABLES `api_est_m_usuario` WRITE;
/*!40000 ALTER TABLE `api_est_m_usuario` DISABLE KEYS */;
INSERT INTO `api_est_m_usuario` VALUES (0,'2300238843','JASON','BERMEO','webadasdeanfibius@gmail.com','0995190578','12345',1,1,'cliente'),(1,'E230023884','roberto','BERMEO','webadasdeanfibius@gmail.com','0995190578','123456',2,1,'empleado jason'),(2,'E171351520','cecibel','varela','webadasdeanfibius@gmail.com','0995190578','22222',2,1,'empleado nuris'),(3,'E230023876','nicole','bermeo','webadasdeanfibius@gmail.com','0995190578','33333',2,1,'empleado dayana'),(4,'E115096004','agustin','bermeo','webadasdeanfibius@gmail.com','0995190578','44444',0,1,'empleado jared'),(5,'1150960043','jared','bermeo','webadasdeanfibius@gmail.com','0995190578','55555',1,1,'asd'),(6,'2300238769','dayana','bermeo','webadasdeanfibius@gmail.com','0995190578','66666',1,1,'cliente'),(7,'1111111111','nombre1','apellido1','correo1','0999999999','11111',1,1,'');
/*!40000 ALTER TABLE `api_est_m_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_est_s_funcion`
--

DROP TABLE IF EXISTS `api_est_s_funcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_est_s_funcion` (
  `fu_codigo` bigint unsigned NOT NULL,
  `fu_descripcion` varchar(100) NOT NULL,
  `fu_estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`fu_codigo`),
  CONSTRAINT `api_est_s_funcion_chk_1` CHECK ((`fu_codigo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_est_s_funcion`
--

LOCK TABLES `api_est_s_funcion` WRITE;
/*!40000 ALTER TABLE `api_est_s_funcion` DISABLE KEYS */;
INSERT INTO `api_est_s_funcion` VALUES (0,'Administrar',1),(1,'Agendar',1),(2,'Cancelar Agenda',1),(3,'Ver historial',1),(4,'Ver reportes',1);
/*!40000 ALTER TABLE `api_est_s_funcion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_est_s_funcion_rol`
--

DROP TABLE IF EXISTS `api_est_s_funcion_rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_est_s_funcion_rol` (
  `fr_codigo` bigint unsigned NOT NULL,
  `fu_codigo_id` bigint unsigned NOT NULL,
  `ro_codigo_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`fr_codigo`),
  KEY `api_est_s_funcion_rol_fu_codigo_id_de8a9749` (`fu_codigo_id`),
  KEY `api_est_s_funcion_rol_ro_codigo_id_a4cfadb1` (`ro_codigo_id`),
  CONSTRAINT `api_est_s_funcion_ro_fu_codigo_id_de8a9749_fk_api_est_s` FOREIGN KEY (`fu_codigo_id`) REFERENCES `api_est_s_funcion` (`fu_codigo`),
  CONSTRAINT `api_est_s_funcion_ro_ro_codigo_id_a4cfadb1_fk_api_est_s` FOREIGN KEY (`ro_codigo_id`) REFERENCES `api_est_s_roles` (`ro_codigo`),
  CONSTRAINT `api_est_s_funcion_rol_chk_1` CHECK ((`fr_codigo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_est_s_funcion_rol`
--

LOCK TABLES `api_est_s_funcion_rol` WRITE;
/*!40000 ALTER TABLE `api_est_s_funcion_rol` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_est_s_funcion_rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_est_s_roles`
--

DROP TABLE IF EXISTS `api_est_s_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_est_s_roles` (
  `ro_codigo` bigint unsigned NOT NULL,
  `ro_nombre` varchar(100) NOT NULL,
  `ro_descripcion` varchar(100) DEFAULT NULL,
  `ro_estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`ro_codigo`),
  CONSTRAINT `api_est_s_roles_chk_1` CHECK ((`ro_codigo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_est_s_roles`
--

LOCK TABLES `api_est_s_roles` WRITE;
/*!40000 ALTER TABLE `api_est_s_roles` DISABLE KEYS */;
INSERT INTO `api_est_s_roles` VALUES (0,'Administrador','Administrador',1),(1,'Cliente','Cliente',1),(2,'Empleado','Empleado',1);
/*!40000 ALTER TABLE `api_est_s_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add est_m_cita',7,'add_est_m_cita'),(26,'Can change est_m_cita',7,'change_est_m_cita'),(27,'Can delete est_m_cita',7,'delete_est_m_cita'),(28,'Can view est_m_cita',7,'view_est_m_cita'),(29,'Can add est_m_cita_servicio',8,'add_est_m_cita_servicio'),(30,'Can change est_m_cita_servicio',8,'change_est_m_cita_servicio'),(31,'Can delete est_m_cita_servicio',8,'delete_est_m_cita_servicio'),(32,'Can view est_m_cita_servicio',8,'view_est_m_cita_servicio'),(33,'Can add est_m_cliente',9,'add_est_m_cliente'),(34,'Can change est_m_cliente',9,'change_est_m_cliente'),(35,'Can delete est_m_cliente',9,'delete_est_m_cliente'),(36,'Can view est_m_cliente',9,'view_est_m_cliente'),(37,'Can add est_m_emplado',10,'add_est_m_emplado'),(38,'Can change est_m_emplado',10,'change_est_m_emplado'),(39,'Can delete est_m_emplado',10,'delete_est_m_emplado'),(40,'Can view est_m_emplado',10,'view_est_m_emplado'),(41,'Can add est_m_servicio',11,'add_est_m_servicio'),(42,'Can change est_m_servicio',11,'change_est_m_servicio'),(43,'Can delete est_m_servicio',11,'delete_est_m_servicio'),(44,'Can view est_m_servicio',11,'view_est_m_servicio'),(45,'Can add est_m_usuario',12,'add_est_m_usuario'),(46,'Can change est_m_usuario',12,'change_est_m_usuario'),(47,'Can delete est_m_usuario',12,'delete_est_m_usuario'),(48,'Can view est_m_usuario',12,'view_est_m_usuario'),(49,'Can add est_s_funcion',13,'add_est_s_funcion'),(50,'Can change est_s_funcion',13,'change_est_s_funcion'),(51,'Can delete est_s_funcion',13,'delete_est_s_funcion'),(52,'Can view est_s_funcion',13,'view_est_s_funcion'),(53,'Can add est_s_funcion_rol',14,'add_est_s_funcion_rol'),(54,'Can change est_s_funcion_rol',14,'change_est_s_funcion_rol'),(55,'Can delete est_s_funcion_rol',14,'delete_est_s_funcion_rol'),(56,'Can view est_s_funcion_rol',14,'view_est_s_funcion_rol'),(57,'Can add est_s_roles',15,'add_est_s_roles'),(58,'Can change est_s_roles',15,'change_est_s_roles'),(59,'Can delete est_s_roles',15,'delete_est_s_roles'),(60,'Can view est_s_roles',15,'view_est_s_roles'),(61,'Can add est_m_categoria',16,'add_est_m_categoria'),(62,'Can change est_m_categoria',16,'change_est_m_categoria'),(63,'Can delete est_m_categoria',16,'delete_est_m_categoria'),(64,'Can view est_m_categoria',16,'view_est_m_categoria'),(65,'Can add est_m_empleado_especialidad',17,'add_est_m_empleado_especialidad'),(66,'Can change est_m_empleado_especialidad',17,'change_est_m_empleado_especialidad'),(67,'Can delete est_m_empleado_especialidad',17,'delete_est_m_empleado_especialidad'),(68,'Can view est_m_empleado_especialidad',17,'view_est_m_empleado_especialidad'),(69,'Can add est_m_especialidad',18,'add_est_m_especialidad'),(70,'Can change est_m_especialidad',18,'change_est_m_especialidad'),(71,'Can delete est_m_especialidad',18,'delete_est_m_especialidad'),(72,'Can view est_m_especialidad',18,'view_est_m_especialidad');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$870000$I3i5vhspWkF6izfEr8uxTs$q09KnWTgVM3REVJr0dzoGL+C7X6qhMPar0c7nNrtkBA=','2024-08-14 15:41:46.928576',1,'estetica','','','j.asber@hotmail.com',1,1,'2024-08-10 21:42:27.886830');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-08-11 02:17:24.867579','1','est_m_especialidad object (1)',1,'[{\"added\": {}}]',18,1),(2,'2024-08-11 02:17:31.336982','2','est_m_especialidad object (2)',1,'[{\"added\": {}}]',18,1),(3,'2024-08-11 02:17:36.162880','3','est_m_especialidad object (3)',1,'[{\"added\": {}}]',18,1),(4,'2024-08-11 18:47:34.918421','1','est_s_roles object (1)',1,'[{\"added\": {}}]',15,1),(5,'2024-08-11 18:47:46.769748','2','est_s_roles object (2)',1,'[{\"added\": {}}]',15,1),(6,'2024-08-11 18:47:56.819382','0','est_s_roles object (0)',1,'[{\"added\": {}}]',15,1),(7,'2024-08-11 18:48:41.995379','0','est_s_funcion object (0)',1,'[{\"added\": {}}]',13,1),(8,'2024-08-11 18:48:54.971544','1','est_s_funcion object (1)',1,'[{\"added\": {}}]',13,1),(9,'2024-08-11 18:49:01.348276','2','est_s_funcion object (2)',1,'[{\"added\": {}}]',13,1),(10,'2024-08-11 18:49:06.663583','3','est_s_funcion object (3)',1,'[{\"added\": {}}]',13,1),(11,'2024-08-11 18:49:12.000058','4','est_s_funcion object (4)',1,'[{\"added\": {}}]',13,1),(12,'2024-08-11 18:50:30.791388','0','est_m_usuario object (0)',1,'[{\"added\": {}}]',12,1),(13,'2024-08-12 05:09:54.561568','1','est_m_servicio object (1)',1,'[{\"added\": {}}]',11,1),(14,'2024-08-12 05:10:20.858067','2','est_m_servicio object (2)',1,'[{\"added\": {}}]',11,1),(15,'2024-08-12 05:10:45.374414','3','est_m_servicio object (3)',1,'[{\"added\": {}}]',11,1),(16,'2024-08-13 00:34:35.451673','1','est_m_usuario object (1)',1,'[{\"added\": {}}]',12,1),(17,'2024-08-13 00:35:20.134609','3','est_m_usuario object (3)',1,'[{\"added\": {}}]',12,1),(18,'2024-08-13 00:37:29.662857','4','est_m_usuario object (4)',1,'[{\"added\": {}}]',12,1),(19,'2024-08-13 00:38:55.788388','2','est_m_usuario object (2)',1,'[{\"added\": {}}]',12,1),(20,'2024-08-13 00:39:49.730034','1','est_m_emplado object (1)',1,'[{\"added\": {}}]',10,1),(21,'2024-08-13 00:40:12.346645','2','est_m_emplado object (2)',1,'[{\"added\": {}}]',10,1),(22,'2024-08-13 00:40:29.959910','3','est_m_emplado object (3)',1,'[{\"added\": {}}]',10,1),(23,'2024-08-13 00:40:48.885372','4','est_m_emplado object (4)',1,'[{\"added\": {}}]',10,1),(24,'2024-08-13 00:41:02.758984','4','est_m_emplado object (4)',2,'[{\"changed\": {\"fields\": [\"Em especialidad\"]}}]',10,1),(25,'2024-08-13 00:41:05.786323','3','est_m_emplado object (3)',2,'[{\"changed\": {\"fields\": [\"Em especialidad\"]}}]',10,1),(26,'2024-08-13 00:41:08.323348','2','est_m_emplado object (2)',2,'[{\"changed\": {\"fields\": [\"Em especialidad\"]}}]',10,1),(27,'2024-08-13 00:41:10.729480','1','est_m_emplado object (1)',2,'[{\"changed\": {\"fields\": [\"Em especialidad\"]}}]',10,1),(28,'2024-08-13 04:12:21.222029','5','est_m_usuario object (5)',1,'[{\"added\": {}}]',12,1),(29,'2024-08-13 04:12:47.933495','6','est_m_usuario object (6)',1,'[{\"added\": {}}]',12,1),(30,'2024-08-14 15:42:48.746675','0','est_m_usuario object (0)',2,'[]',12,1),(31,'2024-08-14 15:42:59.199865','1','est_m_usuario object (1)',2,'[]',12,1),(32,'2024-08-14 15:43:03.473576','2','est_m_usuario object (2)',2,'[]',12,1),(33,'2024-08-14 15:43:06.731610','3','est_m_usuario object (3)',2,'[]',12,1),(34,'2024-08-14 15:43:17.829880','4','est_m_usuario object (4)',2,'[]',12,1),(35,'2024-08-14 15:43:22.913307','5','est_m_usuario object (5)',2,'[]',12,1),(36,'2024-08-14 15:43:27.262013','1','est_m_usuario object (1)',2,'[]',12,1),(37,'2024-08-14 15:43:30.800265','2','est_m_usuario object (2)',2,'[]',12,1),(38,'2024-08-14 15:46:37.780749','1','est_m_especialidad object (1)',2,'[]',18,1),(39,'2024-08-14 15:46:40.015478','2','est_m_especialidad object (2)',2,'[]',18,1),(40,'2024-08-14 15:46:44.383519','3','est_m_especialidad object (3)',2,'[]',18,1),(41,'2024-08-14 15:46:53.262064','1','est_m_categoria object (1)',2,'[]',16,1),(42,'2024-08-14 15:46:57.039927','1','est_m_especialidad object (1)',2,'[]',18,1),(43,'2024-08-14 15:48:31.228063','2','est_m_cliente object (2)',2,'[]',9,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(16,'api','est_m_categoria'),(7,'api','est_m_cita'),(8,'api','est_m_cita_servicio'),(9,'api','est_m_cliente'),(10,'api','est_m_emplado'),(17,'api','est_m_empleado_especialidad'),(18,'api','est_m_especialidad'),(11,'api','est_m_servicio'),(12,'api','est_m_usuario'),(13,'api','est_s_funcion'),(14,'api','est_s_funcion_rol'),(15,'api','est_s_roles'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-08-10 21:24:15.396084'),(2,'auth','0001_initial','2024-08-10 21:24:16.079840'),(3,'admin','0001_initial','2024-08-10 21:24:16.250297'),(4,'admin','0002_logentry_remove_auto_add','2024-08-10 21:24:16.266663'),(5,'admin','0003_logentry_add_action_flag_choices','2024-08-10 21:24:16.307287'),(6,'contenttypes','0002_remove_content_type_name','2024-08-10 21:24:16.411962'),(7,'auth','0002_alter_permission_name_max_length','2024-08-10 21:24:16.492713'),(8,'auth','0003_alter_user_email_max_length','2024-08-10 21:24:16.534313'),(9,'auth','0004_alter_user_username_opts','2024-08-10 21:24:16.550582'),(10,'auth','0005_alter_user_last_login_null','2024-08-10 21:24:16.623343'),(11,'auth','0006_require_contenttypes_0002','2024-08-10 21:24:16.623343'),(12,'auth','0007_alter_validators_add_error_messages','2024-08-10 21:24:16.639327'),(13,'auth','0008_alter_user_username_max_length','2024-08-10 21:24:16.712970'),(14,'auth','0009_alter_user_last_name_max_length','2024-08-10 21:24:16.794290'),(15,'auth','0010_alter_group_name_max_length','2024-08-10 21:24:16.835087'),(16,'auth','0011_update_proxy_permissions','2024-08-10 21:24:16.848128'),(17,'auth','0012_alter_user_first_name_max_length','2024-08-10 21:24:16.923348'),(18,'sessions','0001_initial','2024-08-10 21:24:16.956108'),(19,'api','0001_initial','2024-08-10 21:25:20.008718'),(20,'api','0002_remove_est_m_cita_id_remove_est_m_cita_servicio_id_and_more','2024-08-11 00:58:50.168221'),(21,'api','0003_est_m_categoria_est_m_empleado_especialidad_and_more','2024-08-11 01:08:34.575878'),(22,'api','0004_alter_est_s_funcion_rol_fu_codigo_and_more','2024-08-11 01:13:05.574061'),(23,'api','0005_alter_est_m_cita_em_codigo_and_more','2024-08-11 01:57:23.587644'),(24,'api','0006_remove_est_m_cita_cl_codigo_and_more','2024-08-11 02:11:26.219534'),(25,'api','0007_est_m_categoria_ca_imagen','2024-08-11 23:48:01.750701'),(26,'api','0008_alter_est_m_categoria_es_codigo','2024-08-13 00:49:28.628724'),(27,'api','0009_est_m_emplado_em_imagen','2024-08-13 00:57:51.133058');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('yv70xhym99fgeff2k8pt3uroxmqp0nr5','.eJxVjDsOwjAQRO_iGln-fyjpOYO1Xi84gGwpTirE3UmkFFBMM-_NvFmCdalpHTSnqbAzk-z022XAJ7UdlAe0e-fY2zJPme8KP-jg117odTncv4MKo25rL7UhYdBFD8VpcmCVsorKTdstGgV5zEIaCEjBeZs1GI1ORW8Ehcg-X9akN3U:1seG8A:-0ezaAXdelDZkjbbIVMJjeJ3kkubzIPhFjVp0kOAGoU','2024-08-28 15:41:46.935559');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista`
--

DROP TABLE IF EXISTS `lista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lista` (
  `id` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lista`
--

LOCK TABLES `lista` WRITE;
/*!40000 ALTER TABLE `lista` DISABLE KEYS */;
/*!40000 ALTER TABLE `lista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista1`
--

DROP TABLE IF EXISTS `lista1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lista1` (
  `iden` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `hora` varchar(255) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `entendido` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lista1`
--

LOCK TABLES `lista1` WRITE;
/*!40000 ALTER TABLE `lista1` DISABLE KEYS */;
/*!40000 ALTER TABLE `lista1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'django_estetica'
--
/*!50003 DROP PROCEDURE IF EXISTS `agendarCita` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agendarCita`(e_fecha varchar(10), e_hora int, e_empleado int, e_cliente int, e_servicio int)
BEGIN

	DECLARE v_ci_codigo int;
    DECLARE v_cs_codigo int;
    DECLARE v_cl_codigo int;
    DECLARE v_ci_hora varchar(100);
    DECLARE v_codigo int;
    DECLARE v_mensaje varchar(255);
	DECLARE exit handler FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT -1 AS codigo, MESSAGE_TEXT as mensaje;
	END;

    set v_ci_hora = (select concat(LPAD(concat('',e_hora,''), 2, '0'),':00'));
    
    START TRANSACTION;
    
		set v_ci_codigo = (select ifnull(max(ci_codigo),0)+1 from api_est_m_cita);
		insert into api_est_m_cita(ci_codigo,ci_fecha,ci_hora,ci_estado,ci_nota) values
		(v_ci_codigo, e_fecha, v_ci_hora, 1, 'Pendiente');
        
        set v_cs_codigo = (select ifnull(max(cs_codigo),0)+1 from api_est_m_cita_servicio);
        set v_cl_codigo = (select cl_codigo from api_est_m_cliente c inner join api_est_m_usuario u on c.us_codigo_id = u.us_codigo where u.us_codigo = e_cliente);
		insert into api_est_m_cita_servicio(cs_codigo, em_codigo_id, cl_codigo_id, ci_codigo_id, se_codigo_id) values
        (v_cs_codigo, e_empleado,  v_cl_codigo, v_ci_codigo, e_servicio);
		
	COMMIT;
    
		
        SELECT v_ci_codigo AS codigo, 'Cita agendada' as mensaje;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `creaCorreo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `creaCorreo`(e_cita int)
BEGIN

	select concat('Estimado ',upper(us.us_nombre),' ',upper(us.us_apellido),' le saluda la Estetica Antonella, se le informa que se ha realizado con exito su agenda con los siguientes datos. Fecha: ',ci_fecha,' - Hora: ',ci_hora)  mensaje, us_correo correo
    from api_est_m_cita ci
    inner join api_est_m_cita_servicio cs on cs.ci_codigo_id = ci.ci_codigo 
    inner join api_est_m_cliente cl on cs.cl_codigo_id = cl.cl_codigo
    inner join api_est_m_usuario us on cl.us_codigo_id = us.us_codigo
    where ci.ci_codigo = e_cita;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `IterarProductos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `IterarProductos`()
BEGIN
    -- Declarar un cursor
    DECLARE done INT DEFAULT FALSE;
	DECLARE ide INT;
    DECLARE id INT;
    DECLARE hora VARCHAR(255);
    DECLARE cantidad INT;
    DECLARE entendido INT;
    DECLARE horaFlag VARCHAR(5);
    DECLARE horaNueva VARCHAR(5);
    
    -- Declarar un cursor para la tabla productos
    DECLARE cur CURSOR FOR 
        SELECT * 
        FROM lista1;
    
    -- Declarar un manejador para el fin del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    set horaFlag = '';
    SET SQL_SAFE_UPDATES = 0;
    
    -- Abrir el cursor
    OPEN cur;
    
    -- Leer cada fila del cursor
    read_loop: LOOP
        FETCH cur INTO ide, id, hora, cantidad, entendido;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        if(horaFlag = hora)
        then
            set horaNueva = LPAD(SUBSTRING(convert(substring(hora,1,2), UNSIGNED) + 1, 1, 2), 2, '0');
            update lista1 set hora = concat(horaNueva,':00') where iden=ide;
        end if;
        set horaFlag = hora;
    END LOOP;
    
    -- Cerrar el cursor
    CLOSE cur;
    SET SQL_SAFE_UPDATES = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_cancelaCita` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_cancelaCita`(e_cita int)
BEGIN

	update api_est_m_cita set ci_estado = 3, ci_nota = 'Cancelada' where ci_codigo = e_cita;
	-- update api_est_m_cita set ci_estado = 1, ci_nota = 'Pendiente' where ci_codigo = 8;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_cCategorias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_cCategorias`(e_id int, e_nombre varchar(100))
BEGIN
	if e_id = -1 then
		select ca_codigo, upper(ca_nombre),es_codigo_id es_codigo, ifnull(ca_imagen,'') ca_imagen from api_est_m_categoria where ca_nombre = e_nombre;
    else 
		select ca_codigo, upper(ca_nombre),es_codigo_id es_codigo, ifnull(ca_imagen,'') ca_imagen from api_est_m_categoria where ca_codigo = e_id;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_cEmpleadoxServicio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_cEmpleadoxServicio`(e_id int)
BEGIN
	select concat(upper(us.us_nombre), ' ', upper(us.us_apellido)) em_nombre, em.em_codigo, us_codigo, em_especialidad, em.em_hora_entrada, em.em_hora_salida, em_imagen from api_est_m_emplado em
	inner join api_est_m_usuario us on em.us_codigo_id = us_codigo
	inner join api_est_m_empleado_especialidad ee on em.em_codigo = ee.em_codigo_id
	inner join api_est_m_especialidad es on ee.es_codigo_id = es.es_codigo
	inner join api_est_m_categoria ca on ca.es_codigo_id = es.es_codigo 
	inner join api_est_m_servicio se on se.ca_codigo_id = ca.ca_codigo
	where se.se_codigo=e_id
	order by em.em_codigo;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_creaCorreo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_creaCorreo`(e_cita int)
BEGIN

	select concat('Estimado ',upper(us.us_nombre),' ',upper(us.us_apellido),' le saluda la Estetica Antonella, se le informa que se ha realizado con exito su agenda con los siguientes datos. Fecha: ',ci_fecha,' - Hora: ',ci_hora)  mensaje, us_correo correo
    from api_est_m_cita ci
    inner join api_est_m_cita_servicio cs on cs.ci_codigo_id = ci.ci_codigo 
    inner join api_est_m_cliente cl on cs.cl_codigo_id = cl.cl_codigo
    inner join api_est_m_usuario us on cl.us_codigo_id = us.us_codigo
    where ci.ci_codigo = e_cita;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_cServicios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_cServicios`(e_id int ,e_categoria int)
BEGIN
	if e_id <> -1 then
		select se_codigo, se_nombre, se_descripcion, se_duracion, se_precio, ca_codigo_id from api_est_m_servicio WHERE se_estado=1 and se_codigo = e_id;
	else
		select se_codigo, se_nombre, se_descripcion, se_duracion, se_precio, ca_codigo_id from api_est_m_servicio WHERE se_estado=1 and ca_codigo_id = e_categoria;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_gCategorias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_gCategorias`()
BEGIN
	select ca_codigo, upper(ca_nombre),es_codigo_id es_codigo, ifnull(ca_imagen,'') ca_imagen from api_est_m_categoria order by ca_codigo;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_generaPdfEsp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_generaPdfEsp`(e_categoria int, e_servicio int, e_fecha_inicio varchar(10), e_fecha_fin varchar(10))
BEGIN

	select  
		ca.ca_codigo,
        ca.ca_nombre,
        se.se_codigo,
        se.se_nombre,
        ci.ci_fecha,
        ci.ci_hora,
        concat(upper(usc.us_nombre), ' ', upper(usc.us_apellido)) cliente,
        concat(upper(usem.us_nombre), ' ', upper(usem.us_apellido)) empleado,
        ci.ci_estado,
        case when ci.ci_estado = 1 then 'Pendiente' when ci.ci_estado = 2 then 'Hecho' else 'Cancelada' end estado_des
    from api_est_m_cita ci
    inner join api_est_m_cita_servicio cs on cs.ci_codigo_id = ci.ci_codigo
    inner join api_est_m_servicio se on se.se_codigo = cs.se_codigo_id
    inner join api_est_m_categoria ca on ca.ca_codigo = se.ca_codigo_id
    inner join api_est_m_cliente cl on cl.cl_codigo = cs.cl_codigo_id
    inner join api_est_m_usuario usc on usc.us_codigo = cl.us_codigo_id
    inner join api_est_m_emplado em on em.em_codigo = cs.cl_codigo_id
    inner join api_est_m_usuario usem on usem.us_codigo = em.us_codigo_id
	where ci.ci_fecha between e_fecha_inicio and e_fecha_fin and ca.ca_codigo = e_categoria and se.se_codigo = e_servicio
    order by ci.ci_codigo;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_generaPdfTodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_generaPdfTodo`(e_fecha_inicio varchar(10), e_fecha_fin varchar(10))
BEGIN

	select  
		ca.ca_codigo,
        ca.ca_nombre,
        se.se_codigo,
        se.se_nombre,
        ci.ci_fecha,
        ci.ci_hora,
        concat(upper(usc.us_nombre), ' ', upper(usc.us_apellido)) cliente,
        concat(upper(usem.us_nombre), ' ', upper(usem.us_apellido)) empleado,
        ci.ci_estado,
        case when ci.ci_estado = 1 then 'Pendiente' when ci.ci_estado = 2 then 'Hecho' else 'Cancelada' end estado_des
    from api_est_m_cita ci
    inner join api_est_m_cita_servicio cs on cs.ci_codigo_id = ci.ci_codigo
    inner join api_est_m_servicio se on se.se_codigo = cs.se_codigo_id
    inner join api_est_m_categoria ca on ca.ca_codigo = se.ca_codigo_id
    inner join api_est_m_cliente cl on cl.cl_codigo = cs.cl_codigo_id
    inner join api_est_m_usuario usc on usc.us_codigo = cl.us_codigo_id
    inner join api_est_m_emplado em on em.em_codigo = cs.cl_codigo_id
    inner join api_est_m_usuario usem on usem.us_codigo = em.us_codigo_id
	where ci.ci_fecha between e_fecha_inicio and e_fecha_fin
    order by ci.ci_codigo;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_getHistorial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_getHistorial`(e_usuario int, e_tipo int, e_cliemp int)
BEGIN
	-- 0 empleado
    -- 1 cliente
	if e_cliemp = 1 then 
		if e_tipo = 1 then
			SELECT 
				c.ci_codigo codigo_cita,
				c.ci_hora hora_cita,
				se.se_codigo codigo_servicio,
				se.se_nombre codigo_nombre,
				concat(se.se_duracion, case when se.se_duracion > 1 then ' horas' else ' hora' end) duracion,
				c.ci_estado codigo_estado,
				case when c.ci_estado = 1 then 'Pendiente' when c.ci_estado = 2 then 'Hecha' else 'Cancelada' end estado,
                concat(upper(u.us_nombre), ' ', upper(u.us_apellido)) cliente,
				concat(upper(uem.us_nombre), ' ', upper(uem.us_apellido)) empleado,
				c.ci_fecha as date,
				concat(DATE_FORMAT(ci_fecha, '%d-%m-%Y'),' ',c.ci_hora) fecha_hora
			FROM django_estetica.api_est_m_cita_servicio s
			inner join api_est_m_servicio se on se.se_codigo = s.se_codigo_id
			inner join api_est_m_cita c on c.ci_codigo = s.ci_codigo_id
			inner join api_est_m_emplado e on e.em_codigo = s.em_codigo_id
			inner join api_est_m_cliente cl on cl.cl_codigo = s.cl_codigo_id
			inner join api_est_m_usuario u on u.us_codigo = cl.us_codigo_id
			inner join api_est_m_usuario uem on uem.us_codigo = e.us_codigo_id
			where u.us_codigo = e_usuario
			order by c.ci_fecha, c.ci_codigo;
		else
			SELECT 
				c.ci_codigo codigo_cita,
				c.ci_hora hora_cita,
				se.se_codigo codigo_servicio,
				se.se_nombre codigo_nombre,
				concat(se.se_duracion, case when se.se_duracion > 1 then ' horas' else ' hora' end) duracion,
				c.ci_estado codigo_estado,
				case when c.ci_estado = 1 then 'Pendiente' when c.ci_estado = 2 then 'Hecha' else 'Cancelada' end estado,
                concat(upper(u.us_nombre), ' ', upper(u.us_apellido)) cliente,
				concat(upper(uem.us_nombre), ' ', upper(uem.us_apellido)) empleado,
				c.ci_fecha,
				concat(DATE_FORMAT(ci_fecha, '%d-%m-%Y'),' ',c.ci_hora) fecha_hora
			FROM django_estetica.api_est_m_cita_servicio s
			inner join api_est_m_servicio se on se.se_codigo = s.se_codigo_id
			inner join api_est_m_cita c on c.ci_codigo = s.ci_codigo_id
			inner join api_est_m_emplado e on e.em_codigo = s.em_codigo_id
			inner join api_est_m_cliente cl on cl.cl_codigo = s.cl_codigo_id
			inner join api_est_m_usuario u on u.us_codigo = cl.us_codigo_id
			inner join api_est_m_usuario uem on uem.us_codigo = e.us_codigo_id
			where u.us_codigo = e_usuario and c.ci_estado = 1
			order by c.ci_fecha, c.ci_codigo;
		end if;
	else
		select
			c.ci_codigo codigo_cita,
			c.ci_hora hora_cita,
			se.se_codigo codigo_servicio,
			se.se_nombre codigo_nombre,
			concat(se.se_duracion, case when se.se_duracion > 1 then ' horas' else ' hora' end) duracion,
			c.ci_estado codigo_estado,
			case when c.ci_estado = 1 then 'Pendiente' when c.ci_estado = 2 then 'Hecha' else 'Cancelada' end estado,
            concat(upper(u.us_nombre), ' ', upper(u.us_apellido)) cliente,
			concat(upper(uem.us_nombre), ' ', upper(uem.us_apellido)) empleado,
			c.ci_fecha,
			concat(DATE_FORMAT(ci_fecha, '%d-%m-%Y'),' ',c.ci_hora) fecha_hora
		FROM django_estetica.api_est_m_cita_servicio s
		inner join api_est_m_servicio se on se.se_codigo = s.se_codigo_id
		inner join api_est_m_cita c on c.ci_codigo = s.ci_codigo_id
		inner join api_est_m_emplado e on e.em_codigo = s.em_codigo_id
		inner join api_est_m_cliente cl on cl.cl_codigo = s.cl_codigo_id
		inner join api_est_m_usuario u on u.us_codigo = cl.us_codigo_id
		inner join api_est_m_usuario uem on uem.us_codigo = e.us_codigo_id
		where uem.us_codigo = e_usuario and c.ci_estado = 1
		order by c.ci_fecha, c.ci_codigo;
	end if;
    
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_horariosXFecha` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_horariosXFecha`(e_fecha varchar(10), e_empleado int)
BEGIN

	SET SQL_SAFE_UPDATES = 0;

	DROP TABLE IF EXISTS `lista`;
	CREATE TABLE lista (
		id INT,
		cantidad INT,
		nombre VARCHAR(255)
	);

	DROP TABLE IF EXISTS `lista1`;
	CREATE TABLE lista1 (
		iden int,
		id INT,
		hora VARCHAR(255),
		cantidad INT,
		entendido int
	);
	
    insert into lista
	select cs.cs_codigo, se.se_duracion, ci.ci_hora
	from api_est_m_cita ci
	inner join api_est_m_cita_servicio cs on cs.ci_codigo_id = ci.ci_codigo
	inner join api_est_m_emplado em on cs.em_codigo_id = em.em_codigo
    inner join api_est_m_servicio se on cs.se_codigo_id = se.se_codigo
	where ci_estado = 1 and ci_fecha = e_fecha and em.em_codigo=e_empleado;
    
    -- lista 1
    insert into lista1 
	-- Consulta para expandir las filas según la cantidad
	SELECT 
		ROW_NUMBER() OVER (ORDER BY sub.id, sub.row_num) AS identificador,
		sub.id,
		sub.nombre,
		sub.cantidad,
		sub.row_num AS nombre_extendido
	FROM (
		SELECT 
			l.id,
			l.nombre,
			l.cantidad,
			n.n AS row_num
		FROM 
			lista l
		JOIN 
			(SELECT 1 n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) n 
		ON n.n <= l.cantidad
	) sub
	ORDER BY sub.id, sub.row_num;
    
    call IterarProductos;
    
    select * from (
		select 
				case 
				when hora = '08:00' then 8
				when hora = '09:00' then 9 
				when hora = '10:00' then 10 
				when hora = '11:00' then 11 
				when hora = '12:00' then 12 
				when hora = '13:00' then 13 
				when hora = '14:00' then 14 
				when hora = '15:00' then 15 
				when hora = '16:00' then 16 
				when hora = '17:00' then 17 
				when hora = '18:00' then 18 
				end as hora, hora ci_hora, e_empleado em_codigo
			from lista1
		)X order by X.hora;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_login`(e_cedula varchar(10), e_clave varchar(100))
BEGIN
	DECLARE v_claveEncrypt varchar(255);
    if exists (select 1 from api_est_m_usuario where us_estado=1 and us_cedula = e_cedula) then
		set v_claveEncrypt = TO_BASE64(AES_ENCRYPT(e_clave, 'esteticaAntonela'));
		select us_codigo, us_cedula, upper(us_nombre), upper(us_apellido), us_correo, us_telefono, ro_codigo_id from api_est_m_usuario where us_estado=1 and us_cedula = e_cedula and TO_BASE64(AES_ENCRYPT(us_clave, 'esteticaAntonela')) = v_claveEncrypt;
	else
		select -1 us_codigo, 'Usuario no existe' mensaje;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pa_registrarCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_registrarCliente`(e_cedula varchar(10), e_nombre varchar(100), e_apellido varchar(100), e_correo varchar(100), e_telefono varchar(10), e_clave varchar(100))
BEGIN
	DECLARE v_us_codigo int;
    set v_us_codigo = (select ifnull(max(us_codigo),0)+1 from api_est_m_usuario);
	insert into api_est_m_usuario values
	(v_us_codigo, e_cedula, e_nombre, e_apellido, e_correo, e_telefono, e_clave, 1, 1, '');
    select 0 codigo_error, 'Cliente Registrado' mensaje;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-15  3:19:34
