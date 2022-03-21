-- phpMyAdmin SQL Dump
-- version 4.5.4.1
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Dim 13 Mars 2022 à 22:07
-- Version du serveur :  5.7.11
-- Version de PHP :  5.6.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `mediatek2022`
--

-- --------------------------------------------------------

--
-- Structure de la table `document`
--

CREATE TABLE `document` (
  `idDocument` int(11) NOT NULL,
  `titreDocument` varchar(35) COLLATE utf8_bin NOT NULL,
  `disponible` tinyint(1) NOT NULL,
  `typeDocument` varchar(20) COLLATE utf8_bin NOT NULL,
  `auteur` varchar(50) COLLATE utf8_bin NOT NULL,
  `idUtilsateurEmprunt` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Contenu de la table `document`
--

INSERT INTO `document` (`idDocument`, `titreDocument`, `disponible`, `typeDocument`, `auteur`, `idUtilsateurEmprunt`) VALUES
(38, 'Le Roi Lion', 0, 'DVD', 'Rob Minkof', 2),
(39, 'Cendrillon', 1, 'DVD', 'Clyde Geronimi', NULL),
(40, 'Spider-Man : No Way Home', 0, 'DVD', 'Jon Watts', 3),
(41, 'Les 101 Dalmatiens', 0, 'DVD', 'Wolfang Reitherman', 3),
(42, 'Au revoir la-haut', 0, 'Livre', 'Pierre Lemaitre', 3),
(43, 'Les fleurs du Mal', 0, 'Livre', 'Charles Baudelaire', 3),
(44, 'Madame Bovary', 0, 'Livre', 'Gustave Flaubert', 2),
(45, 'Germinal', 0, 'Livre', 'Emile Zola', 2),
(46, 'Peter Pan', 1, 'DVD', 'Hamilton Luske', NULL),
(47, 'Thriller', 0, 'CD', 'Michael Jackson', 2),
(48, 'Nevermind', 1, 'CD', 'Nirvana', NULL),
(49, 'The Beatles', 0, 'CD', 'Les Beatles', 3),
(50, 'The Eminem Show', 0, 'CD', 'Eminem', 2),
(51, 'Meteora', 1, 'CD', 'Linkin Park', NULL),
(52, 'Au bonheur des dames', 1, 'Livre', 'Emile Zola', NULL),
(53, 'La Parure', 1, 'Livre', 'Maupassant', NULL),
(54, 'Les miserables', 1, 'Livre', 'Victor Hugo', NULL),
(55, 'Candide', 1, 'Livre', 'Voltaire', NULL),
(56, 'La condition Humaine', 1, 'Livre', 'Andre Malraux', NULL),
(57, 'Notre-Dame de Paris', 0, 'Livre', 'Victor Hugo', 3),
(58, 'Interstellar', 1, 'DVD', 'Christopher Nolan', NULL),
(59, 'Mission Impossible', 1, 'DVD', 'Bruce Geller', NULL),
(60, 'The Dark Side Of The Moon', 1, 'CD', 'Pink Floyd', NULL),
(61, 'Bad', 0, 'CD', 'Michael Jackson', 3),
(62, 'Hunky Dory', 1, 'CD', 'David Bowie', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `idUtilisateur` int(11) NOT NULL,
  `age` int(11) NOT NULL,
  `bibliothecaire` tinyint(1) NOT NULL,
  `login` varchar(25) COLLATE utf8_bin NOT NULL,
  `password` varchar(16) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Contenu de la table `utilisateur`
--

INSERT INTO `utilisateur` (`idUtilisateur`, `age`, `bibliothecaire`, `login`, `password`) VALUES
(1, 19, 1, 'Elyes', 'Elyes'),
(2, 18, 0, 'Daniyal', 'Slim'),
(3, 19, 0, 'Mourad', 'Ouziri'),
(4, 19, 0, 'Admin', 'Elyes');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`idDocument`),
  ADD UNIQUE KEY `titreDocument` (`titreDocument`,`typeDocument`,`auteur`),
  ADD KEY `idUtilsateurEmprunt` (`idUtilsateurEmprunt`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`idUtilisateur`),
  ADD UNIQUE KEY `login` (`login`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `document`
--
ALTER TABLE `document`
  MODIFY `idDocument` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;
--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `idUtilisateur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `document`
--
ALTER TABLE `document`
  ADD CONSTRAINT `document_ibfk_1` FOREIGN KEY (`idUtilsateurEmprunt`) REFERENCES `utilisateur` (`idUtilisateur`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
