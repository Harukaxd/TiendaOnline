-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-11-2023 a las 22:51:37
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ropa`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `Adm_cod` int(2) NOT NULL COMMENT 'Llave primaria del administrador',
  `Tipo_documento_adm` varchar(15) NOT NULL,
  `Documento_adm` varchar(15) NOT NULL,
  `Nombre_adm` varchar(20) NOT NULL,
  `Apellido_adm` varchar(20) NOT NULL,
  `Celular_adm` int(10) NOT NULL,
  `Usu_cod` int(2) NOT NULL,
  `Ven_cod` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `Cli_cod` int(11) NOT NULL,
  `Documento_cliente` varchar(15) NOT NULL,
  `Nombre_cliente` varchar(20) NOT NULL,
  `Apellido_cliente` varchar(20) NOT NULL,
  `Tel_cliente` varchar(10) NOT NULL,
  `Correo_cliente` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`Cli_cod`, `Documento_cliente`, `Nombre_cliente`, `Apellido_cliente`, `Tel_cliente`, `Correo_cliente`) VALUES
(6, '987654321', 'Nombre', 'Apellido', '123456789', 'Correo@mail.com'),
(7, '9638227410', 'nombre2', 'apellido2', '1472583690', 'correo2@mail.com'),
(17, '1073707235', 'Nicolas', 'Agudelo Gómez', '2147483647', 'nicolas.agudelo@uniminuto.edu.co'),
(18, '3213213545', 'marco', 'roble', '32165468', 'marco@gmail.com'),
(19, '3213213545', 'marco', 'roble', '32165468', 'marco@gmail.com'),
(20, '10354687351', 'nombre3', 'apellido3', '3213546546', 'correo4@hotmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `Det_cod` int(2) NOT NULL,
  `Subtotal_detalle` decimal(10,0) NOT NULL,
  `Cantidad_producto` int(11) NOT NULL,
  `Ven_cod` int(2) NOT NULL,
  `Pro_cod` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `Pro_cod` int(2) NOT NULL,
  `Nombre_prod` varchar(30) NOT NULL,
  `Precio_prod` decimal(10,0) NOT NULL,
  `Stock_prod` int(11) NOT NULL,
  `Desc_prod` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`Pro_cod`, `Nombre_prod`, `Precio_prod`, `Stock_prod`, `Desc_prod`) VALUES
(1, 'Camisetas', '35000', 5, 'Camiseta manga caída, estilo oversize, tendencia Street WEAR, excelente calidad, franela licra 97% algodón 3% spandex / disponible en gris claro, negro, blanco, verde militar, rosado, vinotinto, beis , blanco marfil, rojo, terracota ... en tallas XS S M L XL XXL, ( medida de pecho en guía de talla hace referencia al contorno de la prenda a la altura del pecho* )'),
(2, 'Gorras', '25000', 10, 'Gorra Plana Snapback Beisbolera Ny Angeles\r\n\r\n- Materiales: poliéster transpirable\r\n- Diferentes colores (Atención: los colores del producto pueden tener leves variaciones de tono, de acuerdo al lote de material disponible en el mercado a la fecha de compra, gracias.)\r\n- Talla única estándar ajustable de 58 a 64 cm aproximadamente.\r\n- Ajuste en velcro o con hebilla (aleatorio según inventario).\r\n- Cómodas y frescas.'),
(3, 'Jeans', '60000', 8, 'Jeans tiro alto de distintos colores. Confeccionado 70% Algodón,24% Polyester,3% Elastano, 3% Rayón, bolsillos laterales y posteriores funcionales, bota amplia.'),
(5, 'Tenis', '160000', 15, 'Tenis mixto - Running Response Runner U');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `usuario` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `Activación` int(11) NOT NULL DEFAULT 0,
  `Token` varchar(40) NOT NULL,
  `Token_password` varchar(40) DEFAULT NULL,
  `Password_request` int(11) NOT NULL DEFAULT 0,
  `Id_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `usuario`, `password`, `Activación`, `Token`, `Token_password`, `Password_request`, `Id_cliente`) VALUES
(2, 'user', 'password', 0, 'ec30b628245060b67c813402b992d10a', NULL, 0, 6),
(3, 'prueba2', '321*', 0, '39931d2485646ef9084135da5dfc3146', NULL, 0, 7),
(13, 'haruka', '12345', 1, '6c0b84fa438f3ad66c428f42fc5d9bff', NULL, 0, 17),
(14, 'marc', '123', 0, '51de5372582ea041f6f95ac51f78b96a', NULL, 0, 18),
(16, 'prueba3', '123', 0, '4942d7331376e13808a9740214e58f10', NULL, 0, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `Ven_cod` int(11) NOT NULL,
  `Fecha_venta` date NOT NULL,
  `Cantidad_venta` int(11) NOT NULL,
  `Total_venta` decimal(11,0) NOT NULL,
  `Det_cod` int(2) NOT NULL,
  `Cli_cod` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`Adm_cod`),
  ADD UNIQUE KEY `Usu_cod` (`Usu_cod`),
  ADD UNIQUE KEY `Ven_cod` (`Ven_cod`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`Cli_cod`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`Det_cod`),
  ADD UNIQUE KEY `Pro_cod` (`Pro_cod`),
  ADD UNIQUE KEY `Ven_cod` (`Ven_cod`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`Pro_cod`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Usuario` (`usuario`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`Ven_cod`),
  ADD UNIQUE KEY `Det_cod` (`Det_cod`),
  ADD UNIQUE KEY `Cli_cod` (`Cli_cod`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `Cli_cod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `Pro_cod` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
