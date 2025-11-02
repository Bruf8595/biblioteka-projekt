-- База: bibliotekaruslan_zakruzhetskyi
-- Тільки CREATE (таблиці, PK, FK, VIEW, PROCEDURE)

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

DELIMITER $$

-- Процедуры
CREATE DEFINER=`root`@`localhost` PROCEDURE `AktywneWypozyczeniaUzytkownika` (IN `p_IdUzytkownik` INT) BEGIN
    SELECT * FROM AktywneWypozyczenia WHERE IdUzytkownik = p_IdUzytkownik;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteWypozyczenie` (IN `p_Id` INT) BEGIN
    DELETE FROM Wypozyczenia WHERE Id = p_Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertWypozyczenie` (IN `p_IdUzytkownik` INT, IN `p_IdEgzemplarz` INT, IN `p_DataPlanowanegoZwrotu` DATE) BEGIN
    INSERT INTO Wypozyczenia (IdUzytkownik, IdEgzemplarz, DataPlanowanegoZwrotu)
    VALUES (p_IdUzytkownik, p_IdEgzemplarz, p_DataPlanowanegoZwrotu);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateWypozyczenie` (IN `p_Id` INT, IN `p_DataPlanowanegoZwrotu` DATE) BEGIN
    UPDATE Wypozyczenia SET DataPlanowanegoZwrotu = p_DataPlanowanegoZwrotu WHERE Id = p_Id;
END$$

DELIMITER ;

-- Таблиці
CREATE TABLE `adresy` (
  `Id` int(11) NOT NULL,
  `IdUzytkownik` int(11) NOT NULL,
  `Ulica` varchar(100) DEFAULT NULL,
  `Miasto` varchar(100) DEFAULT NULL,
  `KodPocztowy` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

CREATE TABLE `autorzy` (
  `Id` int(11) NOT NULL,
  `Imie` varchar(100) NOT NULL,
  `Nazwisko` varchar(100) NOT NULL,
  `DataUrodzenia` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

CREATE TABLE `egzemplarze` (
  `Id` int(11) NOT NULL,
  `IdKsiazka` int(11) NOT NULL,
  `NumerSeryjny` varchar(50) DEFAULT NULL,
  `IdStatus` int(11) DEFAULT NULL,
  `IdLokalizacja` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

CREATE TABLE `kary` (
  `Id` int(11) NOT NULL,
  `IdWypozyczenie` int(11) NOT NULL,
  `Kwota` decimal(10,2) NOT NULL,
  `DataNaliczenia` date DEFAULT curdate(),
  `Opis` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

CREATE TABLE `kategorie` (
  `Id` int(11) NOT NULL,
  `Nazwa` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

CREATE TABLE `ksiazki` (
  `Id` int(11) NOT NULL,
  `Tytul` varchar(255) NOT NULL,
  `ISBN` varchar(20) DEFAULT NULL,
  `RokWydania` year(4) DEFAULT NULL,
  `IdAutor` int(11) DEFAULT NULL,
  `IdWydawca` int(11) DEFAULT NULL,
  `IdKategoria` int(11) DEFAULT NULL,
  `IdTypKsiazki` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

CREATE TABLE `lokalizacje` (
  `Id` int(11) NOT NULL,
  `Regal` varchar(50) DEFAULT NULL,
  `Polka` int(11) DEFAULT NULL,
  `Opis` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

CREATE TABLE `rezerwacje` (
  `Id` int(11) NOT NULL,
  `IdUzytkownik` int(11) NOT NULL,
  `IdKsiazka` int(11) NOT NULL,
  `DataRezerwacji` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

CREATE TABLE `statusyksiazek` (
  `Id` int(11) NOT NULL,
  `Nazwa` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

CREATE TABLE `typyksiazek` (
  `Id` int(11) NOT NULL,
  `Nazwa` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

CREATE TABLE `typyuzytkownikow` (
  `Id` int(11) NOT NULL,
  `Nazwa` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

CREATE TABLE `uzytkownicy` (
  `Id` int(11) NOT NULL,
  `Imie` varchar(100) NOT NULL,
  `Nazwisko` varchar(100) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Telefon` varchar(20) DEFAULT NULL,
  `DataRejestracji` date DEFAULT curdate(),
  `IdTypUzytkownika` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

