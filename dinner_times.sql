-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 20, 2023 at 05:27 PM
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

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dinner_times`
--
ALTER TABLE `dinner_times`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dinner_times`
--
ALTER TABLE `dinner_times`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
