-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 28-06-2024 a las 16:53:47
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
-- Base de datos: `veterinaria_chio`
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

--
-- Volcado de datos para la tabla `crud_modulo`
--

INSERT INTO `crud_modulo` (`idmod`, `mod_nombre`, `mod_descripcion`, `mod_estado`) VALUES
(1, 'Propietarios', '\r\nCREATE TABLE vet_propietarios (\r\n                idpropietario INT AUTO_INCREMENT NOT NULL,\r\n                nombres VARCHAR(200) NOT NULL,\r\n                apellidos VARCHAR(255) NOT NULL,\r\n                celular VARCHAR(12),\r\n                direccion VARCHAR(200),\r\n                estado BOOLEAN DEFAULT 1 NOT NULL,\r\n                eliminado BOOLEAN DEFAULT 0 NOT NULL,\r\n                fecha_registro DATETIME NOT NULL,\r\n                ultima_actualizacion DATE NOT NULL,\r\n                PRIMARY KEY (idpropietario)\r\n);', 1),
(2, 'Propietarios', '\r\nCREATE TABLE vet_propietarios (\r\n                idpropietario INT AUTO_INCREMENT NOT NULL,\r\n                nombres VARCHAR(200) NOT NULL,\r\n                apellidos VARCHAR(255) NOT NULL,\r\n                celular VARCHAR(12),\r\n                direccion VARCHAR(200),\r\n                estado BOOLEAN DEFAULT 1 NOT NULL,\r\n                eliminado BOOLEAN DEFAULT 0 NOT NULL,\r\n                fecha_registro DATETIME NOT NULL,\r\n                ultima_actualizacion DATE NOT NULL,\r\n                PRIMARY KEY (idpropietario)\r\n);', 1),
(3, 'Mascotas', 'CREATE TABLE vet_mascotas (\r\n                idmascota INT AUTO_INCREMENT NOT NULL,\r\n                idpropietario INT NOT NULL,\r\n                idespecie INT NOT NULL,\r\n                idraza INT NOT NULL,\r\n                idgenero INT NOT NULL,\r\n                nombre VARCHAR(200) NOT NULL,\r\n                color VARCHAR(100),\r\n                observaciones VARCHAR(255),\r\n                fecha_nacimiento TIME,\r\n                eliminado BOOLEAN DEFAULT 0 NOT NULL,\r\n                fecha_registro DATETIME NOT NULL,\r\n                ultima_actualizacion DATE NOT NULL,\r\n                PRIMARY KEY (idmascota)\r\n);\r\n', 1),
(4, 'Especies', 'CREATE TABLE vet_especies (\r\n                idespecie INT AUTO_INCREMENT NOT NULL,\r\n                nombre VARCHAR(255) NOT NULL,\r\n                estado BOOLEAN DEFAULT 1 NOT NULL,\r\n                eliminado BOOLEAN DEFAULT 0 NOT NULL,\r\n                fecha_registro DATETIME DEFAULT current_timestamp NOT NULL,\r\n                ultima_actualizacion DATE NOT NULL,\r\n                PRIMARY KEY (idespecie)\r\n);\r\n', 1),
(5, 'Razas', 'CREATE TABLE vet_razas (\r\n                idraza INT AUTO_INCREMENT NOT NULL,\r\n                nombre VARCHAR(255) NOT NULL,\r\n                estado BOOLEAN DEFAULT 1 NOT NULL,\r\n                eliminado BOOLEAN DEFAULT 0 NOT NULL,\r\n                fecha_registro DATETIME DEFAULT current_timestamp NOT NULL,\r\n                ultima_actualizacion DATE NOT NULL,\r\n                PRIMARY KEY (idraza)\r\n);\r\n', 1),
(6, 'Generos', 'CREATE TABLE vet_generos (\r\n                idgenero INT AUTO_INCREMENT NOT NULL,\r\n                nombre VARCHAR(255) NOT NULL,\r\n                estado BOOLEAN DEFAULT 1 NOT NULL,\r\n                eliminado BOOLEAN DEFAULT 0 NOT NULL,\r\n                fecha_registro DATETIME DEFAULT current_timestamp NOT NULL,\r\n                ultima_actualizacion DATE NOT NULL,\r\n                PRIMARY KEY (idgenero)\r\n);\r\n', 1),
(7, 'Servicios', '\r\nCREATE TABLE vet_servicios (\r\n                idservicio INT AUTO_INCREMENT NOT NULL,\r\n                nombre VARCHAR(200) NOT NULL,\r\n                descripcion VARCHAR(255),\r\n                estado BOOLEAN DEFAULT 1 NOT NULL,\r\n                eliminado BOOLEAN DEFAULT 0 NOT NULL,\r\n                fecha_registro DATETIME,\r\n                ultima_actualizacion DATETIME NOT NULL,\r\n                PRIMARY KEY (idservicio)\r\n);', 1),
(8, 'Estadoconsulta', 'CREATE TABLE vet_estado_consulta (\r\n                idestado INT AUTO_INCREMENT NOT NULL,\r\n                nombre VARCHAR(255) NOT NULL,\r\n                estado BOOLEAN DEFAULT 1 NOT NULL,\r\n                eliminado BOOLEAN DEFAULT 0 NOT NULL,\r\n                fecha_registro DATETIME DEFAULT current_timestamp() NOT NULL,\r\n                ultima_actualizacion DATETIME,\r\n                PRIMARY KEY (idestado)\r\n);\r\n', 1),
(9, 'Estadoconsulta ', 'CREATE TABLE vet_estado_consulta (\r\n                idestado INT AUTO_INCREMENT NOT NULL,\r\n                nombre VARCHAR(255) NOT NULL,\r\n                estado BOOLEAN DEFAULT 1 NOT NULL,\r\n                eliminado BOOLEAN DEFAULT 0 NOT NULL,\r\n                fecha_registro DATETIME DEFAULT current_timestamp() NOT NULL,\r\n                ultima_actualizacion DATETIME,\r\n                PRIMARY KEY (idestado)\r\n);\r\n', 1),
(10, 'Estadoconsulta ', 'CREATE TABLE vet_estado_consulta (\r\n                idestado INT AUTO_INCREMENT NOT NULL,\r\n                nombre VARCHAR(255) NOT NULL,\r\n                estado BOOLEAN DEFAULT 1 NOT NULL,\r\n                eliminado BOOLEAN DEFAULT 0 NOT NULL,\r\n                fecha_registro DATETIME DEFAULT current_timestamp() NOT NULL,\r\n                ultima_actualizacion DATETIME,\r\n                PRIMARY KEY (idestado)\r\n);\r\n', 1),
(11, 'Estadoconsulta', 'CREATE TABLE vet_estado_consulta (\r\n                idestado INT AUTO_INCREMENT NOT NULL,\r\n                nombre VARCHAR(255) NOT NULL,\r\n                estado BOOLEAN DEFAULT 1 NOT NULL,\r\n                eliminado BOOLEAN DEFAULT 0 NOT NULL,\r\n                fecha_registro DATETIME DEFAULT current_timestamp() NOT NULL,\r\n                ultima_actualizacion DATETIME,\r\n                PRIMARY KEY (idestado)\r\n);\r\n', 1),
(12, 'Reservas_citas', 'CREATE TABLE vet_reservas_citas (\r\n                idreservacita INT AUTO_INCREMENT NOT NULL,\r\n                nombres VARCHAR(255) NOT NULL,\r\n                apellidos VARCHAR(255) NOT NULL,\r\n                correo VARCHAR(255) NOT NULL,\r\n                celular VARCHAR(12) NOT NULL,\r\n                fecha_consulta DATE NOT NULL,\r\n                hora_consulta TIME NOT NULL,\r\n                idespecie INT NOT NULL,\r\n                idgenero INT NOT NULL,\r\n                idraza INT NOT NULL,\r\n                nombre_mascota VARCHAR(45) NOT NULL,\r\n                descripcion_mascota VARCHAR(255) NOT NULL,\r\n                motivo_consulta VARCHAR(255) NOT NULL,\r\n                fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,\r\n                ultima_actualizacion DATETIME,\r\n                eliminado BOOLEAN DEFAULT 1 NOT NULL,\r\n                PRIMARY KEY (idreservacita)\r\n);\r\n', 1),
(13, 'Reservarcitas', 'CREATE TABLE vet_reservas_citas (\n                idreservacita INT AUTO_INCREMENT NOT NULL,\n                nombres VARCHAR(255) NOT NULL,\n                apellidos VARCHAR(255) NOT NULL,\n                correo VARCHAR(255) NOT NULL,\n                celular VARCHAR(12) NOT NULL,\n                fecha_consulta DATE NOT NULL,\n                hora_consulta TIME NOT NULL,\n                idespecie INT NOT NULL,\n                idgenero INT NOT NULL,\n                idraza INT NOT NULL,\n                nombre_mascota VARCHAR(45) NOT NULL,\n                descripcion_mascota VARCHAR(255) NOT NULL,\n                motivo_consulta VARCHAR(255) NOT NULL,\n                fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,\n                ultima_actualizacion DATETIME,\n                eliminado BOOLEAN DEFAULT 1 NOT NULL,\n                PRIMARY KEY (idreservacita)\n);\n', 1),
(14, 'Consultas', 'CREATE TABLE vet_consultas (\r\n                idconsulta INT AUTO_INCREMENT NOT NULL,\r\n                idreservacita INT DEFAULT 0 NOT NULL,\r\n                idpropietario INT DEFAULT 0 NOT NULL,\r\n                idmascota INT DEFAULT 0 NOT NULL,\r\n                idestado INT NOT NULL,\r\n                idpersonal INT NOT NULL,\r\n                codigo VARCHAR(45) NOT NULL,\r\n                fecha_consulta DATE NOT NULL,\r\n                hora_consulta TIME NOT NULL,\r\n                diagnostico TEXT NOT NULL,\r\n                observaciones TEXT NOT NULL,\r\n                fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,\r\n                ultima_actualizacion DATETIME,\r\n                eliminado BOOLEAN DEFAULT 0 NOT NULL,\r\n                PRIMARY KEY (idconsulta)\r\n);', 1);

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
(1, 'Maestras', '#', 0, NULL, 'bx-lock-open-alt', 0, 10, 1, '2023-03-06 12:39:09'),
(2, 'Modulo Usuarios', '#', 0, NULL, 'bx-circle', 0, 5, 1, '2023-03-07 00:41:34'),
(3, 'Modulo clientes', '#', 0, NULL, 'bx-circle', 0, 3, 1, '2024-06-04 16:56:01'),
(5, 'Tablas Maestras', '#', 0, NULL, 'bx-circle', 0, 9, 1, '2024-06-07 11:37:14'),
(6, 'Modulo Servicios', '#', 0, NULL, 'bx-circle', 0, 6, 1, '2024-06-12 00:09:58'),
(7, 'Modulo reserva cita', '#', 0, NULL, 'bx-circle', 0, 4, 1, '2024-06-12 01:08:51'),
(8, 'Modulo Consulta', '#', 0, NULL, 'bx-circle', 0, 2, 1, '2024-06-25 14:34:39'),
(9, 'Modulo Historia Clínica', '#', 0, NULL, 'bx-circle', 0, 1, 1, '2024-06-28 09:22:42');

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
(6, 1, 4, 1, 1, 1, 1),
(7, 1, 7, 1, 1, 1, 1),
(8, 1, 8, 1, 1, 1, 1),
(9, 1, 9, 1, 1, 1, 1),
(10, 1, 11, 1, 1, 1, 1),
(11, 1, 13, 1, 1, 1, 1),
(12, 1, 14, 1, 1, 1, 1),
(13, 1, 15, 1, 1, 1, 1),
(14, 1, 16, 1, 1, 1, 1),
(15, 1, 17, 1, 1, 1, 1),
(16, 1, 18, 1, 1, 1, 1),
(17, 1, 19, 1, 1, 1, 1);

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
(4, 'web', 'Usuario Web', 'usuario web, con privilegios READ y VIEW', 1, '2023-03-08 13:22:56'),
(6, 'vet', 'Veterinario', '', 1, '2024-06-25 14:50:25');

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
(3, 1, 'Permisos', '/admin/permisos', 0, 'PermisosController', 'index', 'bx-key', 3, 1, '2023-03-06 12:42:10'),
(4, 2, 'Usuarios', '/admin/usuarios', 0, 'UsuariosController', 'index', 'bx-user', 2, 1, '2023-03-07 00:43:11'),
(7, 2, 'Personal', '/admin/personas', 0, 'PersonasController', 'index', 'bxs-user', 1, 1, '2023-03-07 19:44:33'),
(8, 2, 'Roles', '/admin/roles', 0, 'RolesController', 'index', 'bx-ruler', 3, 1, '2023-03-07 19:44:54'),
(9, 3, 'registrar propietario', '/admin/propietarios', 0, 'PropietariosController', 'index', 'bx-circle', 2, 1, '2024-06-04 16:56:33'),
(11, 3, 'registrar mascota', '/admin/mascotas', 0, 'MascotasController', 'index', 'bx-circle', 1, 1, '2024-06-04 16:58:28'),
(13, 1, 'Crud', '/admin/crud', 0, 'CrudController', 'index', 'bx-edit', 4, 1, '2024-06-04 18:46:27'),
(14, 5, 'Razas', '/admin/razas', 0, 'RazasController', 'index', 'bx-circle', 1, 1, '2024-06-07 11:37:45'),
(15, 6, 'Generar servicio', '/admin/servicios', 0, 'ServiciosController', 'index', 'bx-circle', 1, 1, '2024-06-12 00:11:38'),
(16, 7, 'Generar Reserva Cita', '/admin/reservarcitas', 0, 'ReservarcitasController', 'index', 'bx-circle', 1, 1, '2024-06-12 01:09:35'),
(17, 7, 'reporte citas', '#', 0, '#', 'index', 'bx-circle', 2, 1, '2024-06-12 01:13:04'),
(18, 8, 'Generar Consulta', '/admin/crearconsulta', 0, 'ConsultasController', 'index', 'bx-circle', 1, 1, '2024-06-25 14:35:50'),
(19, 9, 'Generar historia clinica', '#', 0, '#', 'index', 'bx-circle', 1, 1, '2024-06-28 09:23:39');

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
(5, 'Delete Centinela Y Visitas', '', 'DELETE FROM `sis_centinela`;\r\nDELETE FROM `web_visitas`;', '2023-03-24 19:30:52');

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
-- Estructura de tabla para la tabla `vet_consultas`
--

