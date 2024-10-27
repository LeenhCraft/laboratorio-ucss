-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 27-10-2024 a las 00:55:50
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

--
-- Volcado de datos para la tabla `lab_balance_inventarios`
--

INSERT INTO `lab_balance_inventarios` (`idbalance`, `idproducto`, `idinsumo`, `idmaterial`, `stock_cajas`, `stock_unidades_sueltas`, `stock_total`, `factor_caja`, `fecha_ultima_actualizacion`, `fecha_registro`) VALUES
(1, NULL, 1, NULL, 0, 1, 1, 0, '2024-10-15 15:38:43', '2024-10-15 15:38:43'),
(2, NULL, NULL, 1, 0, 1, 1, 0, '2024-10-15 15:39:19', '2024-10-15 15:39:19'),
(3, NULL, 2, NULL, 0, 1, 1, 0, '2024-10-15 15:39:57', '2024-10-15 15:39:57'),
(4, NULL, 3, NULL, 0, 6, 6, 0, '2024-10-15 15:40:26', '2024-10-15 15:40:26'),
(5, NULL, 4, NULL, 0, 1, 1, 0, '2024-10-15 15:41:12', '2024-10-15 15:41:12'),
(6, NULL, 5, NULL, 0, 50, 50, 0, '2024-10-15 15:41:35', '2024-10-15 15:41:35'),
(7, NULL, 6, NULL, 0, 100, 100, 0, '2024-10-15 15:42:06', '2024-10-15 15:42:06'),
(8, NULL, 7, NULL, 0, 100, 100, 0, '2024-10-15 15:42:52', '2024-10-15 15:42:52'),
(9, NULL, 8, NULL, 0, 25, 25, 0, '2024-10-15 15:43:17', '2024-10-15 15:43:17'),
(10, NULL, NULL, 2, 0, 50, 50, 0, '2024-10-15 15:43:35', '2024-10-15 15:43:35'),
(11, NULL, NULL, 3, 0, 1, 1, 0, '2024-10-15 16:26:22', '2024-10-15 16:26:22'),
(12, NULL, NULL, 5, 0, 1, 1, 0, '2024-10-15 17:42:06', '2024-10-15 17:42:06'),
(13, NULL, NULL, 4, 0, 1, 1, 0, '2024-10-15 17:42:20', '2024-10-15 17:42:20'),
(14, NULL, NULL, 6, 0, 1, 1, 0, '2024-10-15 17:42:28', '2024-10-15 17:42:28'),
(15, NULL, NULL, 7, 0, 1, 1, 0, '2024-10-15 17:42:35', '2024-10-15 17:42:35'),
(16, NULL, NULL, 8, 0, 10, 10, 0, '2024-10-26 19:50:47', '2024-10-26 19:49:53');

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

--
-- Volcado de datos para la tabla `lab_detalle_inventarios`
--