CREATE TABLE `wydawcy` (
  `Id` int(11) NOT NULL,
  `Nazwa` varchar(100) NOT NULL,
  `Adres` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

CREATE TABLE `wypozyczenia` (
  `Id` int(11) NOT NULL,
  `IdUzytkownik` int(11) NOT NULL,
  `IdEgzemplarz` int(11) NOT NULL,
  `DataWypozyczenia` date DEFAULT curdate(),
  `DataPlanowanegoZwrotu` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

CREATE TABLE `zwroty` (
  `Id` int(11) NOT NULL,
  `IdWypozyczenie` int(11) NOT NULL,
  `DataZwrotu` date DEFAULT curdate(),
  `StanZwrotu` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- Види (Views)
DROP TABLE IF EXISTS `aktywnewypozyczenia`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `aktywnewypozyczenia` AS 
SELECT `w`.`Id` AS `Id`, `u`.`Imie` AS `Imie`, `u`.`Nazwisko` AS `Nazwisko`, `k`.`Tytul` AS `Tytul`, 
       `w`.`DataWypozyczenia` AS `DataWypozyczenia`, `w`.`DataPlanowanegoZwrotu` AS `DataPlanowanegoZwrotu` 
FROM ((((`wypozyczenia` `w` join `uzytkownicy` `u` on(`w`.`IdUzytkownik` = `u`.`Id`)) 
join `egzemplarze` `e` on(`w`.`IdEgzemplarz` = `e`.`Id`)) 
join `ksiazki` `k` on(`e`.`IdKsiazka` = `k`.`Id`)) 
left join `zwroty` `z` on(`w`.`Id` = `z`.`IdWypozyczenie`)) 
WHERE `z`.`Id` is null;

DROP TABLE IF EXISTS `niedostepneksiazki`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `niedostepneksiazki` AS 
SELECT DISTINCT `k`.`Id` AS `Id`, `k`.`Tytul` AS `Tytul`, `a`.`Imie` AS `Imie`, `a`.`Nazwisko` AS `Nazwisko`, 'Wypożyczona' AS `Status` 
FROM (((`ksiazki` `k` join `autorzy` `a` on(`k`.`IdAutor` = `a`.`Id`)) 
join `egzemplarze` `e` on(`k`.`Id` = `e`.`IdKsiazka`)) 
join `statusyksiazek` `s` on(`e`.`IdStatus` = `s`.`Id`)) 
WHERE `s`.`Nazwa` = 'Wypożyczona'
UNION 
SELECT `k`.`Id` AS `Id`,`k`.`Tytul` AS `Tytul`,`a`.`Imie` AS `Imie`,`a`.`Nazwisko` AS `Nazwisko`,'Zarezerwowana' AS `Zarezerwowana` 
FROM ((`ksiazki` `k` join `autorzy` `a` on(`k`.`IdAutor` = `a`.`Id`)) 
join `rezerwacje` `r` on(`k`.`Id` = `r`.`IdKsiazka`));

DROP TABLE IF EXISTS `wypozyczeniapoterminie`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wypozyczeniapoterminie` AS 
SELECT `w`.`Id` AS `Id`, `u`.`Imie` AS `Imie`, `u`.`Nazwisko` AS `Nazwisko`, `k`.`Tytul` AS `Tytul`, 
       `w`.`DataWypozyczenia` AS `DataWypozyczenia`, `w`.`DataPlanowanegoZwrotu` AS `DataPlanowanegoZwrotu`, 
       to_days(curdate()) - to_days(`w`.`DataPlanowanegoZwrotu`) AS `DniOpóznienia` 
FROM ((((`wypozyczenia` `w` join `uzytkownicy` `u` on(`w`.`IdUzytkownik` = `u`.`Id`)) 
join `egzemplarze` `e` on(`w`.`IdEgzemplarz` = `e`.`Id`)) 
join `ksiazki` `k` on(`e`.`IdKsiazka` = `k`.`Id`)) 
left join `zwroty` `z` on(`w`.`Id` = `z`.`IdWypozyczenie`)) 
WHERE `z`.`Id` is null AND `w`.`DataPlanowanegoZwrotu` < curdate();

-- PK, FK, AUTO_INCREMENT
ALTER TABLE `adresy` ADD PRIMARY KEY (`Id`), ADD KEY `IdUzytkownik` (`IdUzytkownik`);
ALTER TABLE `autorzy` ADD PRIMARY KEY (`Id`);
ALTER TABLE `egzemplarze` ADD PRIMARY KEY (`Id`), ADD UNIQUE KEY `NumerSeryjny` (`NumerSeryjny`), ADD KEY `IdKsiazka` (`IdKsiazka`), ADD KEY `IdStatus` (`IdStatus`), ADD KEY `IdLokalizacja` (`IdLokalizacja`);
ALTER TABLE `kary` ADD PRIMARY KEY (`Id`), ADD KEY `IdWypozyczenie` (`IdWypozyczenie`);
ALTER TABLE `kategorie` ADD PRIMARY KEY (`Id`), ADD UNIQUE KEY `Nazwa` (`Nazwa`);
ALTER TABLE `ksiazki` ADD PRIMARY KEY (`Id`), ADD UNIQUE KEY `ISBN` (`ISBN`), ADD KEY `IdAutor` (`IdAutor`), ADD KEY `IdWydawca` (`IdWydawca`), ADD KEY `IdKategoria` (`IdKategoria`), ADD KEY `IdTypKsiazki` (`IdTypKsiazki`);
ALTER TABLE `lokalizacje` ADD PRIMARY KEY (`Id`);
ALTER TABLE `rezerwacje` ADD PRIMARY KEY (`Id`), ADD KEY `IdUzytkownik` (`IdUzytkownik`), ADD KEY `IdKsiazka` (`IdKsiazka`);
ALTER TABLE `statusyksiazek` ADD PRIMARY KEY (`Id`), ADD UNIQUE KEY `Nazwa` (`Nazwa`);
ALTER TABLE `typyksiazek` ADD PRIMARY KEY (`Id`), ADD UNIQUE KEY `Nazwa` (`Nazwa`);
ALTER TABLE `typyuzytkownikow` ADD PRIMARY KEY (`Id`), ADD UNIQUE KEY `Nazwa` (`Nazwa`);
ALTER TABLE `uzytkownicy` ADD PRIMARY KEY (`Id`), ADD UNIQUE KEY `Email` (`Email`), ADD KEY `IdTypUzytkownika` (`IdTypUzytkownika`);
ALTER TABLE `wydawcy` ADD PRIMARY KEY (`Id`);
ALTER TABLE `wypozyczenia` ADD PRIMARY KEY (`Id`), ADD KEY `IdUzytkownik` (`IdUzytkownik`), ADD KEY `IdEgzemplarz` (`IdEgzemplarz`);
ALTER TABLE `zwroty` ADD PRIMARY KEY (`Id`), ADD KEY `IdWypozyczenie` (`IdWypozyczenie`);

ALTER TABLE `adresy` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `autorzy` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `egzemplarze` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `kary` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `kategorie` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `ksiazki` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `lokalizacje` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `rezerwacje` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `statusyksiazek` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `typyksiazek` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `typyuzytkownikow` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `uzytkownicy` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `wydawcy` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `wypozyczenia` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `zwroty` MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

-- FK
ALTER TABLE `adresy` ADD CONSTRAINT `adresy_ibfk_1` FOREIGN KEY (`IdUzytkownik`) REFERENCES `uzytkownicy` (`Id`) ON DELETE CASCADE;
ALTER TABLE `egzemplarze` ADD CONSTRAINT `egzemplarze_ibfk_1` FOREIGN KEY (`IdKsiazka`) REFERENCES `ksiazki` (`Id`) ON DELETE CASCADE,
                          ADD CONSTRAINT `egzemplarze_ibfk_2` FOREIGN KEY (`IdStatus`) REFERENCES `statusyksiazek` (`Id`) ON DELETE SET NULL,
                          ADD CONSTRAINT `egzemplarze_ibfk_3` FOREIGN KEY (`IdLokalizacja`) REFERENCES `lokalizacje` (`Id`) ON DELETE SET NULL;
ALTER TABLE `kary` ADD CONSTRAINT `kary_ibfk_1` FOREIGN KEY (`IdWypozyczenie`) REFERENCES `wypozyczenia` (`Id`) ON DELETE CASCADE;
ALTER TABLE `ksiazki` ADD CONSTRAINT `ksiazki_ibfk_1` FOREIGN KEY (`IdAutor`) REFERENCES `autorzy` (`Id`) ON DELETE SET NULL,
                       ADD CONSTRAINT `ksiazki_ibfk_2` FOREIGN KEY (`IdWydawca`) REFERENCES `wydawcy` (`Id`) ON DELETE SET NULL,
                       ADD CONSTRAINT `ksiazki_ibfk_3` FOREIGN KEY (`IdKategoria`) REFERENCES `kategorie` (`Id`) ON DELETE SET NULL,
                       ADD CONSTRAINT `ksiazki_ibfk_4` FOREIGN KEY (`IdTypKsiazki`) REFERENCES `typyksiazek` (`Id`) ON DELETE SET NULL;
ALTER TABLE `rezerwacje` ADD CONSTRAINT `rezerwacje_ibfk_1` FOREIGN KEY (`IdUzytkownik`) REFERENCES `uzytkownicy` (`Id`) ON DELETE CASCADE,
                          ADD CONSTRAINT `rezerwacje_ibfk_2` FOREIGN KEY (`IdKsiazka`) REFERENCES `ksiazki` (`Id`) ON DELETE CASCADE;
ALTER TABLE `uzytkownicy` ADD CONSTRAINT `uzytkownicy_ibfk_1` FOREIGN KEY (`IdTypUzytkownika`) REFERENCES `typyuzytkownikow` (`Id`) ON DELETE SET NULL;
ALTER TABLE `wypozyczenia` ADD CONSTRAINT `wypozyczenia_ibfk_1` FOREIGN KEY (`IdUzytkownik`) REFERENCES `uzytkownicy` (`Id`) ON DELETE CASCADE,
                            ADD CONSTRAINT `wypozyczenia_ibfk_2` FOREIGN KEY (`IdEgzemplarz`) REFERENCES `egzemplarze` (`Id`) ON DELETE CASCADE;
ALTER TABLE `zwroty` ADD CONSTRAINT `zwroty_ibfk_1` FOREIGN KEY (`IdWypozyczenie`) REFERENCES `wypozyczenia` (`Id`) ON DELETE CASCADE;

COMMIT;