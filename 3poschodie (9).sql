-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hostiteľ: 127.0.0.1
-- Čas generovania: Št 17.Sep 2026, 12:21
-- Verzia serveru: 10.4.32-MariaDB
-- Verzia PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáza: `3poschodie`
--

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `devices`
--

CREATE TABLE `devices` (
  `id` int(11) NOT NULL,
  `floor` int(11) NOT NULL,
  `room` varchar(10) NOT NULL,
  `teacher` varchar(100) NOT NULL,
  `device_type` varchar(50) NOT NULL,
  `model` varchar(100) DEFAULT NULL,
  `cpu` varchar(100) DEFAULT NULL,
  `gpu` varchar(100) DEFAULT NULL,
  `ram` varchar(50) DEFAULT NULL,
  `disk` varchar(100) DEFAULT NULL,
  `os` varchar(100) DEFAULT NULL,
  `count` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `devices_floor3`
--

CREATE TABLE `devices_floor3` (
  `id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `device_type` varchar(100) NOT NULL,
  `model` varchar(150) DEFAULT NULL,
  `cpu` varchar(150) DEFAULT NULL,
  `ram` varchar(50) DEFAULT NULL,
  `storage` varchar(100) DEFAULT NULL,
  `gpu` varchar(100) DEFAULT NULL,
  `os` varchar(100) DEFAULT NULL,
  `count` int(11) DEFAULT 1,
  `status` varchar(50) DEFAULT 'funkčné',
  `note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sťahujem dáta pre tabuľku `devices_floor3`
--

INSERT INTO `devices_floor3` (`id`, `room_id`, `device_type`, `model`, `cpu`, `ram`, `storage`, `gpu`, `os`, `count`, `status`, `note`, `created_at`, `updated_by`) VALUES
(1, 1, 'Notebook', 'Lenovo Legion Y540-17IRH PG0', 'Intel Core i5-9300H', '16 GB DDR4', '512 GB SSD NVMe', 'NVIDIA GTX 1650 4GB', 'Windows 11 Home', 14, 'funkčné', 'Žiacke notebooky', '2025-11-05 07:51:13', 'admin'),
(2, 1, 'Dataprojektor', 'Epson EB-W06', '', '', '', '', '', 1, 'funkčné', 'Dataprojektor\r\n', '2025-11-05 07:51:13', ''),
(3, 1, '3D tlačiareň', 'Bambu Lab A1', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(4, 2, 'Notebook', 'Lenovo B590', 'Intel Core i3-3110M 2.4GHz', '4 GB DDR3', '500 GB HDD', 'Intel HD Graphics 4000', 'Windows 10 Pro', 11, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(5, 2, 'Dataprojektor', 'Vivitek D7', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(6, 3, 'PC', 'Lenovo B50', 'Intel Pentium 3558U', '8 GB DDR3', '120 GB SSD', 'Intel HD Graphics', 'Windows 10 Pro', 15, 'funkčné', 'Žiacke počítače', '2025-11-05 07:51:13', 'admin'),
(7, 3, 'Dataprojektor', 'BenQ MP610', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(8, 3, '3D tlačiareň', 'Elegoo Neptune 4 Pro', '', '', '', '', '', 1, 'funkčné', '', '2025-11-05 07:51:13', NULL),
(9, 4, 'Notebook', 'Lenovo IdeaPad B590', 'Intel Pentium 2030M', '8 GB DDR3', '240 GB SSD', 'NVIDIA GeForce 610M', 'Windows 10 Pro', 15, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(10, 4, 'Dataprojektor', 'Vivitek D795WT', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(11, 5, 'Notebook', 'Acer TravelMate IP', 'AMD Ryzen 5 PRO 4650U', '8 GB DDR4', '512 GB SSD NVMe', 'Radeon Graphics', 'Windows 10 Pro', 15, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(12, 5, 'Dataprojektor', 'Vivitek', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(13, 6, 'Notebook', 'Acer TravelMate P215-41', 'AMD Ryzen 5 PRO 4650U', '8 GB DDR4', '932 GB HDD + 238 GB SSD', 'Radeon Graphics', 'Windows 10 Education', 15, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(14, 6, 'Dataprojektor', 'Epson EB-455Wi', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(15, 7, 'Notebook', 'Lenovo Pentium 4405U', 'Intel Pentium 4405U', '8 GB DDR4', '233 GB SSD', 'Intel HD 510', 'Windows 11', 15, 'funkčné', '', '2025-11-05 07:51:13', 'admin'),
(16, 7, 'Tlačiareň', 'Lexmark e120n', '', '', '', '', '', 1, 'funkčné', '', '2025-11-05 07:51:13', NULL),
(17, 8, 'Notebook', 'Lenovo IdeaPad 5 15IILL05', 'Intel Core i5-1035G1', '8 GB DDR4', '512 GB SSD', 'Intel UHD G1', 'Windows 11', 6, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(18, 8, 'Notebook', 'Acer Aspire 3 A315-23', 'AMD Ryzen 5 3500U', '8 GB DDR4', '477 GB SSD', 'Radeon Vega Mobile', 'Windows 11', 6, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(20, 8, '3D tlačiareň', 'Bambu Lab A1', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(21, 9, 'Notebook', 'Lenovo Z50-70', 'Intel Core i3-4030U', '4 GB DDR3L', '1 TB HDD', 'Intel HD 4600', 'Windows 10 Pro', 5, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(22, 9, 'Dataprojektor', 'Epson EB-435W', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(23, 9, 'Tlačiareň', 'LaserJet 1600', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(24, 10, 'Notebook', 'Lenovo ThinkPad E490', 'AMD Ryzen 5 3500U', '8 GB DDR4', '1 TB SSD+HDD', 'Radeon Vega', 'Windows 11 Pro', 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(25, 10, 'Dataprojektor', 'Epson EB-X7', '', '', '', '', '', 1, 'funkčné', '', '2025-11-05 07:51:13', NULL),
(26, 11, 'PC', 'Lenovo ThinkCentre', 'Intel Pentium G4560', '8 GB DDR4', '500 GB HDD + 120 GB SSD', 'Intel HD 610', 'Windows 10 Pro', 8, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(27, 11, 'Notebook', 'Lenovo Z50-70', 'Intel Core i3-4030U', '4 GB DDR3L', '1 TB HDD', 'Intel HD 4600', 'Windows 10 Pro', 2, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(28, 11, 'Dataprojektor', 'BenQ W1070', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(29, 11, 'TV', 'Panasonic TX-P50X10Y', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(30, 12, 'Notebook', 'Acer TravelMate P2', 'AMD Ryzen 5 PRO 4650U', '8 GB DDR4', '239 GB SSD + 932 GB HDD', 'Radeon Graphics', 'Windows 10 Pro', 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(31, 12, 'Dataprojektor', 'Panasonic PT-LB80', '', '', '', '', '', 1, 'funkčné', '', '2025-11-05 07:51:13', 'test'),
(32, 3, 'Monitor', 'Dell 21.5\"', NULL, NULL, NULL, NULL, NULL, 15, 'funkčné', 'Žiacke monitory', '2025-11-05 07:51:13', NULL),
(33, 3, 'Monitor', 'Samsung S22C300B', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', 'Učiteľský monitor', '2025-11-05 07:51:13', NULL),
(34, 3, 'Monitor', 'Dell 200V4LAB/00', NULL, NULL, NULL, NULL, NULL, 2, 'funkčné', 'Žiacke monitory', '2025-11-05 07:51:13', NULL),
(35, 3, 'Router', 'TP-Link Archer C6', '', '', '', '', '', 1, 'funkčné', '', '2025-11-05 07:51:13', NULL),
(36, 3, '3D tlačiareň', 'Elegoo Neptune 4 Pro', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(37, 4, 'Monitor', 'Samsung S22C300B', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', 'Učiteľský monitor', '2025-11-05 07:51:13', NULL),
(38, 5, 'Switch', 'Cisco Catalyst 2960', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(39, 5, 'Router', 'Linksys WRT160NL', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(40, 6, 'Monitor', 'Dell U2715Hc', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', 'Učiteľský monitor', '2025-11-05 07:51:13', NULL),
(41, 6, '3D tlačiareň', 'Bambu Lab A1', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(42, 6, 'Switch', 'Cisco Catalyst 3750-X', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(43, 7, 'Monitor', 'Philips 223V5LSV/00', '', '', '', '', '', 1, 'funkčné', 'Učiteľský monitor', '2025-11-05 07:51:13', 'test'),
(44, 7, 'Switch', 'TP-Link JetStream T1500G-10MPS', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(45, 8, 'Switch', 'Cisco Catalyst 3750-X', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(46, 8, 'Dataprojektor', 'BenQ TH685P', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(47, 8, 'Monitor', 'Philips 221V8', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', 'Učiteľský monitor', '2025-11-05 07:51:13', NULL),
(48, 9, 'Switch', 'Linksys SRW224G4', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(49, 10, 'Monitor', 'Dell P2214H', '', '', '', '', '', 3, 'Funkčné', 'Učiteľský monitor', '2025-11-05 07:51:13', 'Marek'),
(50, 11, 'Monitor', 'Dell P2214H', NULL, NULL, NULL, NULL, NULL, 8, 'funkčné', 'Žiacke monitory', '2025-11-05 07:51:13', NULL),
(51, 12, 'Switch', 'Cisco WS-C3750X-48P-S', NULL, NULL, NULL, NULL, NULL, 2, 'funkčné', 'Nepoužívané', '2025-11-05 07:51:13', NULL),
(52, 12, 'Router', 'TP-Link Archer AX55 WiFi 6', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(53, 12, 'TV', 'Panasonic TX-P50X10Y', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(54, 12, 'Dataprojektor', 'Panasonic PT-LB80', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2025-11-05 07:51:13', NULL),
(82, 37, 'Notebook', 'Lenovo ThinkPad TP00094F', 'Ryzen 5 3500U', '8GB', '1TB HDD', 'Vega 8', 'Windows 11', 1, 'funkčné', '', '2026-02-15 10:55:59', 'admin'),
(83, 37, 'Dataprojektor', 'BenQ MX704', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(84, 38, 'Notebook', 'Acer TravelMate P215-41', 'Ryzen 5 PRO 4650U', '8GB', '932GB HDD + 238GB SSD', 'Radeon', 'Win 10 Education', 1, 'Funkčné', '', '2026-02-15 10:55:59', 'admin'),
(85, 38, 'Dataprojektor', 'BenQ TH585', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(86, 38, 'Tlačiareň', 'Xerox Phaser 3020', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(87, 39, 'Notebook', 'Acer TravelMate P215-41', 'Ryzen 5 PRO 4650U', '8GB', 'SSD+HDD', 'Radeon', 'Windows 10 Education', 1, 'Funkčné', '', '2026-02-15 10:55:59', 'admin'),
(88, 39, 'Dataprojektor', 'BenQ TH585', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(89, 40, 'Notebook', 'Lenovo B50-70', 'Pentium 3558U', '16GB', '233GB SSD', 'Intel HD', 'Windows 10', 1, 'Funkčné', '', '2026-02-15 10:55:59', 'admin'),
(90, 40, 'Dataprojektor', 'Epson EB-X7', '', '', '', '', '', 1, 'funkčné', '', '2026-02-15 10:55:59', 'test'),
(91, 41, 'Notebook', 'Lenovo IdeaPad S145', 'Ryzen 3 3200U', '8GB', '256GB SSD', 'Vega 3', 'Windows 10 Home', 1, 'Funkčné', '', '2026-02-15 10:55:59', 'admin'),
(92, 41, 'Dataprojektor', 'Epson EH-TW5210', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(93, 42, 'Notebook', 'Lenovo B50-70', 'Pentium 3558U', '16GB', '233GB SSD', 'Intel HD', 'Windows 10', 1, 'funkčné', '', '2026-02-15 10:55:59', 'admin'),
(94, 42, 'Dataprojektor', 'Epson EB-S9', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(95, 43, 'Notebook', 'Lenovo ThinkPad T530', 'Core i5-2520M', '4GB', '320GB SSD', 'Intel HD', 'Windows 10', 1, 'funkčné', '', '2026-02-15 10:55:59', 'admin'),
(96, 43, 'Dataprojektor', 'Epson EB-W41', '', '', '', '', '', 1, 'funkčné', '', '2026-02-15 10:55:59', 'test'),
(97, 44, 'Notebook', 'Lenovo IdeaPad G510', 'i3-4000M', '4GB', '1TB HDD', 'GT 820M', 'Windows 10', 1, 'funkčné', '', '2026-02-15 10:55:59', 'admin'),
(98, 44, 'Dataprojektor', 'Epson EB-X72', '', '', '', '', '', 1, 'funkčné', '', '2026-02-15 10:55:59', 'test'),
(99, 45, 'Notebook', 'Neznámy model', 'Core 2030M', '4GB', '224GB SSD', 'GT 610M', 'Windows 10', 1, 'funkčné', '', '2026-02-15 10:55:59', 'admin'),
(100, 45, 'Dataprojektor', 'Vivitek D755WTi', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(101, 45, 'Audio', 'FrontRow To Go', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(102, 46, 'Notebook', 'ASUS TUF505 (Študentské)', 'Ryzen 5 3550H', '8GB', '477GB SSD', 'RX 560X', 'Windows 10', 15, 'funkčné', '', '2026-02-15 10:55:59', 'admin'),
(103, 46, 'Notebook', 'Lenovo B50-70 (Učiteľ)', 'Pentium 3558U', '4GB', '233GB SSD', 'Intel HD', 'Windows 10', 1, 'funkčné', '', '2026-02-15 10:55:59', 'admin'),
(104, 46, 'Dataprojektor', 'Vivitek DW770UST', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(105, 46, 'Monitor', 'Samsung 943NW', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(106, 46, 'Switch', 'TP-Link TL-SF1016 (16-port)', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(107, 46, 'Switch', 'ZyXEL GS1900-24E (Smart)', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(108, 47, 'Notebook', 'Lenovo B50-80', 'Radeon R5', '4GB', '500GB HDD', 'Intel HD', 'Windows 8.1', 1, 'funkčné', '', '2026-02-15 10:55:59', 'admin'),
(109, 47, 'Dataprojektor', 'BenQ TH585', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(110, 47, 'Monitor', 'HP L1900w', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(111, 48, 'Notebook', 'Acer TravelMate', 'Ryzen 5 PRO 4650U', '8GB', 'SSD+HDD', 'Radeon R5', 'Windows 10', 1, 'funkčné', '', '2026-02-15 10:55:59', 'admin'),
(112, 48, 'Dataprojektor', 'BenQ TH585', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-15 10:55:59', NULL),
(113, 57, 'Notebook', 'Lenovo B590', 'i3-3110M', '8 GB DDR3', '1 TB HDD', 'Intel HD Graphics', 'Windows 10', 1, 'funkčné', NULL, '2026-02-17 09:08:03', NULL),
(114, 57, 'Dataprojektor', 'Epson EB-X7 LCD', '', '', '', '', '', 1, 'funkčné', '', '2026-02-17 09:08:03', 'test'),
(115, 58, 'Notebook', 'ASUS X75V', 'i3-3120M', '4GB DDR3', '224 GB SSD', 'GT 720M / HD 4000', 'Windows 10 Home', 1, 'funkčné', NULL, '2026-02-17 09:08:03', NULL),
(116, 58, 'Dataprojektor', 'BenQ TH685P', '', '', '', '', '', 1, 'funkčné', '', '2026-02-17 09:08:03', 'test'),
(117, 59, 'Notebook', 'Lenovo ThinkPad E495', 'AMD Ryzen 5 3500U', '8GB DDR3', '1TB HDD + 256GB SSD', 'AMD Radeon(TM) Vega 8', 'Windows 10', 1, 'Funkčné', '', '2026-02-17 09:08:03', 'admin'),
(118, 59, 'Dataprojektor', 'Epson EH-TW5200', '', '', '', '', '', 1, 'funkčné', '', '2026-02-17 09:08:03', 'test'),
(119, 60, 'Notebook', 'Lenovo ThinkPad E495', 'Ryzen 5 3500U', '8GB DDR', '1.14 TB', 'Radeon Vega 8', 'Windows 11 Pro', 1, 'funkčné', NULL, '2026-02-17 09:08:03', NULL),
(120, 60, 'Dataprojektor', 'Epson EH-TW5200', '', '', '', '', '', 1, 'funkčné', '', '2026-02-17 09:08:03', 'test'),
(121, 60, 'Tlačiareň', 'WorkCentre 3025', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:08:03', NULL),
(122, 61, 'Notebook', 'Acer TravelMate P214-41', 'Ryzen 5 PRO 4650U', '8GB DDR4', '1.14 TB (SSD+HDD)', 'Radeon Graphics', 'Windows 11 Pro Education', 1, 'Funkčné', '', '2026-02-17 09:08:03', 'admin'),
(123, 61, 'Dataprojektor', 'BenQ TH685P', '', '', '', '', '', 1, 'funkčné', '', '2026-02-17 09:08:03', 'test'),
(124, 61, 'Monitor', 'DELL P2425H', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:08:03', NULL),
(125, 62, 'Notebook', 'Lenovo ThinkPad X230', 'i5-3320M', '4GB DDR3', '320GB HDD', 'HD Graphics 4000', 'Windows 10 Education', 1, 'Funkčné', '', '2026-02-17 09:08:03', 'admin'),
(126, 62, 'Dataprojektor', 'Epson PowerLite S9', '', '', '', '', '', 1, 'funkčné', '', '2026-02-17 09:08:03', 'test'),
(127, 62, 'Tlačiareň', 'HP LaserJet 1020', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:08:03', NULL),
(128, 63, 'All-in-One', 'Acer Aspire C24-1650', 'i5-1135G7', '8GB DDR4', '256GB SSD + 1TB HDD', 'Iris Xe Graphics', 'Windows 11 Home', 16, 'funkčné', NULL, '2026-02-17 09:08:03', NULL),
(129, 63, 'Dataprojektor', 'BenQ TH685P', '', '', '', '', '', 1, 'funkčné', '', '2026-02-17 09:08:03', 'test'),
(130, 63, 'Switch', 'SR224G', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:08:03', NULL),
(131, 64, 'Notebook', 'Acer TravelMate P215-41', 'Ryzen 5 PRO 4650U', '8GB DDR4', '128GB SSD + 1TB HDD', 'Radeon Graphics', 'Windows 11 Pro', 15, 'funkčné', NULL, '2026-02-17 09:08:03', NULL),
(132, 64, 'Dataprojektor', 'BenQ / Epson S9', '', '', '', '', '', 1, 'funkčné', '', '2026-02-17 09:08:03', 'test'),
(133, 64, 'Monitor', 'Philips 200V4LAB', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:08:03', NULL),
(155, 60, 'Tlačiareň', 'WorkCentre 3025', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:09:53', NULL),
(157, 62, 'Tlačiareň', 'HP LaserJet 1020', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:09:53', NULL),
(158, 63, 'Switch', 'SR224G', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:09:53', NULL),
(159, 63, 'Dataprojektor', 'BenQ TH685P', '', '', '', '', '', 1, 'funkčné', '', '2026-02-17 09:09:53', 'test'),
(160, 64, 'Monitor', 'Philips 200V4LAB', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:09:53', NULL),
(161, 64, 'Tlačiareň', 'HP LaserJet 1020', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:09:53', NULL),
(162, 64, 'Dataprojektor', 'Epson PowerLite S9 / BenQ', '', '', '', '', '', 1, 'funkčné', '', '2026-02-17 09:09:53', 'test'),
(163, 67, 'Tlačiareň', 'HP Color LaserJet CP3525n', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:10:34', NULL),
(164, 67, 'Dataprojektor', 'BenQ TH685P', '', '', '', '', '', 1, 'funkčné', '', '2026-02-17 09:10:34', 'test'),
(165, 68, 'Switch', 'Linksys SR224G', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:10:34', NULL),
(166, 68, 'Tlačiareň', 'Lexmark X862de 3', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:10:34', NULL),
(167, 69, 'Tlačiareň', 'OfficeEdge Pro4000', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:10:34', NULL),
(168, 70, 'Dataprojektor', 'BenQ TH685P', '', '', '', '', '', 1, 'funkčné', '', '2026-02-17 09:10:34', 'test'),
(169, 70, 'Router', 'TP-Link Archer AX23', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:10:34', NULL),
(170, 71, 'Notebook', 'Lenovo B50-70', 'Pentium 3558U', '8GB DDR3', '1TB HDD', 'Intel HD', 'Windows 10 Pro', 1, 'Funkčné', '', '2026-02-17 09:10:34', 'admin'),
(171, 71, 'Dataprojektor', 'Hitachi CP-BX301WN', '', '', '', '', '', 1, 'funkčné', '', '2026-02-17 09:10:34', 'test'),
(172, 71, 'Tlačiareň', 'HP LaserJet P1102w', NULL, NULL, NULL, NULL, NULL, 1, 'funkčné', NULL, '2026-02-17 09:10:34', NULL),
(173, 72, 'Notebook', 'Lenovo B50-70', 'Pentium 3558U', '8GB DDR3', '1TB HDD', 'Intel HD', 'Windows 10 Pro', 1, 'funkčné', NULL, '2026-02-17 09:10:34', NULL),
(174, 72, 'Dataprojektor', 'Vivitek D555', '', '', '', '', '', 1, 'funkčné', '', '2026-02-17 09:10:34', 'test'),
(175, 73, 'Dataprojektor', 'Vivitek D755WT', '', '', '', '', '', 1, 'Funkčné', '', '2026-02-18 07:28:33', 'admin'),
(176, 73, 'Switch', 'Cisco Catalyst 3750X', '', '', '', '', '', 1, 'funkčné', '', '2026-02-18 07:28:33', 'admin'),
(177, 73, 'Notebook', 'Lenovo ThinkBook 15 G3 ACL', 'AMD Ryzen 5 5500U', '8GB DDR4', 'SSD 256 GB', 'AMD Radeon(TM) Graphics', 'Windows 11 Pro', 1, 'funkčné', 'učiteľský', '2026-02-18 07:28:33', 'admin'),
(178, 73, 'Notebook', 'LENOVO B50-70', 'Intel(R) Pentium(R) 3558U', '4GB DDR3', '1TB HDD', 'Intel(R) HD Graphics', 'Windows 10 Pro', 14, 'Funkčné', 'žiacke', '2026-02-18 07:28:33', 'admin'),
(179, 70, 'Notebook', 'Acer TravelMate P215-41', 'AMD Ryzen 5 PRO 4650U', '8GB DDR4', '238 SSD', 'AMD Radeon(TM) Graphics', 'Windows 11 Pro Education', 1, 'Funkčné', '', '2026-02-18 07:28:33', 'admin'),
(180, 66, 'Switch', 'Linksys LGS108', '', '', '', '', '', 1, 'funkčné', '', '2026-02-18 07:28:33', 'admin'),
(181, 66, 'Router', 'TP-Link Archer C6 AC1200', '', '', '', '', '', 1, 'funkčné', '', '2026-02-18 07:28:33', 'admin'),
(182, 66, 'Notebook', 'Lenovo V15 ADA', 'AMD Ryzen 5 PRO 4650U', '8GB DDR4', '238 SSD', 'AMD Radeon(TM) Graphics', 'Windows 10 Pro', 1, 'funkčné', '', '2026-02-18 07:28:33', 'admin'),
(183, 65, 'Dataprojektor', 'BenQ TH685P', '', '', '', '', '', 1, 'funkčné', '', '2026-02-18 07:28:33', 'admin'),
(184, 65, 'Router', 'TP-Link Archer C20 AC750', '', '', '', '', '', 1, 'funkčné', '', '2026-02-18 07:28:33', 'admin'),
(185, 65, 'Notebook', 'Acer TravelMate P215-41', 'AMD Ryzen 5 PRO 4650U', '8GB DDR4', '238 SSD', 'AMD Radeon(TM) Graphics', 'Windows 10 Pro Education', 1, 'funkčné', '', '2026-02-18 07:28:33', 'admin'),
(186, 69, 'Router', 'TP-Link Archer AX1800', '', '', '', '', '', 1, 'funkčné', '', '2026-02-18 07:32:51', 'admin'),
(187, 69, 'Dataprojektor', 'BenQ TH685P', '', '', '', '', '', 1, 'funkčné', '', '2026-02-18 07:32:51', 'admin'),
(188, 69, 'Notebook', 'Acer TravelMate P215-41', 'AMD Ryzen 5 PRO 4650U', '8GB DDR4', '238 SSD', 'AMD Radeon(TM) Graphics', 'Windows 11 Pro Education', 1, 'Funkčné', '', '2026-02-18 07:32:51', 'test'),
(193, 7, 'Dataprojektor', 'BenQ TH685P', '', '', '', '', '', 1, 'Funkčné', '', '2026-04-19 08:26:24', 'admin'),
(194, 4, 'Notebook', 'Lenovo ThinkPad B590', 'Intel Pentium 2030M', '8GB DDR3', 'Patriot Burst Elite 240 GB SSD', 'VIDIA GeForce 610M + Intel HD Graphics', 'Windows 10 Pro', 15, 'Funkčné', 'Žiacke notebooky', '2026-04-19 08:33:30', 'admin'),
(195, 11, 'PC', 'Lenovo ThinkCentre Small Form Factor', 'Intel Pentium G4560', '8 GB DDR4', '500 GB HDD + 120 GB SSD', 'Intel HD Graphics 610', 'Windows 10 Pro', 8, 'Funkčné', 'Žiacke notebooky', '2026-04-19 08:50:39', 'admin');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `rooms_floor3`
--

CREATE TABLE `rooms_floor3` (
  `id` int(11) NOT NULL,
  `room_number` varchar(10) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `floor` int(11) DEFAULT 3,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sťahujem dáta pre tabuľku `rooms_floor3`
--

INSERT INTO `rooms_floor3` (`id`, `room_number`, `teacher_id`, `floor`, `note`) VALUES
(1, '302', 1, 3, 'Legion Y540, 3D tlačiareň Bambu Lab A1, projektor Epson EB-W06'),
(2, '303', 2, 3, '11x Lenovo B590, projektor Vivitek D7'),
(3, '305', 3, 3, 'Lenovo B50, 3D tlačiareň Elegoo Neptune 4 Pro, projektor BenQ MP610'),
(4, '306', 4, 3, '15x Lenovo B590, projektor Vivitek D795WT'),
(5, '309', 5, 3, '15x Acer TravelMate IP, Cisco Catalyst 2960, projektor Vivitek'),
(6, '310', 6, 3, '15x Acer TravelMate IP P215-41, Telepresence 1000, projektor Epson EB-455Wi'),
(7, '311', 7, 3, '15x Lenovo Pentium, Lexmark e120n, TP-Link JetStream T1500G'),
(8, '313', 8, 3, '6x Lenovo IdeaPad 5, 6x Acer Aspire 3, 3D tlačiareň Bambu Lab A1, projektor BenQ TH685P'),
(9, '314', 9, 3, '5x Lenovo Z50-70, projektor Epson EB-435W, tlačiareň LaserJet 1600'),
(10, '315', 10, 3, 'Lenovo ThinkPad E490, projektor Epson EB-X7'),
(11, '316', 11, 3, '8x Lenovo ThinkCentre, 3x notebooky Lenovo Z50-70, BenQ W1070, TV Panasonic TX-P50X10Y'),
(12, '317', 12, 3, 'Acer TravelMate P2, projektor Panasonic PT-LB80'),
(37, '218', 16, 2, NULL),
(38, '214', 17, 2, NULL),
(39, '216', 18, 2, NULL),
(40, '215', 19, 2, NULL),
(41, '212', 20, 2, NULL),
(42, '220', 21, 2, NULL),
(43, '211', 22, 2, NULL),
(44, '202', 23, 2, NULL),
(45, '210', 24, 2, NULL),
(46, '208', 25, 2, NULL),
(47, '206', 26, 2, NULL),
(48, '203', 27, 2, NULL),
(57, '109', 28, 1, NULL),
(58, '108', 29, 1, NULL),
(59, '107', 30, 1, NULL),
(60, '106', 31, 1, NULL),
(61, '104', 32, 1, NULL),
(62, '102', 33, 1, NULL),
(63, '114', 34, 1, NULL),
(64, '124', 35, 1, NULL),
(65, '017', 36, 0, NULL),
(66, '016', 37, 0, NULL),
(67, '015', 38, 0, NULL),
(68, '013', 39, 0, NULL),
(69, '012', 40, 0, NULL),
(70, '011', 41, 0, NULL),
(71, '006', 42, 0, NULL),
(72, '021', 43, 0, NULL),
(73, '023', 44, 0, NULL),
(83, '023', 44, 0, NULL),
(84, '011', 41, 0, NULL),
(85, '016', 37, 0, NULL),
(86, '017', 36, 0, NULL),
(87, '023', 44, 0, NULL),
(88, '011', 41, 0, NULL),
(89, '016', 37, 0, NULL),
(90, '017', 36, 0, NULL),
(91, '012', 40, 0, NULL),
(92, '308', 5, 3, NULL);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `teachers`
--

CREATE TABLE `teachers` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sťahujem dáta pre tabuľku `teachers`
--

INSERT INTO `teachers` (`id`, `full_name`, `title`, `email`) VALUES
(1, 'Marcel Takáč', NULL, NULL),
(2, 'Lukáš Zmuda', 'Mgr.', NULL),
(3, 'Ľubomír Gedra', NULL, NULL),
(4, 'Pavol Balint', 'Ing.', NULL),
(5, 'Katarína Zmudová', 'MHR', NULL),
(6, 'Marcela Timková', 'Ing.', NULL),
(7, 'Martina Šantová', 'Ing.', NULL),
(8, 'Ľubomír Cmorej', NULL, NULL),
(9, 'Peter Krištof', 'Ing.', NULL),
(10, 'Marek Štofa', 'Ing.', NULL),
(11, 'Jana Chudá', 'Mgr.', NULL),
(12, 'Ľudovít Repko', NULL, NULL),
(13, '-- Nepriradené / Prázdna --', NULL, NULL),
(14, 'Mgr. Nový Učiteľ 1', NULL, NULL),
(15, 'Ing. Nový Učiteľ 2', NULL, NULL),
(16, 'Marián Drančák', NULL, NULL),
(17, 'Ivan Švajlen', NULL, NULL),
(18, 'Adriana Hudákova', NULL, NULL),
(19, 'Zuzana Sobotková', NULL, NULL),
(20, 'Diana Kačalová', NULL, NULL),
(21, 'Veronika Mereiderová', NULL, NULL),
(22, 'Ivana Dragonová', NULL, NULL),
(23, 'Štefan Ružbašan', NULL, NULL),
(24, 'Natalia Jakabová', NULL, NULL),
(25, 'Antónia Danková', NULL, NULL),
(26, 'Alena Havrilová', NULL, NULL),
(27, 'Natalia Bátorová', NULL, NULL),
(28, 'Eva Zumerová', NULL, NULL),
(29, 'Jana Hanesová', NULL, NULL),
(30, 'Kristína Kardošová', NULL, NULL),
(31, 'Zuzana Romcová', NULL, NULL),
(32, 'Rastislav Fedorčák', NULL, NULL),
(33, 'Gabriela Dydňanská', NULL, NULL),
(34, 'Aleš Chovanec', NULL, NULL),
(35, 'Anna Kapová', NULL, NULL),
(36, 'Mariana Tobisová', NULL, NULL),
(37, 'Peter Tokoš', NULL, NULL),
(38, 'Nicol Haško', NULL, NULL),
(39, 'Ivana Tokošová', NULL, NULL),
(40, 'Tobiáš Sedlák', NULL, NULL),
(41, 'Emília Bolčová', NULL, NULL),
(42, 'Antónia Švidová', NULL, NULL),
(43, 'Lenka Trebunová', NULL, NULL),
(44, 'Viera Kovačová', NULL, NULL);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sťahujem dáta pre tabuľku `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `created_at`) VALUES
(1, 'admin', '0192023a7bbd73250516f069df18b500', 'admin', '2025-11-05 07:44:55'),
(6, 'pouzivatel', '09a389d06be2a0d071e1ff4c2d3f1591', 'user', '2025-11-08 20:08:01'),
(8, 'test', '098f6bcd4621d373cade4e832627b4f6', 'user', '2026-04-15 06:56:00'),
(12, 'Marek', 'e061c9aea5026301e7b3ff09e9aca2cf', 'admin', '2026-04-21 07:47:03');

--
-- Kľúče pre exportované tabuľky
--

--
-- Indexy pre tabuľku `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `devices_floor3`
--
ALTER TABLE `devices_floor3`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexy pre tabuľku `rooms_floor3`
--
ALTER TABLE `rooms_floor3`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_id` (`teacher_id`);

--
-- Indexy pre tabuľku `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT pre exportované tabuľky
--

--
-- AUTO_INCREMENT pre tabuľku `devices`
--
ALTER TABLE `devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `devices_floor3`
--
ALTER TABLE `devices_floor3`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=202;

--
-- AUTO_INCREMENT pre tabuľku `rooms_floor3`
--
ALTER TABLE `rooms_floor3`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT pre tabuľku `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT pre tabuľku `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Obmedzenie pre exportované tabuľky
--

--
-- Obmedzenie pre tabuľku `devices_floor3`
--
ALTER TABLE `devices_floor3`
  ADD CONSTRAINT `devices_floor3_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms_floor3` (`id`);

--
-- Obmedzenie pre tabuľku `rooms_floor3`
--
ALTER TABLE `rooms_floor3`
  ADD CONSTRAINT `rooms_floor3_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
