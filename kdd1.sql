-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 31-05-2016 a las 17:11:51
-- Versión del servidor: 10.1.8-MariaDB
-- Versión de PHP: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `kdd1`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administran`
--

CREATE TABLE IF NOT EXISTS `administran` (
  `id_user` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `id_lista` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id_user`,`id_lista`),
  KEY `id_lista` (`id_lista`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etiquetas`
--

CREATE TABLE IF NOT EXISTS `etiquetas` (
  `etiqueta` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`etiqueta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos`
--

CREATE TABLE IF NOT EXISTS `eventos` (
  `id_evento` bigint(20) NOT NULL,
  `nombre_evento` varchar(200) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `fecha_ini_evento` datetime NOT NULL,
  `fecha_fin_evento` datetime NOT NULL,
  `lugar_evento` varchar(200) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `descripcion` longtext CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id_evento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `listas`
--

CREATE TABLE IF NOT EXISTS `listas` (
  `pass_lista` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `nombre` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `nombre_des` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `tipo_lista` int(10) NOT NULL DEFAULT '1' COMMENT '1 publica, 2 contenido privado, 3 privado',
  PRIMARY KEY (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lista_lista`
--

CREATE TABLE IF NOT EXISTS `lista_lista` (
  `id_lista_original` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `id_lista_seguidora` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id_lista_original`,`id_lista_seguidora`),
  KEY `id_lista_seguidora` (`id_lista_seguidora`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pertenencia`
--

CREATE TABLE IF NOT EXISTS `pertenencia` (
  `id_evento` bigint(20) NOT NULL,
  `id_lista` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `pertenece` int(11) NOT NULL COMMENT '0 no, 1 si pertenece',
  PRIMARY KEY (`id_evento`,`id_lista`),
  KEY `id_lista` (`id_lista`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `siguen`
--

CREATE TABLE IF NOT EXISTS `siguen` (
  `id_user` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `id_lista` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `id_etiqueta` varchar(200) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id_user`,`id_lista`,`id_etiqueta`),
  KEY `id_lista` (`id_lista`),
  KEY `id_etiqueta` (`id_etiqueta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `mail` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `nick` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `password` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`nick`),
  KEY `nick` (`nick`),
  KEY `nick_2` (`nick`),
  KEY `nick_3` (`nick`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `van`
--

CREATE TABLE IF NOT EXISTS `van` (
  `id_user` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `id_lista` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `como_van` int(11) NOT NULL COMMENT 'por definir',
  PRIMARY KEY (`id_user`,`id_lista`),
  KEY `id_lista` (`id_lista`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='tabla con evolucion pendiente';

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administran`
--
ALTER TABLE `administran`
  ADD CONSTRAINT `administran_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`nick`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `administran_ibfk_2` FOREIGN KEY (`id_lista`) REFERENCES `listas` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `lista_lista`
--
ALTER TABLE `lista_lista`
  ADD CONSTRAINT `lista_lista_ibfk_1` FOREIGN KEY (`id_lista_original`) REFERENCES `listas` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lista_lista_ibfk_2` FOREIGN KEY (`id_lista_seguidora`) REFERENCES `listas` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pertenencia`
--
ALTER TABLE `pertenencia`
  ADD CONSTRAINT `pertenencia_ibfk_1` FOREIGN KEY (`id_lista`) REFERENCES `listas` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pertenencia_ibfk_2` FOREIGN KEY (`id_evento`) REFERENCES `eventos` (`id_evento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `siguen`
--
ALTER TABLE `siguen`
  ADD CONSTRAINT `siguen_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`nick`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `siguen_ibfk_2` FOREIGN KEY (`id_lista`) REFERENCES `listas` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `siguen_ibfk_3` FOREIGN KEY (`id_etiqueta`) REFERENCES `etiquetas` (`etiqueta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `van`
--
ALTER TABLE `van`
  ADD CONSTRAINT `van_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`nick`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `van_ibfk_2` FOREIGN KEY (`id_lista`) REFERENCES `listas` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
