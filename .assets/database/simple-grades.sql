-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 10.35.232.173:3306
-- Erstellungszeit: 01. Jun 2023 um 18:26
-- Server-Version: 8.0.33
-- PHP-Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `k199462_simple-grades`
--
CREATE DATABASE IF NOT EXISTS `k199462_simple-grades` DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;
USE `k199462_simple-grades`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `enrolled_subject_mapping`
--

DROP TABLE IF EXISTS `enrolled_subject_mapping`;
CREATE TABLE `enrolled_subject_mapping` (
  `study_path_id` int NOT NULL,
  `subject_id` int NOT NULL,
  `student_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `semster`
--

DROP TABLE IF EXISTS `semster`;
CREATE TABLE `semster` (
  `id` int NOT NULL,
  `study_path_id` int NOT NULL,
  `sem_no` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `student`
--

DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `student_studypath_mapping`
--

DROP TABLE IF EXISTS `student_studypath_mapping`;
CREATE TABLE `student_studypath_mapping` (
  `study_path_id` int NOT NULL,
  `student_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `student_subject_test`
--

DROP TABLE IF EXISTS `student_subject_test`;
CREATE TABLE `student_subject_test` (
  `id` int NOT NULL,
  `student_id` int NOT NULL,
  `subject_semster_id` int NOT NULL,
  `weigth` int NOT NULL,
  `grade` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `studypath`
--

DROP TABLE IF EXISTS `studypath`;
CREATE TABLE `studypath` (
  `id` int NOT NULL,
  `uni_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `degree` varchar(50) NOT NULL,
  `semster_count` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `subject`
--

DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `subject_semster_mapping`
--

DROP TABLE IF EXISTS `subject_semster_mapping`;
CREATE TABLE `subject_semster_mapping` (
  `id` int NOT NULL,
  `semster_id` int NOT NULL,
  `subject_id` int NOT NULL,
  `credits` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `university`
--

DROP TABLE IF EXISTS `university`;
CREATE TABLE `university` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `enrolled_subject_mapping`
--
ALTER TABLE `enrolled_subject_mapping`
  ADD PRIMARY KEY (`study_path_id`,`subject_id`,`student_id`),
  ADD KEY `enrolled_student_fk` (`student_id`),
  ADD KEY `enrolled_subject_fk` (`subject_id`);

--
-- Indizes für die Tabelle `semster`
--
ALTER TABLE `semster`
  ADD PRIMARY KEY (`id`),
  ADD KEY `studypath_semster` (`study_path_id`);

--
-- Indizes für die Tabelle `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_email` (`email`);

--
-- Indizes für die Tabelle `student_studypath_mapping`
--
ALTER TABLE `student_studypath_mapping`
  ADD PRIMARY KEY (`study_path_id`,`student_id`);

--
-- Indizes für die Tabelle `student_subject_test`
--
ALTER TABLE `student_subject_test`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_id` (`student_id`,`subject_semster_id`),
  ADD KEY `test_subject_semester_fk` (`subject_semster_id`);

--
-- Indizes für die Tabelle `studypath`
--
ALTER TABLE `studypath`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uni_studypath` (`uni_id`);

--
-- Indizes für die Tabelle `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `subject_semster_mapping`
--
ALTER TABLE `subject_semster_mapping`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_subject_semster` (`semster_id`,`subject_id`) USING BTREE,
  ADD KEY `subject_fk` (`subject_id`);

--
-- Indizes für die Tabelle `university`
--
ALTER TABLE `university`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `semster`
--
ALTER TABLE `semster`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `student`
--
ALTER TABLE `student`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `student_subject_test`
--
ALTER TABLE `student_subject_test`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `studypath`
--
ALTER TABLE `studypath`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `subject`
--
ALTER TABLE `subject`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `subject_semster_mapping`
--
ALTER TABLE `subject_semster_mapping`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `university`
--
ALTER TABLE `university`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `enrolled_subject_mapping`
--
ALTER TABLE `enrolled_subject_mapping`
  ADD CONSTRAINT `enrolled_student_fk` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `enrolled_study_path_fk` FOREIGN KEY (`study_path_id`) REFERENCES `studypath` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `enrolled_subject_fk` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints der Tabelle `semster`
--
ALTER TABLE `semster`
  ADD CONSTRAINT `studypath_semster` FOREIGN KEY (`study_path_id`) REFERENCES `studypath` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints der Tabelle `student_subject_test`
--
ALTER TABLE `student_subject_test`
  ADD CONSTRAINT `test_student_fk` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `test_subject_semester_fk` FOREIGN KEY (`subject_semster_id`) REFERENCES `subject_semster_mapping` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints der Tabelle `studypath`
--
ALTER TABLE `studypath`
  ADD CONSTRAINT `uni_studypath` FOREIGN KEY (`uni_id`) REFERENCES `university` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints der Tabelle `subject_semster_mapping`
--
ALTER TABLE `subject_semster_mapping`
  ADD CONSTRAINT `semster_fk` FOREIGN KEY (`semster_id`) REFERENCES `semster` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `subject_fk` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
