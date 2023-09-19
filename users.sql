-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 11, 2023 at 05:50 PM
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
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `first_name` text DEFAULT NULL,
  `last_name` text DEFAULT NULL,
  `contact_number` text DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `address_country` text DEFAULT NULL,
  `address_city` text DEFAULT NULL,
  `address_street_and_house` text NOT NULL,
  `address_postcode` text NOT NULL,
  `preferences` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `parent`, `type`, `password`, `pin`, `created`, `first_name`, `last_name`, `contact_number`, `date_of_birth`, `address_country`, `address_city`, `address_street_and_house`, `address_postcode`, `preferences`) VALUES
(0, 'root', NULL, 'Administrator', '%242y%2410%24j6J7s855Ey2fX7NO.2fbTe7FFPZLhahN6XQ4FxY7tKxlcox8LdtDm', NULL, '2023-09-08 20:07:39', NULL, NULL, NULL, NULL, '', NULL, '', '', NULL),
(39, 'krisnorm05', NULL, 'Guest', '%242y%2410%24ZSedBELAKaThIgGJU4oxo.JlI9mxr9nbRKG2S3of3kdLlnNEcANPy', NULL, '2023-09-11 17:21:44', 'Anders', 'Norman', NULL, NULL, '', NULL, '', '', NULL),
(40, 'krisnorm02', NULL, 'Guest', '%242y%2410%24bh1D3R9%2F2VXv7HLsHNQAg.l4uGlz%2F5IVKXQW%2FxEJyX2G.v8htqgdu', NULL, '2023-09-11 17:25:46', 'Kristoffer', 'Norman', NULL, NULL, '', NULL, '', '', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
