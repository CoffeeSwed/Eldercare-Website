-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 28, 2023 at 12:00 PM
-- Server version: 10.11.2-MariaDB-1:10.11.2+maria~ubu2204
-- PHP Version: 8.1.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eldercare`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`eldercare`@`%` FUNCTION `UuidFromBin` (`_bin` BINARY(16)) RETURNS BINARY(36) SQL SECURITY INVOKER
RETURN
        LCASE(CONCAT_WS('-',
            HEX(SUBSTR(_bin,  5, 4)),
            HEX(SUBSTR(_bin,  3, 2)),
            HEX(SUBSTR(_bin,  1, 2)),
            HEX(SUBSTR(_bin,  9, 2)),
            HEX(SUBSTR(_bin, 11))
                 ))$$

CREATE DEFINER=`eldercare`@`%` FUNCTION `UuidToBin` (`_uuid` BINARY(36)) RETURNS BINARY(16) SQL SECURITY INVOKER
RETURN UNHEX(CONCAT(
            SUBSTR(_uuid, 15, 4),
            SUBSTR(_uuid, 10, 4),
            SUBSTR(_uuid,  1, 8),
            SUBSTR(_uuid, 20, 4),
            SUBSTR(_uuid, 25) ))$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `dinner_times`
--

CREATE TABLE `dinner_times` (
  `id` int(16) UNSIGNED NOT NULL,
  `swedish_name` text NOT NULL,
  `english_name` text NOT NULL,
  `at` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dinner_times`
--

