-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-05-2023 a las 03:54:55
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
-- Base de datos: `flask_jwt`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE PROCEDURE `sp_addUser` (IN `pUsername` VARCHAR(20), IN `pPassword` VARCHAR(20), IN `pFullname` VARCHAR(50))  BEGIN
    INSERT INTO user (username, password, fullname)
    VALUES (pUsername, AES_ENCRYPT(pPassword, SHA2('B!1w8*NAt1T^%kvhUI*S^_', 512)), pFullname);
END$$

CREATE PROCEDURE `sp_listLanguages` ()  BEGIN
	SELECT LAN.id, LAN.name 
    FROM language LAN 
    ORDER BY LAN.name ASC;
END$$

CREATE PROCEDURE `sp_verifyIdentity` (IN `pUsername` VARCHAR(20), IN `pPassword` VARCHAR(20))  BEGIN
	SELECT USER.id, USER.username, USER.fullname 
	FROM user USER 
    WHERE 1 = 1 
    AND USER.username = pUsername 
	AND CAST(AES_DECRYPT(USER.password, SHA2('B!1w8*NAt1T^%kvhUI*S^_', 512)) AS CHAR(30)) = pPassword;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `language`
--

CREATE TABLE `language` (
  `id` tinyint(2) UNSIGNED NOT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Store the languages data.';

--
-- Volcado de datos para la tabla `language`
--

INSERT INTO `language` (`id`, `name`) VALUES
(1, 'Python'),
(2, 'Java'),
(3, 'C#'),
(4, 'PHP'),
(5, 'JavaScript'),
(6, 'Kotlin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` smallint(3) UNSIGNED NOT NULL,
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `password` blob NOT NULL,
  `fullname` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Stores the user''s data.';

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `fullname`) VALUES
(1, 'USKOKRUM', 0x98fb67ca8f459f49841208bd4261bceb, 'Oscar García');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `language`
--
ALTER TABLE `language`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `language`
--
ALTER TABLE `language`
  MODIFY `id` tinyint(2) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` smallint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
