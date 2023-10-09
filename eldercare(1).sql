-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 05, 2023 at 04:01 PM
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
(3, 'Middag', 'Dinner', '18:00:00'),
(4, 'Mellanmål', 'Snack', '19:30:00'),
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
(16, 907, 1, 1, 0, 1),
(19, 907, 2, 0, 1, 0),
(20, 1350, 1, 0, 1, 0),
(21, 1350, 2, 0, 1, 0),
(22, 1350, 3, 0, 1, 0),
(23, 1350, 4, 0, 1, 0),
(24, 1350, 5, 0, 1, 1),
(74, 1474, 1, 1, 0, 0);

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
(2996, 907, 1, '2023-10-03', '%5B%221%22%5D', 1),
(2997, 907, 3, '2023-10-03', '%5B%225%22%5D', 1),
(2998, 907, 4, '2023-10-03', '%5B%222%22%5D', 0),
(2999, 907, 5, '2023-10-03', '%5B%224%22%5D', 0),
(3000, 907, 1, '2023-10-04', '%5B%223%22%5D', 0),
(3001, 907, 3, '2023-10-04', '%5B%225%22%5D', 0),
(3002, 907, 5, '2023-10-04', '%5B%222%22%5D', 0),
(3003, 907, 4, '2023-10-04', '%5B%224%22%5D', 0),
(3004, 907, 1, '2023-10-05', '%5B%223%22%5D', 1),
(3005, 907, 3, '2023-10-05', '%5B%228%22%5D', 1),
(3006, 907, 4, '2023-10-05', '%5B%221%22%5D', 1),
(3007, 907, 5, '2023-10-05', '%5B%221%22%5D', 1),
(3008, 1347, 1, '2023-10-02', '%5B%223%22%5D', 0),
(3009, 1347, 2, '2023-10-02', '%5B%221%22%5D', 0),
(3010, 1348, 1, '2023-10-02', '%5B%222%22%5D', 0),
(3011, 1347, 3, '2023-10-02', '%5B%2214%22%5D', 0),
(3012, 907, 1, '2023-10-02', '%5B%223%22%5D', 0),
(3013, 1348, 2, '2023-10-02', '%5B%224%22%5D', 0),
(3014, 1347, 4, '2023-10-02', '%5B%222%22%5D', 0),
(3015, 907, 3, '2023-10-02', '%5B%2214%22%5D', 0),
(3016, 1348, 3, '2023-10-02', '%5B%2212%22%5D', 0),
(3017, 1347, 5, '2023-10-02', '%5B%221%22%5D', 0),
(3018, 907, 4, '2023-10-02', '%5B%224%22%5D', 0),
(3019, 907, 5, '2023-10-02', '%5B%222%22%5D', 1),
(3020, 1348, 4, '2023-10-02', '%5B%222%22%5D', 0),
(3021, 1348, 5, '2023-10-02', '%5B%222%22%5D', 0),
(3022, 1349, 1, '2023-10-02', '%5B%223%22%5D', 0),
(3023, 1349, 2, '2023-10-02', '%5B%221%22%5D', 0),
(3024, 1349, 3, '2023-10-02', '%5B%225%22%5D', 0),
(3025, 1349, 4, '2023-10-02', '%5B%221%22%5D', 0),
(3026, 1349, 5, '2023-10-02', '%5B%224%22%5D', 0),
(3027, 1363, 1, '2023-10-02', '%5B%221%22%5D', 0),
(3028, 1363, 2, '2023-10-02', '%5B%222%22%5D', 0),
(3029, 1363, 3, '2023-10-02', '%5B%2215%22%5D', 0),
(3030, 1350, 5, '2023-10-02', '%5B%221%22%5D', 0),
(3031, 1363, 4, '2023-10-02', '%5B%222%22%5D', 0),
(3032, 1363, 5, '2023-10-02', '%5B%221%22%5D', 0),
(3033, 1362, 1, '2023-10-02', '%5B%223%22%5D', 0),
(3034, 1362, 2, '2023-10-02', '%5B%221%22%5D', 0),
(3035, 1362, 3, '2023-10-02', '%5B%2211%22%5D', 0),
(3036, 1362, 4, '2023-10-02', '%5B%221%22%5D', 0),
(3037, 1362, 5, '2023-10-02', '%5B%224%22%5D', 0),
(3038, 1364, 1, '2023-10-02', '%5B%221%22%5D', 0),
(3039, 1364, 2, '2023-10-02', '%5B%222%22%5D', 0),
(3040, 1364, 3, '2023-10-02', '%5B%2216%22%5D', 0),
(3041, 1364, 4, '2023-10-02', '%5B%222%22%5D', 0),
(3042, 1364, 5, '2023-10-02', '%5B%221%22%5D', 0),
(3043, 1365, 1, '2023-10-02', '%5B%221%22%5D', 0),
(3044, 1365, 2, '2023-10-02', '%5B%221%22%5D', 0),
(3045, 1365, 3, '2023-10-02', '%5B%2211%22%5D', 0),
(3046, 1365, 4, '2023-10-02', '%5B%223%22%5D', 0),
(3047, 1365, 5, '2023-10-02', '%5B%221%22%5D', 0),
(3048, 1366, 1, '2023-10-02', '%5B%221%22%5D', 0),
(3049, 1366, 2, '2023-10-02', '%5B%224%22%5D', 0),
(3050, 1366, 3, '2023-10-02', '%5B%2216%22%5D', 0),
(3051, 1366, 4, '2023-10-02', '%5B%221%22%5D', 0),
(3052, 1366, 5, '2023-10-02', '%5B%222%22%5D', 0),
(3053, 1367, 1, '2023-10-02', '%5B%224%22%5D', 0),
(3054, 1367, 2, '2023-10-02', '%5B%222%22%5D', 0),
(3055, 1367, 3, '2023-10-02', '%5B%226%22%5D', 0),
(3056, 1367, 4, '2023-10-02', '%5B%224%22%5D', 0),
(3057, 1367, 5, '2023-10-02', '%5B%223%22%5D', 0),
(3058, 1368, 1, '2023-10-02', '%5B%224%22%5D', 0),
(3059, 1368, 2, '2023-10-02', '%5B%222%22%5D', 0),
(3060, 1368, 3, '2023-10-02', '%5B%225%22%5D', 0),
(3061, 1368, 4, '2023-10-02', '%5B%221%22%5D', 0),
(3062, 1368, 5, '2023-10-02', '%5B%224%22%5D', 0),
(3063, 1373, 1, '2023-10-02', '%5B%223%22%5D', 0),
(3064, 1373, 2, '2023-10-02', '%5B%222%22%5D', 0),
(3065, 1373, 3, '2023-10-02', '%5B%226%22%5D', 0),
(3066, 1373, 4, '2023-10-02', '%5B%224%22%5D', 0),
(3067, 1373, 5, '2023-10-02', '%5B%224%22%5D', 0),
(3068, 1349, 1, '2023-10-03', '%5B%221%22%5D', 0),
(3069, 1349, 2, '2023-10-03', '%5B%221%22%5D', 0),
(3070, 1349, 3, '2023-10-03', '%5B%2216%22%5D', 0),
(3071, 1349, 4, '2023-10-03', '%5B%223%22%5D', 0),
(3072, 1349, 5, '2023-10-03', '%5B%222%22%5D', 0),
(3073, 1350, 5, '2023-10-03', '%5B%222%22%5D', 0),
(3074, 1350, 5, '2023-10-04', '%5B%222%22%5D', 0),
(3075, 1350, 5, '2023-10-05', '%5B%222%22%5D', 0),
(3076, 1350, 5, '2023-10-06', '%5B%221%22%5D', 0),
(3077, 1362, 1, '2023-10-03', '%5B%221%22%5D', 0),
(3078, 1362, 2, '2023-10-03', '%5B%222%22%5D', 0),
(3079, 1362, 3, '2023-10-03', '%5B%2214%22%5D', 0),
(3080, 1362, 4, '2023-10-03', '%5B%223%22%5D', 0),
(3081, 1362, 5, '2023-10-03', '%5B%222%22%5D', 0),
(3082, 1362, 1, '2023-10-04', '%5B%224%22%5D', 0),
(3083, 1362, 2, '2023-10-04', '%5B%223%22%5D', 0),
(3084, 1362, 3, '2023-10-04', '%5B%2211%22%5D', 0),
(3085, 1362, 4, '2023-10-04', '%5B%222%22%5D', 0),
(3086, 1362, 5, '2023-10-04', '%5B%224%22%5D', 0),
(3087, 1362, 1, '2023-10-05', '%5B%223%22%5D', 0),
(3088, 1362, 2, '2023-10-05', '%5B%221%22%5D', 0),
(3089, 1362, 3, '2023-10-05', '%5B%227%22%5D', 0),
(3090, 1362, 4, '2023-10-05', '%5B%222%22%5D', 0),
(3091, 1362, 5, '2023-10-05', '%5B%222%22%5D', 0),
(3092, 1362, 1, '2023-10-06', '%5B%221%22%5D', 0),
(3093, 1362, 2, '2023-10-06', '%5B%224%22%5D', 0),
(3094, 1362, 3, '2023-10-06', '%5B%2211%22%5D', 0),
(3095, 1362, 4, '2023-10-06', '%5B%224%22%5D', 0),
(3096, 1362, 5, '2023-10-06', '%5B%221%22%5D', 0),
(3097, 907, 1, '2023-10-01', '%5B%222%22%5D', 0),
(3098, 907, 3, '2023-10-01', '%5B%2213%22%5D', 0),
(3099, 907, 4, '2023-10-01', '%5B%222%22%5D', 0),
(3100, 907, 5, '2023-10-01', '%5B%224%22%5D', 0),
(3101, 908, 1, '2023-10-02', '%5B%224%22%5D', 0),
(3102, 908, 2, '2023-10-02', '%5B%221%22%5D', 0),
(3103, 908, 3, '2023-10-02', '%5B%2216%22%5D', 0),
(3104, 908, 4, '2023-10-02', '%5B%222%22%5D', 0),
(3105, 908, 5, '2023-10-02', '%5B%221%22%5D', 0),
(3106, 1364, 1, '2023-10-03', '%5B%221%22%5D', 0),
(3107, 1364, 2, '2023-10-03', '%5B%223%22%5D', 0),
(3108, 1364, 3, '2023-10-03', '%5B%2216%22%5D', 0),
(3109, 1364, 4, '2023-10-03', '%5B%224%22%5D', 0),
(3110, 1364, 5, '2023-10-03', '%5B%221%22%5D', 0),
(3111, 1364, 1, '2023-10-04', '%5B%222%22%5D', 0),
(3112, 1364, 2, '2023-10-04', '%5B%221%22%5D', 0),
(3113, 1364, 3, '2023-10-04', '%5B%2211%22%5D', 0),
(3114, 1364, 4, '2023-10-04', '%5B%224%22%5D', 0),
(3115, 1364, 5, '2023-10-04', '%5B%224%22%5D', 0),
(3116, 1364, 1, '2023-10-05', '%5B%224%22%5D', 0),
(3117, 1364, 2, '2023-10-05', '%5B%221%22%5D', 0),
(3118, 1364, 3, '2023-10-05', '%5B%2212%22%5D', 0),
(3119, 1364, 4, '2023-10-05', '%5B%222%22%5D', 0),
(3120, 1364, 5, '2023-10-05', '%5B%221%22%5D', 0),
(3121, 1347, 1, '2023-10-03', '%5B%223%22%5D', 0),
(3122, 1347, 2, '2023-10-03', '%5B%221%22%5D', 0),
(3123, 1347, 3, '2023-10-03', '%5B%2211%22%5D', 0),
(3124, 1347, 4, '2023-10-03', '%5B%221%22%5D', 0),
(3125, 1347, 5, '2023-10-03', '%5B%223%22%5D', 0),
(3126, 1348, 1, '2023-10-03', '%5B%221%22%5D', 0),
(3127, 1348, 2, '2023-10-03', '%5B%223%22%5D', 0),
(3128, 1348, 3, '2023-10-03', '%5B%2216%22%5D', 0),
(3129, 1348, 4, '2023-10-03', '%5B%223%22%5D', 0),
(3130, 1348, 5, '2023-10-03', '%5B%223%22%5D', 0),
(3131, 1363, 1, '2023-10-03', '%5B%221%22%5D', 0),
(3132, 1363, 2, '2023-10-03', '%5B%224%22%5D', 0),
(3133, 1363, 3, '2023-10-03', '%5B%228%22%5D', 0),
(3134, 1363, 4, '2023-10-03', '%5B%221%22%5D', 0),
(3135, 1363, 5, '2023-10-03', '%5B%224%22%5D', 0),
(3136, 1365, 1, '2023-10-03', '%5B%221%22%5D', 0),
(3137, 1365, 2, '2023-10-03', '%5B%224%22%5D', 0),
(3138, 1365, 3, '2023-10-03', '%5B%2215%22%5D', 0),
(3139, 1365, 4, '2023-10-03', '%5B%224%22%5D', 0),
(3140, 1365, 5, '2023-10-03', '%5B%223%22%5D', 0),
(3141, 1366, 1, '2023-10-03', '%5B%221%22%5D', 0),
(3142, 1366, 2, '2023-10-03', '%5B%224%22%5D', 0),
(3143, 1366, 3, '2023-10-03', '%5B%228%22%5D', 0),
(3144, 1366, 4, '2023-10-03', '%5B%222%22%5D', 0),
(3145, 1366, 5, '2023-10-03', '%5B%221%22%5D', 0),
(3146, 1367, 1, '2023-10-03', '%5B%223%22%5D', 0),
(3147, 1367, 2, '2023-10-03', '%5B%224%22%5D', 0),
(3148, 1367, 3, '2023-10-03', '%5B%225%22%5D', 0),
(3149, 1367, 4, '2023-10-03', '%5B%222%22%5D', 0),
(3150, 1367, 5, '2023-10-03', '%5B%222%22%5D', 0),
(3151, 1368, 1, '2023-10-03', '%5B%223%22%5D', 0),
(3152, 1368, 2, '2023-10-03', '%5B%221%22%5D', 0),
(3153, 1368, 3, '2023-10-03', '%5B%225%22%5D', 0),
(3154, 1368, 4, '2023-10-03', '%5B%224%22%5D', 0),
(3155, 1368, 5, '2023-10-03', '%5B%221%22%5D', 0),
(3156, 1373, 1, '2023-10-03', '%5B%222%22%5D', 0),
(3157, 1373, 2, '2023-10-03', '%5B%222%22%5D', 0),
(3158, 1373, 3, '2023-10-03', '%5B%2216%22%5D', 0),
(3159, 1373, 4, '2023-10-03', '%5B%223%22%5D', 0),
(3160, 1373, 5, '2023-10-03', '%5B%221%22%5D', 0),
(3161, 1365, 1, '2023-10-04', '%5B%224%22%5D', 0),
(3162, 1365, 2, '2023-10-04', '%5B%224%22%5D', 0),
(3163, 1365, 3, '2023-10-04', '%5B%229%22%5D', 0),
(3164, 1365, 4, '2023-10-04', '%5B%223%22%5D', 0),
(3165, 1365, 5, '2023-10-04', '%5B%224%22%5D', 0),
(3166, 1365, 1, '2023-10-05', '%5B%221%22%5D', 0),
(3167, 1365, 2, '2023-10-05', '%5B%221%22%5D', 0),
(3168, 1365, 3, '2023-10-05', '%5B%2212%22%5D', 0),
(3169, 1365, 4, '2023-10-05', '%5B%222%22%5D', 0),
(3170, 1365, 5, '2023-10-05', '%5B%222%22%5D', 0),
(3171, 1373, 1, '2023-10-04', '%5B%221%22%5D', 0),
(3172, 1373, 2, '2023-10-04', '%5B%223%22%5D', 0),
(3173, 1373, 3, '2023-10-04', '%5B%2215%22%5D', 0),
(3174, 1373, 4, '2023-10-04', '%5B%221%22%5D', 0),
(3175, 1373, 5, '2023-10-04', '%5B%222%22%5D', 0),
(3176, 908, 1, '2023-10-03', '%5B%222%22%5D', 0),
(3177, 908, 2, '2023-10-03', '%5B%222%22%5D', 0),
(3178, 908, 3, '2023-10-03', '%5B%2213%22%5D', 0),
(3179, 908, 4, '2023-10-03', '%5B%224%22%5D', 0),
(3180, 908, 5, '2023-10-03', '%5B%222%22%5D', 0),
(3181, 1347, 1, '2023-10-04', '%5B%223%22%5D', 0),
(3182, 1347, 2, '2023-10-04', '%5B%222%22%5D', 0),
(3183, 1347, 3, '2023-10-04', '%5B%2212%22%5D', 0),
(3184, 1347, 4, '2023-10-04', '%5B%222%22%5D', 0),
(3185, 1347, 5, '2023-10-04', '%5B%221%22%5D', 0),
(3186, 1454, 1, '2023-10-03', '%5B%221%22%5D', 0),
(3187, 1454, 2, '2023-10-03', '%5B%222%22%5D', 0),
(3188, 1454, 3, '2023-10-03', '%5B%226%22%5D', 0),
(3189, 1454, 4, '2023-10-03', '%5B%222%22%5D', 0),
(3190, 1454, 5, '2023-10-03', '%5B%223%22%5D', 0),
(3191, 1455, 1, '2023-10-03', '%5B%222%22%5D', 0),
(3192, 1455, 2, '2023-10-03', '%5B%223%22%5D', 0),
(3193, 1455, 3, '2023-10-03', '%5B%229%22%5D', 0),
(3194, 1455, 4, '2023-10-03', '%5B%221%22%5D', 0),
(3195, 1455, 5, '2023-10-03', '%5B%222%22%5D', 0),
(3196, 907, 1, '2023-10-07', '%5B%221%22%5D', 0),
(3197, 907, 3, '2023-10-07', '%5B%227%22%5D', 0),
(3198, 907, 4, '2023-10-07', '%5B%223%22%5D', 0),
(3199, 907, 5, '2023-10-07', '%5B%222%22%5D', 0),
(3200, 1348, 1, '2023-10-04', '%5B%223%22%5D', 0),
(3201, 1348, 2, '2023-10-04', '%5B%224%22%5D', 0),
(3202, 1348, 3, '2023-10-04', '%5B%2216%22%5D', 0),
(3203, 1348, 4, '2023-10-04', '%5B%224%22%5D', 0),
(3204, 1348, 5, '2023-10-04', '%5B%223%22%5D', 0),
(3205, 1349, 1, '2023-10-04', '%5B%223%22%5D', 0),
(3206, 1349, 2, '2023-10-04', '%5B%223%22%5D', 0),
(3207, 1349, 3, '2023-10-04', '%5B%225%22%5D', 0),
(3208, 1349, 4, '2023-10-04', '%5B%223%22%5D', 0),
(3209, 1349, 5, '2023-10-04', '%5B%221%22%5D', 0),
(3210, 1363, 1, '2023-10-04', '%5B%223%22%5D', 0),
(3211, 1363, 2, '2023-10-04', '%5B%223%22%5D', 0),
(3212, 1363, 3, '2023-10-04', '%5B%228%22%5D', 0),
(3213, 1363, 4, '2023-10-04', '%5B%221%22%5D', 0),
(3214, 1363, 5, '2023-10-04', '%5B%222%22%5D', 0),
(3215, 1366, 1, '2023-10-04', '%5B%224%22%5D', 0),
(3216, 1366, 2, '2023-10-04', '%5B%223%22%5D', 0),
(3217, 1366, 3, '2023-10-04', '%5B%2213%22%5D', 0),
(3218, 1366, 4, '2023-10-04', '%5B%223%22%5D', 0),
(3219, 1366, 5, '2023-10-04', '%5B%223%22%5D', 0),
(3220, 1367, 1, '2023-10-04', '%5B%221%22%5D', 0),
(3221, 1367, 2, '2023-10-04', '%5B%223%22%5D', 0),
(3222, 1367, 3, '2023-10-04', '%5B%2216%22%5D', 0),
(3223, 1367, 4, '2023-10-04', '%5B%224%22%5D', 0),
(3224, 1367, 5, '2023-10-04', '%5B%224%22%5D', 0),
(3225, 1368, 1, '2023-10-04', '%5B%224%22%5D', 0),
(3226, 1368, 2, '2023-10-04', '%5B%221%22%5D', 0),
(3227, 1368, 3, '2023-10-04', '%5B%2216%22%5D', 0),
(3228, 1368, 4, '2023-10-04', '%5B%223%22%5D', 0),
(3229, 1368, 5, '2023-10-04', '%5B%224%22%5D', 0),
(3230, 1454, 1, '2023-10-04', '%5B%224%22%5D', 0),
(3231, 1454, 2, '2023-10-04', '%5B%224%22%5D', 0),
(3232, 1454, 3, '2023-10-04', '%5B%228%22%5D', 0),
(3233, 1454, 4, '2023-10-04', '%5B%221%22%5D', 0),
(3234, 1454, 5, '2023-10-04', '%5B%224%22%5D', 0),
(3235, 1455, 1, '2023-10-04', '%5B%221%22%5D', 0),
(3236, 1455, 2, '2023-10-04', '%5B%221%22%5D', 0),
(3237, 1455, 3, '2023-10-04', '%5B%228%22%5D', 0),
(3238, 1455, 4, '2023-10-04', '%5B%223%22%5D', 0),
(3239, 1455, 5, '2023-10-04', '%5B%223%22%5D', 0),
(3240, 1347, 1, '2023-10-05', '%5B%223%22%5D', 0),
(3241, 1347, 2, '2023-10-05', '%5B%224%22%5D', 0),
(3242, 1347, 3, '2023-10-05', '%5B%227%22%5D', 0),
(3243, 1347, 4, '2023-10-05', '%5B%221%22%5D', 0),
(3244, 1347, 5, '2023-10-05', '%5B%222%22%5D', 0),
(3245, 1348, 1, '2023-10-05', '%5B%221%22%5D', 0),
(3246, 1348, 2, '2023-10-05', '%5B%221%22%5D', 0),
(3247, 1348, 3, '2023-10-05', '%5B%2214%22%5D', 0),
(3248, 1348, 4, '2023-10-05', '%5B%221%22%5D', 0),
(3249, 1348, 5, '2023-10-05', '%5B%223%22%5D', 0),
(3250, 1349, 1, '2023-10-05', '%5B%223%22%5D', 0),
(3251, 1349, 2, '2023-10-05', '%5B%223%22%5D', 0),
(3252, 1349, 3, '2023-10-05', '%5B%225%22%5D', 0),
(3253, 1349, 4, '2023-10-05', '%5B%222%22%5D', 0),
(3254, 1349, 5, '2023-10-05', '%5B%221%22%5D', 0),
(3255, 1363, 1, '2023-10-05', '%5B%221%22%5D', 0),
(3256, 1363, 2, '2023-10-05', '%5B%222%22%5D', 0),
(3257, 1363, 3, '2023-10-05', '%5B%2215%22%5D', 0),
(3258, 1363, 4, '2023-10-05', '%5B%221%22%5D', 0),
(3259, 1363, 5, '2023-10-05', '%5B%222%22%5D', 0),
(3260, 1366, 1, '2023-10-05', '%5B%223%22%5D', 0),
(3261, 1366, 2, '2023-10-05', '%5B%222%22%5D', 0),
(3262, 1366, 3, '2023-10-05', '%5B%2211%22%5D', 0),
(3263, 1366, 4, '2023-10-05', '%5B%222%22%5D', 0),
(3264, 1366, 5, '2023-10-05', '%5B%222%22%5D', 0),
(3265, 1367, 1, '2023-10-05', '%5B%223%22%5D', 0),
(3266, 1367, 2, '2023-10-05', '%5B%223%22%5D', 0),
(3267, 1367, 3, '2023-10-05', '%5B%228%22%5D', 0),
(3268, 1367, 4, '2023-10-05', '%5B%224%22%5D', 0),
(3269, 1367, 5, '2023-10-05', '%5B%223%22%5D', 0),
(3270, 1368, 1, '2023-10-05', '%5B%222%22%5D', 0),
(3271, 1368, 2, '2023-10-05', '%5B%221%22%5D', 0),
(3272, 1368, 3, '2023-10-05', '%5B%2214%22%5D', 0),
(3273, 1368, 4, '2023-10-05', '%5B%221%22%5D', 0),
(3274, 1368, 5, '2023-10-05', '%5B%224%22%5D', 0),
(3275, 1373, 1, '2023-10-05', '%5B%221%22%5D', 0),
(3276, 1373, 2, '2023-10-05', '%5B%223%22%5D', 0),
(3277, 1373, 3, '2023-10-05', '%5B%225%22%5D', 0),
(3278, 1373, 4, '2023-10-05', '%5B%224%22%5D', 0),
(3279, 1373, 5, '2023-10-05', '%5B%223%22%5D', 0),
(3280, 1454, 1, '2023-10-05', '%5B%224%22%5D', 0),
(3281, 1454, 2, '2023-10-05', '%5B%221%22%5D', 0),
(3282, 1454, 3, '2023-10-05', '%5B%229%22%5D', 0),
(3283, 1454, 4, '2023-10-05', '%5B%221%22%5D', 0),
(3284, 1454, 5, '2023-10-05', '%5B%224%22%5D', 0),
(3285, 1455, 1, '2023-10-05', '%5B%224%22%5D', 0),
(3286, 1455, 2, '2023-10-05', '%5B%223%22%5D', 0),
(3287, 1455, 3, '2023-10-05', '%5B%228%22%5D', 0),
(3288, 1455, 4, '2023-10-05', '%5B%221%22%5D', 0),
(3289, 1455, 5, '2023-10-05', '%5B%224%22%5D', 0),
(3290, 907, 1, '2023-10-06', '%5B%224%22%5D', 0),
(3291, 907, 3, '2023-10-06', '%5B%2210%22%5D', 0),
(3292, 907, 4, '2023-10-06', '%5B%223%22%5D', 0),
(3293, 907, 5, '2023-10-06', '%5B%222%22%5D', 0),
(3294, 1456, 1, '2023-10-05', '%5B%224%22%5D', 0),
(3295, 1456, 2, '2023-10-05', '%5B%222%22%5D', 0),
(3296, 1456, 3, '2023-10-05', '%5B%2216%22%5D', 0),
(3297, 1456, 4, '2023-10-05', '%5B%224%22%5D', 0),
(3298, 1456, 5, '2023-10-05', '%5B%224%22%5D', 0),
(3324, 1462, 1, '2023-10-05', '%5B%221%22%5D', 0),
(3325, 1462, 2, '2023-10-05', '%5B%222%22%5D', 0),
(3326, 1462, 3, '2023-10-05', '%5B%2210%22%5D', 0),
(3327, 1462, 4, '2023-10-05', '%5B%222%22%5D', 0),
(3328, 1462, 5, '2023-10-05', '%5B%222%22%5D', 0),
(3329, 1348, 1, '2023-10-06', '%5B%224%22%5D', 0),
(3330, 1348, 2, '2023-10-06', '%5B%221%22%5D', 0),
(3331, 1348, 3, '2023-10-06', '%5B%2210%22%5D', 0),
(3332, 1348, 4, '2023-10-06', '%5B%224%22%5D', 0),
(3333, 1348, 5, '2023-10-06', '%5B%223%22%5D', 0),
(3389, 1474, 1, '2023-10-05', '%5B%223%22%5D', 1),
(3390, 1474, 2, '2023-10-05', '%5B%222%22%5D', 0),
(3391, 1474, 3, '2023-10-05', '%5B%228%22%5D', 0),
(3392, 1474, 4, '2023-10-05', '%5B%221%22%5D', 0),
(3393, 1474, 5, '2023-10-05', '%5B%223%22%5D', 0);

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
(1, 2, 557, 'Dinner should be served god dam cold'),
(40, 1, 907, 'Should not be served viagra');

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
('allow_Caregiver_does_user_exist_all', 1),
('allow_Caregiver_does_user_exist_self', 0),
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
('allow_Patient_get_meal_plan_of_Administrator', 0),
('allow_Patient_get_meal_plan_of_all', 0),
('allow_Patient_get_meal_plan_of_Caregiver', 0),
('allow_Patient_get_meal_plan_of_handled_Administrator', 0),
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
(242, 557, 'Parent_of', 1360),
(363, 908, 'Parent_of', 1348),
(364, 908, 'Parent_of', 1349),
(366, 908, 'Parent_of', 1362),
(367, 908, 'Parent_of', 1363),
(368, 908, 'Parent_of', 1364),
(369, 908, 'Parent_of', 1365),
(370, 908, 'Parent_of', 1366),
(371, 908, 'Parent_of', 1367),
(372, 908, 'Parent_of', 1368),
(373, 908, 'Parent_of', 1373),
(374, 908, 'Parent_of', 1454),
(375, 908, 'Parent_of', 1455),
(383, 908, 'Parent_of', 907),
(385, 907, 'Parent_of', 557),
(392, 908, 'Parent_of', 1347),
(401, 1456, 'Parent_of', 907),
(403, 1456, 'Parent_of', 1347),
(404, 908, 'Parent_of', 1350),
(405, 1456, 'Parent_of', 1350),
(413, 1456, 'Parent_of', 1462),
(414, 908, 'Parent_of', 1462);

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
(4879, 0x11ee5df5da0b2c9b8c69d00299f70b4f, 'DWEUknUFjkro4NQo', 908, '2023-09-28 11:55:00'),
(4880, 0x11ee5df6b26f06778c69d00299f70b4f, 'BJtpZ7SuzQ6iogXY', 908, '2023-09-28 12:01:03'),
(4881, 0x11ee5df6b571bc188c69d00299f70b4f, 'A23ra5xiSOITkkEs', 908, '2023-09-28 12:01:08'),
(4882, 0x11ee5df84635ab6e8c69d00299f70b4f, '0oHZYTj10bzPTatz', 907, '2023-09-28 12:12:20'),
(4883, 0x11ee5df8511227dd8c69d00299f70b4f, 'WC78oIpHD9S6ypKp', 907, '2023-09-28 12:12:38'),
(4884, 0x11ee5df85e77653e8c69d00299f70b4f, 'rJlsamTPHq3giqgy', 907, '2023-09-28 12:13:01'),
(4885, 0x11ee5df87cf7e5cc8c69d00299f70b4f, 'SQGXeIXSgYHis7C7', 907, '2023-09-28 12:13:52'),
(4886, 0x11ee5df8a9465d158c69d00299f70b4f, 'atRM8eqY08MUzPD6', 908, '2023-09-28 12:15:06'),
(4887, 0x11ee5df8b4d641088c69d00299f70b4f, 'QaAVSRUCQtyBcEQl', 907, '2023-09-28 12:15:26'),
(4888, 0x11ee5df8bdc566ad8c69d00299f70b4f, 'v4bg2G7cZ5VV32ez', 907, '2023-09-28 12:15:41'),
(4889, 0x11ee5df8c6aed0048c69d00299f70b4f, 'y6yJOIcnfgIytHm5', 907, '2023-09-28 12:15:56'),
(4890, 0x11ee5df8c9a3c5ba8c69d00299f70b4f, 'lcdXDph2UJKF7y4F', 907, '2023-09-28 12:16:01'),
(4891, 0x11ee5df93a95eb8d8c69d00299f70b4f, 'g585lHLFOpIaoUSO', 908, '2023-09-28 12:19:10'),
(4892, 0x11ee5dfa45b684d08c69d00299f70b4f, 'GvNdl9q4hdVLV1Um', 907, '2023-09-28 12:26:38'),
(4893, 0x11ee5dfa7fff94118c69d00299f70b4f, 'xaW2hZSNqXcOn9IM', 907, '2023-09-28 12:28:16'),
(4894, 0x11ee5dfa851c46d98c69d00299f70b4f, 'PaWhFhHZM62GIJUC', 907, '2023-09-28 12:28:25'),
(4895, 0x11ee5dfd9bca1f208c69d00299f70b4f, 's12vjBqxAyipIZqr', 908, '2023-09-28 12:50:31'),
(4896, 0x11ee5dfdba76b3668c69d00299f70b4f, 'DbP39Jk1WzXP5mpt', 908, '2023-09-28 12:51:23'),
(4897, 0x11ee5dfe11c1c8bd8c69d00299f70b4f, 'WXIaX4eTendqhI5N', 907, '2023-09-28 12:53:49'),
(4898, 0x11ee5dfe1bb647a58c69d00299f70b4f, 'hl8CK6YDvr7DMNzM', 907, '2023-09-28 12:54:06'),
(4899, 0x11ee5dfe2006a9178c69d00299f70b4f, 'JHY5D34ykq1cCcTB', 907, '2023-09-28 12:54:13'),
(4900, 0x11ee5dffc4b7cd738c69d00299f70b4f, 'ydKz4ClyX0kx05nS', 907, '2023-09-28 13:05:59'),
(4901, 0x11ee5dffcba1c0468c69d00299f70b4f, 'V6K6pqes1NQSxG7s', 907, '2023-09-28 13:06:10'),
(4902, 0x11ee5dffddd9de968c69d00299f70b4f, 'BXYz1JNWsfS3NNDX', 907, '2023-09-28 13:06:41'),
(4903, 0x11ee5e04f8df21a88c69d00299f70b4f, 'kzbip414xchvhp5S', 908, '2023-09-28 13:43:14'),
(4904, 0x11ee5e05cb9009328c69d00299f70b4f, 'x3clP3YCwtgUJohL', 908, '2023-09-28 13:49:07'),
(4905, 0x11ee5e0756d81f538c69d00299f70b4f, 'CbPY4miJCbajPR0H', 907, '2023-09-28 14:00:10'),
(4906, 0x11ee5e078c8ab8c08c69d00299f70b4f, '4IamEds319QUka1T', 1348, '2023-09-28 14:01:41'),
(4907, 0x11ee5e07da116ea68c69d00299f70b4f, 'VCAyiyFnSqoOUDte', 1348, '2023-09-28 14:03:51'),
(4908, 0x11ee5e07ef3276f98c69d00299f70b4f, 'rF5HMff7Um5AQCf4', 1348, '2023-09-28 14:04:26'),
(4909, 0x11ee5e08081b68698c69d00299f70b4f, '3LeWqiwx5Fe5eW5g', 907, '2023-09-28 14:05:08'),
(4910, 0x11ee5e08211002f28c69d00299f70b4f, 'lvD5V8p3JlTtaVyl', 907, '2023-09-28 14:05:50'),
(4911, 0x11ee5e08667843ec8c69d00299f70b4f, 'IMVFAqNnVMIQZZYO', 908, '2023-09-28 14:07:46'),
(4912, 0x11ee5e09ee8e6a0f8c69d00299f70b4f, '1evYmgjDDWbVw30s', 908, '2023-09-28 14:18:44'),
(4913, 0x11ee5e1b7b638dd58c69d00299f70b4f, 'YpNKB9W4d8VnxJdn', 908, '2023-09-28 16:24:22'),
(4914, 0x11ee5e3a5023161f8c69d00299f70b4f, 'c569QC5o8ZKQjP94', 907, '2023-09-28 20:05:04'),
(4915, 0x11ee5e3a674352668c69d00299f70b4f, 'X75vaqf6CYGoP3tG', 908, '2023-09-28 20:05:42'),
(4916, 0x11ee5e3a9298c5dd8c69d00299f70b4f, 'RPZT2veMxF9mLYoM', 1347, '2023-09-28 20:06:55'),
(4917, 0x11ee5e3ac6ab0e0a8c69d00299f70b4f, 'Z0h9yE0Mlap2Gu2D', 908, '2023-09-28 20:08:22'),
(4918, 0x11ee5e3b17491ba88c69d00299f70b4f, 'tayXnmAYnUxSbWgJ', 1347, '2023-09-28 20:10:38'),
(4919, 0x11ee5e3b24e626f78c69d00299f70b4f, 'Fg7ThFky5lG4ZFSH', 908, '2023-09-28 20:11:01'),
(4920, 0x11ee5ea0a021cfdb8c69d00299f70b4f, 'GPjePCkGdBZfn64T', 908, '2023-09-29 08:17:26'),
(4921, 0x11ee5ea504340d0e8c69d00299f70b4f, 'j69WU9sppUtNUhW3', 908, '2023-09-29 08:48:52'),
(4922, 0x11ee5ea62ef884e38c69d00299f70b4f, '790n6BXDn7Wqwvz2', 908, '2023-09-29 08:57:14'),
(4923, 0x11ee5ea703c57c8c8c69d00299f70b4f, 'ekTnrsgI6Q5eb1rm', 908, '2023-09-29 09:03:11'),
(4924, 0x11ee5eaab0e5e7788c69d00299f70b4f, 'IeTKlsHcG89nSlFK', 908, '2023-09-29 09:29:30'),
(4925, 0x11ee5f01d438f21f8c69d00299f70b4f, 'uKEr17B5PBOV6vv1', 907, '2023-09-29 19:53:15'),
(4926, 0x11ee5f0202a5c97a8c69d00299f70b4f, 'XStt16WA2Af9xgA0', 907, '2023-09-29 19:54:33'),
(4927, 0x11ee5f021065a8278c69d00299f70b4f, 'xPEafkxRf0BHORO7', 908, '2023-09-29 19:54:56'),
(4928, 0x11ee5fdc546303c88c69d00299f70b4f, 'wKoIZ8bQcGVgt4c2', 908, '2023-09-30 21:57:20'),
(4929, 0x11ee5fddad1de5d58c69d00299f70b4f, 'GM1MrIuSnKiYE70s', 557, '2023-09-30 22:06:59'),
(4930, 0x11ee5fddad37a1808c69d00299f70b4f, 'T3wKP9Di1Z7XPiBi', 557, '2023-09-30 22:06:59'),
(4931, 0x11ee5fddad5189178c69d00299f70b4f, 'iNywv8eDFQrSidq5', 557, '2023-09-30 22:06:59'),
(4932, 0x11ee6061cf319d298c69d00299f70b4f, 'eCsCQsIojvn2LeQv', 908, '2023-10-01 13:52:49'),
(4933, 0x11ee606271d534758c69d00299f70b4f, 'bZy7faJ18toAp2ne', 908, '2023-10-01 13:57:22'),
(4934, 0x11ee6062720a992c8c69d00299f70b4f, 'WrpWscutsZdclEYx', 908, '2023-10-01 13:57:23'),
(4935, 0x11ee60678d3182228c69d00299f70b4f, 'D9XH1bOYMIDtDySF', 908, '2023-10-01 14:33:56'),
(4936, 0x11ee60678d51ac028c69d00299f70b4f, '8yEcYuNp0FObGJX7', 908, '2023-10-01 14:33:56'),
(4937, 0x11ee608599a3957b8c69d00299f70b4f, 'WQwQ7iMsJXjbWsF0', 908, '2023-10-01 18:09:01'),
(4938, 0x11ee6085e898f6548c69d00299f70b4f, 'jkTYpUgKV3F9IS84', 907, '2023-10-01 18:11:14'),
(4939, 0x11ee6085f48d61a58c69d00299f70b4f, 'JDWBGetSsGjEJXNC', 908, '2023-10-01 18:11:34'),
(4940, 0x11ee60877766258a8c69d00299f70b4f, 'XcFmOucXQTwPvxmc', 907, '2023-10-01 18:22:23'),
(4941, 0x11ee6105441eaa8b8c69d00299f70b4f, 'dW3zFQWeAxu7iZSz', 908, '2023-10-02 09:22:54'),
(4942, 0x11ee612a599622fc8c69d00299f70b4f, 'e4VeudtMsGndyHNZ', 908, '2023-10-02 13:48:21'),
(4943, 0x11ee6140590640be8c69d00299f70b4f, 'Xhe2ev3hLgqHWlOu', 908, '2023-10-02 16:25:49'),
(4944, 0x11ee6140593c7a698c69d00299f70b4f, 'dbPi64Cmhp58P0Yj', 908, '2023-10-02 16:25:49'),
(4945, 0x11ee614d5992866f8c69d00299f70b4f, 'A2i0Kx7oELZxGY2q', 908, '2023-10-02 17:58:53'),
(4946, 0x11ee614d87721a268c69d00299f70b4f, 'TDKpfNBHgaYZL01J', 908, '2023-10-02 18:00:10'),
(4947, 0x11ee614db3edda2f8c69d00299f70b4f, '82GKyx3O7mLTZMWo', 908, '2023-10-02 18:01:25'),
(4948, 0x11ee614dda7dd5e58c69d00299f70b4f, 'mpWqtWfqJceGvYXx', 908, '2023-10-02 18:02:30'),
(4949, 0x11ee614de0b3fbc78c69d00299f70b4f, '1UdrkA0WRJMkQ9dx', 908, '2023-10-02 18:02:40'),
(4950, 0x11ee614de63903098c69d00299f70b4f, '4bs0l9ZvTdxAoq1s', 907, '2023-10-02 18:02:49'),
(4951, 0x11ee614e006482668c69d00299f70b4f, '9A3lFYJj8lV66cw3', 907, '2023-10-02 18:03:33'),
(4952, 0x11ee614e40c900bf8c69d00299f70b4f, 'J7FzyD66M1TICIT6', 907, '2023-10-02 18:05:21'),
(4953, 0x11ee614e7990bfb98c69d00299f70b4f, 'mruqbZiAx3oWxogR', 908, '2023-10-02 18:06:56'),
(4954, 0x11ee614e79c4f6908c69d00299f70b4f, 'EkwXTTpxH6ZQWNf0', 908, '2023-10-02 18:06:57'),
(4955, 0x11ee614ea837678f8c69d00299f70b4f, '6Pw9CTwjvKwd5cj1', 907, '2023-10-02 18:08:15'),
(4956, 0x11ee614eafe7c3e08c69d00299f70b4f, '7C2e4kysbTZQntHb', 908, '2023-10-02 18:08:28'),
(4957, 0x11ee614ff1431d688c69d00299f70b4f, 'gN01PWgfgpFD0l1u', 908, '2023-10-02 18:17:27'),
(4958, 0x11ee6150906d65848c69d00299f70b4f, 'YL5dFnrbUXtay1hW', 908, '2023-10-02 18:21:54'),
(4959, 0x11ee6151ac3dee928c69d00299f70b4f, '4zUWedFFvXu207zu', 908, '2023-10-02 18:29:50'),
(4960, 0x11ee615231b576018c69d00299f70b4f, 'vEFXYUcjLFju0mrB', 908, '2023-10-02 18:33:34'),
(4961, 0x11ee6152446372fd8c69d00299f70b4f, 'Vhh1uWfpHeyQF4RY', 908, '2023-10-02 18:34:05'),
(4962, 0x11ee61554111b0208c69d00299f70b4f, 'Mu9oxO643vncIG6R', 908, '2023-10-02 18:55:28'),
(4963, 0x11ee6155566c17ec8c69d00299f70b4f, 'xyYbWSIdHdLvvI5S', 908, '2023-10-02 18:56:04'),
(4964, 0x11ee61d062129a398c69d00299f70b4f, 'eXfWAMS0OT8mf1HU', 908, '2023-10-03 09:36:52'),
(4965, 0x11ee61d0b9e073578c69d00299f70b4f, '96Yt33ZUa2dKbgsJ', 908, '2023-10-03 09:39:19'),
(4966, 0x11ee61d1f7cbc8788c69d00299f70b4f, 'HgCsRRNV3NYScwcx', 907, '2023-10-03 09:48:12'),
(4967, 0x11ee61d3de4c4b228c69d00299f70b4f, 'WaePw9iNHaW5SMEK', 908, '2023-10-03 10:01:49'),
(4968, 0x11ee61e147d05ea78c69d00299f70b4f, 'QPoBrwTuLk5Wlbpa', 908, '2023-10-03 11:37:49'),
(4969, 0x11ee61e2f07477698c69d00299f70b4f, 'HeBJXiN2VyAh3Rnx', 908, '2023-10-03 11:49:41'),
(4970, 0x11ee61e320c06d358c69d00299f70b4f, 'jiZg0A8oGp0doN5m', 908, '2023-10-03 11:51:03'),
(4971, 0x11ee61e521f9c6988c69d00299f70b4f, '7fqPVZ8PE5jL91CM', 908, '2023-10-03 12:05:24'),
(4972, 0x11ee61e67d23a7298c69d00299f70b4f, 'p1S5xGhOM4Np2xm6', 908, '2023-10-03 12:15:06'),
(4973, 0x11ee61e95052019c8c69d00299f70b4f, '9WaJYJvJ6KLHbxZT', 908, '2023-10-03 12:35:19'),
(4974, 0x11ee61e9d9d41b808c69d00299f70b4f, 'eLroiF1kEUjU7tUE', 908, '2023-10-03 12:39:10'),
(4975, 0x11ee61e9e76b9c898c69d00299f70b4f, 'feNX4HWMjmHv3e4B', 908, '2023-10-03 12:39:33'),
(4976, 0x11ee61e9e7af51428c69d00299f70b4f, 'eyLLuBNIWWSWqylw', 908, '2023-10-03 12:39:33'),
(4977, 0x11ee61eed5c558078c69d00299f70b4f, 'ErMOkwPnU3xUOiSF', 908, '2023-10-03 13:14:51'),
(4978, 0x11ee61f1b10368098c69d00299f70b4f, 'bbnxzByW8S5XCG9P', 908, '2023-10-03 13:35:17'),
(4979, 0x11ee61f912c860268c69d00299f70b4f, 'rucLHzIHqDqsX9It', 907, '2023-10-03 14:28:08'),
(4980, 0x11ee61f92483645e8c69d00299f70b4f, 'cp8wUXot1wNZ32sv', 907, '2023-10-03 14:28:38'),
(4981, 0x11ee61f94ab3873a8c69d00299f70b4f, 'wGhlLjlMi4cFWDm8', 907, '2023-10-03 14:29:42'),
(4982, 0x11ee61f955f03b258c69d00299f70b4f, 'IXeBptcNsPDMO4G5', 907, '2023-10-03 14:30:01'),
(4983, 0x11ee61f95fa4bc868c69d00299f70b4f, 'pSO1zwBQWqq1GJkS', 907, '2023-10-03 14:30:17'),
(4984, 0x11ee61f9bc4c088c8c69d00299f70b4f, 'X0Nyk66nuvTZCjSQ', 907, '2023-10-03 14:32:52'),
(4985, 0x11ee61f9d364ef368c69d00299f70b4f, 'ngx8lqk457tJWPUo', 907, '2023-10-03 14:33:31'),
(4986, 0x11ee61f9e5167edf8c69d00299f70b4f, 'NMuYoDbjKUNwy15e', 907, '2023-10-03 14:34:01'),
(4987, 0x11ee61f9f66da82e8c69d00299f70b4f, 'Jy850qVoASGEpY1R', 907, '2023-10-03 14:34:30'),
(4988, 0x11ee61fa24b672428c69d00299f70b4f, 'fnV4wVK4H3zVmJes', 907, '2023-10-03 14:35:48'),
(4989, 0x11ee61fa61a8d6718c69d00299f70b4f, 'tY42w2STVtgo4hR0', 907, '2023-10-03 14:37:30'),
(4990, 0x11ee61fa91e6ae6d8c69d00299f70b4f, '0iDo6y5qCn55ZdfQ', 907, '2023-10-03 14:38:51'),
(4991, 0x11ee61faab3581938c69d00299f70b4f, 'MECqh8DQT9RS8xij', 907, '2023-10-03 14:39:33'),
(4992, 0x11ee62009bafcb678c69d00299f70b4f, 'UWlNSUKT2QVOyolE', 907, '2023-10-03 15:22:04'),
(4993, 0x11ee620186a240228c69d00299f70b4f, 'C2Iw9mGMDcX1weT0', 907, '2023-10-03 15:28:38'),
(4994, 0x11ee62026af2a62c8c69d00299f70b4f, 'mWynHqs51Gw3GQUn', 907, '2023-10-03 15:35:01'),
(4995, 0x11ee6202fa574f718c69d00299f70b4f, 'P1mGGEkYjn8YKf7f', 907, '2023-10-03 15:39:02'),
(4996, 0x11ee6203109d03698c69d00299f70b4f, 'Paczo7iPZDeRut38', 907, '2023-10-03 15:39:39'),
(4997, 0x11ee62031cb524598c69d00299f70b4f, 'hb9zqU08C7tpZhbP', 907, '2023-10-03 15:40:00'),
(4998, 0x11ee62033783626a8c69d00299f70b4f, 'VWByWDZllyJGcDKC', 908, '2023-10-03 15:40:45'),
(4999, 0x11ee6204004286d18c69d00299f70b4f, 'zsTYbvsA3owkSthT', 907, '2023-10-03 15:46:21'),
(5000, 0x11ee62040787e8648c69d00299f70b4f, '85K5RAamoCqlog7o', 907, '2023-10-03 15:46:34'),
(5001, 0x11ee620417a93afa8c69d00299f70b4f, '909Ti5Hw2ZlbfG8Q', 907, '2023-10-03 15:47:01'),
(5002, 0x11ee6204399db6e68c69d00299f70b4f, 'tdjUWDIvHOHVKJsR', 907, '2023-10-03 15:47:58'),
(5003, 0x11ee6204ae45952d8c69d00299f70b4f, 'rk8CfmwvtG5nXXlc', 908, '2023-10-03 15:51:13'),
(5004, 0x11ee6204b9a3d6ae8c69d00299f70b4f, 'nlTxFIzULNpEnuQ8', 907, '2023-10-03 15:51:32'),
(5005, 0x11ee620501e691238c69d00299f70b4f, 'uZ0rwxhLfC0u0bHV', 907, '2023-10-03 15:53:34'),
(5006, 0x11ee62050b842c6f8c69d00299f70b4f, 'wUTFrs8ArhxTI1wT', 907, '2023-10-03 15:53:50'),
(5007, 0x11ee620564b343598c69d00299f70b4f, 'eLHzOuegRgnAD2fu', 907, '2023-10-03 15:56:19'),
(5008, 0x11ee62056d9612898c69d00299f70b4f, 'g7zVvDKrF0RyzUTn', 907, '2023-10-03 15:56:34'),
(5009, 0x11ee620592409bd98c69d00299f70b4f, 'A4LGs5FTWpbryXO6', 907, '2023-10-03 15:57:36'),
(5010, 0x11ee6205b93abbe68c69d00299f70b4f, 'VNjN2uJ1VN5H5bL5', 907, '2023-10-03 15:58:41'),
(5011, 0x11ee6205d9e647d98c69d00299f70b4f, 'O5HpEcyGPp8XEyNI', 907, '2023-10-03 15:59:36'),
(5012, 0x11ee6205e5b9e7e38c69d00299f70b4f, '6H0Qi58a4Zj5V7fJ', 907, '2023-10-03 15:59:56'),
(5013, 0x11ee6205fea346148c69d00299f70b4f, 'rscj0fovUAoXTcaE', 907, '2023-10-03 16:00:38'),
(5014, 0x11ee620608dce5328c69d00299f70b4f, 'vPO4Prywi3vsKrVe', 907, '2023-10-03 16:00:55'),
(5015, 0x11ee62062bea645e8c69d00299f70b4f, '0DpQdqg7h26lhVnk', 907, '2023-10-03 16:01:54'),
(5016, 0x11ee6206450f7b138c69d00299f70b4f, 'Y7NrdGQaLY7hrA2F', 907, '2023-10-03 16:02:36'),
(5017, 0x11ee62064e3d84158c69d00299f70b4f, '3Rnldf6E6ATy2LbZ', 907, '2023-10-03 16:02:51'),
(5018, 0x11ee620676d1ed558c69d00299f70b4f, 'SC6GJIzEyLrCSz3q', 907, '2023-10-03 16:03:59'),
(5019, 0x11ee6206898cac778c69d00299f70b4f, 'vLE1vE0uBDiRJmZD', 907, '2023-10-03 16:04:31'),
(5020, 0x11ee6206b1e6347c8c69d00299f70b4f, '9JSc6TdlCsm8szYh', 907, '2023-10-03 16:05:38'),
(5021, 0x11ee6206fbbcea9a8c69d00299f70b4f, 'MElM1Zt6LB0dBeC9', 907, '2023-10-03 16:07:42'),
(5022, 0x11ee6207093629d58c69d00299f70b4f, 'gHebbOgdG94Le1Pp', 907, '2023-10-03 16:08:05'),
(5023, 0x11ee620738834d3b8c69d00299f70b4f, 'RIUALZveiDRGwxE8', 907, '2023-10-03 16:09:24'),
(5024, 0x11ee62074c65cdcf8c69d00299f70b4f, 'umarLv12lzHeRgm3', 907, '2023-10-03 16:09:58'),
(5025, 0x11ee6207565835df8c69d00299f70b4f, 'tN5gveFWANQcBDqE', 907, '2023-10-03 16:10:14'),
(5026, 0x11ee62077b4fa1cd8c69d00299f70b4f, 'TBwB9YnWRDkVqLYY', 907, '2023-10-03 16:11:16'),
(5027, 0x11ee6207879645138c69d00299f70b4f, 'pyMhqJz0gH8cuXi5', 907, '2023-10-03 16:11:37'),
(5028, 0x11ee6207a56dfd098c69d00299f70b4f, 'bf69at4Zql3PGR9M', 907, '2023-10-03 16:12:27'),
(5029, 0x11ee6207cca9d8158c69d00299f70b4f, 'rxqjADF0A1EumQSu', 1350, '2023-10-03 16:13:33'),
(5030, 0x11ee620856acea138c69d00299f70b4f, 'y2Q9eQ1hIIgdKC2w', 907, '2023-10-03 16:17:24'),
(5031, 0x11ee62088af300108c69d00299f70b4f, 'fBYSC6i2wyBmJ3W0', 907, '2023-10-03 16:18:52'),
(5032, 0x11ee6208ab4e6fc68c69d00299f70b4f, 'Ho3R63cwLtYftQdz', 907, '2023-10-03 16:19:46'),
(5033, 0x11ee6208c174d9c28c69d00299f70b4f, 'NtazCr6n34pxcsXA', 907, '2023-10-03 16:20:23'),
(5034, 0x11ee6208e1058fba8c69d00299f70b4f, 'Tf2K0MHLPvY0PeXn', 907, '2023-10-03 16:21:16'),
(5035, 0x11ee620917fcaa918c69d00299f70b4f, 'PfiNhDOBd9Pf2CS5', 907, '2023-10-03 16:22:49'),
(5036, 0x11ee6209525410778c69d00299f70b4f, 'sIDhdUsNyjq4wRcV', 907, '2023-10-03 16:24:27'),
(5037, 0x11ee6209701c714f8c69d00299f70b4f, 'NUSLplONer24OtwU', 907, '2023-10-03 16:25:17'),
(5038, 0x11ee6209863a3e8e8c69d00299f70b4f, '3pCgIvDbOalDresO', 907, '2023-10-03 16:25:54'),
(5039, 0x11ee6209c55fb5838c69d00299f70b4f, 'E93w3X8uGdrRM1UP', 907, '2023-10-03 16:27:40'),
(5040, 0x11ee620a1e8b98518c69d00299f70b4f, 'h38XzJVfa9ADtDFw', 907, '2023-10-03 16:30:09'),
(5041, 0x11ee620a3ec16a478c69d00299f70b4f, 'z6LkbSO2s69Vz7OI', 907, '2023-10-03 16:31:03'),
(5042, 0x11ee620a46fca3a58c69d00299f70b4f, '3RGfWWBGlCfBbAwD', 907, '2023-10-03 16:31:17'),
(5043, 0x11ee620a4efb2d468c69d00299f70b4f, 'en8HbBiH6iHHzOrX', 907, '2023-10-03 16:31:30'),
(5044, 0x11ee620abfe72b4e8c69d00299f70b4f, 'p1Ez4zHLRtdwxRTa', 908, '2023-10-03 16:34:40'),
(5045, 0x11ee620ac80a3ee78c69d00299f70b4f, 'sFnQlxuHG9DzufxM', 908, '2023-10-03 16:34:54'),
(5046, 0x11ee620ad0c552718c69d00299f70b4f, '6zyYHYd5KXLVYyTb', 908, '2023-10-03 16:35:08'),
(5047, 0x11ee620ad6f07a598c69d00299f70b4f, 'TvAvOwOt4taJuozv', 907, '2023-10-03 16:35:19'),
(5048, 0x11ee620add2fe3f38c69d00299f70b4f, 'e8Nbbh9FKKknzk8J', 908, '2023-10-03 16:35:29'),
(5049, 0x11ee620ae5d4750e8c69d00299f70b4f, 'iAkQggjGJS5E26yp', 908, '2023-10-03 16:35:44'),
(5050, 0x11ee620aec4b054e8c69d00299f70b4f, 'VHJAnd3suxX6myuH', 907, '2023-10-03 16:35:54'),
(5051, 0x11ee620af25c9eb18c69d00299f70b4f, 'HnGZUwIE6vOaAnnL', 908, '2023-10-03 16:36:05'),
(5052, 0x11ee620afe5a6fb28c69d00299f70b4f, 'X9Qa2BlXVDxnLmpQ', 907, '2023-10-03 16:36:25'),
(5053, 0x11ee620b0cb7ca8c8c69d00299f70b4f, 'CL89TEc33YneyTef', 908, '2023-10-03 16:36:49'),
(5054, 0x11ee620b1a77eef68c69d00299f70b4f, 'UwIxCMhpXy3zH6MW', 907, '2023-10-03 16:37:12'),
(5055, 0x11ee620b20aa48558c69d00299f70b4f, 'EDo5yaCozJ4GzXLY', 908, '2023-10-03 16:37:22'),
(5056, 0x11ee620ba773e1f48c69d00299f70b4f, 'GVrNy0Tez3SORfLP', 907, '2023-10-03 16:41:08'),
(5057, 0x11ee620bb1081a0e8c69d00299f70b4f, 'MVL5xskcrpLCvuG8', 908, '2023-10-03 16:41:24'),
(5058, 0x11ee620bc28b97668c69d00299f70b4f, '4VIyKhE2Q3YbXDGt', 908, '2023-10-03 16:41:54'),
(5059, 0x11ee620be95b69898c69d00299f70b4f, '2mMOfC2TtVPIXepD', 908, '2023-10-03 16:42:59'),
(5060, 0x11ee620bfc6962a78c69d00299f70b4f, 'YLRWWTfLpGBaGe2L', 908, '2023-10-03 16:43:31'),
(5061, 0x11ee620c098eb7838c69d00299f70b4f, 'aAAdDAK7Y0xbF1Zc', 908, '2023-10-03 16:43:53'),
(5062, 0x11ee620c20068d368c69d00299f70b4f, 'g9AcezAUvUZW7vZp', 908, '2023-10-03 16:44:31'),
(5063, 0x11ee620c308d768e8c69d00299f70b4f, '9TAZ08F2PbqO2MmV', 908, '2023-10-03 16:44:58'),
(5064, 0x11ee620c6cc299d48c69d00299f70b4f, '34Sl5o8DT82YAbLT', 908, '2023-10-03 16:46:39'),
(5065, 0x11ee62c281c8d1a78c69d00299f70b4f, 'bS7l4w1HCrXwzjdJ', 908, '2023-10-04 14:30:03'),
(5066, 0x11ee62c993c67a468c69d00299f70b4f, 'NVYOK15xhsv0R1t2', 908, '2023-10-04 15:20:40'),
(5067, 0x11ee636ec9264f748c69d00299f70b4f, 'w0KE1VVMffvVQsci', 908, '2023-10-05 11:03:16'),
(5068, 0x11ee636ec9411ec68c69d00299f70b4f, 'NwmB7iHOv1ZDkDTb', 908, '2023-10-05 11:03:16'),
(5069, 0x11ee637293ce73a08c69d00299f70b4f, 'Q54KyUxNR95vmMLz', 908, '2023-10-05 11:30:25'),
(5070, 0x11ee63729c5fcdbc8c69d00299f70b4f, 'E4fxBbqh9NxO2SvN', 907, '2023-10-05 11:30:39'),
(5071, 0x11ee6372a8db9d0b8c69d00299f70b4f, '16RCDUTn4zsvOVlt', 908, '2023-10-05 11:31:00'),
(5072, 0x11ee6373e15cbf5c8c69d00299f70b4f, 'LsNV8Ig76O94i6Lx', 908, '2023-10-05 11:39:44'),
(5073, 0x11ee6376062464fc8c69d00299f70b4f, '0ZZAPcuyBKafjSsu', 908, '2023-10-05 11:55:05'),
(5074, 0x11ee6376324ed59e8c69d00299f70b4f, 'VwGXCz3RQybGc4PX', 1456, '2023-10-05 11:56:19'),
(5075, 0x11ee6376a60549708c69d00299f70b4f, 'FT5RsQIy5evXSMS3', 908, '2023-10-05 11:59:33'),
(5076, 0x11ee6376db5bb1578c69d00299f70b4f, 'iV6GrqiX1wWLiDwY', 1456, '2023-10-05 12:01:03'),
(5077, 0x11ee63773199d21c8c69d00299f70b4f, 'UdoGp5gk9ZKsDMT1', 1456, '2023-10-05 12:03:27'),
(5078, 0x11ee6378a0125d078c69d00299f70b4f, 'OzTCGT4aFIsmK7FY', 1456, '2023-10-05 12:13:42'),
(5079, 0x11ee6378a944b2468c69d00299f70b4f, 'fVhmFms7vEOHVlwS', 1456, '2023-10-05 12:13:58'),
(5080, 0x11ee637974b9a02b8c69d00299f70b4f, 'WL0lS2v0vq289P4K', 1456, '2023-10-05 12:19:39'),
(5081, 0x11ee637e54bbf7438c69d00299f70b4f, 'Lo75j0ijhtD8lvHF', 908, '2023-10-05 12:54:33'),
(5082, 0x11ee638214d98d668c69d00299f70b4f, 'p7hygn1UA2rgh3Zh', 908, '2023-10-05 13:21:24'),
(5083, 0x11ee638214f2e7e78c69d00299f70b4f, '9uUOylxwOItN60LC', 908, '2023-10-05 13:21:24'),
(5084, 0x11ee6382150c7d828c69d00299f70b4f, 'mP1BCc4xI8KrU3ig', 908, '2023-10-05 13:21:24'),
(5085, 0x11ee6382151929ec8c69d00299f70b4f, '6rQjZLTdRCRMqcDL', 908, '2023-10-05 13:21:24'),
(5086, 0x11ee638237bae9af8c69d00299f70b4f, 'bjDoLM5UPTfOtpRb', 908, '2023-10-05 13:22:22'),
(5087, 0x11ee63824052f7008c69d00299f70b4f, 'jmHraerz5CYcYnf4', 908, '2023-10-05 13:22:37'),
(5088, 0x11ee638329c93ce08c69d00299f70b4f, 'jBwj5mb7nT8oXkNM', 908, '2023-10-05 13:29:08'),
(5089, 0x11ee6383d87544718c69d00299f70b4f, 'aoM31rrDKDs4N1uz', 908, '2023-10-05 13:34:01'),
(5090, 0x11ee6383d889d87f8c69d00299f70b4f, '341X8R5JttkJV0Y9', 908, '2023-10-05 13:34:01'),
(5091, 0x11ee6383e1b9823b8c69d00299f70b4f, '5jxS9gmfPbTVfDxP', 908, '2023-10-05 13:34:17'),
(5092, 0x11ee6384468d25c98c69d00299f70b4f, 'a6hSLiZiV0x5UN36', 908, '2023-10-05 13:37:06'),
(5093, 0x11ee6385b9e6b7c38c69d00299f70b4f, '1HQxdeY9fbekApL2', 907, '2023-10-05 13:47:29'),
(5094, 0x11ee6385d32984f78c69d00299f70b4f, 'eTQFvHDpEe82WHhe', 907, '2023-10-05 13:48:11'),
(5095, 0x11ee6385def21ac88c69d00299f70b4f, 'JD0dyLyajYeDH4Bz', 908, '2023-10-05 13:48:31'),
(5096, 0x11ee6385fec051218c69d00299f70b4f, 'SdJHDbsBXT39LfyJ', 907, '2023-10-05 13:49:25'),
(5097, 0x11ee63860a23b1518c69d00299f70b4f, 'qhaNB86pMZJKmffz', 907, '2023-10-05 13:49:44'),
(5098, 0x11ee63868bd823c98c69d00299f70b4f, 'jIRuFdbNu4sfOoYw', 907, '2023-10-05 13:53:21'),
(5099, 0x11ee63888a6acfb78c69d00299f70b4f, 'wcB8gil6OkCA8GHU', 907, '2023-10-05 14:07:38'),
(5100, 0x11ee6388c1b6518a8c69d00299f70b4f, 'U51EZwkP5n8QBFTH', 908, '2023-10-05 14:09:11'),
(5101, 0x11ee63968c45fddb8c69d00299f70b4f, 'vYbCQTAYatuHriBj', 908, '2023-10-05 15:47:54');

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
(907, 'Patient', 'Patient', '%242y%2410%24tiZF4T0kKm9BRNVVARIQZuPk7yehbkjihHz.6Yt3F1Vgj.qgrEMLG', NULL, '2023-09-21 10:16:21', 'Kerstin', 'Demente', NULL, NULL, '1904-1-1', NULL, NULL, NULL, NULL, NULL),
(908, 'Caregiver', 'Caregiver', '%242y%2410%24L7Fscfn%2Fb1LFPAeVuUckM.TMxuCePKqfhl2WsIP%2FOV0AKjBl8LFrC', NULL, '2023-09-21 10:16:28', 'Karin', 'Burncock', NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(909, 'Administrator', 'Administrator', '%242y%2410%24AO1gGvy97duMO.bkvtzbt.8NDcOyl1Aii9Wq.ugts7mFSQRg45rbe', NULL, '2023-09-21 10:16:36', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(1288, 'swe', 'Guest', '%242y%2410%24boaKuHPViRuF%2FpyouY3bDuauCJvwH3qhhoGyEgK4xivzjR%2F5c%2F1Ka', NULL, '2023-09-21 19:18:48', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(1289, 'swea', 'Guest', '%242y%2410%242stAt58KZrq40SMwt7o2ceUeiRUXVj6bPGWmjxTyAtcYexmPZ6ljO', NULL, '2023-09-21 19:19:05', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(1290, 'sweaa', 'Guest', '%242y%2410%24HCtM82qXu9fw77uk88MCJOuZHwT08rlTR4Xa3b%2F8BXfrTORqDefoK', NULL, '2023-09-21 19:20:07', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(1292, 'Kers', 'Guest', '%242y%2410%24V7rXWnKC1A202FeGMJdYxeiL%2FO8EEduaUktqyR0rVKm2aU.cpqQRq', NULL, '2023-09-22 08:29:05', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(1347, 'Patient1', 'Patient', '%242y%2410%24Xlml%2FbO9watmlwuMKpgoCeFR5YnZTOx4kYmUNxnGTwFbEl8If3EdW', NULL, '2023-09-22 23:57:11', 'Klara', 'F%C3%A4rdiga', NULL, NULL, '1942-8-4', NULL, NULL, NULL, NULL, NULL),
(1348, 'Patient2', 'Patient', '%242y%2410%24CVxZDB7w%2FwEeaZ5GCSpyqOTjQJya0E53S1xp1IVRRmLlSA6%2FRcyAq', NULL, '2023-09-22 23:57:14', 'Stefan', 'Surström', NULL, NULL, '1969-6-9', NULL, NULL, NULL, NULL, NULL),
(1349, 'Patient3', 'Patient', '%242y%2410%24%2FgMXOpCXmac85N99PqFlTOliZ4bF3Kt0DlXU1FGBuyI%2FoV.CQvtAm', NULL, '2023-09-22 23:57:16', 'Jeg', 'LikerBuller', NULL, NULL, '1964-08-8', NULL, NULL, NULL, NULL, NULL),
(1350, 'Patient4', 'Patient', '%242y%2410%24tcnJ%2F9r%2FJDg5DD5NMuiVje4HZ4cCTEsXKg2M1v1T.hDZgGGT3MA2.', NULL, '2023-09-22 23:57:18', 'Karlsson', 'Taket', NULL, NULL, '1938-3-3', NULL, NULL, NULL, NULL, NULL),
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
(1454, 'Satan', 'Patient', '%242y%2410%24D00ocUNKmXZ.y1TJB62HD.sN32%2FV0cGJyi5IxffVpKFy8mTKpErxu', NULL, '2023-10-03 13:13:14', 'SatanJohansson', 'YEy', NULL, NULL, '1808-6-8', NULL, NULL, NULL, NULL, NULL),
(1455, 'JohanFalk', 'Patient', '%242y%2410%24CJQnk3K62kU7y4iNW03oZuNnQMv678XGLstV1f.w7cLbTikvFWZua', NULL, '2023-10-03 13:42:06', 'JohanFalk', 'Falk', NULL, NULL, '1807-10-28', NULL, NULL, NULL, NULL, NULL),
(1456, 'Norman', 'Caregiver', '%242y%2410%24M1XR.W8DouVFdje6Lcs7pe%2F.2xGXgnSSoeEieo%2FoxFEUhi%2FVFar2W', NULL, '2023-10-05 11:55:21', 'Anders', 'Norman', NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(1462, 'NormanTest', 'Patient', '%242y%2410%24EbAEv5tWtp4EQnW9De7SB.ATuPFIX7jOKuCtka6mgul.S.n6iHQ5y', NULL, '2023-10-05 12:20:48', 'Anders', 'Norman', NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL),
(1474, 'Kristoffer', 'Guest', '%242y%2410%24ZbULuiEeC9kEkoY%2FaN9%2FweOr94udQlbo6XxfTd74QxqXMqldZj81u', NULL, '2023-10-05 16:01:31', NULL, NULL, NULL, NULL, '1800-1-1', NULL, NULL, NULL, NULL, NULL);

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
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `meal_plan_entry`
--
ALTER TABLE `meal_plan_entry`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3394;

--
-- AUTO_INCREMENT for table `meal_types`
--
ALTER TABLE `meal_types`
  MODIFY `id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `notes_for_dinner_times`
--
ALTER TABLE `notes_for_dinner_times`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `relations`
--
ALTER TABLE `relations`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=415;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(32) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5102;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(16) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1475;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
