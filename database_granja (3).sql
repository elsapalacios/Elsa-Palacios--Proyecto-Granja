-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-03-2025 a las 23:59:38
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `database_granja`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarUbicacionAnimal` (IN `animal_id` INT, IN `nueva_ubicacion` VARCHAR(100))   BEGIN
    UPDATE
        Animales
    SET
        ubicacion = nueva_ubicacion
    WHERE
        id_animal = animal_id ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarEspecie` (IN `nombre` VARCHAR(50), IN `descripcion` TEXT)   BEGIN
    INSERT INTO Especies (nombre_especie, descripcion) 
    VALUES (nombre, descripcion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerAnimal` (IN `animal_id` INT)   BEGIN
    SELECT * FROM Animales WHERE id_animal = animal_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Obtener_Especie` (IN `p_id_especie` INT)   BEGIN
SELECT * FROM especies WHERE id = p_id_especie;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alimentacion`
--

CREATE TABLE `alimentacion` (
  `id_alimentacion` int(11) NOT NULL,
  `id_especie` int(11) NOT NULL,
  `tipo_alimento` varchar(100) NOT NULL,
  `cantidad_gramos` decimal(10,2) NOT NULL,
  `fecha_alimentacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `alimentacion`
--

INSERT INTO `alimentacion` (`id_alimentacion`, `id_especie`, `tipo_alimento`, `cantidad_gramos`, `fecha_alimentacion`) VALUES
(1, 1, 'Croquetas', 500.00, '2024-03-01'),
(2, 2, 'Huesos y carne', 800.00, '2024-03-02'),
(3, 3, 'Pasto y heno', 3000.00, '2024-03-03'),
(4, 4, 'Maíz y grano', 250.00, '2024-03-04'),
(5, 5, 'Hierba fresca', 2000.00, '2024-03-05'),
(6, 6, 'Forraje y maíz', 1800.00, '2024-03-06'),
(7, 7, 'Zanahorias y alfalfa', 500.00, '2024-03-07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `animales`
--

CREATE TABLE `animales` (
  `id_animal` int(11) NOT NULL,
  `nombre_cientifico` varchar(100) NOT NULL,
  `nombre_comun` varchar(100) DEFAULT NULL,
  `especie` varchar(100) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `estado` enum('Sano','Enfermo','Recuperación') DEFAULT 'Sano',
  `descripcion` text DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `animales`
--

INSERT INTO `animales` (`id_animal`, `nombre_cientifico`, `nombre_comun`, `especie`, `edad`, `ubicacion`, `estado`, `descripcion`, `fecha_registro`) VALUES
(1, 'Canis lupus familiaris', 'Perro', 'Mamíferos', 3, 'Refugio Animal', 'Sano', 'Mascota doméstica leal.', '2025-03-13 06:13:37'),
(2, 'Felis catus', 'Gato', 'Mamíferos', 2, 'Refugio Animal', 'Sano', 'Animal independiente y ágil.', '2025-03-13 06:13:37'),
(3, 'Gallus gallus domesticus', 'Gallina', 'Aves', 1, 'Granja Los Andes', 'Sano', 'Ave de corral productora de huevos.', '2025-03-13 06:13:37'),
(4, 'Equus ferus caballus', 'Caballo', 'Mamíferos', 5, 'Rancho Santa Fe', 'Recuperación', 'Animal fuerte y veloz usado en transporte.', '2025-03-13 06:13:37'),
(5, 'Chelonia mydas', 'Tortuga marina', 'Reptiles', 20, 'Santuario Marino', 'Enfermo', 'Reptil marino en peligro de extinción.', '2025-03-13 06:13:37'),
(6, 'Brachypelma smithi', 'Tarántula', 'Arácnidos', 7, 'Laboratorio Biológico', 'Sano', 'Araña grande y peluda.', '2025-03-13 06:13:37'),
(7, 'Apis mellifera', 'Abeja', 'Insectos', 1, 'Colmena Natural', 'Sano', 'Insecto polinizador clave para el ecosistema.', '2025-03-13 06:13:37');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `costos`
--

CREATE TABLE `costos` (
  `id_costo` int(11) NOT NULL,
  `tipo_costo` enum('Alimentación','Salud','Mantenimiento','Salarios','Otro') NOT NULL,
  `descripcion` text NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha` date NOT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `id_animal` int(11) DEFAULT NULL,
  `id_especie` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `costos`
--

INSERT INTO `costos` (`id_costo`, `tipo_costo`, `descripcion`, `monto`, `fecha`, `id_empleado`, `id_animal`, `id_especie`) VALUES
(1, 'Alimentación', 'Compra de alimento para perros', 150000.00, '2025-03-12', 2, 5, 1),
(2, 'Salud', 'Vacunación de gatos', 80000.00, '2025-03-12', 3, 7, 2),
(3, 'Mantenimiento', 'Reparación de jaulas', 120000.00, '2025-03-10', 4, 3, 2),
(4, 'Otro', 'Traslado de animales rescatados', 50000.00, '2025-03-11', 1, 6, 6),
(5, 'Salud', 'Consulta veterinaria', 60000.00, '2025-03-09', 5, 4, 1),
(6, 'Alimentación', 'Compra de semillas para aves', 30000.00, '2025-03-08', 6, 3, 2),
(7, 'Mantenimiento', 'Compra de collares y correas', 45000.00, '2025-03-07', 7, 4, 1),
(8, 'Alimentación', 'Compra de miel', 35000.00, '2025-01-15', 5, 7, 7),
(9, 'Salud', 'Revisión médica', 70000.00, '2025-03-03', 6, 5, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `id_empleado` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `rol` varchar(50) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_contratacion` date NOT NULL,
  `salario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`id_empleado`, `nombre`, `rol`, `telefono`, `fecha_contratacion`, `salario`) VALUES
(1, 'Carlos Pérez', 'Veterinario', '3001234567', '2023-05-10', 3200000.00),
(2, 'Ana Gómez', 'Asistente', '3019876543', '2024-02-15', 1800000.00),
(3, 'Luis Rodríguez', 'Encargado de alimentación', '3024567890', '2022-11-20', 2200000.00),
(4, 'María Fernández', 'Administradora', '3007654321', '2021-07-05', 4000000.00),
(5, 'Javier Méndez', 'Cuidador de animales', '3012345678', '2023-09-12', 2000000.00),
(6, 'Paula Castro', 'Recepcionista', '3023456789', '2024-01-08', 1600000.00),
(7, 'Diego Ramírez', 'Entrenador', '3035678901', '2023-06-25', 2500000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especies`
--

CREATE TABLE `especies` (
  `id_especie` int(11) NOT NULL,
  `nombre_especie` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `especies`
--

INSERT INTO `especies` (`id_especie`, `nombre_especie`, `descripcion`) VALUES
(1, 'Mamíferos', 'Animales de sangre caliente que amamantan a sus crías.'),
(2, 'Aves', 'Vertebrados con plumas y capacidad de volar.'),
(3, 'Reptiles', 'Animales de sangre fría con escamas.'),
(4, 'Anfibios', 'Animales que pasan parte de su vida en el agua y parte en tierra.'),
(5, 'Peces', 'Animales acuáticos con branquias.'),
(6, 'Arácnidos', 'Invertebrados con ocho patas.'),
(7, 'Insectos', 'Animales invertebrados con seis patas.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos_alertas`
--

CREATE TABLE `eventos_alertas` (
  `id_evento` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_animal` int(11) DEFAULT NULL,
  `id_planta` int(11) DEFAULT NULL,
  `tipo` enum('Evento','Alerta') NOT NULL,
  `descripcion` text NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_salud`
--

CREATE TABLE `historial_salud` (
  `id_historial` int(11) NOT NULL,
  `id_animal` int(11) NOT NULL,
  `fecha_cambio` date NOT NULL,
  `estado_anterior` enum('Sano','Enfermo','Recuperación') DEFAULT NULL,
  `estado_nuevo` enum('Sano','Enfermo','Recuperación') NOT NULL,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenes_adjuntos`
--

CREATE TABLE `imagenes_adjuntos` (
  `id_archivo` int(11) NOT NULL,
  `id_reporte` int(11) NOT NULL,
  `nombre_archivo` varchar(255) NOT NULL,
  `ruta_archivo` varchar(255) NOT NULL,
  `tipo_archivo` enum('Imagen','Documento','Otro') NOT NULL,
  `fecha_subida` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plantas`
--

CREATE TABLE `plantas` (
  `id_planta` int(11) NOT NULL,
  `nombre_cientifico` varchar(100) NOT NULL,
  `nombre_comun` varchar(100) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `estado` enum('Sano','Enfermo','Recuperación') DEFAULT 'Sano',
  `descripcion` text DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `plantas`
--

INSERT INTO `plantas` (`id_planta`, `nombre_cientifico`, `nombre_comun`, `ubicacion`, `estado`, `descripcion`, `fecha_registro`) VALUES
(1, 'Quercus robur', 'Roble', 'Parque Central', 'Sano', 'Árbol frondoso de gran tamaño.', '2025-03-13 06:13:06'),
(2, 'Pinus sylvestris', 'Pino silvestre', 'Bosque Norte', 'Sano', 'Conífera de hoja perenne.', '2025-03-13 06:13:06'),
(3, 'Eucalyptus globulus', 'Eucalipto', 'Jardín Botánico', 'Enfermo', 'Árbol de gran porte usado en medicina.', '2025-03-13 06:13:06'),
(4, 'Ficus benjamina', 'Ficus', 'Avenida Principal', 'Recuperación', 'Árbol ornamental común en ciudades.', '2025-03-13 06:13:06'),
(5, 'Coffea arabica', 'Café', 'Finca El Paraíso', 'Sano', 'Planta productora de granos de café.', '2025-03-13 06:13:06'),
(6, 'Rosa indica', 'Rosa', 'Jardín de Rosas', 'Sano', 'Flor ornamental de gran belleza.', '2025-03-13 06:13:06'),
(7, 'Lilium candidum', 'Lirio blanco', 'Invernadero Central', 'Sano', 'Planta con flores aromáticas.', '2025-03-13 06:13:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `produccion`
--

CREATE TABLE `produccion` (
  `id_produccion` int(11) NOT NULL,
  `id_animal` int(11) DEFAULT NULL,
  `tipo_produccion` enum('Leche','Huevos','Carne','Otro') NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `fecha_recoleccion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `produccion`
--

INSERT INTO `produccion` (`id_produccion`, `id_animal`, `tipo_produccion`, `cantidad`, `fecha_recoleccion`) VALUES
(1, 4, 'Leche', 20.50, '2024-03-01'),
(2, 6, 'Huevos', 30.00, '2024-03-02'),
(3, 5, 'Carne', 50.00, '2024-03-03'),
(4, 4, 'Leche', 25.00, '2024-03-04'),
(5, 6, 'Huevos', 28.00, '2024-03-05'),
(6, 5, 'Carne', 45.00, '2024-03-06'),
(7, 4, 'Leche', 22.00, '2024-03-07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `tipo_producto` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_salud`
--

CREATE TABLE `registro_salud` (
  `id_registro` int(11) NOT NULL,
  `id_animal` int(11) NOT NULL,
  `fecha_revision` date NOT NULL,
  `peso` decimal(5,2) DEFAULT NULL,
  `estado_salud` enum('Sano','Enfermo','En tratamiento') DEFAULT 'Sano',
  `diagnostico` text DEFAULT NULL,
  `tratamiento` text DEFAULT NULL,
  `veterinario_responsable` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes`
--

CREATE TABLE `reportes` (
  `id_reporte` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_planta` int(11) DEFAULT NULL,
  `id_animal` int(11) DEFAULT NULL,
  `tipo` enum('Planta','Animal') NOT NULL,
  `diagnostico` text NOT NULL,
  `fecha_reporte` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `reportes`
--

INSERT INTO `reportes` (`id_reporte`, `id_usuario`, `id_planta`, `id_animal`, `tipo`, `diagnostico`, `fecha_reporte`) VALUES
(1, 1, NULL, 2, 'Animal', 'Infección en la piel detectada', '2025-03-13 06:22:11'),
(2, 2, 1, NULL, 'Planta', 'Ataque de plagas en hojas', '2025-03-13 06:22:11'),
(3, 3, NULL, 5, 'Animal', 'Problema digestivo detectado', '2025-03-13 06:22:11'),
(4, 4, 3, NULL, 'Planta', 'Falta de nutrientes en el suelo', '2025-03-13 06:22:11'),
(5, 5, NULL, 6, 'Animal', 'Posible fractura en pata trasera', '2025-03-13 06:22:11'),
(6, 6, 5, NULL, 'Planta', 'Síntomas de enfermedad fúngica', '2025-03-13 06:22:11'),
(7, 7, NULL, 7, 'Animal', 'Deshidratación leve detectada', '2025-03-13 06:22:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamientos`
--

CREATE TABLE `tratamientos` (
  `id_tratamiento` int(11) NOT NULL,
  `id_reporte` int(11) DEFAULT NULL,
  `descripcion` text NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `resultado` enum('Exitoso','En Proceso','Fallido') DEFAULT 'En Proceso'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `tratamientos`
--

INSERT INTO `tratamientos` (`id_tratamiento`, `id_reporte`, `descripcion`, `fecha_inicio`, `fecha_fin`, `resultado`) VALUES
(1, 1, 'Aplicación de antibióticos', '2024-03-01', '2024-03-10', 'Exitoso'),
(2, 2, 'Riego con pesticida ecológico', '2024-03-05', '2024-03-12', 'Exitoso'),
(3, 3, 'Cambio de dieta y medicación', '2024-03-07', NULL, 'En Proceso'),
(4, 4, 'Fertilización de suelo', '2024-03-10', '2024-03-15', 'Exitoso'),
(5, 5, 'Reposo y vendaje en la pata', '2024-03-11', NULL, 'En Proceso'),
(6, 6, 'Tratamiento antifúngico', '2024-03-12', '2024-03-19', 'Exitoso'),
(7, 7, 'Aumento de hidratación y control', '2024-03-14', NULL, 'En Proceso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion_georreferenciada`
--

CREATE TABLE `ubicacion_georreferenciada` (
  `id_ubicacion` int(11) NOT NULL,
  `id_animal` int(11) DEFAULT NULL,
  `id_planta` int(11) DEFAULT NULL,
  `latitud` decimal(10,8) NOT NULL,
  `longitud` decimal(11,8) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `usuario` enum('Investigador','Veterinario','Botánico','Administrador') NOT NULL,
  `contraseña` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `correo`, `telefono`, `usuario`, `contraseña`) VALUES
(1, 'Juan Pérez', 'juan@example.com', '3123456789', 'Investigador', 'clave123'),
(2, 'María Gómez', 'maria@example.com', '3159876543', 'Veterinario', 'clave456'),
(3, 'Carlos López', 'carlos@example.com', '3206543210', 'Botánico', 'clave789'),
(4, 'Ana Torres', 'ana@example.com', '3112233445', 'Administrador', 'clave101'),
(5, 'Pedro Sánchez', 'pedro@example.com', '3223344556', 'Investigador', 'clave202'),
(6, 'Laura Ruiz', 'laura@example.com', '3199988776', 'Veterinario', 'clave303'),
(7, 'Miguel Díaz', 'miguel@example.com', '3101122334', 'Botánico', 'clave404');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `id_produccion` int(11) DEFAULT NULL,
  `id_animal` int(11) DEFAULT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `precio_total` decimal(10,2) NOT NULL,
  `fecha_venta` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_costos_totales`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_costos_totales` (
`tipo_costo` enum('Alimentación','Salud','Mantenimiento','Salarios','Otro')
,`total_monto` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_especies`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_especies` (
`id_especie` int(11)
,`nombre_especie` varchar(50)
,`descripcion` text
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_produccion_total`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_produccion_total` (
`tipo_produccion` enum('Leche','Huevos','Carne','Otro')
,`total_cantidad` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_costos_totales`
--
DROP TABLE IF EXISTS `vista_costos_totales`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_costos_totales`  AS SELECT `costos`.`tipo_costo` AS `tipo_costo`, sum(`costos`.`monto`) AS `total_monto` FROM `costos` GROUP BY `costos`.`tipo_costo` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_especies`
--
DROP TABLE IF EXISTS `vista_especies`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_especies`  AS SELECT `especies`.`id_especie` AS `id_especie`, `especies`.`nombre_especie` AS `nombre_especie`, `especies`.`descripcion` AS `descripcion` FROM `especies` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_produccion_total`
--
DROP TABLE IF EXISTS `vista_produccion_total`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_produccion_total`  AS SELECT `produccion`.`tipo_produccion` AS `tipo_produccion`, sum(`produccion`.`cantidad`) AS `total_cantidad` FROM `produccion` GROUP BY `produccion`.`tipo_produccion` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alimentacion`
--
ALTER TABLE `alimentacion`
  ADD PRIMARY KEY (`id_alimentacion`),
  ADD KEY `id_especie` (`id_especie`);

--
-- Indices de la tabla `animales`
--
ALTER TABLE `animales`
  ADD PRIMARY KEY (`id_animal`);

--
-- Indices de la tabla `costos`
--
ALTER TABLE `costos`
  ADD PRIMARY KEY (`id_costo`),
  ADD KEY `id_empleado` (`id_empleado`),
  ADD KEY `id_animal` (`id_animal`),
  ADD KEY `id_especie` (`id_especie`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id_empleado`);

--
-- Indices de la tabla `especies`
--
ALTER TABLE `especies`
  ADD PRIMARY KEY (`id_especie`);

--
-- Indices de la tabla `eventos_alertas`
--
ALTER TABLE `eventos_alertas`
  ADD PRIMARY KEY (`id_evento`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_animal` (`id_animal`),
  ADD KEY `id_planta` (`id_planta`);

--
-- Indices de la tabla `historial_salud`
--
ALTER TABLE `historial_salud`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `id_animal` (`id_animal`);

--
-- Indices de la tabla `imagenes_adjuntos`
--
ALTER TABLE `imagenes_adjuntos`
  ADD PRIMARY KEY (`id_archivo`),
  ADD KEY `id_reporte` (`id_reporte`);

--
-- Indices de la tabla `plantas`
--
ALTER TABLE `plantas`
  ADD PRIMARY KEY (`id_planta`);

--
-- Indices de la tabla `produccion`
--
ALTER TABLE `produccion`
  ADD PRIMARY KEY (`id_produccion`),
  ADD KEY `id_animal` (`id_animal`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `registro_salud`
--
ALTER TABLE `registro_salud`
  ADD PRIMARY KEY (`id_registro`),
  ADD KEY `id_animal` (`id_animal`);

--
-- Indices de la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`id_reporte`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_planta` (`id_planta`),
  ADD KEY `id_animal` (`id_animal`);

--
-- Indices de la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD PRIMARY KEY (`id_tratamiento`),
  ADD KEY `id_reporte` (`id_reporte`);

--
-- Indices de la tabla `ubicacion_georreferenciada`
--
ALTER TABLE `ubicacion_georreferenciada`
  ADD PRIMARY KEY (`id_ubicacion`),
  ADD KEY `id_animal` (`id_animal`),
  ADD KEY `id_planta` (`id_planta`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_produccion` (`id_produccion`),
  ADD KEY `id_animal` (`id_animal`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alimentacion`
--
ALTER TABLE `alimentacion`
  MODIFY `id_alimentacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `animales`
--
ALTER TABLE `animales`
  MODIFY `id_animal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `costos`
--
ALTER TABLE `costos`
  MODIFY `id_costo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `especies`
--
ALTER TABLE `especies`
  MODIFY `id_especie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `eventos_alertas`
--
ALTER TABLE `eventos_alertas`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_salud`
--
ALTER TABLE `historial_salud`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `imagenes_adjuntos`
--
ALTER TABLE `imagenes_adjuntos`
  MODIFY `id_archivo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `plantas`
--
ALTER TABLE `plantas`
  MODIFY `id_planta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `produccion`
--
ALTER TABLE `produccion`
  MODIFY `id_produccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registro_salud`
--
ALTER TABLE `registro_salud`
  MODIFY `id_registro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reportes`
--
ALTER TABLE `reportes`
  MODIFY `id_reporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  MODIFY `id_tratamiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `ubicacion_georreferenciada`
--
ALTER TABLE `ubicacion_georreferenciada`
  MODIFY `id_ubicacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alimentacion`
--
ALTER TABLE `alimentacion`
  ADD CONSTRAINT `alimentacion_ibfk_1` FOREIGN KEY (`id_especie`) REFERENCES `especies` (`id_especie`);

--
-- Filtros para la tabla `costos`
--
ALTER TABLE `costos`
  ADD CONSTRAINT `costos_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`) ON DELETE SET NULL,
  ADD CONSTRAINT `costos_ibfk_2` FOREIGN KEY (`id_animal`) REFERENCES `animales` (`id_animal`) ON DELETE SET NULL,
  ADD CONSTRAINT `costos_ibfk_3` FOREIGN KEY (`id_especie`) REFERENCES `especies` (`id_especie`) ON DELETE SET NULL;

--
-- Filtros para la tabla `eventos_alertas`
--
ALTER TABLE `eventos_alertas`
  ADD CONSTRAINT `eventos_alertas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `eventos_alertas_ibfk_2` FOREIGN KEY (`id_animal`) REFERENCES `animales` (`id_animal`) ON DELETE CASCADE,
  ADD CONSTRAINT `eventos_alertas_ibfk_3` FOREIGN KEY (`id_planta`) REFERENCES `plantas` (`id_planta`) ON DELETE CASCADE;

--
-- Filtros para la tabla `historial_salud`
--
ALTER TABLE `historial_salud`
  ADD CONSTRAINT `historial_salud_ibfk_1` FOREIGN KEY (`id_animal`) REFERENCES `animales` (`id_animal`) ON DELETE CASCADE;

--
-- Filtros para la tabla `imagenes_adjuntos`
--
ALTER TABLE `imagenes_adjuntos`
  ADD CONSTRAINT `imagenes_adjuntos_ibfk_1` FOREIGN KEY (`id_reporte`) REFERENCES `reportes` (`id_reporte`) ON DELETE CASCADE;

--
-- Filtros para la tabla `produccion`
--
ALTER TABLE `produccion`
  ADD CONSTRAINT `produccion_ibfk_1` FOREIGN KEY (`id_animal`) REFERENCES `animales` (`id_animal`) ON DELETE SET NULL;

--
-- Filtros para la tabla `registro_salud`
--
ALTER TABLE `registro_salud`
  ADD CONSTRAINT `registro_salud_ibfk_1` FOREIGN KEY (`id_animal`) REFERENCES `animales` (`id_animal`);

--
-- Filtros para la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD CONSTRAINT `reportes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `reportes_ibfk_2` FOREIGN KEY (`id_planta`) REFERENCES `plantas` (`id_planta`) ON DELETE CASCADE,
  ADD CONSTRAINT `reportes_ibfk_3` FOREIGN KEY (`id_animal`) REFERENCES `animales` (`id_animal`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD CONSTRAINT `tratamientos_ibfk_1` FOREIGN KEY (`id_reporte`) REFERENCES `reportes` (`id_reporte`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ubicacion_georreferenciada`
--
ALTER TABLE `ubicacion_georreferenciada`
  ADD CONSTRAINT `ubicacion_georreferenciada_ibfk_1` FOREIGN KEY (`id_animal`) REFERENCES `animales` (`id_animal`) ON DELETE CASCADE,
  ADD CONSTRAINT `ubicacion_georreferenciada_ibfk_2` FOREIGN KEY (`id_planta`) REFERENCES `plantas` (`id_planta`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_produccion`) REFERENCES `produccion` (`id_produccion`) ON DELETE SET NULL,
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_animal`) REFERENCES `animales` (`id_animal`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