INSERT INTO `dinner_times` (`id`, `swedish_name`, `english_name`, `at`) VALUES
(1, 'Frukost', 'Breakfast', '09:00:00'),
(2, 'Lunch', 'Lunch', '12:00:00'),
(3, 'Middag', 'Dinner', '18:09:00'),
(4, 'Mellanmål', 'Snack', '18:30:00'),
(5, 'Kvällsmat', 'Supper', '21:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `dinner_times_settings_for_users`
--

CREATE TABLE `dinner_times_settings_for_users` (
  `id` int(16) UNSIGNED NOT NULL,
  `owner` int(16) UNSIGNED NOT NULL,
  `dinner_time` int(16) UNSIGNED NOT NULL,
  `show_note` tinyint(1) NOT NULL DEFAULT 0,
  `show_meal_types` tinyint(1) NOT NULL DEFAULT 1,
  `enabled` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dinner_times_settings_for_users`
--

INSERT INTO `dinner_times_settings_for_users` (`id`, `owner`, `dinner_time`, `show_note`, `show_meal_types`, `enabled`) VALUES
(16, 907, 1, 1, 1, 1),
(17, 1414, 1, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `meal_plan_entry`
--

CREATE TABLE `meal_plan_entry` (
  `id` int(16) UNSIGNED NOT NULL,
  `owner` int(16) UNSIGNED NOT NULL,
  `at` int(16) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `meal_types` text NOT NULL,
  `has_eaten` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meal_plan_entry`
--

INSERT INTO `meal_plan_entry` (`id`, `owner`, `at`, `date`, `meal_types`, `has_eaten`) VALUES
(2047, 907, 1, '2023-09-23', '%5B%224%22%5D', 0),
(2048, 907, 2, '2023-09-23', '%5B%221%22%5D', 0),
(2049, 907, 3, '2023-09-23', '%5B%2214%22%5D', 0),
(2050, 907, 4, '2023-09-23', '%5B%222%22%5D', 0),
(2051, 907, 5, '2023-09-23', '%5B%224%22%5D', 0),
(2052, 907, 1, '2023-09-24', '%5B%224%22%5D', 0),
(2053, 907, 2, '2023-09-24', '%5B%222%22%5D', 0),
(2054, 907, 3, '2023-09-24', '%5B%226%22%5D', 0),
(2055, 907, 4, '2023-09-24', '%5B%223%22%5D', 0),
(2056, 907, 5, '2023-09-24', '%5B%223%22%5D', 0),
(2057, 907, 1, '2023-09-26', '%5B%224%22%5D', 0),
(2058, 907, 2, '2023-09-26', '%5B%222%22%5D', 0),
(2059, 907, 3, '2023-09-26', '%5B%2210%22%5D', 0),
(2060, 907, 4, '2023-09-26', '%5B%223%22%5D', 0),
(2061, 907, 5, '2023-09-26', '%5B%222%22%5D', 0),
(2062, 907, 1, '2023-09-22', '%5B%222%22%5D', 0),
(2063, 907, 2, '2023-09-22', '%5B%222%22%5D', 0),
(2064, 907, 3, '2023-09-22', '%5B%2214%22%5D', 0),
(2065, 907, 4, '2023-09-22', '%5B%222%22%5D', 0),
(2066, 907, 5, '2023-09-22', '%5B%224%22%5D', 0),
(2067, 908, 1, '2023-09-23', '%5B%223%22%5D', 0),
(2068, 908, 2, '2023-09-23', '%5B%221%22%5D', 0),
(2069, 908, 3, '2023-09-23', '%5B%2214%22%5D', 0),
(2070, 908, 4, '2023-09-23', '%5B%222%22%5D', 0),
(2071, 908, 5, '2023-09-23', '%5B%224%22%5D', 0),
(2072, 908, 1, '2023-09-24', '%5B%223%22%5D', 0),
(2073, 908, 2, '2023-09-24', '%5B%221%22%5D', 0),
(2074, 908, 3, '2023-09-24', '%5B%2216%22%5D', 0),
(2075, 908, 4, '2023-09-24', '%5B%223%22%5D', 0),
(2076, 908, 5, '2023-09-24', '%5B%223%22%5D', 0),
(2077, 908, 1, '2023-09-25', '%5B%221%22%5D', 0),
(2078, 908, 2, '2023-09-25', '%5B%223%22%5D', 0),
(2079, 908, 3, '2023-09-25', '%5B%225%22%5D', 0),
(2080, 908, 4, '2023-09-25', '%5B%224%22%5D', 0),
(2081, 908, 5, '2023-09-25', '%5B%221%22%5D', 0),
(2082, 908, 1, '2023-09-26', '%5B%224%22%5D', 0),
(2083, 908, 2, '2023-09-26', '%5B%221%22%5D', 0),
(2084, 908, 3, '2023-09-26', '%5B%2216%22%5D', 0),
(2085, 908, 4, '2023-09-26', '%5B%222%22%5D', 0),
(2086, 908, 5, '2023-09-26', '%5B%221%22%5D', 0),
(2087, 1347, 1, '2023-09-23', '%5B%221%22%5D', 0),
(2088, 1347, 2, '2023-09-23', '%5B%223%22%5D', 0),
(2089, 1347, 3, '2023-09-23', '%5B%227%22%5D', 0),
(2090, 1347, 4, '2023-09-23', '%5B%223%22%5D', 0),
(2091, 1347, 5, '2023-09-23', '%5B%222%22%5D', 0),
(2092, 1350, 1, '2023-09-23', '%5B%223%22%5D', 0),
(2093, 1350, 2, '2023-09-23', '%5B%222%22%5D', 0),
(2094, 1350, 3, '2023-09-23', '%5B%2212%22%5D', 0),
(2095, 1350, 4, '2023-09-23', '%5B%221%22%5D', 0),
(2096, 1350, 5, '2023-09-23', '%5B%222%22%5D', 0),
(2097, 1348, 1, '2023-09-23', '%5B%223%22%5D', 0),
(2098, 1348, 2, '2023-09-23', '%5B%224%22%5D', 0),
(2099, 1348, 3, '2023-09-23', '%5B%226%22%5D', 0),
(2100, 1348, 4, '2023-09-23', '%5B%223%22%5D', 0),
(2101, 1348, 5, '2023-09-23', '%5B%221%22%5D', 0),
(2102, 1349, 1, '2023-09-23', '%5B%224%22%5D', 0),
(2103, 1349, 2, '2023-09-23', '%5B%223%22%5D', 0),
(2104, 1349, 3, '2023-09-23', '%5B%2215%22%5D', 0),
(2105, 1349, 4, '2023-09-23', '%5B%221%22%5D', 0),
(2106, 1349, 5, '2023-09-23', '%5B%224%22%5D', 0),
(2107, 907, 1, '2023-09-25', '%5B%222%22%5D', 0),
(2108, 907, 2, '2023-09-25', '%5B%223%22%5D', 0),
(2109, 907, 3, '2023-09-25', '%5B%228%22%5D', 0),
(2110, 907, 4, '2023-09-25', '%5B%224%22%5D', 0),
(2111, 907, 5, '2023-09-25', '%5B%223%22%5D', 0),
(2112, 1347, 1, '2023-09-24', '%5B%222%22%5D', 0),
(2113, 1347, 2, '2023-09-24', '%5B%224%22%5D', 0),
(2114, 1347, 3, '2023-09-24', '%5B%2210%22%5D', 0),
(2115, 1347, 4, '2023-09-24', '%5B%224%22%5D', 0),
(2116, 1347, 5, '2023-09-24', '%5B%224%22%5D', 0),
(2117, 1350, 1, '2023-09-25', '%5B%223%22%5D', 0),
(2118, 1350, 2, '2023-09-25', '%5B%222%22%5D', 0),
(2119, 1350, 3, '2023-09-25', '%5B%229%22%5D', 0),
(2120, 1350, 4, '2023-09-25', '%5B%222%22%5D', 0),
(2121, 1350, 5, '2023-09-25', '%5B%223%22%5D', 0),
(2122, 1349, 1, '2023-09-25', '%5B%222%22%5D', 0),
(2123, 1349, 2, '2023-09-25', '%5B%222%22%5D', 0),
(2124, 1349, 3, '2023-09-25', '%5B%228%22%5D', 0),
(2125, 1349, 4, '2023-09-25', '%5B%223%22%5D', 0),
(2126, 1349, 5, '2023-09-25', '%5B%223%22%5D', 0),
(2127, 1347, 1, '2023-09-25', '%5B%224%22%5D', 0),
(2128, 1347, 2, '2023-09-25', '%5B%224%22%5D', 0),
(2129, 1347, 3, '2023-09-25', '%5B%2211%22%5D', 0),
(2130, 1347, 4, '2023-09-25', '%5B%221%22%5D', 0),
(2131, 1347, 5, '2023-09-25', '%5B%224%22%5D', 0),
(2132, 907, 1, '2023-09-27', '%5B%224%22%5D', 1),
(2133, 907, 2, '2023-09-27', '%5B%223%22%5D', 1),
(2134, 907, 3, '2023-09-27', '%5B%2211%22%5D', 1),
(2135, 907, 4, '2023-09-27', '%5B%222%22%5D', 1),
(2136, 907, 5, '2023-09-27', '%5B%224%22%5D', 0),
(2137, 907, 1, '2023-09-28', '%5B%224%22%5D', 1),
(2138, 907, 2, '2023-09-28', '%5B%223%22%5D', 1),
(2139, 907, 3, '2023-09-28', '%5B%226%22%5D', 0),
(2140, 907, 4, '2023-09-28', '%5B%224%22%5D', 0),
(2141, 907, 5, '2023-09-28', '%5B%222%22%5D', 0),
(2142, 908, 1, '2023-09-27', '%5B%222%22%5D', 0),
(2143, 908, 2, '2023-09-27', '%5B%223%22%5D', 0),
(2144, 908, 3, '2023-09-27', '%5B%226%22%5D', 0),
(2145, 908, 4, '2023-09-27', '%5B%221%22%5D', 0),
(2146, 908, 5, '2023-09-27', '%5B%221%22%5D', 0),
(2147, 1347, 1, '2023-09-27', '%5B%221%22%5D', 1),
(2148, 1347, 2, '2023-09-27', '%5B%224%22%5D', 1),
(2149, 1347, 3, '2023-09-27', '%5B%226%22%5D', 1),
(2150, 1347, 4, '2023-09-27', '%5B%221%22%5D', 1),
(2151, 1347, 5, '2023-09-27', '%5B%221%22%5D', 0),
(2152, 1350, 1, '2023-09-26', '%5B%222%22%5D', 0),
(2153, 1350, 2, '2023-09-26', '%5B%222%22%5D', 0),
(2154, 1350, 3, '2023-09-26', '%5B%2213%22%5D', 0),
(2155, 1350, 4, '2023-09-26', '%5B%224%22%5D', 0),
(2156, 1350, 5, '2023-09-26', '%5B%222%22%5D', 0),
(2157, 1350, 1, '2023-09-27', '%5B%223%22%5D', 1),
(2158, 1350, 2, '2023-09-27', '%5B%222%22%5D', 0),
(2159, 1350, 3, '2023-09-27', '%5B%2212%22%5D', 0),
(2160, 1350, 4, '2023-09-27', '%5B%224%22%5D', 0),
(2161, 1350, 5, '2023-09-27', '%5B%221%22%5D', 0),
(2162, 1350, 1, '2023-09-28', '%5B%224%22%5D', 0),
(2163, 1350, 2, '2023-09-28', '%5B%222%22%5D', 0),
(2164, 1350, 3, '2023-09-28', '%5B%226%22%5D', 0),
(2165, 1350, 4, '2023-09-28', '%5B%224%22%5D', 0),
(2166, 1350, 5, '2023-09-28', '%5B%221%22%5D', 0),
(2167, 1347, 1, '2023-09-26', '%5B%223%22%5D', 0),
(2168, 1347, 2, '2023-09-26', '%5B%223%22%5D', 0),
(2169, 1347, 3, '2023-09-26', '%5B%226%22%5D', 0),
(2170, 1347, 4, '2023-09-26', '%5B%223%22%5D', 0),
(2171, 1347, 5, '2023-09-26', '%5B%223%22%5D', 0),
(2172, 1348, 1, '2023-09-25', '%5B%221%22%5D', 0),
(2173, 1348, 2, '2023-09-25', '%5B%222%22%5D', 0),
(2174, 1348, 3, '2023-09-25', '%5B%229%22%5D', 0),
(2175, 1348, 4, '2023-09-25', '%5B%223%22%5D', 0),
(2176, 1348, 5, '2023-09-25', '%5B%222%22%5D', 0),
(2177, 1348, 1, '2023-09-26', '%5B%221%22%5D', 0),
(2178, 1348, 2, '2023-09-26', '%5B%222%22%5D', 0),
(2179, 1348, 3, '2023-09-26', '%5B%227%22%5D', 0),
(2180, 1348, 4, '2023-09-26', '%5B%223%22%5D', 0),
(2181, 1348, 5, '2023-09-26', '%5B%221%22%5D', 0),
(2182, 1348, 1, '2023-09-27', '%5B%223%22%5D', 1),
(2183, 1348, 2, '2023-09-27', '%5B%221%22%5D', 1),
(2184, 1348, 3, '2023-09-27', '%5B%225%22%5D', 0),
(2185, 1348, 4, '2023-09-27', '%5B%222%22%5D', 0),
(2186, 1348, 5, '2023-09-27', '%5B%221%22%5D', 0),
(2187, 1348, 1, '2023-09-28', '%5B%223%22%5D', 0),
(2188, 1348, 2, '2023-09-28', '%5B%223%22%5D', 0),
(2189, 1348, 3, '2023-09-28', '%5B%228%22%5D', 0),
(2190, 1348, 4, '2023-09-28', '%5B%223%22%5D', 0),
(2191, 1348, 5, '2023-09-28', '%5B%221%22%5D', 0),
(2192, 1348, 1, '2023-09-29', '%5B%223%22%5D', 0),
(2193, 1348, 2, '2023-09-29', '%5B%224%22%5D', 0),
(2194, 1348, 3, '2023-09-29', '%5B%228%22%5D', 0),
(2195, 1348, 4, '2023-09-29', '%5B%222%22%5D', 0),
(2196, 1348, 5, '2023-09-29', '%5B%222%22%5D', 0),
(2197, 907, 1, '2023-09-29', '%5B%221%22%5D', 1),
(2198, 907, 2, '2023-09-29', '%5B%222%22%5D', 0),
(2199, 907, 3, '2023-09-29', '%5B%227%22%5D', 0),
(2200, 907, 4, '2023-09-29', '%5B%223%22%5D', 0),
(2201, 907, 5, '2023-09-29', '%5B%221%22%5D', 0),
(2202, 1349, 1, '2023-09-27', '%5B%223%22%5D', 1),
(2203, 1349, 2, '2023-09-27', '%5B%223%22%5D', 0),
(2204, 1349, 3, '2023-09-27', '%5B%225%22%5D', 1),
(2205, 1349, 4, '2023-09-27', '%5B%224%22%5D', 1),
(2206, 1349, 5, '2023-09-27', '%5B%222%22%5D', 1),
(2207, 1349, 1, '2023-09-28', '%5B%224%22%5D', 0),
(2208, 1349, 2, '2023-09-28', '%5B%222%22%5D', 0),
(2209, 1349, 3, '2023-09-28', '%5B%226%22%5D', 0),
(2210, 1349, 4, '2023-09-28', '%5B%221%22%5D', 0),
(2211, 1349, 5, '2023-09-28', '%5B%224%22%5D', 0),
(2212, 1350, 1, '2023-09-29', '%5B%224%22%5D', 0),
(2213, 1350, 2, '2023-09-29', '%5B%223%22%5D', 0),
(2214, 1350, 3, '2023-09-29', '%5B%226%22%5D', 0),
(2215, 1350, 4, '2023-09-29', '%5B%223%22%5D', 0),
(2216, 1350, 5, '2023-09-29', '%5B%224%22%5D', 0),
(2217, 907, 1, '2023-09-30', '%5B%224%22%5D', 0),
(2218, 907, 2, '2023-09-30', '%5B%224%22%5D', 0),
(2219, 907, 3, '2023-09-30', '%5B%2211%22%5D', 0),
(2220, 907, 4, '2023-09-30', '%5B%224%22%5D', 0),
(2221, 907, 5, '2023-09-30', '%5B%222%22%5D', 0),
(2227, 1349, 1, '2023-09-26', '%5B%224%22%5D', 0),
(2228, 1349, 2, '2023-09-26', '%5B%224%22%5D', 0),
(2229, 1349, 3, '2023-09-26', '%5B%2213%22%5D', 0),
(2230, 1349, 4, '2023-09-26', '%5B%223%22%5D', 0),
(2231, 1349, 5, '2023-09-26', '%5B%223%22%5D', 0),
(2232, 1363, 1, '2023-09-26', '%5B%223%22%5D', 0),
(2233, 1363, 2, '2023-09-26', '%5B%223%22%5D', 0),
(2234, 1363, 3, '2023-09-26', '%5B%2211%22%5D', 0),
(2235, 1363, 4, '2023-09-26', '%5B%223%22%5D', 0),
(2236, 1363, 5, '2023-09-26', '%5B%223%22%5D', 0),
(2237, 1362, 1, '2023-09-26', '%5B%224%22%5D', 0),
(2238, 1362, 2, '2023-09-26', '%5B%223%22%5D', 0),
(2239, 1362, 3, '2023-09-26', '%5B%2213%22%5D', 0),
(2240, 1362, 4, '2023-09-26', '%5B%223%22%5D', 0),
(2241, 1362, 5, '2023-09-26', '%5B%224%22%5D', 0),
(2242, 1362, 1, '2023-09-27', '%5B%222%22%5D', 0),
(2243, 1362, 2, '2023-09-27', '%5B%223%22%5D', 0),
(2244, 1362, 3, '2023-09-27', '%5B%229%22%5D', 0),
(2245, 1362, 4, '2023-09-27', '%5B%221%22%5D', 0),
(2246, 1362, 5, '2023-09-27', '%5B%224%22%5D', 0),
(2247, 1363, 1, '2023-09-27', '%5B%222%22%5D', 0),
(2248, 1363, 2, '2023-09-27', '%5B%222%22%5D', 0),
(2249, 1363, 3, '2023-09-27', '%5B%225%22%5D', 0),
(2250, 1363, 4, '2023-09-27', '%5B%222%22%5D', 0),
(2251, 1363, 5, '2023-09-27', '%5B%224%22%5D', 0),
(2252, 1347, 1, '2023-09-28', '%5B%222%22%5D', 0),
(2253, 1347, 2, '2023-09-28', '%5B%223%22%5D', 1),
(2254, 1347, 3, '2023-09-28', '%5B%2215%22%5D', 0),
(2255, 1347, 4, '2023-09-28', '%5B%224%22%5D', 0),
(2256, 1347, 5, '2023-09-28', '%5B%223%22%5D', 0),
(2257, 1347, 1, '2023-09-29', '%5B%223%22%5D', 0),
(2258, 1347, 2, '2023-09-29', '%5B%223%22%5D', 0),
(2259, 1347, 3, '2023-09-29', '%5B%226%22%5D', 0),
(2260, 1347, 4, '2023-09-29', '%5B%221%22%5D', 0),
(2261, 1347, 5, '2023-09-29', '%5B%221%22%5D', 0),
(2262, 1348, 1, '2023-09-30', '%5B%223%22%5D', 1),
(2263, 1348, 2, '2023-09-30', '%5B%223%22%5D', 0),
(2264, 1348, 3, '2023-09-30', '%5B%2212%22%5D', 0),
(2265, 1348, 4, '2023-09-30', '%5B%222%22%5D', 0),
(2266, 1348, 5, '2023-09-30', '%5B%221%22%5D', 0),
(2272, 1365, 1, '2023-09-27', '%5B%222%22%5D', 0),
(2273, 1365, 2, '2023-09-27', '%5B%224%22%5D', 0),
(2274, 1365, 3, '2023-09-27', '%5B%2214%22%5D', 0),
(2275, 1365, 4, '2023-09-27', '%5B%222%22%5D', 0),
(2276, 1365, 5, '2023-09-27', '%5B%221%22%5D', 0),
(2277, 1368, 1, '2023-09-27', '%5B%223%22%5D', 0),
(2278, 1368, 2, '2023-09-27', '%5B%223%22%5D', 0),
(2279, 1368, 3, '2023-09-27', '%5B%2215%22%5D', 0),
(2280, 1368, 4, '2023-09-27', '%5B%223%22%5D', 0),
(2281, 1368, 5, '2023-09-27', '%5B%221%22%5D', 0),
(2282, 1368, 1, '2023-09-30', '%5B%221%22%5D', 1),
(2283, 1368, 2, '2023-09-30', '%5B%221%22%5D', 1),
(2284, 1368, 3, '2023-09-30', '%5B%227%22%5D', 0),
(2285, 1368, 4, '2023-09-30', '%5B%222%22%5D', 0),
(2286, 1368, 5, '2023-09-30', '%5B%224%22%5D', 0),
(2297, 557, 1, '2023-09-27', '%5B%221%22%5D', 0),
(2298, 557, 2, '2023-09-27', '%5B%221%22%5D', 0),
(2299, 557, 3, '2023-09-27', '%5B%2213%22%5D', 0),
(2300, 557, 4, '2023-09-27', '%5B%223%22%5D', 0),
(2301, 557, 5, '2023-09-27', '%5B%223%22%5D', 0),
(2307, 557, 1, '2023-09-28', '%5B%221%22%5D', 0),
(2308, 557, 2, '2023-09-28', '%5B%223%22%5D', 0),
(2309, 557, 3, '2023-09-28', '%5B%2214%22%5D', 0),
(2310, 557, 4, '2023-09-28', '%5B%222%22%5D', 0),
(2311, 557, 5, '2023-09-28', '%5B%221%22%5D', 0),
(2312, 1366, 1, '2023-09-27', '%5B%223%22%5D', 0),
(2313, 1366, 2, '2023-09-27', '%5B%222%22%5D', 0),
(2314, 1366, 3, '2023-09-27', '%5B%2213%22%5D', 0),
(2315, 1366, 4, '2023-09-27', '%5B%224%22%5D', 0),
(2316, 1366, 5, '2023-09-27', '%5B%221%22%5D', 0),
(2317, 1364, 1, '2023-09-27', '%5B%222%22%5D', 0),
(2318, 1364, 2, '2023-09-27', '%5B%221%22%5D', 0),
(2319, 1364, 3, '2023-09-27', '%5B%2211%22%5D', 0),
(2320, 1364, 4, '2023-09-27', '%5B%221%22%5D', 0),
(2321, 1364, 5, '2023-09-27', '%5B%221%22%5D', 0),
(2327, 908, 1, '2023-09-28', '%5B%221%22%5D', 0),
(2328, 908, 2, '2023-09-28', '%5B%222%22%5D', 0),
(2329, 908, 3, '2023-09-28', '%5B%227%22%5D', 0),
(2330, 908, 4, '2023-09-28', '%5B%222%22%5D', 0),
(2331, 908, 5, '2023-09-28', '%5B%222%22%5D', 0),
(2332, 1362, 1, '2023-09-28', '%5B%221%22%5D', 0),
(2333, 1362, 2, '2023-09-28', '%5B%223%22%5D', 0),
(2334, 1362, 3, '2023-09-28', '%5B%2215%22%5D', 0),
(2335, 1362, 4, '2023-09-28', '%5B%224%22%5D', 0),
(2336, 1362, 5, '2023-09-28', '%5B%224%22%5D', 0),
(2337, 1373, 1, '2023-09-28', '%5B%224%22%5D', 1),
(2338, 1373, 2, '2023-09-28', '%5B%224%22%5D', 0),
(2339, 1373, 3, '2023-09-28', '%5B%2214%22%5D', 0),
(2340, 1373, 4, '2023-09-28', '%5B%221%22%5D', 0),
(2341, 1373, 5, '2023-09-28', '%5B%221%22%5D', 0),
(2542, 1367, 1, '2023-09-28', '%5B%222%22%5D', 0),
(2543, 1367, 2, '2023-09-28', '%5B%223%22%5D', 0),
(2544, 1367, 3, '2023-09-28', '%5B%226%22%5D', 0),
(2545, 1367, 4, '2023-09-28', '%5B%223%22%5D', 0),
(2546, 1367, 5, '2023-09-28', '%5B%223%22%5D', 0),
(2547, 1414, 1, '2023-09-28', '%5B%224%22%5D', 0),
(2548, 1414, 2, '2023-09-28', '%5B%221%22%5D', 0),
(2549, 1414, 3, '2023-09-28', '%5B%2210%22%5D', 0),
(2550, 1414, 4, '2023-09-28', '%5B%221%22%5D', 0),
(2551, 1414, 5, '2023-09-28', '%5B%224%22%5D', 0);

-- --------------------------------------------------------

--
-- Table structure for table `meal_types`
--

CREATE TABLE `meal_types` (
  `id` int(16) NOT NULL,
  `swedish_name` text NOT NULL,
  `english_name` text NOT NULL,
  `available_at` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meal_types`
--

INSERT INTO `meal_types` (`id`, `swedish_name`, `english_name`, `available_at`) VALUES
(1, 'Smörgås', 'Sandwich', '[1,2,4,5]'),
(2, 'Gröt', 'Oatmeal', '[1,2,4,5]'),
(3, 'Yoghurt', 'Yoghurt', '[1,2,4,5]'),
(4, 'Smoothie av jordgubb eller choklad', 'Smoothie', '[1,2,4,5]'),
(5, 'Pannkakor', 'Pancakes', '[3]'),
(6, 'Våfflor', 'Waffles', '[3]'),
(7, 'Potatismos med köttbullar ', 'Meatballs with mashed potatoes ', '[3]'),
(8, 'Raggmunk med fläsk och lingon', 'Raggmunk with pork and lingonberries', '[3]'),
(9, 'Ärtsoppa med pannkakor', 'Pea soup with pancakes', '[3]'),
(10, 'Kåldolmar', 'Cabbage dumplings', '[3]'),
(11, 'Palt eller kroppkakor', 'Palt or body cakes', '[3]'),
(12, 'Raggmunk med fläsk och lingon', 'Raggmunk with pork and lingonberries', '[3]'),
(13, 'Falukorv med stuvade makaroner', 'Falu sausage with stewed macaroni', '[3]'),
(14, 'Blodpudding med lingon', 'Blood pudding with lingonberries', '[3]'),
(15, 'Pyttipanna', 'Hash', '[3]'),
(16, 'Pannbiff med löksås', 'Pan steak with onion sauce', '[3]');

-- --------------------------------------------------------

--
-- Table structure for table `notes_for_dinner_times`
--

CREATE TABLE `notes_for_dinner_times` (
  `id` int(16) UNSIGNED NOT NULL,
  `dinner_time` int(16) UNSIGNED NOT NULL,
  `owner` int(16) UNSIGNED NOT NULL,
  `note` text DEFAULT '\'\''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notes_for_dinner_times`
--

INSERT INTO `notes_for_dinner_times` (`id`, `dinner_time`, `owner`, `note`) VALUES
(1, 2, 557, 'Dinner should be served god dam cold');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `name` varchar(256) NOT NULL,
  `allowed` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`name`, `allowed`) VALUES
('allow_Administrator_add_parent_to_all', 1),
('allow_Administrator_browse_info_of_all', 1),
('allow_Administrator_create_all', 1),
('allow_Administrator_delete_all', 1),
('allow_Administrator_delete_parent_to_all', 1),
('allow_Administrator_edit_meal_state_of_all', 1),
('allow_Administrator_edit_meal_state_of_Caregiver', 0),
('allow_Administrator_edit_meal_state_of_handled_all', 0),
('allow_Administrator_edit_meal_state_of_handled_Caregiver', 0),
('allow_Administrator_edit_meal_state_of_self', 0),
('allow_Administrator_get_meal_plan_of_all', 1),
('allow_Administrator_get_meal_plan_of_Guest', 0),
('allow_Administrator_get_meal_plan_of_handled_all', 0),
('allow_Administrator_get_meal_plan_of_handled_Guest', 0),
('allow_Administrator_list_matching_users_', 0),
('allow_Administrator_list_matching_users_all', 1),
('allow_Administrator_list_matching_users_Guest', 0),
('allow_Administrator_list_matching_users_handled_', 0),
('allow_Administrator_list_matching_users_handled_all', 0),
('allow_Administrator_list_matching_users_handled_Guest', 0),
('allow_Administrator_list_matching_users_self', 0),
('allow_Administrator_set_note_all', 0),
('allow_Administrator_set_note_handled_all', 0),
('allow_Administrator_set_note_handled_Patient', 0),
('allow_Administrator_set_note_Patient', 1),
('allow_Administrator_set_note_self', 1),
('allow_Caregiver_add_parent_to_all', 1),
('allow_Caregiver_browse_info_of_all', 1),
('allow_Caregiver_browse_info_of_handled_all', 1),
('allow_Caregiver_browse_info_of_handled_Patient', 0),
('allow_Caregiver_browse_info_of_Patient', 0),
('allow_Caregiver_browse_info_of_self', 0),
('allow_Caregiver_create_all', 1),
('allow_Caregiver_create_Caregiver', 1),
('allow_Caregiver_create_Guest', 1),
('allow_Caregiver_create_handled_all', 0),
('allow_Caregiver_create_handled_Caregiver', 0),
('allow_Caregiver_create_Patient', 1),
('allow_Caregiver_create_self', 0),
('allow_Caregiver_delete_all', 0),
('allow_Caregiver_delete_handled_all', 0),
('allow_Caregiver_delete_handled_Patient', 0),
('allow_Caregiver_delete_parent_to_all', 1),
('allow_Caregiver_delete_Patient', 1),
('allow_Caregiver_delete_self', 0),
('allow_Caregiver_edit_meal_state_of_all', 1),
('allow_Caregiver_edit_meal_state_of_Caregiver', 0),
('allow_Caregiver_edit_meal_state_of_handled_all', 0),
('allow_Caregiver_edit_meal_state_of_handled_Caregiver', 0),
('allow_Caregiver_edit_meal_state_of_self', 1),
('allow_Caregiver_get_meal_plan_of_all', 1),
('allow_Caregiver_list_matching_users_all', 1),
('allow_Caregiver_set_note_all', 0),
('allow_Caregiver_set_note_handled_all', 1),
('allow_Caregiver_set_note_handled_Patient', 0),
('allow_Caregiver_set_note_Patient', 1),
('allow_Caregiver_set_note_self', 0),
('allow_Caregiver_set_setting_', 0),
('allow_Caregiver_set_setting_all', 0),
('allow_Caregiver_set_setting_handled_all', 0),
('allow_Caregiver_set_setting_handled_Patient', 0),
('allow_Caregiver_set_setting_Patient', 1),
('allow_Caregiver_set_setting_self', 1),
('allow_Guest_create_all', 0),
('allow_Guest_create_Guest', 0),
('allow_Guest_create_handled_all', 0),
('allow_Guest_create_handled_Guest', 0),
('allow_Guest_create_self', 0),
('allow_Guest_get_meal_plan_of_all', 0),
('allow_Guest_get_meal_plan_of_Guest', 0),
('allow_Guest_get_meal_plan_of_handled_all', 0),
('allow_Guest_get_meal_plan_of_handled_Guest', 0),
('allow_Guest_get_meal_plan_of_self', 0),
('allow_Guest_list_matching_users_all', 0),
('allow_Guest_list_matching_users_Guest', 0),
('allow_Guest_list_matching_users_handled_all', 0),
('allow_Guest_list_matching_users_handled_Guest', 0),
('allow_Guest_list_matching_users_self', 0),
('allow_null_create_all', 0),
('allow_null_create_Caregiver', 0),
('allow_null_create_handled_all', 0),
('allow_null_create_handled_Caregiver', 0),
('allow_null_create_handled_Moron', 0),
('allow_null_create_handled_Patient', 0),
('allow_null_create_Moron', 0),
('allow_null_create_Patient', 0),
('allow_null_create_self', 0),
('allow_null_get_meal_plan_of_Administrator', 0),
('allow_null_get_meal_plan_of_all', 0),
('allow_null_get_meal_plan_of_handled_Administrator', 0),
('allow_null_get_meal_plan_of_handled_all', 0),
('allow_null_get_meal_plan_of_handled_Patient', 0),
('allow_null_get_meal_plan_of_Patient', 0),
('allow_null_get_meal_plan_of_self', 0),
('allow_null_list_matching_users_', 0),
('allow_null_list_matching_users_Administrator', 0),
('allow_null_list_matching_users_all', 0),
('allow_null_list_matching_users_Caregiver', 0),
('allow_null_list_matching_users_handled_', 0),
('allow_null_list_matching_users_handled_Administrator', 0),
('allow_null_list_matching_users_handled_all', 0),
('allow_null_list_matching_users_handled_Caregiver', 0),
('allow_null_list_matching_users_self', 0),
('allow_null_set_note_all', 0),
('allow_null_set_note_handled_all', 0),
('allow_null_set_note_handled_Patient', 0),
('allow_null_set_note_Patient', 0),
('allow_null_set_note_self', 0),
('allow_Patient_browse_info_of_Administrator', 0),
('allow_Patient_browse_info_of_all', 1),
('allow_Patient_browse_info_of_handled_Administrator', 0),
('allow_Patient_browse_info_of_handled_all', 0),
('allow_Patient_browse_info_of_self', 1),
('allow_Patient_edit_meal_state_of_all', 1),
('allow_Patient_edit_meal_state_of_Caregiver', 0),
('allow_Patient_edit_meal_state_of_handled_all', 0),
('allow_Patient_edit_meal_state_of_handled_Caregiver', 0),
('allow_Patient_edit_meal_state_of_self', 1),
('allow_Patient_get_meal_plan_of_all', 0),
('allow_Patient_get_meal_plan_of_Caregiver', 0),
('allow_Patient_get_meal_plan_of_handled_all', 0),
('allow_Patient_get_meal_plan_of_handled_Caregiver', 0),
('allow_Patient_get_meal_plan_of_Patient', 0),
('allow_Patient_get_meal_plan_of_self', 1),
('allow_type_Administrator_create_Guest', 1),
('test_permission', 1);

-- --------------------------------------------------------

--
-- Table structure for table `relations`
--

CREATE TABLE `relations` (
  `id` int(16) UNSIGNED NOT NULL,
  `person_1` int(16) UNSIGNED NOT NULL,
  `type` enum('Parent_of') NOT NULL,
  `person_2` int(16) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `relations`
--

INSERT INTO `relations` (`id`, `person_1`, `type`, `person_2`) VALUES
(236, 908, 'Parent_of', 907),
(237, 907, 'Parent_of', 557),
(238, 908, 'Parent_of', 1347),
(239, 908, 'Parent_of', 1348),
(240, 908, 'Parent_of', 1349),
(241, 908, 'Parent_of', 1350),
(242, 557, 'Parent_of', 1360),
(243, 908, 'Parent_of', 1361),
(244, 908, 'Parent_of', 1362),
(245, 908, 'Parent_of', 1363),
(246, 908, 'Parent_of', 1364),
(247, 908, 'Parent_of', 1365),
(248, 908, 'Parent_of', 1366),
(249, 908, 'Parent_of', 1367),
(250, 908, 'Parent_of', 1368),
(251, 908, 'Parent_of', 1373);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` int(32) UNSIGNED NOT NULL,
  `session` binary(16) NOT NULL,
  `pass` text NOT NULL,
  `owner` int(16) UNSIGNED NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `session`, `pass`, `owner`, `created`) VALUES
(3354, 0x11ee56214066cd4a8c69d00299f70b4f, '8RVU9fJ1t5xs052F', 534, '2023-09-18 12:45:30'),
(3355, 0x11ee56217e42733b8c69d00299f70b4f, 'nVlFQrDTkgMLKX7j', 534, '2023-09-18 12:47:14'),
(3368, 0x11ee5623353bce728c69d00299f70b4f, 'Qc2qUABbwP2H2unr', 546, '2023-09-18 12:59:31'),
(3430, 0x11ee5625b4f0defd8c69d00299f70b4f, 'PKHsfkW4bYYXhIxE', 594, '2023-09-18 13:17:24'),
(4286, 0x11ee59222be3172c8c69d00299f70b4f, 'rTF1uPz0Eah3w0AF', 1292, '2023-09-22 08:29:39'),
(4554, 0x11ee5b9dac66874e8c69d00299f70b4f, 'I0JTkb1PvztovhjL', 906, '2023-09-25 12:18:45'),
(4560, 0x11ee5ba3683e60578c69d00299f70b4f, 'PDbOTT1Am06eoYNA', 906, '2023-09-25 12:59:48'),
(4653, 0x11ee5c95df9e956a8c69d00299f70b4f, 'jBToCCz6ZwpSTCVs', 909, '2023-09-26 17:55:26'),
(4707, 0x11ee5d1536e30fb28c69d00299f70b4f, 'd9uJW34t1KMOe6r1', 906, '2023-09-27 09:06:59'),
(4842, 0x11ee5d70254b967d8c69d00299f70b4f, 'A92TlfwWrF5ijLxn', 557, '2023-09-27 19:57:53'),
(4845, 0x11ee5dc09e9b16398c69d00299f70b4f, '1oe5UCbPaE9qtAEz', 909, '2023-09-28 05:33:57'),
(4852, 0x11ee5dd44c29f6f48c69d00299f70b4f, 'G13YB9kE1SCsALQp', 1373, '2023-09-28 07:54:48'),
(4860, 0x11ee5de0e46c6ad68c69d00299f70b4f, 'DYwrcLU3AZeuPxn0', 557, '2023-09-28 09:24:58'),
(4865, 0x11ee5de5bded78be8c69d00299f70b4f, '2PCV5DBrC61MxtbL', 557, '2023-09-28 09:59:41'),
(4867, 0x11ee5de69c0f62d28c69d00299f70b4f, 'VKVNKWgppfe2J0eL', 907, '2023-09-28 10:05:53'),
(4869, 0x11ee5de89a8738f58c69d00299f70b4f, 'CiZbUHbQ1pSZg7W6', 907, '2023-09-28 10:20:10'),
(4873, 0x11ee5df3501f70a88c69d00299f70b4f, 'LpGh5pcR0GB2k9d5', 907, '2023-09-28 11:36:49'),
(4877, 0x11ee5df52e6a449a8c69d00299f70b4f, 'efecYzAb5jCARz1t', 908, '2023-09-28 11:50:12'),
(4878, 0x11ee5df5621312ca8c69d00299f70b4f, 'C5xtj2gDubqbssl2', 908, '2023-09-28 11:51:38'),
(4879, 0x11ee5df5da0b2c9b8c69d00299f70b4f, 'DWEUknUFjkro4NQo', 908, '2023-09-28 11:55:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(16) UNSIGNED NOT NULL,
  `username` text NOT NULL,
  `type` enum('Administrator','Caregiver','Patient','Guest') NOT NULL DEFAULT 'Guest',
  `password` text NOT NULL,
  `pin` text DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `first_name` text DEFAULT NULL,
  `last_name` text DEFAULT NULL,
  `email` text DEFAULT NULL,
  `contact_number` text DEFAULT NULL,
  `date_of_birth` text DEFAULT NULL,
  `address_country` text DEFAULT NULL,
  `address_city` text DEFAULT NULL,
  `address_street_and_house` text DEFAULT NULL,
  `address_postcode` text DEFAULT NULL,
  `preferences` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `type`, `password`, `pin`, `created`, `first_name`, `last_name`, `email`, `contact_number`, `date_of_birth`, `address_country`, `address_city`, `address_street_and_house`, `address_postcode`, `preferences`) VALUES
(557, 'root', 'Administrator', '%242y%2410%24po7alyPaWFoyJESElc2etOghveTki1lP2A7VeulUOOtvQ9FVQ2VUu', NULL, '2023-09-18 13:08:27', 'Kristoffer', 'Norman', NULL, '0763186703', '2011-3-4', NULL, NULL, NULL, NULL, NULL),
(906, 'Guest', 'Guest', '%242y%2410%24g6YCTj97yBWB3JGpkKlMbetRNgW8A.MGFJpyJtKsSNXyeSE8Ty7xK', NULL, '2023-09-21 10:16:14', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(907, 'Patient', 'Patient', '%242y%2410%24tiZF4T0kKm9BRNVVARIQZuPk7yehbkjihHz.6Yt3F1Vgj.qgrEMLG', NULL, '2023-09-21 10:16:21', 'Kerstin', 'Demente', NULL, NULL, '1904-01-01', NULL, NULL, NULL, NULL, NULL),
(908, 'Caregiver', 'Caregiver', '%242y%2410%24L7Fscfn%2Fb1LFPAeVuUckM.TMxuCePKqfhl2WsIP%2FOV0AKjBl8LFrC', NULL, '2023-09-21 10:16:28', 'Karin', 'Burncock', NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(909, 'Administrator', 'Administrator', '%242y%2410%24AO1gGvy97duMO.bkvtzbt.8NDcOyl1Aii9Wq.ugts7mFSQRg45rbe', NULL, '2023-09-21 10:16:36', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(1288, 'swe', 'Guest', '%242y%2410%24boaKuHPViRuF%2FpyouY3bDuauCJvwH3qhhoGyEgK4xivzjR%2F5c%2F1Ka', NULL, '2023-09-21 19:18:48', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(1289, 'swea', 'Guest', '%242y%2410%242stAt58KZrq40SMwt7o2ceUeiRUXVj6bPGWmjxTyAtcYexmPZ6ljO', NULL, '2023-09-21 19:19:05', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(1290, 'sweaa', 'Guest', '%242y%2410%24HCtM82qXu9fw77uk88MCJOuZHwT08rlTR4Xa3b%2F8BXfrTORqDefoK', NULL, '2023-09-21 19:20:07', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(1292, 'Kers', 'Guest', '%242y%2410%24V7rXWnKC1A202FeGMJdYxeiL%2FO8EEduaUktqyR0rVKm2aU.cpqQRq', NULL, '2023-09-22 08:29:05', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(1347, 'Patient1', 'Patient', '%242y%2410%24Xlml%2FbO9watmlwuMKpgoCeFR5YnZTOx4kYmUNxnGTwFbEl8If3EdW', NULL, '2023-09-22 23:57:11', 'Klara', 'Färdiga', NULL, NULL, '1942-08-4', NULL, NULL, NULL, NULL, NULL),
(1348, 'Patient2', 'Patient', '%242y%2410%24CVxZDB7w%2FwEeaZ5GCSpyqOTjQJya0E53S1xp1IVRRmLlSA6%2FRcyAq', NULL, '2023-09-22 23:57:14', 'Stefan', 'Surström', NULL, NULL, '1969-6-9', NULL, NULL, NULL, NULL, NULL),
(1349, 'Patient3', 'Patient', '%242y%2410%24%2FgMXOpCXmac85N99PqFlTOliZ4bF3Kt0DlXU1FGBuyI%2FoV.CQvtAm', NULL, '2023-09-22 23:57:16', 'Jeg', 'LikerBuller', NULL, NULL, '1964-08-8', NULL, NULL, NULL, NULL, NULL),
(1350, 'Patient4', 'Patient', '%242y%2410%24tcnJ%2F9r%2FJDg5DD5NMuiVje4HZ4cCTEsXKg2M1v1T.hDZgGGT3MA2.', NULL, '2023-09-22 23:57:18', 'Karlsson', 'Taket', NULL, NULL, '1938-03-03', NULL, NULL, NULL, NULL, NULL),
(1351, 'test', 'Patient', '%242y%2410%24.iaIFJiTTFp7ZNqXH.dLH.BxWGW81Rr8uCp.fhUN4TYij1ZJ54iIm', NULL, '2023-09-26 17:56:05', 'test', 'test', NULL, NULL, '1980-7-7', NULL, NULL, NULL, NULL, NULL),
(1352, 'test1', 'Patient', '%242y%2410%24eF5D30drttO8XFIfoLLiHu4S2x4qaCy0Je1jmfJx6b.i1rYyryPKK', NULL, '2023-09-26 18:05:09', 'test', 'test', NULL, NULL, '1980-7-7', NULL, NULL, NULL, NULL, NULL),
(1362, 'Kristoffer+Norman', 'Patient', '%242y%2410%24vm3XPPmyZ%2FRECsKCgPuHueZZM%2FDnyH9rhIZKSGMiZ%2FMrVOEpKLW%2FO', NULL, '2023-09-26 21:58:55', 'Kristoffer', 'Norman', NULL, NULL, '2001-3-4', NULL, NULL, NULL, NULL, NULL),
(1363, 'Karl', 'Patient', '%242y%2410%24fy97z4uSzqJgwkYkdKhZguc6HC4M78IWTvUBe.gXGdpBq%2F1CfpSbi', NULL, '2023-09-26 22:02:23', 'Karl', 'Okreative', NULL, NULL, '1809-7-11', NULL, NULL, NULL, NULL, NULL),
(1364, 'cool1', 'Patient', '%242y%2410%2488m6JuCmBIxGfiyDn5AGFuJ6EFQeVn%2FU.5CtOFP68qhe%2FeIV7khGC', NULL, '2023-09-27 09:59:32', 'cool1', 'cool1', NULL, NULL, '1912-6-17', NULL, NULL, NULL, NULL, NULL),
(1365, 'johab', 'Patient', '%242y%2410%24cyMlvKQglAPGHbPFwIXeT.vSHuqsPh0cU3VZRjnQSbEdpSOG2%2FVtS', NULL, '2023-09-27 10:19:58', 'Johan', 'Norman', NULL, NULL, '1836-10-28', NULL, NULL, NULL, NULL, NULL),
(1366, 'krille', 'Patient', '%242y%2410%24yQ446s7GGa0cc.Pb1yRCfupyJe.JxPabeaYz2ONBW1O55hhWLrEtO', NULL, '2023-09-27 10:23:02', 'krille', 'andersson', NULL, NULL, '1806-6-5', NULL, NULL, NULL, NULL, NULL),
(1367, 'cool6', 'Patient', '%242y%2410%24K1EfERUIAt7VCZF.NBBpCei6wzTLA45fITwt.Wg8KdlBVBw80klf6', NULL, '2023-09-27 13:37:01', 'cool6', 'cool6', NULL, NULL, '1912-7-16', NULL, NULL, NULL, NULL, NULL),
(1368, 'cool7', 'Patient', '%242y%2410%24dNRTzgLWZTZvckghDRA1g.HyDCGjRA6AUhuzC30tsJJt8aKSBVaUy', NULL, '2023-09-27 13:58:28', 'cool7', 'cool7', NULL, NULL, '1912-8-16', NULL, NULL, NULL, NULL, NULL),
(1373, 'coffee', 'Patient', '%242y%2410%241hsft4oSahzKBzwEqTRINeHvdlMUEvA5LXYQGVz0RGATKIHax4leq', NULL, '2023-09-28 07:51:07', 'Kristoffer', 'Norman', NULL, NULL, '2001-3-4', NULL, NULL, NULL, NULL, NULL),
(1414, 'Kristoffer', 'Guest', '%242y%2410%243yZLO5hLj9xsufLaD7p4muGpKLRtqTtl80oHzGYi7EA9ikwIb%2Fhlm', NULL, '2023-09-28 11:59:02', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dinner_times`
--
ALTER TABLE `dinner_times`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dinner_times_settings_for_users`
--
ALTER TABLE `dinner_times_settings_for_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `meal_plan_entry`
--
ALTER TABLE `meal_plan_entry`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `meal_types`
--
ALTER TABLE `meal_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notes_for_dinner_times`
--
ALTER TABLE `notes_for_dinner_times`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `relations`
--
ALTER TABLE `relations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dinner_times`
--
ALTER TABLE `dinner_times`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `dinner_times_settings_for_users`
--
ALTER TABLE `dinner_times_settings_for_users`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `meal_plan_entry`
--
ALTER TABLE `meal_plan_entry`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2552;

--
-- AUTO_INCREMENT for table `meal_types`
--
ALTER TABLE `meal_types`
  MODIFY `id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `notes_for_dinner_times`
--
ALTER TABLE `notes_for_dinner_times`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `relations`
--
ALTER TABLE `relations`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=252;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(32) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4880;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1415;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
