-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 21-11-2024 a las 21:27:10
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_laboratorio`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `crud_modulo`
--

CREATE TABLE `crud_modulo` (
  `idmod` int NOT NULL,
  `mod_nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mod_descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mod_estado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_balance_inventarios`
--

CREATE TABLE `lab_balance_inventarios` (
  `idbalance` int NOT NULL,
  `idproducto` int DEFAULT NULL,
  `idinsumo` int DEFAULT NULL,
  `idmaterial` int DEFAULT NULL,
  `stock_cajas` int NOT NULL DEFAULT '0',
  `stock_unidades_sueltas` int NOT NULL DEFAULT '0',
  `stock_total` int DEFAULT NULL,
  `factor_caja` int NOT NULL,
  `fecha_ultima_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_condiciones`
--

CREATE TABLE `lab_condiciones` (
  `idcondicion` int NOT NULL,
  `nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `lab_condiciones`
--

INSERT INTO `lab_condiciones` (`idcondicion`, `nombre`, `fecha_registro`) VALUES
(1, 'No especificado', '2024-10-14 11:41:38'),
(2, 'Bueno', '2024-10-14 11:41:38'),
(3, 'Regular', '2024-10-14 11:41:49'),
(4, 'Malo', '2024-10-14 11:41:49'),
(5, 'Reparacion', '2024-10-14 11:41:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_detalle_inventarios`
--

CREATE TABLE `lab_detalle_inventarios` (
  `idinventariodetalle` int NOT NULL,
  `idinventario` int DEFAULT NULL,
  `idproducto` int DEFAULT NULL,
  `idinsumo` int DEFAULT NULL,
  `idmaterial` int DEFAULT NULL,
  `idcondicion` int NOT NULL,
  `cantidad` int NOT NULL,
  `idmedida` int NOT NULL,
  `factor` decimal(7,2) DEFAULT '0.00',
  `fecha_vencimiento` date DEFAULT NULL,
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_detalle_ocurrencias`
--

CREATE TABLE `lab_detalle_ocurrencias` (
  `id_detalle_ocurrencia` int NOT NULL,
  `idocurrencia` int NOT NULL,
  `iddetalle` int NOT NULL,
  `cantidad` int NOT NULL DEFAULT '0',
  `descripcion` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_detalle_prestamos`
--

CREATE TABLE `lab_detalle_prestamos` (
  `iddetalle` int NOT NULL,
  `idbalance` int NOT NULL,
  `idprestamo` int NOT NULL,
  `cantidad` int NOT NULL DEFAULT '1',
  `estado` varchar(45) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_docentes`
--

CREATE TABLE `lab_docentes` (
  `iddocente` int NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `codigo` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `lab_docentes`
--

INSERT INTO `lab_docentes` (`iddocente`, `nombre`, `codigo`, `fecha_registro`) VALUES
(1, 'Leenh Bustamante', '2018100486', '2024-10-17 12:46:53'),
(2, 'Rocio Benites', '2018100654', '2024-10-17 12:47:33'),
(3, 'Jean Benites', '2018445486', '2024-10-17 12:48:17'),
(4, 'Mattwes', '2018100000', '2024-10-17 16:43:44'),
(5, 'Nose', '2018100488', '2024-10-26 19:51:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_estado`
--

CREATE TABLE `lab_estado` (
  `idestado` int NOT NULL,
  `nombre` varchar(200) COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `lab_estado`
--

INSERT INTO `lab_estado` (`idestado`, `nombre`, `fecha_registro`) VALUES
(1, 'Atendido', '2024-11-21 00:30:11'),
(2, 'Pendiente', '2024-11-21 00:30:21'),
(3, 'Completado', '2024-11-21 00:30:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_ingresos_laboratorios`
--

CREATE TABLE `lab_ingresos_laboratorios` (
  `idingreso` int NOT NULL,
  `iddocente` int NOT NULL,
  `titulo_practica` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `nro_practicas` int DEFAULT NULL,
  `carrera` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `asignatura` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `turno` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `ciclo` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `nro_estudiantes` int DEFAULT NULL,
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `completado` tinyint(1) NOT NULL DEFAULT '0',
  `cancelado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_insumos`
--

CREATE TABLE `lab_insumos` (
  `idinsumo` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `modelo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `codigo_ucss` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `stock` decimal(7,2) NOT NULL,
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `lab_insumos`
--

INSERT INTO `lab_insumos` (`idinsumo`, `nombre`, `modelo`, `codigo_ucss`, `stock`, `observaciones`, `fecha_registro`) VALUES
(1, 'Ácido acetil salícilico 100mg', NULL, NULL, 0.00, NULL, '2024-10-15 08:13:11'),
(2, 'Agua estéril de 1000ml', NULL, NULL, 0.00, NULL, '2024-10-15 08:13:49'),
(3, 'Alcohol en gel de 1000ml', NULL, NULL, 0.00, NULL, '2024-10-15 08:14:03'),
(4, 'Algodón', NULL, NULL, 0.00, NULL, '2024-10-15 08:15:06'),
(5, 'Aguja Hipodérmica Estéril 18G x 1 1/2\"', NULL, NULL, 0.00, NULL, '2024-10-15 08:15:15'),
(6, 'Aguja Hipodérmica Estéril 21G x 1 1/2\"', NULL, NULL, 0.00, NULL, '2024-10-15 08:15:29'),
(7, 'Aguja Hipodérmica Estéril 23G x 1 1/2\"', NULL, NULL, 0.00, NULL, '2024-10-15 08:15:38'),
(8, 'Aguja Hipodérmica Estéril 25G x 5/8\"', NULL, NULL, 0.00, NULL, '2024-10-15 08:15:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_inventarios`
--

CREATE TABLE `lab_inventarios` (
  `idinventario` int NOT NULL,
  `codigo` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `motivo_ingreso` int NOT NULL,
  `tipo_documento` int NOT NULL,
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_materiales`
--

CREATE TABLE `lab_materiales` (
  `idmaterial` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `modelo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `codigo_ucss` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `stock` decimal(7,2) NOT NULL,
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `lab_materiales`
--

INSERT INTO `lab_materiales` (`idmaterial`, `nombre`, `modelo`, `codigo_ucss`, `stock`, `observaciones`, `fecha_registro`) VALUES
(1, 'Aerocamara para inhalación', NULL, NULL, 0.00, NULL, '2024-10-15 08:13:30'),
(2, 'Aspirador de secreciones', 'H003-3-FOLEE', '028579', 0.00, NULL, '2024-10-15 08:16:05'),
(3, 'Aspirador de secresiones New Askir 230', NULL, '019207', 0.00, NULL, '2024-10-15 08:16:15'),
(4, 'Balanza de Pie Health o meter', '100KG QTY', '028581', 0.00, NULL, '2024-10-15 08:16:33'),
(5, 'Balanza Neonatal Health o meter', '100KG QTY', '028582', 0.00, NULL, '2024-10-15 08:16:51'),
(6, 'Balanza pediátrica de 10-20 Kg', '549KL', '028532', 0.00, NULL, '2024-10-15 08:17:00'),
(7, 'Balanza pediátrica de 20 Kg (Digital)', 'M108800', '019203', 0.00, NULL, '2024-10-15 08:17:11'),
(8, 'Balón de oxígeno grande', NULL, NULL, 0.00, NULL, '2024-10-26 19:48:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_movimientos`
--

CREATE TABLE `lab_movimientos` (
  `idmovimiento` int NOT NULL,
  `idbalance` int DEFAULT NULL,
  `idusuario` int NOT NULL,
  `idinventariodetalle` int DEFAULT NULL,
  `tipo_movimiento` int DEFAULT NULL,
  `tipo_detalle` int DEFAULT NULL,
  `idmedida` int DEFAULT NULL,
  `cantidad` decimal(7,2) NOT NULL,
  `factor` int NOT NULL DEFAULT '1',
  `fecha_movimiento` date NOT NULL,
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_ocurrencias`
--

CREATE TABLE `lab_ocurrencias` (
  `idocurrencia` int NOT NULL,
  `idestado` int NOT NULL,
  `idseveridad` int NOT NULL,
  `idprestamo` int NOT NULL,
  `estudiante` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha` date NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_prestamos`
--

CREATE TABLE `lab_prestamos` (
  `idprestamo` int NOT NULL,
  `idingreso` int NOT NULL,
  `fecha` date NOT NULL,
  `observaciones` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_productos`
--

CREATE TABLE `lab_productos` (
  `idproducto` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `modelo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `codigo_ucss` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `stock` decimal(7,2) NOT NULL,
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_severidad`
--

CREATE TABLE `lab_severidad` (
  `idseveridad` int NOT NULL,
  `nombre` varchar(200) COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `lab_severidad`
--

INSERT INTO `lab_severidad` (`idseveridad`, `nombre`, `fecha_registro`) VALUES
(1, 'Baja', '2024-11-21 00:31:03'),
(2, 'Media', '2024-11-21 00:31:10'),
(3, 'Alta', '2024-11-21 00:31:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_unidades_medidas`
--

CREATE TABLE `lab_unidades_medidas` (
  `idmedida` int NOT NULL,
  `nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `lab_unidades_medidas`
--

INSERT INTO `lab_unidades_medidas` (`idmedida`, `nombre`, `fecha_registro`) VALUES
(1, 'Sin especificar', '2024-10-14 11:43:37'),
(2, 'Unida', '2024-10-14 11:43:43'),
(3, 'Caja', '2024-10-14 11:43:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sis_centinela`
--

CREATE TABLE `sis_centinela` (
  `idvisita` int NOT NULL,
  `vis_cod` int NOT NULL,
  `idwebusuario` int NOT NULL,
  `vis_ip` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `vis_agente` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `vis_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `vis_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `vis_fechahora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `sis_centinela`
--

INSERT INTO `sis_centinela` (`idvisita`, `vis_cod`, `idwebusuario`, `vis_ip`, `vis_agente`, `vis_method`, `vis_url`, `vis_fechahora`) VALUES
(10907, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin', '2024-11-20 16:27:28'),
(10908, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-20 16:27:30'),
(10909, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-20 16:27:30'),
(10910, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-20 16:27:53'),
(10911, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-20 16:27:53'),
(10912, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:27:56'),
(10913, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:27:56'),
(10914, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save', '2024-11-20 16:28:03'),
(10915, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:28:03'),
(10916, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/e', '2024-11-20 16:28:05'),
(10917, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/p', '2024-11-20 16:28:05'),
(10918, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/u', '2024-11-20 16:28:05'),
(10919, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-20 16:28:16'),
(10920, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-20 16:28:16'),
(10921, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:28:16'),
(10922, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:28:19'),
(10923, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:28:19'),
(10924, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-20 16:28:21'),
(10925, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-20 16:28:21'),
(10926, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:28:22'),
(10927, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:28:22'),
(10928, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 16:28:23'),
(10929, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:28:24'),
(10930, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-20 16:28:24'),
(10931, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/save', '2024-11-20 16:28:53'),
(10932, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:28:53'),
(10933, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-20 16:28:53'),
(10934, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/search', '2024-11-20 16:28:56'),
(10935, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/m', '2024-11-20 16:28:56'),
(10936, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-20 16:28:56'),
(10937, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:28:56'),
(10938, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-20 16:29:04'),
(10939, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-20 16:29:04'),
(10940, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-20 16:29:04'),
(10941, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:29:04'),
(10942, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:29:04'),
(10943, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:29:07'),
(10944, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=1', '2024-11-20 16:29:13'),
(10945, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 16:29:14'),
(10946, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732138154004', '2024-11-20 16:29:14'),
(10947, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-20 16:29:14'),
(10948, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-20 16:29:14'),
(10949, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-20 16:29:54'),
(10950, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732138154005', '2024-11-20 16:29:54'),
(10951, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:30:20'),
(10952, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:30:21'),
(10953, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:30:22'),
(10954, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:30:23'),
(10955, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/delete/art', '2024-11-20 16:30:26'),
(10956, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/delete/art', '2024-11-20 16:30:29'),
(10957, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:30:30'),
(10958, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 16:30:30'),
(10959, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:30:31'),
(10960, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:30:31'),
(10961, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:30:31'),
(10962, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-20 16:30:39'),
(10963, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 16:30:40'),
(10964, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-20 16:30:40'),
(10965, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 16:30:48'),
(10966, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 16:30:49'),
(10967, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732138249362', '2024-11-20 16:30:49'),
(10968, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 16:30:50'),
(10969, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 16:30:51'),
(10970, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:30:51'),
(10971, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:31:00'),
(10972, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 16:31:01'),
(10973, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:31:01'),
(10974, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:31:02'),
(10975, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-20 16:31:47'),
(10976, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 16:31:48'),
(10977, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-20 16:31:48'),
(10978, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-20 16:31:50'),
(10979, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 16:31:51'),
(10980, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-20 16:31:51'),
(10981, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:31:51'),
(10982, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:31:52'),
(10983, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:32:03'),
(10984, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:32:04'),
(10985, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-20 16:32:04'),
(10986, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-20 16:32:04'),
(10987, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:32:06'),
(10988, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:32:06'),
(10989, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 16:32:07'),
(10990, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:32:07'),
(10991, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 16:32:08'),
(10992, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732138328985', '2024-11-20 16:32:09'),
(10993, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:32:11'),
(10994, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:32:11'),
(10995, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save', '2024-11-20 16:32:16'),
(10996, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:32:16'),
(10997, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/p', '2024-11-20 16:32:18'),
(10998, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/e', '2024-11-20 16:32:18'),
(10999, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/u', '2024-11-20 16:32:18'),
(11000, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-20 16:32:25'),
(11001, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-20 16:32:25'),
(11002, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:32:25'),
(11003, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-20 16:32:28'),
(11004, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-20 16:32:28'),
(11005, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 16:32:31'),
(11006, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:32:31'),
(11007, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:32:33'),
(11008, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:32:33'),
(11009, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 16:32:37'),
(11010, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:32:45'),
(11011, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:32:45'),
(11012, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:36:20'),
(11013, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 16:36:23'),
(11014, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:36:24'),
(11015, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-20 16:36:24'),
(11016, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/save', '2024-11-20 16:36:42'),
(11017, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:36:42'),
(11018, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-20 16:36:42'),
(11019, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/search', '2024-11-20 16:36:44'),
(11020, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/m', '2024-11-20 16:36:44'),
(11021, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-20 16:36:44'),
(11022, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:36:44'),
(11023, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-20 16:36:46'),
(11024, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-20 16:36:46'),
(11025, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-20 16:36:46'),
(11026, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:36:46'),
(11027, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:36:46'),
(11028, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/search', '2024-11-20 16:37:26'),
(11029, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/m', '2024-11-20 16:37:26'),
(11030, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-20 16:37:26'),
(11031, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:37:26'),
(11032, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:37:26'),
(11033, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 16:37:32'),
(11034, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:38:40'),
(11035, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:38:42'),
(11036, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:38:43'),
(11037, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:38:43'),
(11038, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/p', '2024-11-20 16:38:46'),
(11039, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/e', '2024-11-20 16:38:46'),
(11040, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/u', '2024-11-20 16:38:46'),
(11041, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-20 16:38:54'),
(11042, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-20 16:38:54'),
(11043, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:38:54'),
(11044, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-20 16:39:28'),
(11045, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-20 16:39:29'),
(11046, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:39:36'),
(11047, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:39:36'),
(11048, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:39:46'),
(11049, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:39:47'),
(11050, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/delete/art', '2024-11-20 16:39:50'),
(11051, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/delete/art', '2024-11-20 16:39:50'),
(11052, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:39:50'),
(11053, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:39:50'),
(11054, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:39:50'),
(11055, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:40:26'),
(11056, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:40:27'),
(11057, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:40:43'),
(11058, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:40:43'),
(11059, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:40:56'),
(11060, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:40:56'),
(11061, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:41:50'),
(11062, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:41:50'),
(11063, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:43:14'),
(11064, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:43:14'),
(11065, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 16:43:18'),
(11066, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:43:19'),
(11067, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 16:46:56'),
(11068, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 16:46:57'),
(11069, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:46:57'),
(11070, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:46:58'),
(11071, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:47:04'),
(11072, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:47:04'),
(11073, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:47:06'),
(11074, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:47:06'),
(11075, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-20 16:47:08'),
(11076, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-20 16:47:08'),
(11077, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 16:47:11'),
(11078, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:47:12'),
(11079, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:47:13'),
(11080, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:47:24'),
(11081, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 16:47:39'),
(11082, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:47:39'),
(11083, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=1', '2024-11-20 16:47:41'),
(11084, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 16:47:42'),
(11085, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732139262043', '2024-11-20 16:47:42'),
(11086, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-20 16:47:42'),
(11087, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-20 16:47:42'),
(11088, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 16:47:44'),
(11089, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:47:44'),
(11090, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/i', '2024-11-20 16:47:46'),
(11091, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:47:47'),
(11092, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:48:07'),
(11093, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:48:09'),
(11094, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=1', '2024-11-20 16:48:28'),
(11095, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 16:48:28'),
(11096, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732139308589', '2024-11-20 16:48:28'),
(11097, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-20 16:48:28'),
(11098, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-20 16:48:28'),
(11099, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-20 16:48:39'),
(11100, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 16:48:45'),
(11101, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-20 16:48:45'),
(11102, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=1', '2024-11-20 16:49:31'),
(11103, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 16:49:31'),
(11104, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 16:49:32'),
(11105, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732139371730', '2024-11-20 16:49:32'),
(11106, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-20 16:49:32'),
(11107, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-20 16:49:32'),
(11108, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-20 16:49:39'),
(11109, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-20 16:49:45'),
(11110, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732139371731', '2024-11-20 16:49:45'),
(11111, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 16:50:01'),
(11112, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732139401387', '2024-11-20 16:50:01'),
(11113, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 16:51:06'),
(11114, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732139466212', '2024-11-20 16:51:06'),
(11115, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 16:51:57'),
(11116, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 16:53:13'),
(11117, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin', '2024-11-20 16:53:41'),
(11118, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 16:53:44'),
(11119, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:53:44'),
(11120, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 16:54:04'),
(11121, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:54:04'),
(11122, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-20 16:54:10'),
(11123, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-20 16:54:10'),
(11124, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:54:11'),
(11125, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:54:12'),
(11126, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:54:13'),
(11127, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:54:13'),
(11128, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:57:04'),
(11129, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:57:05'),
(11130, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-20 16:57:06'),
(11131, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-20 16:57:06'),
(11132, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:57:06'),
(11133, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:57:07'),
(11134, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save', '2024-11-20 16:57:14'),
(11135, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:57:14'),
(11136, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/p', '2024-11-20 16:57:16'),
(11137, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/u', '2024-11-20 16:57:16'),
(11138, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/e', '2024-11-20 16:57:16'),
(11139, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-20 16:57:22'),
(11140, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-20 16:57:22'),
(11141, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:57:22'),
(11142, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:57:25'),
(11143, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:57:25'),
(11144, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-20 16:57:25'),
(11145, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-20 16:57:26'),
(11146, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:57:26'),
(11147, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:57:27'),
(11148, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:57:28'),
(11149, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:57:28'),
(11150, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 16:57:31'),
(11151, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:57:31'),
(11152, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-20 16:57:32'),
(11153, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/save', '2024-11-20 16:57:43'),
(11154, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:57:43'),
(11155, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-20 16:57:43'),
(11156, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/search', '2024-11-20 16:57:45'),
(11157, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-20 16:57:45');
INSERT INTO `sis_centinela` (`idvisita`, `vis_cod`, `idwebusuario`, `vis_ip`, `vis_agente`, `vis_method`, `vis_url`, `vis_fechahora`) VALUES
(11158, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/m', '2024-11-20 16:57:45'),
(11159, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:57:45'),
(11160, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-20 16:57:47'),
(11161, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-20 16:57:47'),
(11162, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-20 16:57:47'),
(11163, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:57:47'),
(11164, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:57:47'),
(11165, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/i', '2024-11-20 16:58:03'),
(11166, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:58:03'),
(11167, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:58:04'),
(11168, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:58:06'),
(11169, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-20 16:58:13'),
(11170, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:58:14'),
(11171, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/e', '2024-11-20 16:58:15'),
(11172, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/p', '2024-11-20 16:58:15'),
(11173, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/u', '2024-11-20 16:58:15'),
(11174, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-20 16:58:22'),
(11175, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-20 16:58:22'),
(11176, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:58:22'),
(11177, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:58:48'),
(11178, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:58:48'),
(11179, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/delete/art', '2024-11-20 16:58:50'),
(11180, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/delete/art', '2024-11-20 16:58:50'),
(11181, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-20 16:58:50'),
(11182, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-20 16:58:50'),
(11183, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 16:58:50'),
(11184, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 16:59:56'),
(11185, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 16:59:57'),
(11186, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 16:59:58'),
(11187, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 17:00:02'),
(11188, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140002195', '2024-11-20 17:00:02'),
(11189, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 17:00:04'),
(11190, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 17:00:04'),
(11191, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=1', '2024-11-20 17:00:07'),
(11192, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 17:00:07'),
(11193, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140007319', '2024-11-20 17:00:07'),
(11194, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-20 17:00:07'),
(11195, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-20 17:00:07'),
(11196, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-20 17:00:18'),
(11197, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140007320', '2024-11-20 17:00:18'),
(11198, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 17:00:37'),
(11199, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=1', '2024-11-20 17:00:40'),
(11200, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 17:00:40'),
(11201, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140040213', '2024-11-20 17:00:40'),
(11202, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-20 17:00:40'),
(11203, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-20 17:00:40'),
(11204, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=1', '2024-11-20 17:00:45'),
(11205, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 17:00:45'),
(11206, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140045581', '2024-11-20 17:00:45'),
(11207, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-20 17:00:45'),
(11208, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-20 17:00:45'),
(11209, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 17:00:56'),
(11210, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 17:00:56'),
(11211, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 17:01:10'),
(11212, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140070360', '2024-11-20 17:01:10'),
(11213, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 17:01:50'),
(11214, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 17:01:53'),
(11215, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 17:01:53'),
(11216, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=1', '2024-11-20 17:01:54'),
(11217, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 17:01:54'),
(11218, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140114764', '2024-11-20 17:01:54'),
(11219, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-20 17:01:55'),
(11220, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-20 17:01:55'),
(11221, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-20 17:02:03'),
(11222, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140114765', '2024-11-20 17:02:03'),
(11223, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 17:02:06'),
(11224, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=1', '2024-11-20 17:02:08'),
(11225, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 17:02:09'),
(11226, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140129089', '2024-11-20 17:02:09'),
(11227, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-20 17:02:09'),
(11228, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-20 17:02:09'),
(11229, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-20 17:02:17'),
(11230, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140129090', '2024-11-20 17:02:17'),
(11231, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?search=&estados=&severidad=&_=1732140129091', '2024-11-20 17:03:23'),
(11232, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?search=titulo&estados=&severidad=&_=1732140129092', '2024-11-20 17:03:27'),
(11233, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?search=titulo&estados=1&severidad=&_=1732140129093', '2024-11-20 17:03:29'),
(11234, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?search=titulo&estados=2&severidad=&_=1732140129094', '2024-11-20 17:03:31'),
(11235, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?search=titulo&estados=3&severidad=&_=1732140129095', '2024-11-20 17:03:34'),
(11236, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?search=titulo&estados=3&severidad=1&_=1732140129096', '2024-11-20 17:03:35'),
(11237, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?search=titulo&estados=3&severidad=2&_=1732140129097', '2024-11-20 17:03:37'),
(11238, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?search=titulo&estados=&severidad=2&_=1732140129098', '2024-11-20 17:03:39'),
(11239, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?search=titulo&estados=&severidad=3&_=1732140129099', '2024-11-20 17:03:40'),
(11240, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?search=titulo&estados=&severidad=&_=1732140129100', '2024-11-20 17:03:43'),
(11241, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 17:03:46'),
(11242, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140226713', '2024-11-20 17:03:46'),
(11243, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 17:03:55'),
(11244, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 17:03:55'),
(11245, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 17:03:56'),
(11246, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140237002', '2024-11-20 17:03:57'),
(11247, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 17:04:29'),
(11248, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140269832', '2024-11-20 17:04:30'),
(11249, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 17:04:30'),
(11250, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 17:04:30'),
(11251, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 17:04:31'),
(11252, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 17:04:32'),
(11253, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 17:04:38'),
(11254, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 17:04:39'),
(11255, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 17:04:39'),
(11256, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-20 17:04:42'),
(11257, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-20 17:04:42'),
(11258, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 17:04:42'),
(11259, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 17:05:10'),
(11260, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 17:05:12'),
(11261, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-20 17:05:17'),
(11262, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-20 17:05:18'),
(11263, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 17:05:20'),
(11264, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 17:05:20'),
(11265, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 17:05:27'),
(11266, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 17:05:43'),
(11267, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 17:08:57'),
(11268, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140538031', '2024-11-20 17:08:58'),
(11269, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 17:08:59'),
(11270, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 17:08:59'),
(11271, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-20 17:09:01'),
(11272, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/save', '2024-11-20 17:09:13'),
(11273, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 17:09:13'),
(11274, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-20 17:09:13'),
(11275, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/search', '2024-11-20 17:09:16'),
(11276, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/m', '2024-11-20 17:09:16'),
(11277, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-20 17:09:16'),
(11278, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 17:09:16'),
(11279, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-20 17:09:18'),
(11280, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-20 17:09:18'),
(11281, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-20 17:09:18'),
(11282, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 17:09:18'),
(11283, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-20 17:09:18'),
(11284, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=2', '2024-11-20 17:09:23'),
(11285, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 17:09:23'),
(11286, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140563288', '2024-11-20 17:09:23'),
(11287, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-20 17:09:23'),
(11288, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-20 17:09:23'),
(11289, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-20 17:09:32'),
(11290, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140563289', '2024-11-20 17:09:32'),
(11291, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-20 17:09:34'),
(11292, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 17:09:35'),
(11293, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-20 17:09:40'),
(11294, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-20 17:09:45'),
(11295, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 17:09:49'),
(11296, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-20 17:09:53'),
(11297, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-20 17:10:09'),
(11298, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/i', '2024-11-20 17:10:33'),
(11299, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-20 17:10:33'),
(11300, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 17:10:36'),
(11301, 1415, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732140637168', '2024-11-20 17:10:37'),
(11302, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/', '2024-11-20 23:02:19'),
(11303, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/login', '2024-11-20 23:04:01'),
(11304, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/', '2024-11-20 23:04:03'),
(11305, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin', '2024-11-20 23:04:03'),
(11306, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:04:07'),
(11307, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732161847399', '2024-11-20 23:04:07'),
(11308, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 23:10:20'),
(11309, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:10:39'),
(11310, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:18:14'),
(11311, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:18:15'),
(11312, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732162695420', '2024-11-20 23:18:16'),
(11313, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:18:35'),
(11314, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:18:36'),
(11315, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732162716275', '2024-11-20 23:18:36'),
(11316, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:19:29'),
(11317, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:19:31'),
(11318, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732162771093', '2024-11-20 23:19:31'),
(11319, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:19:41'),
(11320, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:19:41'),
(11321, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732162781876', '2024-11-20 23:19:42'),
(11322, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:19:52'),
(11323, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:19:53'),
(11324, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732162793362', '2024-11-20 23:19:53'),
(11325, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:20:38'),
(11326, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:20:38'),
(11327, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732162838679', '2024-11-20 23:20:39'),
(11328, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:20:53'),
(11329, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:20:54'),
(11330, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732162854239', '2024-11-20 23:20:54'),
(11331, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:21:13'),
(11332, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:21:14'),
(11333, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732162874081', '2024-11-20 23:21:14'),
(11334, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:21:22'),
(11335, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:21:23'),
(11336, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732162883519', '2024-11-20 23:21:23'),
(11337, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:21:38'),
(11338, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732162898178', '2024-11-20 23:21:38'),
(11339, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:21:43'),
(11340, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:21:58'),
(11341, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732162919285', '2024-11-20 23:21:59'),
(11342, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:22:13'),
(11343, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732162934120', '2024-11-20 23:22:14'),
(11344, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-20 23:22:23'),
(11345, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:23:47'),
(11346, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732163028239', '2024-11-20 23:23:48'),
(11347, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:24:03'),
(11348, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732163044025', '2024-11-20 23:24:04'),
(11349, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:24:22'),
(11350, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:24:40'),
(11351, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:24:41'),
(11352, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732163081069', '2024-11-20 23:24:41'),
(11353, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:30:46'),
(11354, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:30:48'),
(11355, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732163447692', '2024-11-20 23:30:48'),
(11356, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:30:52'),
(11357, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:31:20'),
(11358, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:31:43'),
(11359, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:31:43'),
(11360, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732163503786', '2024-11-20 23:31:44'),
(11361, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:31:46'),
(11362, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:32:27'),
(11363, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:32:28'),
(11364, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732163548159', '2024-11-20 23:32:28'),
(11365, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:33:21'),
(11366, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:33:21'),
(11367, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732163601736', '2024-11-20 23:33:22'),
(11368, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:33:25'),
(11369, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:34:05'),
(11370, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:34:05'),
(11371, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732163645529', '2024-11-20 23:34:05'),
(11372, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:34:06'),
(11373, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:41:35'),
(11374, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:42:44'),
(11375, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:44:53'),
(11376, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:46:05'),
(11377, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:47:04'),
(11378, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:49:23'),
(11379, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:53:48'),
(11380, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:53:49'),
(11381, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732164829848', '2024-11-20 23:53:50'),
(11382, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:53:56'),
(11383, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:54:14'),
(11384, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:55:47'),
(11385, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:55:48'),
(11386, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732164948448', '2024-11-20 23:55:48'),
(11387, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:55:49'),
(11388, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:56:19'),
(11389, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:56:20'),
(11390, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732164980386', '2024-11-20 23:56:20'),
(11391, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:56:21'),
(11392, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-20 23:57:40'),
(11393, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-20 23:57:41'),
(11394, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732165061050', '2024-11-20 23:57:41'),
(11395, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-20 23:57:43'),
(11396, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 00:00:53'),
(11397, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 00:00:54'),
(11398, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732165254009', '2024-11-21 00:00:54'),
(11399, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 00:01:50'),
(11400, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 00:01:50');
INSERT INTO `sis_centinela` (`idvisita`, `vis_cod`, `idwebusuario`, `vis_ip`, `vis_agente`, `vis_method`, `vis_url`, `vis_fechahora`) VALUES
(11401, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732165310523', '2024-11-21 00:01:51'),
(11402, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 00:01:54'),
(11403, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/generarpdf', '2024-11-21 00:01:57'),
(11404, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/generarpdf', '2024-11-21 00:08:29'),
(11405, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/generarpdf', '2024-11-21 00:23:30'),
(11406, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 00:29:15'),
(11407, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 00:31:30'),
(11408, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/generarpdf', '2024-11-21 00:31:34'),
(11409, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/generarpdf', '2024-11-21 00:32:25'),
(11410, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/generarpdf', '2024-11-21 00:33:22'),
(11411, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/generarpdf', '2024-11-21 00:38:17'),
(11412, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/generarpdf', '2024-11-21 00:39:43'),
(11413, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/generarpdf', '2024-11-21 00:40:23'),
(11414, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/generarpdf', '2024-11-21 00:42:58'),
(11415, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/generarpdf', '2024-11-21 00:43:16'),
(11416, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/generarpdf', '2024-11-21 00:44:36'),
(11417, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 00:49:09'),
(11418, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 00:49:10'),
(11419, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732168150388', '2024-11-21 00:49:10'),
(11420, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 00:55:53'),
(11421, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 00:55:56'),
(11422, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 00:56:31'),
(11423, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 00:59:53'),
(11424, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:00:23'),
(11425, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:00:40'),
(11426, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:01:12'),
(11427, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:01:34'),
(11428, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:01:42'),
(11429, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:01:51'),
(11430, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:01:57'),
(11431, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:02:18'),
(11432, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:04:46'),
(11433, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:06:25'),
(11434, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:08:45'),
(11435, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:08:49'),
(11436, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:08:52'),
(11437, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:08:53'),
(11438, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732169333812', '2024-11-21 01:08:54'),
(11439, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:08:56'),
(11440, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:08:58'),
(11441, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:09:26'),
(11442, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:09:26'),
(11443, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732169366581', '2024-11-21 01:09:27'),
(11444, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:09:28'),
(11445, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:09:29'),
(11446, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:11:17'),
(11447, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:11:44'),
(11448, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:12:01'),
(11449, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:13:26'),
(11450, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:13:32'),
(11451, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732169613379', '2024-11-21 01:13:33'),
(11452, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:13:36'),
(11453, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 01:14:57'),
(11454, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 01:14:57'),
(11455, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:15:21'),
(11456, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732169722276', '2024-11-21 01:15:22'),
(11457, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:15:23'),
(11458, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 01:15:25'),
(11459, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 01:15:25'),
(11460, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:15:52'),
(11461, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:15:52'),
(11462, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:15:53'),
(11463, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732169753434', '2024-11-21 01:15:53'),
(11464, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:17:31'),
(11465, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:18:18'),
(11466, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:18:19'),
(11467, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732169899764', '2024-11-21 01:18:20'),
(11468, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 01:18:30'),
(11469, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:18:30'),
(11470, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 01:18:31'),
(11471, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=1', '2024-11-21 01:18:34'),
(11472, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:18:34'),
(11473, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:18:34'),
(11474, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732169914509', '2024-11-21 01:18:34'),
(11475, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 01:18:34'),
(11476, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 01:18:35'),
(11477, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=1', '2024-11-21 01:21:55'),
(11478, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:21:56'),
(11479, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:21:56'),
(11480, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732170116381', '2024-11-21 01:21:56'),
(11481, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 01:21:56'),
(11482, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 01:21:57'),
(11483, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:21:59'),
(11484, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:22:00'),
(11485, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732170120226', '2024-11-21 01:22:00'),
(11486, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:22:03'),
(11487, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:22:36'),
(11488, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:22:37'),
(11489, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732170157033', '2024-11-21 01:22:37'),
(11490, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:22:39'),
(11491, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:23:16'),
(11492, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:35:50'),
(11493, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:35:51'),
(11494, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732170951951', '2024-11-21 01:35:52'),
(11495, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:35:57'),
(11496, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/', '2024-11-21 01:35:57'),
(11497, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:36:32'),
(11498, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:36:32'),
(11499, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732170992670', '2024-11-21 01:36:33'),
(11500, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:36:34'),
(11501, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:36:34'),
(11502, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/', '2024-11-21 01:36:34'),
(11503, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:39:19'),
(11504, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:39:20'),
(11505, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732171160523', '2024-11-21 01:39:20'),
(11506, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:39:22'),
(11507, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:39:22'),
(11508, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/', '2024-11-21 01:39:22'),
(11509, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:41:18'),
(11510, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:41:19'),
(11511, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/', '2024-11-21 01:41:19'),
(11512, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:42:04'),
(11513, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:42:06'),
(11514, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732171326154', '2024-11-21 01:42:06'),
(11515, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:42:09'),
(11516, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:42:09'),
(11517, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 01:42:09'),
(11518, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 01:42:09'),
(11519, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:42:14'),
(11520, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 01:42:32'),
(11521, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:42:55'),
(11522, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:42:55'),
(11523, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 01:42:55'),
(11524, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 01:42:55'),
(11525, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:44:29'),
(11526, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:44:31'),
(11527, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732171471100', '2024-11-21 01:44:31'),
(11528, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:44:32'),
(11529, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:44:32'),
(11530, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 01:44:32'),
(11531, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 01:44:32'),
(11532, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:44:48'),
(11533, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:44:49'),
(11534, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732171489036', '2024-11-21 01:44:49'),
(11535, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:45:00'),
(11536, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:45:00'),
(11537, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732171500816', '2024-11-21 01:45:01'),
(11538, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:45:06'),
(11539, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:45:06'),
(11540, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 01:45:06'),
(11541, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 01:45:06'),
(11542, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:45:33'),
(11543, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:45:34'),
(11544, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732171534363', '2024-11-21 01:45:34'),
(11545, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:45:43'),
(11546, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:45:44'),
(11547, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732171544331', '2024-11-21 01:45:44'),
(11548, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:45:45'),
(11549, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:45:45'),
(11550, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 01:45:45'),
(11551, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 01:45:45'),
(11552, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:46:29'),
(11553, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:46:29'),
(11554, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 01:46:29'),
(11555, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 01:46:29'),
(11556, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:54:39'),
(11557, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:54:40'),
(11558, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732172080518', '2024-11-21 01:54:40'),
(11559, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:54:46'),
(11560, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:54:46'),
(11561, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 01:54:46'),
(11562, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 01:54:46'),
(11563, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:54:58'),
(11564, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:55:17'),
(11565, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:55:18'),
(11566, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732172118332', '2024-11-21 01:55:18'),
(11567, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:55:19'),
(11568, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:55:19'),
(11569, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 01:55:19'),
(11570, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 01:55:20'),
(11571, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:55:25'),
(11572, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:55:25'),
(11573, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 01:55:25'),
(11574, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 01:55:25'),
(11575, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:55:32'),
(11576, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 01:55:37'),
(11577, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 01:55:37'),
(11578, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 01:55:58'),
(11579, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:55:59'),
(11580, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732172159256', '2024-11-21 01:55:59'),
(11581, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 01:56:08'),
(11582, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:56:08'),
(11583, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 01:56:08'),
(11584, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 01:56:08'),
(11585, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 01:57:50'),
(11586, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 01:57:51'),
(11587, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:58:10'),
(11588, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 01:58:14'),
(11589, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 01:58:16'),
(11590, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 01:58:16'),
(11591, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 02:07:09'),
(11592, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 02:07:10'),
(11593, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732172830833', '2024-11-21 02:07:11'),
(11594, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 02:07:19'),
(11595, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 02:07:19'),
(11596, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 02:07:19'),
(11597, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 02:07:19'),
(11598, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 02:07:44'),
(11599, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 02:07:49'),
(11600, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 02:07:49'),
(11601, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 02:08:29'),
(11602, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 02:08:30'),
(11603, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732172909936', '2024-11-21 02:08:30'),
(11604, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 02:08:35'),
(11605, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 02:08:36'),
(11606, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 02:08:36'),
(11607, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 02:08:47'),
(11608, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 02:08:54'),
(11609, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 02:08:54'),
(11610, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 02:08:54'),
(11611, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 02:08:54'),
(11612, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 02:08:59'),
(11613, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 02:09:01'),
(11614, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 02:09:01'),
(11615, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 02:09:16'),
(11616, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 02:09:16'),
(11617, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 02:09:16'),
(11618, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 02:09:16'),
(11619, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 02:09:21'),
(11620, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 02:10:13'),
(11621, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 02:10:16'),
(11622, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 02:10:16'),
(11623, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 02:10:37'),
(11624, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 02:11:37'),
(11625, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 02:11:37'),
(11626, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 02:11:37'),
(11627, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 02:11:37'),
(11628, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 02:11:40'),
(11629, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 02:12:09'),
(11630, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 02:12:10'),
(11631, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732173130157', '2024-11-21 02:12:10'),
(11632, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 02:12:12'),
(11633, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 02:12:12'),
(11634, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 02:12:12'),
(11635, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 02:12:13'),
(11636, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 02:12:17'),
(11637, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 02:12:30'),
(11638, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 02:12:30'),
(11639, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 02:12:30'),
(11640, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 02:12:30');
INSERT INTO `sis_centinela` (`idvisita`, `vis_cod`, `idwebusuario`, `vis_ip`, `vis_agente`, `vis_method`, `vis_url`, `vis_fechahora`) VALUES
(11641, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 02:12:31'),
(11642, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 02:12:32'),
(11643, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732173152137', '2024-11-21 02:12:32'),
(11644, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 02:12:33'),
(11645, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 02:12:33'),
(11646, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 02:12:33'),
(11647, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 02:12:33'),
(11648, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 02:12:43'),
(11649, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 02:12:43'),
(11650, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 02:12:43'),
(11651, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 02:12:43'),
(11652, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 02:13:28'),
(11653, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 02:13:29'),
(11654, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732173209662', '2024-11-21 02:13:30'),
(11655, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 02:13:31'),
(11656, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 02:13:31'),
(11657, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 02:13:31'),
(11658, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 02:13:31'),
(11659, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/', '2024-11-21 11:36:02'),
(11660, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/login', '2024-11-21 11:36:11'),
(11661, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/', '2024-11-21 11:36:12'),
(11662, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin', '2024-11-21 11:36:12'),
(11663, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:36:19'),
(11664, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732206979617', '2024-11-21 11:36:19'),
(11665, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:36:24'),
(11666, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 11:36:28'),
(11667, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:37:03'),
(11668, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207024196', '2024-11-21 11:37:04'),
(11669, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:37:06'),
(11670, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:37:16'),
(11671, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207037028', '2024-11-21 11:37:17'),
(11672, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:37:18'),
(11673, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:37:55'),
(11674, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207075866', '2024-11-21 11:37:56'),
(11675, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:37:57'),
(11676, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:38:01'),
(11677, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207081454', '2024-11-21 11:38:01'),
(11678, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:38:02'),
(11679, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 11:38:37'),
(11680, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 11:38:38'),
(11681, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:38:44'),
(11682, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207124154', '2024-11-21 11:38:44'),
(11683, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:38:45'),
(11684, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207125194', '2024-11-21 11:38:45'),
(11685, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 11:38:47'),
(11686, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 11:38:47'),
(11687, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=1', '2024-11-21 11:38:53'),
(11688, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 11:38:53'),
(11689, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207133489', '2024-11-21 11:38:53'),
(11690, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 11:38:53'),
(11691, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 11:38:53'),
(11692, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 11:39:18'),
(11693, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 11:39:22'),
(11694, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 11:39:23'),
(11695, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 11:39:43'),
(11696, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207133490', '2024-11-21 11:39:43'),
(11697, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:39:48'),
(11698, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 11:39:57'),
(11699, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 11:39:57'),
(11700, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:40:04'),
(11701, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207204219', '2024-11-21 11:40:04'),
(11702, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:40:11'),
(11703, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:43:55'),
(11704, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207435815', '2024-11-21 11:43:56'),
(11705, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:43:58'),
(11706, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:44:10'),
(11707, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207450310', '2024-11-21 11:44:10'),
(11708, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:44:12'),
(11709, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:44:39'),
(11710, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207479647', '2024-11-21 11:44:39'),
(11711, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:44:41'),
(11712, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 11:44:42'),
(11713, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 11:44:42'),
(11714, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207482514', '2024-11-21 11:44:42'),
(11715, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:44:49'),
(11716, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:45:25'),
(11717, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 11:45:26'),
(11718, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207526041', '2024-11-21 11:45:26'),
(11719, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:45:28'),
(11720, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:45:33'),
(11721, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:46:05'),
(11722, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 11:46:06'),
(11723, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207566104', '2024-11-21 11:46:06'),
(11724, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:46:08'),
(11725, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:46:29'),
(11726, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 11:46:30'),
(11727, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207590466', '2024-11-21 11:46:30'),
(11728, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:46:32'),
(11729, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:46:37'),
(11730, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:47:21'),
(11731, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 11:47:21'),
(11732, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207641526', '2024-11-21 11:47:22'),
(11733, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:48:16'),
(11734, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:48:20'),
(11735, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:48:25'),
(11736, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207706474', '2024-11-21 11:48:26'),
(11737, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:48:27'),
(11738, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:48:54'),
(11739, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732207734369', '2024-11-21 11:48:54'),
(11740, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:48:56'),
(11741, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:50:18'),
(11742, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 11:50:19'),
(11743, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 11:50:19'),
(11744, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 11:50:19'),
(11745, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 11:53:06'),
(11746, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 11:53:10'),
(11747, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 11:53:35'),
(11748, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 11:53:36'),
(11749, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732208016139', '2024-11-21 11:53:36'),
(11750, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 11:53:41'),
(11751, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 11:53:41'),
(11752, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 11:53:41'),
(11753, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 11:53:41'),
(11754, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 11:53:50'),
(11755, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:05:14'),
(11756, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732208714722', '2024-11-21 12:05:14'),
(11757, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:05:18'),
(11758, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 12:05:19'),
(11759, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:05:19'),
(11760, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 12:05:19'),
(11761, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 12:05:19'),
(11762, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 12:05:34'),
(11763, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732208714723', '2024-11-21 12:05:34'),
(11764, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 12:05:47'),
(11765, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:05:47'),
(11766, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 12:05:47'),
(11767, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 12:05:47'),
(11768, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 12:06:00'),
(11769, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 12:06:04'),
(11770, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:06:04'),
(11771, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 12:06:05'),
(11772, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 12:06:05'),
(11773, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 12:06:50'),
(11774, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 12:06:56'),
(11775, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:06:56'),
(11776, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 12:06:56'),
(11777, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 12:06:56'),
(11778, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 12:07:01'),
(11779, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:07:31'),
(11780, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:07:32'),
(11781, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732208852310', '2024-11-21 12:07:32'),
(11782, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 12:07:35'),
(11783, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:07:35'),
(11784, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 12:07:35'),
(11785, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 12:07:35'),
(11786, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 12:08:48'),
(11787, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:08:48'),
(11788, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 12:08:48'),
(11789, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 12:08:48'),
(11790, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 12:09:03'),
(11791, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 12:10:00'),
(11792, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732208852311', '2024-11-21 12:10:00'),
(11793, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 12:10:15'),
(11794, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:10:15'),
(11795, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 12:10:15'),
(11796, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 12:10:15'),
(11797, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 12:10:18'),
(11798, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:10:18'),
(11799, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 12:10:18'),
(11800, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 12:10:18'),
(11801, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:11:28'),
(11802, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209088754', '2024-11-21 12:11:29'),
(11803, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:11:34'),
(11804, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 12:11:39'),
(11805, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 12:11:39'),
(11806, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=2', '2024-11-21 12:11:41'),
(11807, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:11:42'),
(11808, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209102080', '2024-11-21 12:11:42'),
(11809, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 12:11:42'),
(11810, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 12:11:42'),
(11811, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 12:12:03'),
(11812, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209102081', '2024-11-21 12:12:03'),
(11813, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 12:12:05'),
(11814, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 12:12:07'),
(11815, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:12:07'),
(11816, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 12:12:07'),
(11817, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 12:12:07'),
(11818, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:12:22'),
(11819, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209143060', '2024-11-21 12:12:23'),
(11820, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 12:12:35'),
(11821, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:12:35'),
(11822, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/2', '2024-11-21 12:12:35'),
(11823, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/2', '2024-11-21 12:12:35'),
(11824, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:12:38'),
(11825, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 12:12:44'),
(11826, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209143061', '2024-11-21 12:12:44'),
(11827, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 12:12:52'),
(11828, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:12:52'),
(11829, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 12:12:53'),
(11830, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=1', '2024-11-21 12:12:58'),
(11831, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:12:59'),
(11832, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:12:59'),
(11833, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209179135', '2024-11-21 12:12:59'),
(11834, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 12:12:59'),
(11835, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 12:12:59'),
(11836, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 12:13:17'),
(11837, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209179136', '2024-11-21 12:13:17'),
(11838, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:14:30'),
(11839, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 12:14:33'),
(11840, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 12:14:33'),
(11841, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 12:15:17'),
(11842, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 12:15:19'),
(11843, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-21 12:15:20'),
(11844, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/save', '2024-11-21 12:15:36'),
(11845, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 12:15:36'),
(11846, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-21 12:15:36'),
(11847, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/search', '2024-11-21 12:15:38'),
(11848, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/m', '2024-11-21 12:15:38'),
(11849, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-21 12:15:38'),
(11850, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 12:15:38'),
(11851, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-21 12:15:42'),
(11852, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 12:15:42'),
(11853, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save', '2024-11-21 12:15:48'),
(11854, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 12:15:48'),
(11855, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/p', '2024-11-21 12:15:52'),
(11856, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/u', '2024-11-21 12:15:52'),
(11857, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/e', '2024-11-21 12:15:52'),
(11858, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-21 12:16:01'),
(11859, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-21 12:16:01'),
(11860, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 12:16:01'),
(11861, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-21 12:16:09'),
(11862, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-21 12:16:09'),
(11863, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 12:16:10'),
(11864, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-21 12:16:15'),
(11865, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-21 12:16:15'),
(11866, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 12:16:17'),
(11867, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 12:16:18'),
(11868, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/search', '2024-11-21 12:16:19'),
(11869, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/m', '2024-11-21 12:16:19'),
(11870, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-21 12:16:19'),
(11871, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 12:16:20'),
(11872, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 12:16:24'),
(11873, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 12:16:24'),
(11874, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 12:16:24'),
(11875, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 12:16:25'),
(11876, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-21 12:16:25'),
(11877, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 12:16:27'),
(11878, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 12:16:27'),
(11879, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 12:16:28'),
(11880, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 12:16:28'),
(11881, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-21 12:16:29'),
(11882, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=3', '2024-11-21 12:16:37'),
(11883, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:16:37'),
(11884, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209397161', '2024-11-21 12:16:37');
INSERT INTO `sis_centinela` (`idvisita`, `vis_cod`, `idwebusuario`, `vis_ip`, `vis_agente`, `vis_method`, `vis_url`, `vis_fechahora`) VALUES
(11885, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/3', '2024-11-21 12:16:37'),
(11886, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/3', '2024-11-21 12:16:37'),
(11887, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 12:17:06'),
(11888, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209397162', '2024-11-21 12:17:06'),
(11889, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 12:17:11'),
(11890, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 12:17:18'),
(11891, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:17:18'),
(11892, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/3', '2024-11-21 12:17:18'),
(11893, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/3', '2024-11-21 12:17:18'),
(11894, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:19:32'),
(11895, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:19:34'),
(11896, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:19:35'),
(11897, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209575017', '2024-11-21 12:19:35'),
(11898, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:20:04'),
(11899, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:20:05'),
(11900, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209605158', '2024-11-21 12:20:05'),
(11901, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:20:29'),
(11902, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:20:29'),
(11903, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209629601', '2024-11-21 12:20:30'),
(11904, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:20:58'),
(11905, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:20:59'),
(11906, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209659633', '2024-11-21 12:20:59'),
(11907, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:21:06'),
(11908, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/3', '2024-11-21 12:21:07'),
(11909, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/3', '2024-11-21 12:21:07'),
(11910, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:22:36'),
(11911, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:22:37'),
(11912, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209757095', '2024-11-21 12:22:37'),
(11913, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:22:49'),
(11914, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/3', '2024-11-21 12:22:53'),
(11915, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/3', '2024-11-21 12:22:53'),
(11916, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:23:53'),
(11917, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/3', '2024-11-21 12:23:55'),
(11918, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/3', '2024-11-21 12:23:55'),
(11919, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:24:30'),
(11920, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:24:30'),
(11921, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209870771', '2024-11-21 12:24:31'),
(11922, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:24:32'),
(11923, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/3', '2024-11-21 12:24:33'),
(11924, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/3', '2024-11-21 12:24:33'),
(11925, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:25:32'),
(11926, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:25:33'),
(11927, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732209933051', '2024-11-21 12:25:33'),
(11928, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:25:34'),
(11929, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/3', '2024-11-21 12:25:36'),
(11930, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/3', '2024-11-21 12:25:36'),
(11931, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:27:26'),
(11932, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:27:27'),
(11933, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732210046909', '2024-11-21 12:27:27'),
(11934, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:27:29'),
(11935, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/3', '2024-11-21 12:27:30'),
(11936, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/3', '2024-11-21 12:27:30'),
(11937, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:28:22'),
(11938, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:28:23'),
(11939, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732210102925', '2024-11-21 12:28:23'),
(11940, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:28:24'),
(11941, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/3', '2024-11-21 12:28:26'),
(11942, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/3', '2024-11-21 12:28:26'),
(11943, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:31:44'),
(11944, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:31:45'),
(11945, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732210304970', '2024-11-21 12:31:45'),
(11946, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 12:31:46'),
(11947, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/3', '2024-11-21 12:31:48'),
(11948, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/3', '2024-11-21 12:31:48'),
(11949, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 12:32:14'),
(11950, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 12:32:15'),
(11951, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732210335285', '2024-11-21 12:32:15'),
(11952, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:06:35'),
(11953, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:06:37'),
(11954, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:06:37'),
(11955, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:06:37'),
(11956, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:06:37'),
(11957, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:07:23'),
(11958, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:07:23'),
(11959, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:07:23'),
(11960, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:07:23'),
(11961, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:08:43'),
(11962, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:08:43'),
(11963, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:08:44'),
(11964, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:08:44'),
(11965, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:09:07'),
(11966, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:09:07'),
(11967, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:09:07'),
(11968, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:09:07'),
(11969, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 13:17:37'),
(11970, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 13:17:38'),
(11971, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732213058399', '2024-11-21 13:17:38'),
(11972, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:17:42'),
(11973, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:17:42'),
(11974, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:17:42'),
(11975, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:17:42'),
(11976, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:19:02'),
(11977, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:19:02'),
(11978, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:19:02'),
(11979, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:19:02'),
(11980, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 13:21:08'),
(11981, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 13:21:09'),
(11982, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732213269201', '2024-11-21 13:21:09'),
(11983, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:21:12'),
(11984, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:21:12'),
(11985, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:21:12'),
(11986, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:21:12'),
(11987, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-21 13:25:32'),
(11988, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-21 13:25:33'),
(11989, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-21 13:25:35'),
(11990, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 13:25:35'),
(11991, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-21 13:25:43'),
(11992, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 13:25:43'),
(11993, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-21 13:25:48'),
(11994, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-21 13:25:49'),
(11995, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-21 13:26:45'),
(11996, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-21 13:26:46'),
(11997, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-21 13:26:48'),
(11998, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 13:26:48'),
(11999, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save', '2024-11-21 13:26:52'),
(12000, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save', '2024-11-21 13:26:54'),
(12001, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 13:26:54'),
(12002, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/e', '2024-11-21 13:26:57'),
(12003, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/p', '2024-11-21 13:26:57'),
(12004, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos/u', '2024-11-21 13:26:57'),
(12005, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-21 13:27:04'),
(12006, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-21 13:27:04'),
(12007, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 13:27:04'),
(12008, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-21 13:27:12'),
(12009, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-21 13:27:12'),
(12010, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 13:27:12'),
(12011, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-21 13:27:19'),
(12012, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/save/art', '2024-11-21 13:27:19'),
(12013, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 13:27:20'),
(12014, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos/view', '2024-11-21 13:27:24'),
(12015, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-21 13:27:24'),
(12016, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-21 13:27:27'),
(12017, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-21 13:27:28'),
(12018, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-21 13:27:33'),
(12019, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 13:27:33'),
(12020, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 13:27:36'),
(12021, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 13:27:37'),
(12022, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-21 13:27:39'),
(12023, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/save', '2024-11-21 13:27:55'),
(12024, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 13:27:55'),
(12025, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-21 13:27:55'),
(12026, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/search', '2024-11-21 13:27:58'),
(12027, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-21 13:27:58'),
(12028, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/m', '2024-11-21 13:27:58'),
(12029, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 13:27:58'),
(12030, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 13:28:00'),
(12031, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 13:28:00'),
(12032, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 13:28:00'),
(12033, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 13:28:00'),
(12034, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-21 13:28:00'),
(12035, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 13:28:04'),
(12036, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 13:28:04'),
(12037, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 13:28:04'),
(12038, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 13:28:04'),
(12039, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-21 13:28:04'),
(12040, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 13:28:17'),
(12041, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 13:28:17'),
(12042, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 13:28:21'),
(12043, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 13:28:21'),
(12044, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/sm', '2024-11-21 13:28:21'),
(12045, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 13:28:21'),
(12046, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/img/bin_empty.png', '2024-11-21 13:28:22'),
(12047, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 13:28:26'),
(12048, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 13:28:28'),
(12049, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 13:28:31'),
(12050, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732213712109', '2024-11-21 13:28:32'),
(12051, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 13:28:32'),
(12052, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 13:28:33'),
(12053, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias?idingreso=1', '2024-11-21 13:28:35'),
(12054, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:28:35'),
(12055, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732213715287', '2024-11-21 13:28:35'),
(12056, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:28:35'),
(12057, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:28:35'),
(12058, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 13:28:39'),
(12059, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 13:29:02'),
(12060, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732213715288', '2024-11-21 13:29:02'),
(12061, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:29:04'),
(12062, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 13:29:07'),
(12063, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:32:14'),
(12064, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:32:14'),
(12065, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:32:14'),
(12066, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:32:14'),
(12067, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:33:58'),
(12068, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:33:58'),
(12069, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:33:58'),
(12070, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:33:58'),
(12071, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 13:34:58'),
(12072, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 13:37:12'),
(12073, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 13:41:21'),
(12074, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732213715289', '2024-11-21 13:41:21'),
(12075, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:41:41'),
(12076, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:41:41'),
(12077, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:41:41'),
(12078, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:41:41'),
(12079, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 13:43:07'),
(12080, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732213715290', '2024-11-21 13:43:07'),
(12081, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:43:51'),
(12082, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 13:43:52'),
(12083, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:44:03'),
(12084, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:44:03'),
(12085, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:44:03'),
(12086, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:44:03'),
(12087, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 13:44:25'),
(12088, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732213715291', '2024-11-21 13:44:25'),
(12089, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:44:27'),
(12090, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 13:44:29'),
(12091, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 13:44:37'),
(12092, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=2', '2024-11-21 13:44:43'),
(12093, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=2', '2024-11-21 13:45:09'),
(12094, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=2', '2024-11-21 13:47:24'),
(12095, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 13:47:28'),
(12096, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=1', '2024-11-21 13:47:54'),
(12097, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/generarpdf?idocurrencia=2', '2024-11-21 13:47:58'),
(12098, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 13:48:53'),
(12099, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732214934064', '2024-11-21 13:48:54'),
(12100, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:48:58'),
(12101, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:48:58'),
(12102, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:48:58'),
(12103, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:48:59'),
(12104, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 13:49:03'),
(12105, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732214934065', '2024-11-21 13:49:03'),
(12106, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:49:06'),
(12107, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:49:06'),
(12108, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:49:06'),
(12109, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:49:06'),
(12110, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:49:11'),
(12111, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:49:11'),
(12112, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:49:12'),
(12113, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:49:12'),
(12114, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 13:49:19'),
(12115, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 13:49:19'),
(12116, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/i', '2024-11-21 13:49:22'),
(12117, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 13:49:22'),
(12118, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 13:49:23'),
(12119, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-21 13:49:25'),
(12120, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 13:49:30'),
(12121, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732214970597', '2024-11-21 13:49:30'),
(12122, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:49:33'),
(12123, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:49:33'),
(12124, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:49:33'),
(12125, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:49:33'),
(12126, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 13:49:37'),
(12127, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 13:49:37'),
(12128, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 13:49:40');
INSERT INTO `sis_centinela` (`idvisita`, `vis_cod`, `idwebusuario`, `vis_ip`, `vis_agente`, `vis_method`, `vis_url`, `vis_fechahora`) VALUES
(12129, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 13:49:44'),
(12130, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 13:57:20'),
(12131, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 13:58:58'),
(12132, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 13:58:59'),
(12133, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732215539704', '2024-11-21 13:59:00'),
(12134, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:59:01'),
(12135, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:59:01'),
(12136, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:59:02'),
(12137, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:59:02'),
(12138, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 13:59:05'),
(12139, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732215539705', '2024-11-21 13:59:05'),
(12140, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 13:59:08'),
(12141, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 13:59:08'),
(12142, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 13:59:09'),
(12143, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 13:59:11'),
(12144, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-21 13:59:16'),
(12145, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-21 13:59:39'),
(12146, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 13:59:46'),
(12147, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 13:59:47'),
(12148, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732215587007', '2024-11-21 13:59:47'),
(12149, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 13:59:48'),
(12150, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 13:59:48'),
(12151, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 13:59:48'),
(12152, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 13:59:48'),
(12153, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/save', '2024-11-21 13:59:51'),
(12154, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732215587008', '2024-11-21 13:59:51'),
(12155, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 13:59:53'),
(12156, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 13:59:54'),
(12157, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 13:59:54'),
(12158, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 13:59:55'),
(12159, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-21 13:59:59'),
(12160, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-21 14:00:18'),
(12161, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-21 14:01:20'),
(12162, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-21 14:02:02'),
(12163, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-21 14:02:39'),
(12164, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-21 14:03:01'),
(12165, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-21 14:03:18'),
(12166, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/r', '2024-11-21 14:03:18'),
(12167, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/lm', '2024-11-21 14:03:18'),
(12168, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 14:03:21'),
(12169, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 14:03:23'),
(12170, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732215803072', '2024-11-21 14:03:23'),
(12171, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ocurrencias/search', '2024-11-21 14:03:25'),
(12172, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos', '2024-11-21 14:03:25'),
(12173, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/ingresos/1', '2024-11-21 14:03:25'),
(12174, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/materiales/1', '2024-11-21 14:03:25'),
(12175, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:03:34'),
(12176, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:03:35'),
(12177, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 14:06:54'),
(12178, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732216015510', '2024-11-21 14:06:55'),
(12179, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 14:08:38'),
(12180, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732216118923', '2024-11-21 14:08:39'),
(12181, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin', '2024-11-21 14:09:20'),
(12182, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:15:45'),
(12183, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:15:46'),
(12184, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:16:18'),
(12185, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:16:18'),
(12186, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:16:21'),
(12187, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:16:21'),
(12188, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:16:24'),
(12189, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:16:24'),
(12190, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:16:26'),
(12191, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:16:27'),
(12192, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:17:00'),
(12193, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:17:01'),
(12194, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:17:01'),
(12195, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:17:02'),
(12196, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:17:43'),
(12197, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:17:43'),
(12198, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-21 14:17:54'),
(12199, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/save', '2024-11-21 14:18:16'),
(12200, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:18:16'),
(12201, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-21 14:18:16'),
(12202, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-21 14:18:21'),
(12203, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/save', '2024-11-21 14:18:31'),
(12204, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio/save', '2024-11-21 14:18:37'),
(12205, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:18:37'),
(12206, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio/docentes', '2024-11-21 14:18:37'),
(12207, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:18:56'),
(12208, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:18:57'),
(12209, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:19:04'),
(12210, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:19:04'),
(12211, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:19:23'),
(12212, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:19:23'),
(12213, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:19:24'),
(12214, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:19:24'),
(12215, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:19:39'),
(12216, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:19:39'),
(12217, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 14:19:47'),
(12218, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1', 'GET', '/admin/laboratorio', '2024-11-21 14:19:52'),
(12219, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 14:19:52'),
(12220, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1', 'POST', '/admin/laboratorio', '2024-11-21 14:19:52'),
(12221, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:21:06'),
(12222, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 14:21:07'),
(12223, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:21:07'),
(12224, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:21:57'),
(12225, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 14:21:58'),
(12226, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:21:58'),
(12227, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:23:35'),
(12228, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 14:23:36'),
(12229, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:23:36'),
(12230, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:23:50'),
(12231, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 14:23:50'),
(12232, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:23:51'),
(12233, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:24:39'),
(12234, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 14:24:39'),
(12235, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:24:40'),
(12236, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:25:33'),
(12237, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 14:25:34'),
(12238, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:25:34'),
(12239, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:26:12'),
(12240, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 14:26:13'),
(12241, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:26:13'),
(12242, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:28:34'),
(12243, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 14:28:35'),
(12244, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:28:36'),
(12245, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 14:28:40'),
(12246, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/js/app/plugins/popper.min.js.map', '2024-11-21 14:28:41'),
(12247, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732217321377', '2024-11-21 14:28:42'),
(12248, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:28:57'),
(12249, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:28:57'),
(12250, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:29:20'),
(12251, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:29:20'),
(12252, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:29:21'),
(12253, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:29:21'),
(12254, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:29:34'),
(12255, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:29:34'),
(12256, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/database', '2024-11-21 14:41:45'),
(12257, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database', '2024-11-21 14:41:46'),
(12258, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database/save', '2024-11-21 14:42:31'),
(12259, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database', '2024-11-21 14:42:31'),
(12260, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database/execute', '2024-11-21 14:48:08'),
(12261, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:48:42'),
(12262, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:48:44'),
(12263, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:48:44'),
(12264, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:48:44'),
(12265, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/database', '2024-11-21 14:48:46'),
(12266, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database', '2024-11-21 14:48:47'),
(12267, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database/execute', '2024-11-21 14:48:51'),
(12268, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database/search', '2024-11-21 14:49:11'),
(12269, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database/search', '2024-11-21 14:50:23'),
(12270, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database/search', '2024-11-21 14:50:28'),
(12271, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database/update', '2024-11-21 14:53:32'),
(12272, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database', '2024-11-21 14:53:32'),
(12273, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database/execute', '2024-11-21 14:53:34'),
(12274, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:53:46'),
(12275, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:53:46'),
(12276, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/laboratorio', '2024-11-21 14:53:47'),
(12277, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/laboratorio', '2024-11-21 14:53:47'),
(12278, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias', '2024-11-21 14:53:48'),
(12279, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ocurrencias/list?_=1732218828666', '2024-11-21 14:53:48'),
(12280, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-21 14:53:50'),
(12281, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 14:53:50'),
(12282, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-21 14:53:52'),
(12283, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-21 14:53:52'),
(12284, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-21 14:53:54'),
(12285, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 14:53:54'),
(12286, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-21 14:54:03'),
(12287, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-21 14:54:04'),
(12288, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/database', '2024-11-21 14:54:07'),
(12289, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database', '2024-11-21 14:54:07'),
(12290, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database/search', '2024-11-21 14:54:09'),
(12291, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database/update', '2024-11-21 14:54:32'),
(12292, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database', '2024-11-21 14:54:32'),
(12293, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/database/execute', '2024-11-21 14:54:34'),
(12294, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/ingresos', '2024-11-21 14:54:36'),
(12295, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/ingresos', '2024-11-21 14:54:37'),
(12296, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/admin/inventario', '2024-11-21 14:54:41'),
(12297, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'POST', '/admin/inventario', '2024-11-21 14:54:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sis_imagenes`
--

CREATE TABLE `sis_imagenes` (
  `idimagen` int NOT NULL,
  `idgalery` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT '0',
  `img_externo` int NOT NULL DEFAULT '0',
  `img_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `img_propietario` int NOT NULL DEFAULT '0',
  `img_type` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `img_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sis_menus`
--

CREATE TABLE `sis_menus` (
  `idmenu` int NOT NULL,
  `men_nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `men_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `men_externo` tinyint(1) NOT NULL DEFAULT '0',
  `men_controlador` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `men_icono` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `men_url_si` tinyint(1) NOT NULL DEFAULT '0',
  `men_orden` int NOT NULL,
  `men_visible` tinyint(1) NOT NULL,
  `men_fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `sis_menus`
--

INSERT INTO `sis_menus` (`idmenu`, `men_nombre`, `men_url`, `men_externo`, `men_controlador`, `men_icono`, `men_url_si`, `men_orden`, `men_visible`, `men_fecha`) VALUES
(1, 'Maestras', '#', 0, NULL, 'bx bx-lock-open-alt', 0, 10, 1, '2023-03-06 12:39:09'),
(2, 'Modulo Usuarios', '#', 0, NULL, 'bx bx-circle', 0, 4, 1, '2023-03-07 00:41:34'),
(10, 'Modulo Inventario', '#', 0, NULL, 'bx bx-package', 0, 2, 1, '2024-10-08 01:35:58'),
(11, 'Modulo Laboratorio', '#', 0, NULL, 'fa-solid fa-flask', 0, 1, 1, '2024-10-08 01:36:07'),
(12, 'Modulo Ocurrencias', '#', 0, NULL, 'bx bx-circle', 0, 3, 1, '2024-10-08 01:36:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sis_permisos`
--

CREATE TABLE `sis_permisos` (
  `idpermisos` int NOT NULL,
  `idrol` int NOT NULL,
  `idsubmenu` int NOT NULL,
  `perm_r` int DEFAULT NULL,
  `perm_w` int DEFAULT NULL,
  `perm_u` int DEFAULT NULL,
  `perm_d` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `sis_permisos`
--

INSERT INTO `sis_permisos` (`idpermisos`, `idrol`, `idsubmenu`, `perm_r`, `perm_w`, `perm_u`, `perm_d`) VALUES
(3, 1, 2, 1, 1, 1, 1),
(4, 1, 3, 1, 1, 1, 1),
(5, 1, 1, 1, 1, 1, 1),
(6, 1, 13, 1, 1, 1, 1),
(7, 1, 4, 1, 1, 1, 1),
(8, 1, 7, 1, 1, 1, 1),
(9, 1, 8, 1, 1, 1, 1),
(10, 1, 20, 1, 1, 1, 1),
(11, 1, 21, 1, 1, 1, 1),
(12, 1, 22, 1, 1, 1, 1),
(13, 1, 23, 1, 1, 1, 0),
(14, 1, 24, 1, 1, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sis_personal`
--

CREATE TABLE `sis_personal` (
  `idpersona` int NOT NULL,
  `per_dni` int NOT NULL,
  `per_nombre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `per_celular` int NOT NULL,
  `per_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `per_direcc` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `per_estado` tinyint(1) NOT NULL DEFAULT '1',
  `per_fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `sis_personal`
--

INSERT INTO `sis_personal` (`idpersona`, `per_dni`, `per_nombre`, `per_celular`, `per_email`, `per_direcc`, `per_estado`, `per_fecha`) VALUES
(1, 76144152, 'Administrador', 987654321, 'admin@admin.com', 'Asd', 1, '2022-07-22 01:09:20'),
(6, 123456, 'Jon Doe', 123123, 'doc@doc.com', 'Por Donde', 1, '2024-06-25 14:48:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sis_rol`
--

CREATE TABLE `sis_rol` (
  `idrol` int NOT NULL,
  `rol_cod` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `rol_nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `rol_descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `rol_estado` tinyint(1) NOT NULL,
  `rol_fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `sis_rol`
--

INSERT INTO `sis_rol` (`idrol`, `rol_cod`, `rol_nombre`, `rol_descripcion`, `rol_estado`, `rol_fecha`) VALUES
(1, '/', 'root', 'desarrollador del sistema', 1, '2022-07-22 01:09:56'),
(2, 'admin', 'admin', 'administrador del sistema, con menos privilegios que el root', 1, '2022-07-28 00:20:50'),
(4, 'web', 'Usuario Web', 'usuario web, con privilegios READ y VIEW', 1, '2023-03-08 13:22:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sis_rutas`
--

CREATE TABLE `sis_rutas` (
  `idruta` int NOT NULL,
  `rt_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `rt_es_grupo` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sis_server_email`
--

CREATE TABLE `sis_server_email` (
  `idserveremail` int NOT NULL,
  `em_host` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `em_usermail` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `em_pass` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `em_port` int NOT NULL,
  `em_estado` tinyint(1) NOT NULL,
  `em_default` tinyint(1) NOT NULL,
  `em_fupdate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `em_fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `sis_server_email`
--

INSERT INTO `sis_server_email` (`idserveremail`, `em_host`, `em_usermail`, `em_pass`, `em_port`, `em_estado`, `em_default`, `em_fupdate`, `em_fecha`) VALUES
(1, 'smtp.gmail.com', '2018100486facke@gmail.com', 'bteaasmagqeaiyax', 465, 1, 1, '2024-06-07 16:05:00', '2024-06-07 16:05:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sis_submenus`
--

CREATE TABLE `sis_submenus` (
  `idsubmenu` int NOT NULL,
  `idmenu` int NOT NULL,
  `sub_nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `sub_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `sub_externo` tinyint(1) NOT NULL DEFAULT '0',
  `sub_controlador` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `sub_metodo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'index',
  `sub_icono` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `sub_orden` int NOT NULL DEFAULT '1',
  `sub_visible` tinyint(1) NOT NULL DEFAULT '1',
  `sub_fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `sis_submenus`
--

INSERT INTO `sis_submenus` (`idsubmenu`, `idmenu`, `sub_nombre`, `sub_url`, `sub_externo`, `sub_controlador`, `sub_metodo`, `sub_icono`, `sub_orden`, `sub_visible`, `sub_fecha`) VALUES
(1, 1, 'Menús', '/admin/menus', 0, 'MenusController', 'index', 'bx-menu', 1, 1, '2023-03-06 12:41:05'),
(2, 1, 'Submenús', '/admin/submenus', 0, 'SubmenusController', 'index', 'bx-menu-alt-right', 2, 1, '2023-03-06 12:41:44'),
(3, 1, 'Permisos', '/admin/permisos', 0, 'PermisosController', 'index', 'bx-key', 4, 1, '2023-03-06 12:42:10'),
(4, 2, 'Usuarios', '/admin/usuarios', 0, 'UsuariosController', 'index', 'bx-user', 2, 1, '2023-03-07 00:43:11'),
(7, 2, 'Personal', '/admin/personas', 0, 'PersonasController', 'index', 'bxs-user', 1, 1, '2023-03-07 19:44:33'),
(8, 2, 'Roles', '/admin/roles', 0, 'RolesController', 'index', 'bx-ruler', 3, 1, '2023-03-07 19:44:54'),
(13, 1, 'Crud', '/admin/crud', 0, 'CrudController', 'index', 'bx-edit', 6, 1, '2024-06-04 18:46:27'),
(20, 1, 'database', '/admin/database', 0, 'DataBaseController', 'index', 'bx-data text-info', 5, 1, '2024-10-08 01:42:39'),
(21, 10, 'Materiales', '/admin/inventario', 0, 'MaterialesController', 'index', 'bx-circle', 2, 1, '2024-10-10 23:14:22'),
(22, 10, 'Ingresos', '/admin/ingresos', 0, 'IngresosController', 'index', 'bx-circle', 1, 1, '2024-10-13 12:27:57'),
(23, 11, 'Ingresos laboratorio', '/admin/laboratorio', 0, 'LaboratorioController', 'index', 'bx-circle', 1, 1, '2024-10-17 12:31:40'),
(24, 11, 'Ocurrencias', '/admin/ocurrencias', 0, 'OcurrenciasController', 'index', 'bx-circle', 2, 1, '2024-10-17 12:36:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sis_tareas_ejecutables`
--

CREATE TABLE `sis_tareas_ejecutables` (
  `idtarea` int NOT NULL,
  `ta_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'undefined',
  `ta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ta_execute` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ta_fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `sis_tareas_ejecutables`
--

INSERT INTO `sis_tareas_ejecutables` (`idtarea`, `ta_name`, `ta_description`, `ta_execute`, `ta_fecha`) VALUES
(1, 'Eliminar App', 'Vaciar todo lo relacionado con el inventario y laboratorios', 'SET FOREIGN_KEY_CHECKS=0;\r\ntruncate table lab_balance_inventarios;\r\ntruncate table lab_detalle_inventarios;\r\ntruncate table lab_detalle_ocurrencias;\r\ntruncate table lab_detalle_prestamos;\r\ntruncate table lab_ingresos_laboratorios;\r\ntruncate table lab_movimientos;\r\ntruncate table lab_ocurrencias;\r\ntruncate table lab_prestamos;\r\ntruncate table lab_prestamos;\r\ntruncate table lab_inventarios;\r\nSET FOREIGN_KEY_CHECKS=1;', '2024-11-21 14:42:31'),
(5, 'Delete Centinela Y Visitas', '', 'DELETE FROM `sis_centinela`;\nDELETE FROM `web_visitas`;', '2023-03-24 19:30:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sis_usuarios`
--

CREATE TABLE `sis_usuarios` (
  `idusuario` int NOT NULL,
  `idrol` int NOT NULL,
  `idpersona` int NOT NULL,
  `usu_usuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `usu_pass` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `usu_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `usu_activo` tinyint(1) NOT NULL,
  `usu_estado` tinyint(1) NOT NULL,
  `usu_primera` tinyint(1) NOT NULL,
  `usu_twoauth` tinyint(1) NOT NULL,
  `usu_code_twoauth` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `usu_fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `sis_usuarios`
--

INSERT INTO `sis_usuarios` (`idusuario`, `idrol`, `idpersona`, `usu_usuario`, `usu_pass`, `usu_token`, `usu_activo`, `usu_estado`, `usu_primera`, `usu_twoauth`, `usu_code_twoauth`, `usu_fecha`) VALUES
(1, 1, 1, 'admin', '$2y$10$Z3rOi0RlLXg2mRRduTAmm.u6sy6CIA9iq2yuJxE1IfcKzt6pGGpW6', NULL, 1, 1, 0, 0, '', '2022-07-22 01:10:31'),
(7, 6, 6, 'doc', '$2y$10$.sOh1gkFWzIV1LQuowONL.jDk4Xb9NzndBinIgD0wzBGqAK7hkWhS', NULL, 1, 1, 0, 0, '0', '2024-06-25 14:50:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `web_carritos`
--

CREATE TABLE `web_carritos` (
  `idcarrito` int NOT NULL,
  `vis_cod` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `idwebusuario` int DEFAULT NULL,
  `idarticulo` int NOT NULL,
  `idpedido` int DEFAULT NULL,
  `car_cantidad` double NOT NULL DEFAULT '1',
  `car_precio` double DEFAULT NULL,
  `car_subtotal` double DEFAULT NULL,
  `car_anulado` tinyint(1) NOT NULL DEFAULT '0',
  `car_fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `web_menus`
--

CREATE TABLE `web_menus` (
  `idmenu` int NOT NULL,
  `men_nombre` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `men_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT '#',
  `men_icono` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `men_url_si` tinyint(1) NOT NULL DEFAULT '0',
  `men_orden` int NOT NULL DEFAULT '1',
  `men_visible` tinyint(1) NOT NULL DEFAULT '1',
  `men_status` tinyint(1) NOT NULL DEFAULT '1',
  `men_fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `web_menus`
--

INSERT INTO `web_menus` (`idmenu`, `men_nombre`, `men_url`, `men_icono`, `men_url_si`, `men_orden`, `men_visible`, `men_status`, `men_fecha`) VALUES
(1, 'Inicio', '/', NULL, 0, 1, 1, 1, '2023-03-03 16:50:37'),
(2, 'usuario', '', NULL, 0, 1, 1, 1, '2023-03-03 16:52:22'),
(3, 'Salir', '/logout', NULL, 0, 1, 1, 1, '2023-03-03 17:48:03'),
(4, 'Mi Cuenta', '/me', NULL, 0, 1, 1, 1, '2023-03-17 00:26:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `web_submenus`
--

CREATE TABLE `web_submenus` (
  `idsubmenu` int NOT NULL,
  `idmenu` int NOT NULL,
  `sub_nombre` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `sub_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT '#',
  `sub_controlador` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `sub_icono` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `sub_orden` int NOT NULL DEFAULT '1',
  `sub_visible` tinyint(1) NOT NULL DEFAULT '1',
  `sub_status` tinyint(1) NOT NULL DEFAULT '1',
  `sub_fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `web_submenus`
--

INSERT INTO `web_submenus` (`idsubmenu`, `idmenu`, `sub_nombre`, `sub_url`, `sub_controlador`, `sub_icono`, `sub_orden`, `sub_visible`, `sub_status`, `sub_fecha`) VALUES
(1, 2, 'Registrarse', '/register', NULL, NULL, 1, 1, 1, '2023-03-03 17:46:35'),
(2, 2, 'Iniciar Sesion', '/login', NULL, NULL, 1, 1, 1, '2023-03-03 17:47:02'),
(3, 2, 'Recuperar Contraseña', '/forgot-password', NULL, NULL, 1, 1, 1, '2023-03-03 17:47:19'),
(4, 2, 'Intranet', '/admin/login', NULL, NULL, 1, 1, 1, '2023-03-05 17:00:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `web_visitas`
--

CREATE TABLE `web_visitas` (
  `idvisita` int NOT NULL,
  `vis_cod` int NOT NULL,
  `idwebusuario` int DEFAULT '0',
  `vis_ip` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `vis_agente` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `vis_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `vis_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `vis_fechahora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `web_visitas`
--

INSERT INTO `web_visitas` (`idvisita`, `vis_cod`, `idwebusuario`, `vis_ip`, `vis_agente`, `vis_method`, `vis_url`, `vis_fechahora`) VALUES
(50, 6901, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/', '2024-11-20 23:02:19'),
(51, 9187, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'GET', '/', '2024-11-21 11:36:02');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `crud_modulo`
--
ALTER TABLE `crud_modulo`
  ADD PRIMARY KEY (`idmod`);

--
-- Indices de la tabla `lab_balance_inventarios`
--
ALTER TABLE `lab_balance_inventarios`
  ADD PRIMARY KEY (`idbalance`),
  ADD KEY `lab_materiales_lab_balance_inventarios_fk` (`idmaterial`),
  ADD KEY `lab_insumos_lab_balance_inventarios_fk` (`idinsumo`),
  ADD KEY `lab_productos_lab_balance_inventarios_fk` (`idproducto`);

--
-- Indices de la tabla `lab_condiciones`
--
ALTER TABLE `lab_condiciones`
  ADD PRIMARY KEY (`idcondicion`);

--
-- Indices de la tabla `lab_detalle_inventarios`
--
ALTER TABLE `lab_detalle_inventarios`
  ADD PRIMARY KEY (`idinventariodetalle`),
  ADD KEY `lab_inventarios_lab_detalle_inventarios_fk` (`idinventario`),
  ADD KEY `lab_unidades_medidas_lab_inventarios_fk` (`idmedida`),
  ADD KEY `lab_condiciones_lab_existencias_fk` (`idcondicion`),
  ADD KEY `lab_materiales_lab_detalle_inventarios_fk` (`idmaterial`),
  ADD KEY `lab_insumos_lab_detalle_inventarios_fk` (`idinsumo`),
  ADD KEY `lab_productos_lab_detalle_inventarios_fk` (`idproducto`);

--
-- Indices de la tabla `lab_detalle_ocurrencias`
--
ALTER TABLE `lab_detalle_ocurrencias`
  ADD PRIMARY KEY (`id_detalle_ocurrencia`),
  ADD KEY `lab_ocurrencias_lab_detalle_ocurrencias_fk` (`idocurrencia`),
  ADD KEY `lab_detalle_prestamos_lab_detalle_ocurrencias_fk` (`iddetalle`);

--
-- Indices de la tabla `lab_detalle_prestamos`
--
ALTER TABLE `lab_detalle_prestamos`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `lab_prestamos_lab_detalle_prestamos_fk` (`idprestamo`),
  ADD KEY `lab_balance_inventarios_lab_detalle_prestamos_fk` (`idbalance`);

--
-- Indices de la tabla `lab_docentes`
--
ALTER TABLE `lab_docentes`
  ADD PRIMARY KEY (`iddocente`);

--
-- Indices de la tabla `lab_estado`
--
ALTER TABLE `lab_estado`
  ADD PRIMARY KEY (`idestado`);

--
-- Indices de la tabla `lab_ingresos_laboratorios`
--
ALTER TABLE `lab_ingresos_laboratorios`
  ADD PRIMARY KEY (`idingreso`),
  ADD KEY `lab_docentes_lab_ingresos_laboratorios_fk` (`iddocente`);

--
-- Indices de la tabla `lab_insumos`
--
ALTER TABLE `lab_insumos`
  ADD PRIMARY KEY (`idinsumo`);

--
-- Indices de la tabla `lab_inventarios`
--
ALTER TABLE `lab_inventarios`
  ADD PRIMARY KEY (`idinventario`);

--
-- Indices de la tabla `lab_materiales`
--
ALTER TABLE `lab_materiales`
  ADD PRIMARY KEY (`idmaterial`);

--
-- Indices de la tabla `lab_movimientos`
--
ALTER TABLE `lab_movimientos`
  ADD PRIMARY KEY (`idmovimiento`),
  ADD KEY `sis_usuarios_lab_movimientos_fk` (`idusuario`);

--
-- Indices de la tabla `lab_ocurrencias`
--
ALTER TABLE `lab_ocurrencias`
  ADD PRIMARY KEY (`idocurrencia`),
  ADD KEY `lab_prestamos_lab_ocurrencias_fk` (`idprestamo`);

--
-- Indices de la tabla `lab_prestamos`
--
ALTER TABLE `lab_prestamos`
  ADD PRIMARY KEY (`idprestamo`),
  ADD KEY `lab_ingresos_laboratorios_lab_prestamos_fk` (`idingreso`);

--
-- Indices de la tabla `lab_productos`
--
ALTER TABLE `lab_productos`
  ADD PRIMARY KEY (`idproducto`);

--
-- Indices de la tabla `lab_severidad`
--
ALTER TABLE `lab_severidad`
  ADD PRIMARY KEY (`idseveridad`);

--
-- Indices de la tabla `lab_unidades_medidas`
--
ALTER TABLE `lab_unidades_medidas`
  ADD PRIMARY KEY (`idmedida`);

--
-- Indices de la tabla `sis_centinela`
--
ALTER TABLE `sis_centinela`
  ADD PRIMARY KEY (`idvisita`);

--
-- Indices de la tabla `sis_imagenes`
--
ALTER TABLE `sis_imagenes`
  ADD PRIMARY KEY (`idimagen`);

--
-- Indices de la tabla `sis_menus`
--
ALTER TABLE `sis_menus`
  ADD PRIMARY KEY (`idmenu`);

--
-- Indices de la tabla `sis_permisos`
--
ALTER TABLE `sis_permisos`
  ADD PRIMARY KEY (`idpermisos`);

--
-- Indices de la tabla `sis_personal`
--
ALTER TABLE `sis_personal`
  ADD PRIMARY KEY (`idpersona`);

--
-- Indices de la tabla `sis_rol`
--
ALTER TABLE `sis_rol`
  ADD PRIMARY KEY (`idrol`);

--
-- Indices de la tabla `sis_rutas`
--
ALTER TABLE `sis_rutas`
  ADD PRIMARY KEY (`idruta`);

--
-- Indices de la tabla `sis_server_email`
--
ALTER TABLE `sis_server_email`
  ADD PRIMARY KEY (`idserveremail`);

--
-- Indices de la tabla `sis_submenus`
--
ALTER TABLE `sis_submenus`
  ADD PRIMARY KEY (`idsubmenu`);

--
-- Indices de la tabla `sis_tareas_ejecutables`
--
ALTER TABLE `sis_tareas_ejecutables`
  ADD PRIMARY KEY (`idtarea`);

--
-- Indices de la tabla `sis_usuarios`
--
ALTER TABLE `sis_usuarios`
  ADD PRIMARY KEY (`idusuario`);

--
-- Indices de la tabla `web_carritos`
--
ALTER TABLE `web_carritos`
  ADD PRIMARY KEY (`idcarrito`);

--
-- Indices de la tabla `web_menus`
--
ALTER TABLE `web_menus`
  ADD PRIMARY KEY (`idmenu`);

--
-- Indices de la tabla `web_submenus`
--
ALTER TABLE `web_submenus`
  ADD PRIMARY KEY (`idsubmenu`);

--
-- Indices de la tabla `web_visitas`
--
ALTER TABLE `web_visitas`
  ADD PRIMARY KEY (`idvisita`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `crud_modulo`
--
ALTER TABLE `crud_modulo`
  MODIFY `idmod` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lab_balance_inventarios`
--
ALTER TABLE `lab_balance_inventarios`
  MODIFY `idbalance` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lab_condiciones`
--
ALTER TABLE `lab_condiciones`
  MODIFY `idcondicion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `lab_detalle_inventarios`
--
ALTER TABLE `lab_detalle_inventarios`
  MODIFY `idinventariodetalle` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lab_detalle_ocurrencias`
--
ALTER TABLE `lab_detalle_ocurrencias`
  MODIFY `id_detalle_ocurrencia` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lab_detalle_prestamos`
--
ALTER TABLE `lab_detalle_prestamos`
  MODIFY `iddetalle` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lab_docentes`
--
ALTER TABLE `lab_docentes`
  MODIFY `iddocente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `lab_estado`
--
ALTER TABLE `lab_estado`
  MODIFY `idestado` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `lab_ingresos_laboratorios`
--
ALTER TABLE `lab_ingresos_laboratorios`
  MODIFY `idingreso` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lab_insumos`
--
ALTER TABLE `lab_insumos`
  MODIFY `idinsumo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `lab_inventarios`
--
ALTER TABLE `lab_inventarios`
  MODIFY `idinventario` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lab_materiales`
--
ALTER TABLE `lab_materiales`
  MODIFY `idmaterial` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `lab_movimientos`
--
ALTER TABLE `lab_movimientos`
  MODIFY `idmovimiento` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lab_ocurrencias`
--
ALTER TABLE `lab_ocurrencias`
  MODIFY `idocurrencia` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lab_prestamos`
--
ALTER TABLE `lab_prestamos`
  MODIFY `idprestamo` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lab_productos`
--
ALTER TABLE `lab_productos`
  MODIFY `idproducto` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lab_severidad`
--
ALTER TABLE `lab_severidad`
  MODIFY `idseveridad` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `lab_unidades_medidas`
--
ALTER TABLE `lab_unidades_medidas`
  MODIFY `idmedida` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `sis_centinela`
--
ALTER TABLE `sis_centinela`
  MODIFY `idvisita` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12298;

--
-- AUTO_INCREMENT de la tabla `sis_imagenes`
--
ALTER TABLE `sis_imagenes`
  MODIFY `idimagen` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sis_menus`
--
ALTER TABLE `sis_menus`
  MODIFY `idmenu` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `sis_permisos`
--
ALTER TABLE `sis_permisos`
  MODIFY `idpermisos` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `sis_personal`
--
ALTER TABLE `sis_personal`
  MODIFY `idpersona` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `sis_rol`
--
ALTER TABLE `sis_rol`
  MODIFY `idrol` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `sis_rutas`
--
ALTER TABLE `sis_rutas`
  MODIFY `idruta` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sis_server_email`
--
ALTER TABLE `sis_server_email`
  MODIFY `idserveremail` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `sis_submenus`
--
ALTER TABLE `sis_submenus`
  MODIFY `idsubmenu` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `sis_tareas_ejecutables`
--
ALTER TABLE `sis_tareas_ejecutables`
  MODIFY `idtarea` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `sis_usuarios`
--
ALTER TABLE `sis_usuarios`
  MODIFY `idusuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `web_carritos`
--
ALTER TABLE `web_carritos`
  MODIFY `idcarrito` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `web_menus`
--
ALTER TABLE `web_menus`
  MODIFY `idmenu` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `web_submenus`
--
ALTER TABLE `web_submenus`
  MODIFY `idsubmenu` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `web_visitas`
--
ALTER TABLE `web_visitas`
  MODIFY `idvisita` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `lab_balance_inventarios`
--
ALTER TABLE `lab_balance_inventarios`
  ADD CONSTRAINT `lab_insumos_lab_balance_inventarios_fk` FOREIGN KEY (`idinsumo`) REFERENCES `lab_insumos` (`idinsumo`),
  ADD CONSTRAINT `lab_materiales_lab_balance_inventarios_fk` FOREIGN KEY (`idmaterial`) REFERENCES `lab_materiales` (`idmaterial`),
  ADD CONSTRAINT `lab_productos_lab_balance_inventarios_fk` FOREIGN KEY (`idproducto`) REFERENCES `lab_productos` (`idproducto`);

--
-- Filtros para la tabla `lab_detalle_inventarios`
--
ALTER TABLE `lab_detalle_inventarios`
  ADD CONSTRAINT `lab_condiciones_lab_existencias_fk` FOREIGN KEY (`idcondicion`) REFERENCES `lab_condiciones` (`idcondicion`),
  ADD CONSTRAINT `lab_insumos_lab_detalle_inventarios_fk` FOREIGN KEY (`idinsumo`) REFERENCES `lab_insumos` (`idinsumo`),
  ADD CONSTRAINT `lab_inventarios_lab_detalle_inventarios_fk` FOREIGN KEY (`idinventario`) REFERENCES `lab_inventarios` (`idinventario`),
  ADD CONSTRAINT `lab_materiales_lab_detalle_inventarios_fk` FOREIGN KEY (`idmaterial`) REFERENCES `lab_materiales` (`idmaterial`),
  ADD CONSTRAINT `lab_productos_lab_detalle_inventarios_fk` FOREIGN KEY (`idproducto`) REFERENCES `lab_productos` (`idproducto`),
  ADD CONSTRAINT `lab_unidades_medidas_lab_inventarios_fk` FOREIGN KEY (`idmedida`) REFERENCES `lab_unidades_medidas` (`idmedida`);

--
-- Filtros para la tabla `lab_detalle_ocurrencias`
--
ALTER TABLE `lab_detalle_ocurrencias`
  ADD CONSTRAINT `lab_detalle_prestamos_lab_detalle_ocurrencias_fk` FOREIGN KEY (`iddetalle`) REFERENCES `lab_detalle_prestamos` (`iddetalle`),
  ADD CONSTRAINT `lab_ocurrencias_lab_detalle_ocurrencias_fk` FOREIGN KEY (`idocurrencia`) REFERENCES `lab_ocurrencias` (`idocurrencia`);

--
-- Filtros para la tabla `lab_detalle_prestamos`
--
ALTER TABLE `lab_detalle_prestamos`
  ADD CONSTRAINT `lab_balance_inventarios_lab_detalle_prestamos_fk` FOREIGN KEY (`idbalance`) REFERENCES `lab_balance_inventarios` (`idbalance`),
  ADD CONSTRAINT `lab_prestamos_lab_detalle_prestamos_fk` FOREIGN KEY (`idprestamo`) REFERENCES `lab_prestamos` (`idprestamo`);

--
-- Filtros para la tabla `lab_ingresos_laboratorios`
--
ALTER TABLE `lab_ingresos_laboratorios`
  ADD CONSTRAINT `lab_docentes_lab_ingresos_laboratorios_fk` FOREIGN KEY (`iddocente`) REFERENCES `lab_docentes` (`iddocente`);

--
-- Filtros para la tabla `lab_movimientos`
--
ALTER TABLE `lab_movimientos`
  ADD CONSTRAINT `sis_usuarios_lab_movimientos_fk` FOREIGN KEY (`idusuario`) REFERENCES `sis_usuarios` (`idusuario`);

--
-- Filtros para la tabla `lab_ocurrencias`
--
ALTER TABLE `lab_ocurrencias`
  ADD CONSTRAINT `lab_prestamos_lab_ocurrencias_fk` FOREIGN KEY (`idprestamo`) REFERENCES `lab_prestamos` (`idprestamo`);

--
-- Filtros para la tabla `lab_prestamos`
--
ALTER TABLE `lab_prestamos`
  ADD CONSTRAINT `lab_ingresos_laboratorios_lab_prestamos_fk` FOREIGN KEY (`idingreso`) REFERENCES `lab_ingresos_laboratorios` (`idingreso`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
