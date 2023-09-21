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
(4, 'Smoothie', 'Smoothie', '[1,2,4,5]'),
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

--
-- Indexes for dumped tables
--

--
-- Indexes for table `meal_types`
--
ALTER TABLE `meal_types`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `meal_types`
--
ALTER TABLE `meal_types`
  MODIFY `id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
