-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Май 21 2024 г., 16:01
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `full_hospital_p312`
--

-- --------------------------------------------------------

--
-- Структура таблицы `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `building` int(11) NOT NULL CHECK (`building` between 1 and 5),
  `financing` decimal(10,2) NOT NULL CHECK (`financing` >= 0),
  `department_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `departments`
--

INSERT INTO `departments` (`id`, `building`, `financing`, `department_name`) VALUES
(1, 5, 1000000.00, 'Polyclinic'),
(2, 2, 5000000.00, 'Oncology'),
(3, 3, 600000.00, 'Therapy');

-- --------------------------------------------------------

--
-- Структура таблицы `diseases`
--

CREATE TABLE `diseases` (
  `id` int(11) NOT NULL,
  `severity` int(11) NOT NULL DEFAULT 1 CHECK (`severity` >= 0),
  `disease_name` varchar(100) NOT NULL,
  `department_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `diseases`
--

INSERT INTO `diseases` (`id`, `severity`, `disease_name`, `department_id`) VALUES
(1, 1, 'Простуда', 1),
(2, 5, 'Рак', 2),
(6, 3, 'Перелом', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `doctors`
--

CREATE TABLE `doctors` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `salary` decimal(10,2) NOT NULL CHECK (`salary` > 0),
  `department_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `doctors`
--

INSERT INTO `doctors` (`id`, `first_name`, `last_name`, `phone`, `salary`, `department_id`) VALUES
(1, 'Артур', 'Морган', '646103274', 50000.00, 1),
(2, 'Датч', 'Ван Дер Линде', '12353447', 100000.00, 2),
(3, 'Джон', 'Марстон', '65468732', 75000.00, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `doctors_and_examinations`
--

CREATE TABLE `doctors_and_examinations` (
  `doctor_id` int(11) NOT NULL,
  `examination_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `doctors_and_examinations`
--

INSERT INTO `doctors_and_examinations` (`doctor_id`, `examination_id`) VALUES
(1, 2),
(2, 3),
(3, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `doctors_and_spezializations`
--

CREATE TABLE `doctors_and_spezializations` (
  `doctor_id` int(11) NOT NULL,
  `spezialization_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `doctors_and_spezializations`
--

INSERT INTO `doctors_and_spezializations` (`doctor_id`, `spezialization_id`) VALUES
(1, 3),
(2, 1),
(3, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `donations`
--

CREATE TABLE `donations` (
  `id` int(11) NOT NULL,
  `summ_donate` decimal(10,2) NOT NULL CHECK (`summ_donate` > 0),
  `donate_date` date NOT NULL,
  `sponsor_id` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `donations`
--

INSERT INTO `donations` (`id`, `summ_donate`, `donate_date`, `sponsor_id`, `department_id`) VALUES
(2, 1000000.00, '2024-06-14', 1, 2),
(3, 500000.00, '2024-04-03', 2, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `examinations`
--

CREATE TABLE `examinations` (
  `id` int(11) NOT NULL,
  `examinations_name` varchar(100) NOT NULL,
  `day_of_week` int(11) NOT NULL CHECK (`day_of_week` between 1 and 7),
  `start_time` time NOT NULL CHECK (`start_time` >= '08:00:00' and `start_time` < '18:00:00'),
  `end_time` time NOT NULL CHECK (`end_time` > `start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `examinations`
--

INSERT INTO `examinations` (`id`, `examinations_name`, `day_of_week`, `start_time`, `end_time`) VALUES
(1, 'Рентген', 4, '15:17:09', '15:20:00'),
(2, 'Мазок', 1, '08:00:00', '09:00:00'),
(3, 'Радиотерапия', 3, '12:00:00', '15:30:00');

-- --------------------------------------------------------

--
-- Структура таблицы `patients`
--

CREATE TABLE `patients` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `birthday` date NOT NULL,
  `date_of_receipt` date NOT NULL,
  `ward_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `patients`
--

INSERT INTO `patients` (`id`, `first_name`, `last_name`, `birthday`, `date_of_receipt`, `ward_id`) VALUES
(1, 'Бени', 'Мус', '1969-05-05', '2024-04-29', 1),
(2, 'Мих', 'Кал', '1939-11-08', '2024-05-01', 2),
(3, 'Чан', 'Кай', '1989-09-22', '2023-12-28', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `patient_and_diseases`
--

CREATE TABLE `patient_and_diseases` (
  `patient_id` int(11) NOT NULL,
  `disease_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `patient_and_diseases`
--

INSERT INTO `patient_and_diseases` (`patient_id`, `disease_id`) VALUES
(1, 2),
(2, 6),
(3, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `patient_and_doctors`
--

CREATE TABLE `patient_and_doctors` (
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `patient_and_doctors`
--

INSERT INTO `patient_and_doctors` (`patient_id`, `doctor_id`) VALUES
(1, 2),
(2, 3),
(3, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `patient_and_examinations`
--

CREATE TABLE `patient_and_examinations` (
  `patient_id` int(11) NOT NULL,
  `examination_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `patient_and_examinations`
--

INSERT INTO `patient_and_examinations` (`patient_id`, `examination_id`) VALUES
(1, 3),
(2, 1),
(3, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `spezializations`
--

CREATE TABLE `spezializations` (
  `id` int(11) NOT NULL,
  `name_of_spezialization` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `spezializations`
--

INSERT INTO `spezializations` (`id`, `name_of_spezialization`) VALUES
(1, 'Онколог'),
(3, 'Терапевт'),
(2, 'Хирург');

-- --------------------------------------------------------

--
-- Структура таблицы `sponsors`
--

CREATE TABLE `sponsors` (
  `id` int(11) NOT NULL,
  `sponsors_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `sponsors`
--

INSERT INTO `sponsors` (`id`, `sponsors_name`) VALUES
(1, 'PET'),
(2, 'R-STR');

-- --------------------------------------------------------

--
-- Структура таблицы `vacations`
--

CREATE TABLE `vacations` (
  `id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL CHECK (`end_date` > `start_date`),
  `doctor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `vacations`
--

INSERT INTO `vacations` (`id`, `start_date`, `end_date`, `doctor_id`) VALUES
(1, '2024-05-09', '2024-05-17', 1),
(2, '2024-06-07', '2024-06-22', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `wards`
--

CREATE TABLE `wards` (
  `id` int(11) NOT NULL,
  `ward_name` varchar(100) NOT NULL,
  `floor` int(11) NOT NULL CHECK (`floor` >= -1),
  `department_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `wards`
--

INSERT INTO `wards` (`id`, `ward_name`, `floor`, `department_id`) VALUES
(1, '№100', 2, 2),
(2, '№101', 3, 1),
(3, '№103', 1, 2);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `department_name` (`department_name`) USING HASH;

--
-- Индексы таблицы `diseases`
--
ALTER TABLE `diseases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `disease_name` (`disease_name`),
  ADD KEY `department_id` (`department_id`);

--
-- Индексы таблицы `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_id` (`department_id`);

--
-- Индексы таблицы `doctors_and_examinations`
--
ALTER TABLE `doctors_and_examinations`
  ADD PRIMARY KEY (`doctor_id`,`examination_id`),
  ADD KEY `examination_id` (`examination_id`);

--
-- Индексы таблицы `doctors_and_spezializations`
--
ALTER TABLE `doctors_and_spezializations`
  ADD PRIMARY KEY (`doctor_id`,`spezialization_id`),
  ADD KEY `spezialization_id` (`spezialization_id`);

--
-- Индексы таблицы `donations`
--
ALTER TABLE `donations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sponsor_id` (`sponsor_id`),
  ADD KEY `department_id` (`department_id`);

--
-- Индексы таблицы `examinations`
--
ALTER TABLE `examinations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `examinations_name` (`examinations_name`);

--
-- Индексы таблицы `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ward_id` (`ward_id`);

--
-- Индексы таблицы `patient_and_diseases`
--
ALTER TABLE `patient_and_diseases`
  ADD PRIMARY KEY (`patient_id`,`disease_id`),
  ADD KEY `disease_id` (`disease_id`);

--
-- Индексы таблицы `patient_and_doctors`
--
ALTER TABLE `patient_and_doctors`
  ADD PRIMARY KEY (`patient_id`,`doctor_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Индексы таблицы `patient_and_examinations`
--
ALTER TABLE `patient_and_examinations`
  ADD PRIMARY KEY (`patient_id`,`examination_id`),
  ADD KEY `examination_id` (`examination_id`);

--
-- Индексы таблицы `spezializations`
--
ALTER TABLE `spezializations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_of_spezialization` (`name_of_spezialization`);

--
-- Индексы таблицы `sponsors`
--
ALTER TABLE `sponsors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sponsors_name` (`sponsors_name`);

--
-- Индексы таблицы `vacations`
--
ALTER TABLE `vacations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Индексы таблицы `wards`
--
ALTER TABLE `wards`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ward_name` (`ward_name`),
  ADD KEY `department_id` (`department_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `diseases`
--
ALTER TABLE `diseases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `donations`
--
ALTER TABLE `donations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `examinations`
--
ALTER TABLE `examinations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `spezializations`
--
ALTER TABLE `spezializations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `sponsors`
--
ALTER TABLE `sponsors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `vacations`
--
ALTER TABLE `vacations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `wards`
--
ALTER TABLE `wards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `diseases`
--
ALTER TABLE `diseases`
  ADD CONSTRAINT `diseases_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);

--
-- Ограничения внешнего ключа таблицы `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);

--
-- Ограничения внешнего ключа таблицы `doctors_and_examinations`
--
ALTER TABLE `doctors_and_examinations`
  ADD CONSTRAINT `doctors_and_examinations_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  ADD CONSTRAINT `doctors_and_examinations_ibfk_2` FOREIGN KEY (`examination_id`) REFERENCES `examinations` (`id`);

--
-- Ограничения внешнего ключа таблицы `doctors_and_spezializations`
--
ALTER TABLE `doctors_and_spezializations`
  ADD CONSTRAINT `doctors_and_spezializations_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  ADD CONSTRAINT `doctors_and_spezializations_ibfk_2` FOREIGN KEY (`spezialization_id`) REFERENCES `spezializations` (`id`);

--
-- Ограничения внешнего ключа таблицы `donations`
--
ALTER TABLE `donations`
  ADD CONSTRAINT `donations_ibfk_1` FOREIGN KEY (`sponsor_id`) REFERENCES `sponsors` (`id`),
  ADD CONSTRAINT `donations_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);

--
-- Ограничения внешнего ключа таблицы `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`ward_id`) REFERENCES `wards` (`id`);

--
-- Ограничения внешнего ключа таблицы `patient_and_diseases`
--
ALTER TABLE `patient_and_diseases`
  ADD CONSTRAINT `patient_and_diseases_ibfk_1` FOREIGN KEY (`disease_id`) REFERENCES `diseases` (`id`),
  ADD CONSTRAINT `patient_and_diseases_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`);

--
-- Ограничения внешнего ключа таблицы `patient_and_doctors`
--
ALTER TABLE `patient_and_doctors`
  ADD CONSTRAINT `patient_and_doctors_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  ADD CONSTRAINT `patient_and_doctors_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`);

--
-- Ограничения внешнего ключа таблицы `patient_and_examinations`
--
ALTER TABLE `patient_and_examinations`
  ADD CONSTRAINT `patient_and_examinations_ibfk_1` FOREIGN KEY (`examination_id`) REFERENCES `examinations` (`id`),
  ADD CONSTRAINT `patient_and_examinations_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`);

--
-- Ограничения внешнего ключа таблицы `vacations`
--
ALTER TABLE `vacations`
  ADD CONSTRAINT `vacations_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`);

--
-- Ограничения внешнего ключа таблицы `wards`
--
ALTER TABLE `wards`
  ADD CONSTRAINT `wards_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
