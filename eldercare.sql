-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 20, 2023 at 05:09 PM
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
  `at` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dinner_times`
--

INSERT INTO `dinner_times` (`id`, `swedish_name`, `english_name`, `at`) VALUES
(1, 'Frukost', 'Breakfast', '09:00'),
(2, 'Lunch', 'Lunch', '12:00'),
(3, 'Middag', 'Dinner', '15:00'),
(4, 'Mellanmål', 'Snack', '18:00'),
(5, 'Kvällsmat', 'Supper', '21:00');

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
(1, 'Smörgås', 'Sandwich', '[1, 2, 4, 5]');

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
(231, 861, 'Parent_of', 871);

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
(3878, 0x11ee5735ad01e9608c69d00299f70b4f, 'KN2zgY23T4BEvFZG', 861, '2023-09-19 21:44:14'),
(3879, 0x11ee5735b80bc2c78c69d00299f70b4f, 'xTsSW0EGScf2Hylw', 861, '2023-09-19 21:44:32'),
(3893, 0x11ee57398878c3878c69d00299f70b4f, 'IV0na9FgVM2jOz30', 861, '2023-09-19 22:11:50'),
(3931, 0x11ee57bea17a6bec8c69d00299f70b4f, 'eJCu81NXWNxYjdQ0', 557, '2023-09-20 14:04:35'),
(3944, 0x11ee57bfaebe002d8c69d00299f70b4f, 'dZWZHjtWqgtTNYPA', 557, '2023-09-20 14:12:07'),
(3945, 0x11ee57bff1a5d9508c69d00299f70b4f, 'iO4LL86OnvEF8DGb', 557, '2023-09-20 14:13:59');

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
(557, 'root', 'Administrator', '%242y%2410%24po7alyPaWFoyJESElc2etOghveTki1lP2A7VeulUOOtvQ9FVQ2VUu', NULL, '2023-09-18 13:08:27', 'Kristoffer', 'Norman', NULL, '0763186703', '011-3-4', NULL, NULL, NULL, NULL, NULL),
(796, 'CoffeeSwed11', 'Guest', '%242y%2410%24PKka3nn4PPcU0wNdZ3KSL.wFN5ABgN3fX9ETm.9yoZvHsCNaW55qO', NULL, '2023-09-19 19:09:25', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(815, 'CoffeeSwed111', 'Patient', '%242y%2410%24epjk7ruZ.kF5B5z9EdSlQuH4AzcFToCdVtubqlS.BRmmji328M142', NULL, '2023-09-19 21:21:31', 'First+Name', 'Last+Name', NULL, '0763186703', '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(861, 'CoffeeSwed1', 'Guest', '%242y%2410%24sOyjkBr3DDjGYgePXBSJn.nkgV%2FTh4zrkUS8r9HV%2FFbB2xeie5FMW', NULL, '2023-09-19 21:42:09', 'First+Name', NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(871, 'CoffeeSwed', 'Patient', '%242y%2410%24MHvf7bvB4tK3nnVEjesUeeku60C%2FLiZgejdbU5hjJWcR8.X%2FUeWAS', NULL, '2023-09-19 22:06:21', 'First+Name', NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(895, 'CoffeeSwed69', 'Patient', '%242y%2410%24xpcQ.dU1mTq%2FA5fkpP4LQuUczMgpfP.ay1d2nGQV4uRUI572vy.Sq', NULL, '2023-09-20 14:08:11', 'Norman', 'Norman', NULL, '069', '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(905, 'Kristoffer', 'Guest', '%242y%2410%24k3NzpB9ztCjGdiUHQiB2eesHwmowZG3o%2FIbBasaAT3BElWQYrClXa', NULL, '2023-09-20 15:59:33', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dinner_times`
--
ALTER TABLE `dinner_times`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `meal_types`
--
ALTER TABLE `meal_types`
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
-- AUTO_INCREMENT for table `meal_types`
--
ALTER TABLE `meal_types`
  MODIFY `id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `relations`
--
ALTER TABLE `relations`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=234;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(32) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3946;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=906;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