INSERT INTO `lab_detalle_inventarios` (`idinventariodetalle`, `idinventario`, `idproducto`, `idinsumo`, `idmaterial`, `idcondicion`, `cantidad`, `idmedida`, `factor`, `fecha_vencimiento`, `observaciones`, `fecha_registro`) VALUES
(12, 2, NULL, 1, NULL, 2, 1, 2, 1.00, NULL, NULL, '2024-10-15 15:38:43'),
(13, 3, NULL, NULL, 1, 2, 1, 2, 1.00, NULL, NULL, '2024-10-15 15:39:19'),
(14, 4, NULL, 2, NULL, 2, 1, 2, 1.00, NULL, NULL, '2024-10-15 15:39:57'),
(15, 5, NULL, 3, NULL, 2, 6, 2, 1.00, NULL, NULL, '2024-10-15 15:40:26'),
(16, 6, NULL, 4, NULL, 2, 1, 2, 1.00, NULL, NULL, '2024-10-15 15:41:12'),
(17, 7, NULL, 5, NULL, 2, 50, 2, 1.00, NULL, NULL, '2024-10-15 15:41:35'),
(18, 8, NULL, 6, NULL, 2, 100, 2, 1.00, NULL, NULL, '2024-10-15 15:42:06'),
(19, 9, NULL, 7, NULL, 2, 100, 2, 1.00, NULL, NULL, '2024-10-15 15:42:52'),
(20, 1, NULL, 8, NULL, 2, 25, 2, 1.00, NULL, NULL, '2024-10-15 15:43:17'),
(21, 11, NULL, NULL, 2, 2, 50, 2, 1.00, NULL, NULL, '2024-10-15 15:43:35'),
(22, 11, NULL, NULL, 3, 2, 1, 2, 1.00, NULL, NULL, '2024-10-15 16:26:22'),
(23, 12, NULL, NULL, 5, 2, 1, 2, 1.00, NULL, NULL, '2024-10-15 17:42:06'),
(24, 12, NULL, NULL, 4, 2, 1, 2, 1.00, NULL, NULL, '2024-10-15 17:42:20'),
(25, 12, NULL, NULL, 6, 2, 1, 2, 1.00, NULL, NULL, '2024-10-15 17:42:28'),
(26, 12, NULL, NULL, 7, 2, 1, 2, 1.00, NULL, NULL, '2024-10-15 17:42:35'),
(28, 13, NULL, NULL, 8, 2, 10, 2, 1.00, NULL, NULL, '2024-10-26 19:50:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lab_detalle_prestamos`
--

CREATE TABLE `lab_detalle_prestamos` (
  `iddetalle` int NOT NULL,
  `idprestamo` int NOT NULL,
  `idinventariodetalle` int NOT NULL,
  `cantidad` int NOT NULL DEFAULT '1',
  `estado` varchar(45) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `lab_detalle_prestamos`
--

INSERT INTO `lab_detalle_prestamos` (`iddetalle`, `idprestamo`, `idinventariodetalle`, `cantidad`, `estado`, `fecha_registro`) VALUES
(1, 1, 16, 3, NULL, '2024-10-18 18:21:18'),
(2, 1, 15, 1, NULL, '2024-10-18 18:42:41'),
(3, 1, 21, 2, NULL, '2024-10-18 18:43:24'),
(4, 2, 26, 1, NULL, '2024-10-18 19:19:00'),
(5, 3, 12, 1, NULL, '2024-10-26 19:38:17'),
(6, 3, 16, 1, NULL, '2024-10-26 19:38:19'),
(7, 3, 17, 1, NULL, '2024-10-26 19:38:22'),
(8, 3, 19, 1, NULL, '2024-10-26 19:38:24'),
(9, 3, 21, 1, NULL, '2024-10-26 19:38:26'),
(10, 3, 23, 1, NULL, '2024-10-26 19:38:28'),
(11, 3, 26, 1, NULL, '2024-10-26 19:38:30'),
(12, 3, 13, 1, NULL, '2024-10-26 19:38:43'),
(13, 3, 14, 1, NULL, '2024-10-26 19:45:04'),
(14, 3, 15, 1, NULL, '2024-10-26 19:45:07'),
(15, 3, 18, 1, NULL, '2024-10-26 19:45:15'),
(16, 4, 28, 1, NULL, '2024-10-26 19:52:10'),
(17, 4, 21, 1, NULL, '2024-10-26 19:52:13');

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
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `lab_ingresos_laboratorios`
--

INSERT INTO `lab_ingresos_laboratorios` (`idingreso`, `iddocente`, `titulo_practica`, `nro_practicas`, `carrera`, `asignatura`, `turno`, `ciclo`, `fecha`, `hora_inicio`, `hora_fin`, `nro_estudiantes`, `observaciones`, `fecha_registro`) VALUES
(1, 1, 'practica 1', 0, 'sistemas', 'lenguaje de programación I', 'mañana', '0', '2024-10-17', '08:00:00', '08:45:00', 0, '', '2024-10-17 12:47:05'),
(2, 2, 'demo 1', 0, 'enfermeria', 'matar gente', 'mañana', '0', '2024-10-15', '10:00:00', '12:00:00', 0, '', '2024-10-17 12:47:49'),
(3, 3, 'reserva', 0, 'ingeniería de sistemas', 'toma de muestras', 'noche', '0', '2024-10-17', '16:00:00', '15:30:00', 0, '', '2024-10-17 12:48:51'),
(4, 4, 'Titulo', 0, 'Carrera', 'Asignatura', 'mañana', '5', '2024-10-18', '07:00:00', '07:45:00', 0, '', '2024-10-17 16:44:00'),
(5, 1, 'Asd', 0, 'Asd', 'Asd', 'asd', '0', '2024-10-09', '16:45:00', '16:45:00', 0, '', '2024-10-17 16:45:25'),
(6, 1, 'Asd', 0, 'Asd123', 'Asd23', 'noche', '0', '2024-10-30', '16:45:00', '16:45:00', 0, '', '2024-10-17 16:45:40'),
(7, 2, 'Ingreso A Laboratorio', 0, '-', '-', '-', '0', '2024-10-19', '10:00:00', '10:45:00', 0, '', '2024-10-18 18:45:47'),
(8, 1, 'Hoy En La Mañana', 0, 'Hoy En La Mañana', 'Hoy En La Mañana', 'mañana', '0', '2024-10-18', '08:00:00', '08:45:00', 0, '', '2024-10-18 19:17:50'),
(9, 1, 'Vgalia', 1, 'Computacion', 'Computacion', 'tarde', '4', '2024-10-26', '14:00:00', '17:00:00', 12, '', '2024-10-26 19:34:01'),
(10, 5, 'Demo', 2, 'Sistemas', 'Lenguaje De Programación I', 'noche', '0', '2024-10-26', '19:50:00', '20:35:00', 32, '', '2024-10-26 19:51:41');

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

--
-- Volcado de datos para la tabla `lab_inventarios`
--

INSERT INTO `lab_inventarios` (`idinventario`, `codigo`, `fecha_ingreso`, `motivo_ingreso`, `tipo_documento`, `observaciones`, `fecha_registro`) VALUES
(1, 'IN-0009', '2024-10-14', 3, 2, NULL, '2024-10-14 23:03:15'),
(2, 'IN-0001', '2024-10-01', 3, 2, NULL, '2024-10-15 08:05:50'),
(3, 'IN-0002', '2024-10-02', 3, 2, NULL, '2024-10-15 08:05:56'),
(4, 'IN-0003', '2024-10-03', 3, 2, NULL, '2024-10-15 08:06:01'),
(5, 'IN-0004', '2024-10-04', 3, 2, NULL, '2024-10-15 08:06:13'),
(6, 'IN-0005', '2024-10-08', 3, 2, NULL, '2024-10-15 08:06:23'),
(7, 'IN-0006', '2024-10-09', 3, 2, NULL, '2024-10-15 08:06:29'),
(8, 'IN-0007', '2024-10-10', 3, 2, NULL, '2024-10-15 08:06:34'),
(9, 'IN-0008', '2024-10-11', 3, 2, NULL, '2024-10-15 08:06:48'),
(11, 'IN-0010', '2024-10-15', 1, 1, NULL, '2024-10-15 12:05:06'),
(12, 'IN-0011', '2024-10-15', 1, 2, NULL, '2024-10-15 17:13:48'),
(13, 'IN-0012', '2024-10-26', 3, 2, NULL, '2024-10-26 19:49:12');

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
  `idinventariodetalle` int NOT NULL,
  `tipo_movimiento` int DEFAULT NULL,
  `tipo_detalle` int DEFAULT NULL,
  `cantidad` decimal(7,2) NOT NULL,
  `factor` int NOT NULL DEFAULT '1',
  `fecha_movimiento` date NOT NULL,
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
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

--
-- Volcado de datos para la tabla `lab_prestamos`
--

INSERT INTO `lab_prestamos` (`idprestamo`, `idingreso`, `fecha`, `observaciones`, `fecha_registro`) VALUES
(1, 4, '2024-10-18', NULL, '2024-10-18 18:21:18'),
(2, 8, '2024-10-18', NULL, '2024-10-18 19:18:59'),
(3, 9, '2024-10-26', NULL, '2024-10-26 19:38:17'),
(4, 10, '2024-10-26', NULL, '2024-10-26 19:52:10');

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
(2, 'Modulo Usuarios', '#', 0, NULL, 'bx bx-circle', 0, 2, 1, '2023-03-07 00:41:34'),
(10, 'Modulo Inventario', '#', 0, NULL, 'bx bx-package', 0, 3, 1, '2024-10-08 01:35:58'),
(11, 'Modulo Laboratorio', '#', 0, NULL, 'fa-solid fa-flask', 0, 1, 1, '2024-10-08 01:36:07'),
(12, 'Modulo Ocurrencias', '#', 0, NULL, 'bx bx-circle', 0, 4, 1, '2024-10-08 01:36:14');

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
(21, 10, 'Materiales', '/admin/inventario', 0, 'MaterialesController', 'index', 'bx-circle', 1, 1, '2024-10-10 23:14:22'),
(22, 10, 'Ingresos', '/admin/ingresos', 0, 'IngresosController', 'index', 'bx-circle', 2, 1, '2024-10-13 12:27:57'),
(23, 11, 'Ingresos laboratorio', '/admin/laboratorio', 0, 'LaboratorioController', 'index', 'bx-circle', 1, 1, '2024-10-17 12:31:40'),
(24, 11, 'Ocurrencias', '#', 0, '#', 'index', 'bx-circle', 2, 1, '2024-10-17 12:36:01');

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
-- Indices de la tabla `lab_detalle_prestamos`
--
ALTER TABLE `lab_detalle_prestamos`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `lab_prestamos_lab_detalle_prestamos_fk` (`idprestamo`),
  ADD KEY `lab_detalle_inventarios_lab_detalle_prestamos_fk` (`idinventariodetalle`);

--
-- Indices de la tabla `lab_docentes`
--
ALTER TABLE `lab_docentes`
  ADD PRIMARY KEY (`iddocente`);

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
  ADD KEY `lab_inventarios_lab_movimientos_fk` (`idinventariodetalle`);

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
  MODIFY `idbalance` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `lab_condiciones`
--
ALTER TABLE `lab_condiciones`
  MODIFY `idcondicion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `lab_detalle_inventarios`
--
ALTER TABLE `lab_detalle_inventarios`
  MODIFY `idinventariodetalle` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `lab_detalle_prestamos`
--
ALTER TABLE `lab_detalle_prestamos`
  MODIFY `iddetalle` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `lab_docentes`
--
ALTER TABLE `lab_docentes`
  MODIFY `iddocente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `lab_ingresos_laboratorios`
--
ALTER TABLE `lab_ingresos_laboratorios`
  MODIFY `idingreso` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `lab_insumos`
--
ALTER TABLE `lab_insumos`
  MODIFY `idinsumo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `lab_inventarios`
--
ALTER TABLE `lab_inventarios`
  MODIFY `idinventario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
-- AUTO_INCREMENT de la tabla `lab_prestamos`
--
ALTER TABLE `lab_prestamos`
  MODIFY `idprestamo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `lab_productos`
--
ALTER TABLE `lab_productos`
  MODIFY `idproducto` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lab_unidades_medidas`
--
ALTER TABLE `lab_unidades_medidas`
  MODIFY `idmedida` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `sis_centinela`
--
ALTER TABLE `sis_centinela`
  MODIFY `idvisita` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6609;

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
  MODIFY `idtarea` int NOT NULL AUTO_INCREMENT;

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
  MODIFY `idvisita` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

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
-- Filtros para la tabla `lab_detalle_prestamos`
--
ALTER TABLE `lab_detalle_prestamos`
  ADD CONSTRAINT `lab_detalle_inventarios_lab_detalle_prestamos_fk` FOREIGN KEY (`idinventariodetalle`) REFERENCES `lab_detalle_inventarios` (`idinventariodetalle`),
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
  ADD CONSTRAINT `lab_inventarios_lab_movimientos_fk` FOREIGN KEY (`idinventariodetalle`) REFERENCES `lab_detalle_inventarios` (`idinventariodetalle`);

--
-- Filtros para la tabla `lab_prestamos`
--
ALTER TABLE `lab_prestamos`
  ADD CONSTRAINT `lab_ingresos_laboratorios_lab_prestamos_fk` FOREIGN KEY (`idingreso`) REFERENCES `lab_ingresos_laboratorios` (`idingreso`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
