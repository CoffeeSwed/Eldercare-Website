-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 11, 2023 at 03:37 PM
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
-- Table structure for table `relations`
--

CREATE TABLE `relations` (
  `id` int(16) UNSIGNED NOT NULL,
  `person_1` int(16) UNSIGNED NOT NULL,
  `type` enum('Handler_of','Host_of') NOT NULL,
  `person_2` int(16) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(206, 0x11ee4e748922aa118c69d00299f70b4f, 'yCHR9jCW5o1rTvMHCehV', 0, '2023-09-08 18:21:31'),
(207, 0x11ee4e841dc97aab8c69d00299f70b4f, 'qRwyb0G0Bnxp7QyDCMne', 18, '2023-09-08 20:13:03'),
(208, 0x11ee4e8431829f0b8c69d00299f70b4f, 'INzgSZAqku3we79udcpy', 0, '2023-09-08 20:13:36'),
(209, 0x11ee4e843a0b9e288c69d00299f70b4f, 'd3PwOxSftKkkP47f0Zc1', 0, '2023-09-08 20:13:51'),
(210, 0x11ee4e843f9996a58c69d00299f70b4f, 'tu8nabrJtxwYCJfUIP0t', 17, '2023-09-08 20:14:00'),
(211, 0x11ee4e85bf0e76058c69d00299f70b4f, 'yNosjV0GHhXVFQpXWLdb', 17, '2023-09-08 20:24:43'),
(212, 0x11ee4e85c21ead008c69d00299f70b4f, 'kVk3s5mymOJR3xZB9Eec', 17, '2023-09-08 20:24:48'),
(213, 0x11ee4e8815b66ba78c69d00299f70b4f, 'U1LiCoURvi0AORChmFnt', 0, '2023-09-08 20:41:28'),
(214, 0x11ee4e8825d9e0db8c69d00299f70b4f, 'FJ6CHhfDXuxyIeYRHbql', 0, '2023-09-08 20:41:55'),
(215, 0x11ee4e8825fa7b428c69d00299f70b4f, 'gxMIRRZ8GI7F9vMBFZAi', 0, '2023-09-08 20:41:55'),
(216, 0x11ee4e883346a0bd8c69d00299f70b4f, 'EzsPPMXCbaf51QOA3OTc', 17, '2023-09-08 20:42:17');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(16) UNSIGNED NOT NULL,
  `username` text NOT NULL,
  `parent` int(16) UNSIGNED DEFAULT NULL,
  `type` enum('Administrator','Caregiver','Patient','Guest') NOT NULL DEFAULT 'Guest',
  `password` text NOT NULL,
  `pin` text DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `parent`, `type`, `password`, `pin`, `created`) VALUES
(0, 'root', NULL, 'Administrator', '%242y%2410%24j6J7s855Ey2fX7NO.2fbTe7FFPZLhahN6XQ4FxY7tKxlcox8LdtDm', NULL, '2023-09-08 20:07:39'),
(17, 'krisnorm02', NULL, 'Guest', '%242y%2410%24OtTohdKAwYO8RH4kc8xMa.FCJnggVl1Y22Dk6tpVHfpttZJITMF9C', NULL, '2023-09-08 20:06:56');

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(32) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=217;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