CREATE TABLE `vet_consultas` (
  `idconsulta` int NOT NULL,
  `idreservacita` int NOT NULL DEFAULT '0',
  `idpropietario` int NOT NULL DEFAULT '0',
  `idmascota` int NOT NULL DEFAULT '0',
  `idestado` int NOT NULL,
  `idpersonal` int NOT NULL,
  `codigo` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_consulta` date NOT NULL,
  `hora_consulta` time NOT NULL,
  `diagnostico` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultima_actualizacion` datetime DEFAULT NULL,
  `eliminado` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `vet_consultas`
--

INSERT INTO `vet_consultas` (`idconsulta`, `idreservacita`, `idpropietario`, `idmascota`, `idestado`, `idpersonal`, `codigo`, `fecha_consulta`, `hora_consulta`, `diagnostico`, `observaciones`, `fecha_registro`, `ultima_actualizacion`, `eliminado`) VALUES
(2, 0, 1, 2, 1, 1, '580601191154688', '2024-06-28', '09:32:00', '', '', '2024-06-28 09:40:58', '2024-06-28 09:40:58', 0),
(3, 0, 2, 4, 1, 1, '580602539136000', '2024-06-28', '09:37:00', '', '', '2024-06-28 09:37:59', '2024-06-28 09:37:59', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vet_especies`
--

CREATE TABLE `vet_especies` (
  `idespecie` int NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `icono` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `eliminado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultima_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `vet_especies`
--

INSERT INTO `vet_especies` (`idespecie`, `nombre`, `icono`, `estado`, `eliminado`, `fecha_registro`, `ultima_actualizacion`) VALUES
(1, 'Perros', 'fa fa-solid fa-dog', 1, 0, '2024-06-06 15:05:07', '2024-06-06 00:00:00'),
(2, 'Gatos', 'fa fa-solid fa-cat', 1, 0, '2024-06-06 15:05:30', '2024-06-06 00:00:00'),
(3, 'Ave', NULL, 1, 0, '2024-06-14 17:09:19', '2024-06-14 17:09:19'),
(4, 'Pez', NULL, 1, 0, '2024-06-14 17:09:19', '2024-06-14 17:09:19'),
(5, 'Reptil', NULL, 1, 0, '2024-06-14 17:09:19', '2024-06-14 17:09:19'),
(6, 'Pequeño Mamífero', NULL, 1, 0, '2024-06-14 17:09:19', '2024-06-14 17:09:19'),
(7, 'Anfibio', NULL, 1, 0, '2024-06-14 17:09:19', '2024-06-14 17:09:19'),
(8, 'Invertebrado', NULL, 1, 0, '2024-06-14 17:09:19', '2024-06-14 17:09:19'),
(9, 'Ave de Corral', NULL, 1, 0, '2024-06-14 17:09:19', '2024-06-14 17:09:19'),
(10, 'Mamífero Exótico', NULL, 1, 0, '2024-06-14 17:09:19', '2024-06-14 17:09:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vet_estados_citas`
--

CREATE TABLE `vet_estados_citas` (
  `idestadocita` int NOT NULL,
  `nombre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultima_actualizacion` datetime DEFAULT NULL,
  `eliminado` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `vet_estados_citas`
--

INSERT INTO `vet_estados_citas` (`idestadocita`, `nombre`, `descripcion`, `fecha_registro`, `ultima_actualizacion`, `eliminado`) VALUES
(1, 'Reservado', NULL, '2024-06-25 01:02:59', '2024-06-25 01:02:59', 0),
(2, 'Atendido', NULL, '2024-06-25 01:02:59', '2024-06-25 01:02:59', 0),
(3, 'Cancelado por el usuario', NULL, '2024-06-25 01:03:14', '2024-06-25 01:03:14', 0),
(4, 'Reprogramado', NULL, '2024-06-25 01:03:31', '2024-06-25 01:03:31', 0),
(5, 'Pendiente', NULL, '2024-06-25 01:09:52', '2024-06-25 01:09:52', 0),
(6, 'Cancelado por el administrador', NULL, '2024-06-25 01:21:27', '2024-06-25 01:21:27', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vet_estado_consulta`
--

CREATE TABLE `vet_estado_consulta` (
  `idestado` int NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `eliminado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultima_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `vet_estado_consulta`
--

INSERT INTO `vet_estado_consulta` (`idestado`, `nombre`, `estado`, `eliminado`, `fecha_registro`, `ultima_actualizacion`) VALUES
(1, 'Generado', 1, 0, '2024-06-12 14:44:39', '2024-06-12 14:44:39'),
(2, 'Atendido', 1, 0, '2024-06-12 14:44:39', '2024-06-12 14:44:39'),
(3, 'Cancelado', 1, 0, '2024-06-27 12:48:00', '2024-06-27 12:48:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vet_generos`
--

CREATE TABLE `vet_generos` (
  `idgenero` int NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `eliminado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultima_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `vet_generos`
--

INSERT INTO `vet_generos` (`idgenero`, `nombre`, `estado`, `eliminado`, `fecha_registro`, `ultima_actualizacion`) VALUES
(1, 'Macho', 1, 0, '2024-06-10 14:35:44', '2024-06-10 19:35:27'),
(2, 'Hembra', 1, 0, '2024-06-10 14:35:44', '2024-06-10 19:35:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vet_mascotas`
--

CREATE TABLE `vet_mascotas` (
  `idmascota` int NOT NULL,
  `idpropietario` int NOT NULL,
  `idespecie` int NOT NULL,
  `idraza` int NOT NULL,
  `idgenero` int NOT NULL,
  `nombre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `eliminado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultima_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `vet_mascotas`
--

INSERT INTO `vet_mascotas` (`idmascota`, `idpropietario`, `idespecie`, `idraza`, `idgenero`, `nombre`, `color`, `observaciones`, `fecha_nacimiento`, `eliminado`, `fecha_registro`, `ultima_actualizacion`) VALUES
(1, 1, 1, 21, 1, 'jean', 'negro', '', '2024-06-25', 0, '2024-06-25 12:24:24', '2024-06-25 12:24:24'),
(2, 1, 1, 21, 1, 'Soyer', 'clasico', '', '2022-05-28', 0, '2024-06-25 12:29:41', '2024-06-25 12:29:41'),
(3, 1, 1, 21, 1, 'tommy', 'negro', '', '2021-08-16', 0, '2024-06-25 12:30:11', '2024-06-25 12:30:11'),
(4, 2, 1, 21, 2, 'kira', 'amarillo', '', '2024-06-27', 0, '2024-06-27 14:26:48', '2024-06-27 14:26:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vet_propietarios`
--

CREATE TABLE `vet_propietarios` (
  `idpropietario` int NOT NULL,
  `nombres` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `apellidos` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `celular` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `direccion` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `eliminado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `ultima_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `vet_propietarios`
--

INSERT INTO `vet_propietarios` (`idpropietario`, `nombres`, `apellidos`, `celular`, `direccion`, `estado`, `eliminado`, `fecha_registro`, `ultima_actualizacion`) VALUES
(1, 'rocio', 'benites', '', '', 1, 0, '2024-06-25 12:21:08', '2024-06-25 12:21:08'),
(2, 'chio', 'benites', '', '', 1, 0, '2024-06-27 14:26:09', '2024-06-27 14:26:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vet_razas`
--

CREATE TABLE `vet_razas` (
  `idraza` int NOT NULL,
  `idespecie` int NOT NULL DEFAULT '0',
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `eliminado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultima_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `vet_razas`
--

INSERT INTO `vet_razas` (`idraza`, `idespecie`, `nombre`, `estado`, `eliminado`, `fecha_registro`, `ultima_actualizacion`) VALUES
(1, 2, 'Persa', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(2, 2, 'Siamés', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(3, 2, 'Maine Coon', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(4, 2, 'Bengalí', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(5, 2, 'Sphynx', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(6, 2, 'Ragdoll', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(7, 2, 'British Shorthair', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(8, 2, 'Abisinio', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(9, 2, 'Scottish Fold', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(10, 2, 'Oriental de Pelo Corto', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(11, 1, 'Labrador Retriever', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(12, 1, 'Pastor Alemán', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(13, 1, 'Bulldog Francés', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(14, 1, 'Golden Retriever', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(15, 1, 'Bulldog Inglés', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(16, 1, 'Beagle', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(17, 1, 'Poodle (Caniche)', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(18, 1, 'Rottweiler', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(19, 1, 'Yorkshire Terrier', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(20, 1, 'Dachshund (Teckel)', 1, 0, '2024-06-14 17:07:35', '2024-06-14 17:07:35'),
(21, 1, 'Mestizo', 1, 0, '2024-06-24 16:42:23', '2024-06-24 16:42:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vet_reservas_citas`
--

CREATE TABLE `vet_reservas_citas` (
  `idreservacita` int NOT NULL,
  `idusuario` int NOT NULL DEFAULT '0',
  `idpropietario` int NOT NULL DEFAULT '0',
  `nombres` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `apellidos` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `celular` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_consulta` date NOT NULL,
  `hora_consulta` time NOT NULL,
  `idmascota` int NOT NULL DEFAULT '0',
  `idespecie` int NOT NULL,
  `idgenero` int NOT NULL,
  `idraza` int NOT NULL,
  `nombre_mascota` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion_mascota` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `motivo_consulta` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `idestadocita` int NOT NULL DEFAULT '0',
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultima_actualizacion` datetime DEFAULT NULL,
  `eliminado` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vet_servicios`
--

CREATE TABLE `vet_servicios` (
  `idservicio` int NOT NULL,
  `nombre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `precio` decimal(7,2) NOT NULL DEFAULT '0.00',
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `eliminado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultima_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `vet_servicios`
--

INSERT INTO `vet_servicios` (`idservicio`, `nombre`, `descripcion`, `precio`, `estado`, `eliminado`, `fecha_registro`, `ultima_actualizacion`) VALUES
(3, 'exámenes de laboratorio', NULL, 0.00, 1, 1, '2024-06-16 16:21:12', '2024-06-16 16:21:12'),
(4, 'Exámenes de Laboratorio', '', 100.00, 1, 0, '2024-06-16 16:22:38', '2024-06-16 17:07:34'),
(5, 'Desparasitaciones', '', 10.00, 1, 0, '2024-06-16 16:24:49', '2024-06-16 16:27:19'),
(6, 'Ecografía y/o Rayos X', '', 1.00, 1, 0, '2024-06-16 16:24:49', '2024-06-16 16:35:17'),
(7, 'Spa canino', '', 1.00, 1, 0, '2024-06-16 16:24:49', '2024-06-16 16:35:26'),
(8, 'Cirugías', '', 1.00, 1, 0, '2024-06-16 16:24:49', '2024-06-16 16:44:08'),
(9, 'Consulta General', '', 1.00, 1, 0, '2024-06-16 16:24:49', '2024-06-16 16:44:12'),
(10, 'Tratamiento', '', 1.00, 1, 0, '2024-06-16 16:24:49', '2024-06-16 16:44:16'),
(11, 'Vacunación', '', 20.00, 1, 0, '2024-06-16 16:24:49', '2024-06-16 16:27:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vet_tratamientos`
--

CREATE TABLE `vet_tratamientos` (
  `idtratamiento` int NOT NULL,
  `idconsulta` int NOT NULL DEFAULT '0',
  `idservicio` int NOT NULL DEFAULT '0',
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `cantidad` double NOT NULL DEFAULT '0',
  `precio` decimal(7,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(7,2) NOT NULL DEFAULT '0.00',
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultima_actualizacion` datetime DEFAULT NULL,
  `eliminado` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `vet_tratamientos`
--

INSERT INTO `vet_tratamientos` (`idtratamiento`, `idconsulta`, `idservicio`, `descripcion`, `cantidad`, `precio`, `subtotal`, `fecha_registro`, `ultima_actualizacion`, `eliminado`) VALUES
(13, 3, 5, '', 1, 10.00, 10.00, '2024-06-28 09:37:59', '2024-06-28 09:37:59', 0),
(14, 3, 11, '', 1, 20.00, 20.00, '2024-06-28 09:37:59', '2024-06-28 09:37:59', 0),
(15, 2, 9, '', 1, 10.00, 10.00, '2024-06-28 09:40:58', '2024-06-28 09:40:58', 0),
(16, 2, 11, '', 1, 10.00, 10.00, '2024-06-28 09:40:58', '2024-06-28 09:40:58', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vet_usuarios`
--

CREATE TABLE `vet_usuarios` (
  `idusuario` int NOT NULL,
  `idpropietario` int NOT NULL DEFAULT '0',
  `usu_cuenta` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `usu_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `usu_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `usu_expire` int DEFAULT NULL,
  `usu_estado` tinyint(1) NOT NULL DEFAULT '1',
  `usu_eliminado` tinyint(1) NOT NULL DEFAULT '0',
  `usu_fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usu_ultima_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `vet_usuarios`
--

INSERT INTO `vet_usuarios` (`idusuario`, `idpropietario`, `usu_cuenta`, `usu_password`, `usu_token`, `usu_expire`, `usu_estado`, `usu_eliminado`, `usu_fecha_registro`, `usu_ultima_actualizacion`) VALUES
(1, 1, 'rocioisabelbenitesloja@gmail.com', '$2y$10$Xye9XpzLMxVO8ysWMODdpOTr0e9YOw4EUmAhPnqXjyEYBZRgkXv4G', NULL, NULL, 1, 0, '2024-06-25 12:21:08', '2024-06-25 12:22:55'),
(2, 2, 'a@a.com', '$2y$10$JS0CqTwBcTlke0ZPQrmb0OVfGMTNBwO.dJfqLFjF6Hpfme.XeK/X6', 'db4d4a07b04b8c955c2d58803615bcc363e68517bf9c0f30e73325d2', 1719602769, 1, 0, '2024-06-27 14:26:09', '2024-06-27 14:26:09');

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
(7, 5611, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'GET', '/admin/login', '2024-06-27 18:34:30'),
(8, 8212, 0, ' IP: ::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'GET', '/', '2024-06-28 09:04:23');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `crud_modulo`
--
ALTER TABLE `crud_modulo`
  ADD PRIMARY KEY (`idmod`);

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
-- Indices de la tabla `sis_usuarios`
--
ALTER TABLE `sis_usuarios`
  ADD PRIMARY KEY (`idusuario`);

--
-- Indices de la tabla `vet_consultas`
--
ALTER TABLE `vet_consultas`
  ADD PRIMARY KEY (`idconsulta`);

--
-- Indices de la tabla `vet_especies`
--
ALTER TABLE `vet_especies`
  ADD PRIMARY KEY (`idespecie`);

--
-- Indices de la tabla `vet_estados_citas`
--
ALTER TABLE `vet_estados_citas`
  ADD PRIMARY KEY (`idestadocita`);

--
-- Indices de la tabla `vet_estado_consulta`
--
ALTER TABLE `vet_estado_consulta`
  ADD PRIMARY KEY (`idestado`);

--
-- Indices de la tabla `vet_generos`
--
ALTER TABLE `vet_generos`
  ADD PRIMARY KEY (`idgenero`);

--
-- Indices de la tabla `vet_mascotas`
--
ALTER TABLE `vet_mascotas`
  ADD PRIMARY KEY (`idmascota`);

--
-- Indices de la tabla `vet_propietarios`
--
ALTER TABLE `vet_propietarios`
  ADD PRIMARY KEY (`idpropietario`);

--
-- Indices de la tabla `vet_razas`
--
ALTER TABLE `vet_razas`
  ADD PRIMARY KEY (`idraza`);

--
-- Indices de la tabla `vet_reservas_citas`
--
ALTER TABLE `vet_reservas_citas`
  ADD PRIMARY KEY (`idreservacita`);

--
-- Indices de la tabla `vet_servicios`
--
ALTER TABLE `vet_servicios`
  ADD PRIMARY KEY (`idservicio`);

--
-- Indices de la tabla `vet_tratamientos`
--
ALTER TABLE `vet_tratamientos`
  ADD PRIMARY KEY (`idtratamiento`);

--
-- Indices de la tabla `vet_usuarios`
--
ALTER TABLE `vet_usuarios`
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
  MODIFY `idmod` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `sis_centinela`
--
ALTER TABLE `sis_centinela`
  MODIFY `idvisita` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14043;

--
-- AUTO_INCREMENT de la tabla `sis_imagenes`
--
ALTER TABLE `sis_imagenes`
  MODIFY `idimagen` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sis_menus`
--
ALTER TABLE `sis_menus`
  MODIFY `idmenu` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `sis_permisos`
--
ALTER TABLE `sis_permisos`
  MODIFY `idpermisos` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
  MODIFY `idsubmenu` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `sis_usuarios`
--
ALTER TABLE `sis_usuarios`
  MODIFY `idusuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `vet_consultas`
--
ALTER TABLE `vet_consultas`
  MODIFY `idconsulta` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `vet_especies`
--
ALTER TABLE `vet_especies`
  MODIFY `idespecie` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `vet_estados_citas`
--
ALTER TABLE `vet_estados_citas`
  MODIFY `idestadocita` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `vet_estado_consulta`
--
ALTER TABLE `vet_estado_consulta`
  MODIFY `idestado` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `vet_generos`
--
ALTER TABLE `vet_generos`
  MODIFY `idgenero` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `vet_mascotas`
--
ALTER TABLE `vet_mascotas`
  MODIFY `idmascota` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `vet_propietarios`
--
ALTER TABLE `vet_propietarios`
  MODIFY `idpropietario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `vet_razas`
--
ALTER TABLE `vet_razas`
  MODIFY `idraza` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `vet_reservas_citas`
--
ALTER TABLE `vet_reservas_citas`
  MODIFY `idreservacita` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `vet_servicios`
--
ALTER TABLE `vet_servicios`
  MODIFY `idservicio` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `vet_tratamientos`
--
ALTER TABLE `vet_tratamientos`
  MODIFY `idtratamiento` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `vet_usuarios`
--
ALTER TABLE `vet_usuarios`
  MODIFY `idusuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `idvisita` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
