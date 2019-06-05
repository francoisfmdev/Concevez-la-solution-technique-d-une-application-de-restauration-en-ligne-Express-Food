SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


CREATE TABLE IF NOT EXISTS `adresse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `NomRue` varchar(255) DEFAULT NULL,
  `CodePostale` int(11) DEFAULT NULL,
  `Ville` varchar(50) DEFAULT NULL,
  `Numero` int(11) DEFAULT NULL,
  `Clients_Id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Adresse_Clients1_idx` (`Clients_Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `adresse` (`id`, `NomRue`, `CodePostale`, `Ville`, `Numero`, `Clients_Id`) VALUES
(1, 'rue Lamartine', 6300, 'Nice', 12, 1),
(2, 'Avenue Napoleon', 59000, 'Lille ', 12, 2);

CREATE TABLE IF NOT EXISTS `clients` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `MotDePasse` varchar(15) DEFAULT NULL,
  `Nom` varchar(50) DEFAULT NULL,
  `Prenom` varchar(50) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Telephone` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `clients` (`Id`, `MotDePasse`, `Nom`, `Prenom`, `Email`, `Telephone`) VALUES
(1, '123456', 'Robert De Niro', 'Robert', 'robert2Niro@Jmail.com', '0654457822'),
(2, 'Javascript', 'VAAST', 'Aurelien', 'aurelienV@Jmail.com', '0600223344');

CREATE TABLE IF NOT EXISTS `commandes` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Etat` varchar(255) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Clients_Id` int(11) NOT NULL,
  `Adresse_id` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_Commandes_Clients1_idx` (`Clients_Id`),
  KEY `fk_Commandes_Adresse1_idx` (`Adresse_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `commandes` (`Id`, `Etat`, `Date`, `Clients_Id`, `Adresse_id`) VALUES
(1, 'En livraison', '2018-12-14 19:43:16', 2, 2),
(2, 'Attente de paiement ', '2018-12-15 20:31:16', 1, 1);

CREATE TABLE IF NOT EXISTS `commandesplat` (
  `Commandes_Id` int(11) NOT NULL,
  `Plat_id` int(11) NOT NULL,
  PRIMARY KEY (`Commandes_Id`,`Plat_id`),
  KEY `fk_Commandes_has_Plat_Plat1_idx` (`Plat_id`),
  KEY `fk_Commandes_has_Plat_Commandes1_idx` (`Commandes_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `commandesplat` (`Commandes_Id`, `Plat_id`) VALUES
(1, 1),
(1, 2),
(2, 2);

CREATE TABLE IF NOT EXISTS `cuisinier` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `EmailCuisinier` varchar(5255) DEFAULT NULL,
  `MotDePasse` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `cuisinier` (`Id`, `EmailCuisinier`, `MotDePasse`) VALUES
(1, 'CharlieCuistot@Mmail.fr', 'ch22101978'),
(2, 'Patou@Mail.fr', 'pat2018');

CREATE TABLE IF NOT EXISTS `livreur` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `MotDePasse` varchar(15) DEFAULT NULL,
  `Prenom` varchar(50) DEFAULT NULL,
  `Localisation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `livreur` (`Id`, `MotDePasse`, `Prenom`, `Localisation`) VALUES
(1, 'J12012000', 'Jean', ' GPS : 37,23 / -115,81'),
(2, 'plop1988', 'Zinedine', ' GPS : 17,23 / -70,81');

CREATE TABLE IF NOT EXISTS `livreurcommandes` (
  `Livreur_Id` int(11) NOT NULL,
  `Commandes_Id` int(11) NOT NULL,
  PRIMARY KEY (`Livreur_Id`,`Commandes_Id`),
  KEY `fk_Livreur_has_Commandes_Commandes1_idx` (`Commandes_Id`),
  KEY `fk_Livreur_has_Commandes_Livreur1_idx` (`Livreur_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `livreurcommandes` (`Livreur_Id`, `Commandes_Id`) VALUES
(1, 1);

CREATE TABLE IF NOT EXISTS `plat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(255) DEFAULT NULL,
  `Description` mediumtext,
  `Image` varchar(255) DEFAULT NULL,
  `Prix` float DEFAULT NULL,
  `Cuisinier_Id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Plat_Cuisinier_idx` (`Cuisinier_Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `plat` (`id`, `Nom`, `Description`, `Image`, `Prix`, `Cuisinier_Id`) VALUES
(1, 'Gratin de courgette au fromage de brebis', 'Un délicieux Gratin de courgette et fromage de brebis parfumé aux épices ', 'images/courgette.png', 9.99, 1),
(2, 'Confit de canard et ses pommes de terre ', 'Un Généreux confit de canard et ses pommes de terre cuite à la graisse de canard', 'images/cannard.png', 12.99, 2);


ALTER TABLE `adresse`
  ADD CONSTRAINT `adresse_ibfk_1` FOREIGN KEY (`Clients_Id`) REFERENCES `clients` (`Id`);

ALTER TABLE `commandes`
  ADD CONSTRAINT `commandes_ibfk_2` FOREIGN KEY (`Adresse_id`) REFERENCES `adresse` (`id`),
  ADD CONSTRAINT `commandes_ibfk_1` FOREIGN KEY (`Clients_Id`) REFERENCES `clients` (`Id`);

ALTER TABLE `plat`
  ADD CONSTRAINT `plat_ibfk_1` FOREIGN KEY (`Cuisinier_Id`) REFERENCES `cuisinier` (`Id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
