-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Ноя 19 2025 г., 20:45
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
-- База данных: `bibliotekaruslan_zakruzhetskyi`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AktywneWypozyczeniaUzytkownika` (IN `p_IdUzytkownik` INT)   BEGIN
    SELECT * FROM AktywneWypozyczenia WHERE IdUzytkownik = p_IdUzytkownik;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteWypozyczenie` (IN `p_Id` INT)   BEGIN
    DELETE FROM Wypozyczenia WHERE Id = p_Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertWypozyczenie` (IN `p_IdUzytkownik` INT, IN `p_IdEgzemplarz` INT, IN `p_DataPlanowanegoZwrotu` DATE)   BEGIN
    INSERT INTO Wypozyczenia (IdUzytkownik, IdEgzemplarz, DataPlanowanegoZwrotu)
    VALUES (p_IdUzytkownik, p_IdEgzemplarz, p_DataPlanowanegoZwrotu);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateWypozyczenie` (IN `p_Id` INT, IN `p_DataPlanowanegoZwrotu` DATE)   BEGIN
    UPDATE Wypozyczenia SET DataPlanowanegoZwrotu = p_DataPlanowanegoZwrotu WHERE Id = p_Id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `aktywnewypozyczenia`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `aktywnewypozyczenia` (
`Id` int(11)
,`Imie` varchar(100)
,`Nazwisko` varchar(100)
,`Tytul` varchar(255)
,`DataWypozyczenia` date
,`DataPlanowanegoZwrotu` date
);

-- --------------------------------------------------------

--
-- Структура таблицы `autorzy`
--

CREATE TABLE `autorzy` (
  `Id` int(11) NOT NULL,
  `Imie` varchar(100) NOT NULL,
  `Nazwisko` varchar(100) NOT NULL,
  `DataUrodzenia` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `autorzy`
--

INSERT INTO `autorzy` (`Id`, `Imie`, `Nazwisko`, `DataUrodzenia`) VALUES
(1, 'J.K.', 'Rowling', '1965-07-31'),
(2, 'J.R.R.', 'Tolkien', '1892-01-03'),
(3, 'Stephen', 'King', '1947-09-21'),
(4, 'Andrzej', 'Sapkowski', '1948-06-21'),
(5, 'George', 'Orwell', '1903-06-25'),
(6, 'Agatha', 'Christie', '1890-09-15'),
(7, 'Stanisław', 'Lem', '1921-09-12'),
(8, 'Henryk', 'Sienkiewicz', '1846-05-05'),
(9, 'Joanne', 'Harris', '1964-07-03'),
(10, 'Dan', 'Brown', '1964-06-22'),
(11, 'Haruki', 'Murakami', '1949-01-12'),
(12, 'Margaret', 'Atwood', '1939-11-18'),
(13, 'Neil', 'Gaiman', '1960-11-10'),
(14, 'Terry', 'Pratchett', '1948-04-28'),
(15, 'Isaac', 'Asimov', '1920-01-02'),
(16, 'Ray', 'Bradbury', '1920-08-22'),
(17, 'Philip', 'Dick', '1928-12-16'),
(18, 'Ursula', 'Le Guin', '1929-10-21'),
(19, 'Frank', 'Herbert', '1920-10-08'),
(20, 'Arthur', 'Clarke', '1917-12-16');

-- --------------------------------------------------------

--
-- Структура таблицы `egzemplarze`
--

CREATE TABLE `egzemplarze` (
  `Id` int(11) NOT NULL,
  `IdKsiazka` int(11) NOT NULL,
  `NumerSeryjny` varchar(50) DEFAULT NULL,
  `IdStatus` int(11) DEFAULT NULL,
  `IdLokalizacja` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `egzemplarze`
--

INSERT INTO `egzemplarze` (`Id`, `IdKsiazka`, `NumerSeryjny`, `IdStatus`, `IdLokalizacja`) VALUES
(1, 1, 'HP001', 1, 1),
(2, 1, 'HP002', 2, 2),
(3, 2, 'WP001', 1, 3),
(4, 2, 'WP002', 1, 4),
(5, 3, 'LS001', 2, 5),
(6, 4, 'WZ001', 1, 6),
(7, 5, '1984-01', 1, 7),
(8, 6, 'MORDERSTWO-01', 2, 8),
(9, 7, 'SOLARIS-01', 1, 9),
(10, 8, 'QUO-01', 1, 10),
(11, 9, 'CZEKOLADA-01', 1, 11),
(12, 10, 'KOD-01', 2, 12),
(13, 11, '1Q84-01', 1, 13),
(14, 12, 'OPOWIESC-01', 1, 14),
(15, 13, 'BOGOWIE-01', 2, 15),
(16, 14, 'OMEN-01', 1, 16),
(17, 15, 'FUNDACJA-01', 1, 17),
(18, 16, '451-01', 1, 18),
(19, 17, 'UBIK-01', 2, 19),
(20, 18, 'LEWA-01', 1, 20),
(21, 19, 'DIUNA-01', 1, 1),
(22, 20, '2001-01', 2, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `kary`
--

CREATE TABLE `kary` (
  `Id` int(11) NOT NULL,
  `IdWypozyczenie` int(11) NOT NULL,
  `Kwota` decimal(10,2) NOT NULL,
  `DataNaliczenia` date DEFAULT curdate(),
  `Opis` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `kary`
--

INSERT INTO `kary` (`Id`, `IdWypozyczenie`, `Kwota`, `DataNaliczenia`, `Opis`) VALUES
(1, 2, 15.00, '2025-11-02', 'Opóźnienie 3 dni'),
(2, 4, 10.00, '2025-11-02', 'Opóźnienie 2 dni'),
(3, 6, 20.00, '2025-11-02', 'Opóźnienie 5 dni'),
(4, 8, 5.00, '2025-11-02', 'Lekkie uszkodzenie'),
(5, 10, 30.00, '2025-11-02', 'Zniszczenie okładki');

-- --------------------------------------------------------

--
-- Структура таблицы `kategorie`
--

CREATE TABLE `kategorie` (
  `Id` int(11) NOT NULL,
  `Nazwa` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `kategorie`
--

INSERT INTO `kategorie` (`Id`, `Nazwa`) VALUES
(6, 'Biografia'),
(12, 'Dramat'),
(7, 'Dzieci'),
(1, 'Fantastyka'),
(5, 'Historia'),
(9, 'Horror'),
(13, 'Komiks'),
(2, 'Kryminał'),
(8, 'Młodzież'),
(4, 'Nauka'),
(15, 'Podróż'),
(11, 'Poezja'),
(14, 'Poradnik'),
(3, 'Romans'),
(10, 'Thriller');

-- --------------------------------------------------------

--
-- Структура таблицы `ksiazki`
--

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

--
-- Дамп данных таблицы `ksiazki`
--

INSERT INTO `ksiazki` (`Id`, `Tytul`, `ISBN`, `RokWydania`, `IdAutor`, `IdWydawca`, `IdKategoria`, `IdTypKsiazki`) VALUES
(1, 'Harry Potter i Kamień Filozoficzny', '9788372782810', '2000', 1, 1, 1, 1),
(2, 'Władca Pierścieni', '9788373191722', '2001', 2, 2, 1, 1),
(3, 'Lśnienie', '9788378859732', '2014', 3, 3, 9, 1),
(4, 'Wiedźmin: Ostatnie życzenie', '9788375780640', '2014', 4, 4, 1, 1),
(5, 'Rok 1984', '9788377588955', '2015', 5, 5, 1, 1),
(6, 'Morderstwo w Orient Expressie', '9788327156420', '2017', 6, 6, 2, 1),
(7, 'Solaris', '9788307023561', '2018', 7, 7, 1, 1),
(8, 'Quo Vadis', '9788373271895', '2010', 8, 8, 5, 1),
(9, 'Czekolada', '9788375103942', '2010', 9, 9, 3, 1),
(10, 'Kod Leonarda da Vinci', '9788375089453', '2016', 10, 10, 10, 1),
(11, '1Q84', '9788377583456', '2013', 11, 11, 1, 1),
(12, 'Opowieść Podręcznej', '9788380322786', '2018', 12, 12, 1, 1),
(13, 'Amerykańscy bogowie', '9788374808458', '2018', 13, 13, 1, 1),
(14, 'Dobry Omen', '9788381164895', '2018', 14, 14, 1, 1),
(15, 'Fundacja', '9788375107892', '2012', 15, 15, 1, 1),
(16, '451 stopni Fahrenheita', '9788377589456', '2015', 16, 16, 1, 1),
(17, 'Ubik', '9788375109456', '2013', 17, 17, 1, 1),
(18, 'Lewa ręka ciemności', '9788374809456', '2019', 18, 18, 1, 1),
(19, 'Diuna', '9788380623456', '2018', 19, 19, 1, 1),
(20, '2001: Odyseja kosmiczna', '9788375103456', '2011', 20, 20, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `lokalizacje`
--

CREATE TABLE `lokalizacje` (
  `Id` int(11) NOT NULL,
  `Regal` varchar(50) DEFAULT NULL,
  `Polka` int(11) DEFAULT NULL,
  `Opis` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `lokalizacje`
--

INSERT INTO `lokalizacje` (`Id`, `Regal`, `Polka`, `Opis`) VALUES
(1, 'A1', 1, 'Główna sala'),
(2, 'A1', 2, 'Główna sala'),
(3, 'B2', 3, 'Czytelnia'),
(4, 'C3', 1, 'Magazyn'),
(5, 'D4', 5, 'Dzieci'),
(6, 'E5', 2, 'Nauka'),
(7, 'F6', 4, 'Literatura piękna'),
(8, 'G7', 1, 'Archiwum'),
(9, 'H8', 3, 'Audiobooki'),
(10, 'I9', 2, 'Czasopisma'),
(11, 'A1', 3, 'Nowe nabytki'),
(12, 'B2', 1, 'Bestsellery'),
(13, 'C3', 4, 'E-booki'),
(14, 'D4', 2, 'Komiksy'),
(15, 'E5', 5, 'Podręczniki'),
(16, 'F6', 1, 'Encyklopedie'),
(17, 'G7', 3, 'Mapy'),
(18, 'H8', 2, 'Płyty'),
(19, 'I9', 4, 'Zbiory specjalne'),
(20, 'A1', 5, 'Rezerwaty');

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `niedostepneksiazki`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `niedostepneksiazki` (
`Id` int(11)
,`Tytul` varchar(255)
,`Imie` varchar(100)
,`Nazwisko` varchar(100)
,`Status` varchar(13)
);

-- --------------------------------------------------------

--
-- Структура таблицы `pracownicy`
--

CREATE TABLE `pracownicy` (
  `Id` int(11) NOT NULL,
  `Imie` varchar(100) NOT NULL,
  `Nazwisko` varchar(100) NOT NULL,
  `DataUrodzenia` date NOT NULL,
  `Stanowisko` varchar(100) DEFAULT 'Bibliotekarz'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `pracownicy`
--

INSERT INTO `pracownicy` (`Id`, `Imie`, `Nazwisko`, `DataUrodzenia`, `Stanowisko`) VALUES
(1, 'Jan', 'Kowalski', '1985-03-15', 'Bibliotekarz'),
(2, 'Maria', 'Nowak', '1992-07-22', 'Starszy bibliotekarz'),
(3, 'Piotr', 'Wiśniewski', '1978-11-30', 'Kierownik'),
(4, 'Anna', 'Wójcik', '1995-01-10', 'Bibliotekarz'),
(5, 'Tomasz', 'Kamiński', '1980-05-18', 'Bibliotekarz'),
(6, 'Katarzyna', 'Lewandowska', '2000-09-05', 'Stażyta'),
(7, 'Michał', 'Zieliński', '1988-12-20', 'Bibliotekarz'),
(8, 'Agnieszka', 'Szymańska', '1998-04-25', 'Bibliotekarz'),
(9, 'Krzysztof', 'Woźniak', '1975-08-14', 'Kierownik zmiany'),
(10, 'Magdalena', 'Kozłowska', '1993-06-30', 'Bibliotekarz');

-- --------------------------------------------------------

--
-- Структура таблицы `rezerwacje`
--

CREATE TABLE `rezerwacje` (
  `Id` int(11) NOT NULL,
  `IdUzytkownik` int(11) NOT NULL,
  `IdKsiazka` int(11) NOT NULL,
  `DataRezerwacji` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `rezerwacje`
--

INSERT INTO `rezerwacje` (`Id`, `IdUzytkownik`, `IdKsiazka`, `DataRezerwacji`) VALUES
(1, 1, 2, '2025-11-02'),
(2, 2, 4, '2025-11-02'),
(3, 3, 6, '2025-11-02'),
(4, 4, 8, '2025-11-02'),
(5, 5, 10, '2025-11-02'),
(6, 6, 12, '2025-11-02'),
(7, 7, 14, '2025-11-02'),
(8, 8, 16, '2025-11-02'),
(9, 9, 18, '2025-11-02'),
(10, 10, 20, '2025-11-02');

-- --------------------------------------------------------

--
-- Структура таблицы `statusyksiazek`
--

CREATE TABLE `statusyksiazek` (
  `Id` int(11) NOT NULL,
  `Nazwa` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `statusyksiazek`
--

INSERT INTO `statusyksiazek` (`Id`, `Nazwa`) VALUES
(5, 'Archiwizowana'),
(10, 'Audiobook'),
(11, 'Czasopismo'),
(17, 'Do czytania na miejscu'),
(1, 'Dostępna'),
(15, 'DVD'),
(9, 'E-book'),
(16, 'Egzemplarz wzorcowy'),
(12, 'Komiks'),
(13, 'Mapa'),
(20, 'Nowa'),
(14, 'Płyta CD'),
(3, 'Uszkodzona'),
(6, 'W naprawie'),
(19, 'W oprawie'),
(8, 'Wycofana'),
(2, 'Wypożyczona'),
(7, 'Zaginiona'),
(4, 'Zarezerwowana'),
(18, 'Zniszczona');

-- --------------------------------------------------------

--
-- Структура таблицы `typyksiazek`
--

CREATE TABLE `typyksiazek` (
  `Id` int(11) NOT NULL,
  `Nazwa` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `typyksiazek`
--

INSERT INTO `typyksiazek` (`Id`, `Nazwa`) VALUES
(8, 'Atlas'),
(3, 'Audiobook'),
(4, 'Czasopismo'),
(2, 'E-book'),
(7, 'Encyklopedia'),
(5, 'Komiks'),
(1, 'Papierowa'),
(6, 'Podręcznik'),
(10, 'Powieść'),
(9, 'Słownik');

-- --------------------------------------------------------

--
-- Структура таблицы `typyuzytkownikow`
--

CREATE TABLE `typyuzytkownikow` (
  `Id` int(11) NOT NULL,
  `Nazwa` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `typyuzytkownikow`
--

INSERT INTO `typyuzytkownikow` (`Id`, `Nazwa`) VALUES
(4, 'Bibliotekarz'),
(13, 'Dorosły'),
(5, 'Dziecko'),
(11, 'Dziecko <12'),
(14, 'Emeryt'),
(15, 'Firma'),
(3, 'Gość'),
(10, 'Inny'),
(16, 'Instytucja'),
(20, 'Klub'),
(12, 'Młodzież'),
(2, 'Nauczyciel'),
(8, 'Pracownik'),
(18, 'Przedszkole'),
(6, 'Senior'),
(1, 'Student'),
(17, 'Szkoła'),
(19, 'Uniwersytet'),
(7, 'VIP'),
(9, 'Wolontariusz');

-- --------------------------------------------------------

--
-- Структура таблицы `typy_adresow`
--

CREATE TABLE `typy_adresow` (
  `Id` int(11) NOT NULL,
  `Typ` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `typy_adresow`
--

INSERT INTO `typy_adresow` (`Id`, `Typ`) VALUES
(2, 'Korespondencyjny'),
(1, 'Zameldowania');

-- --------------------------------------------------------

--
-- Структура таблицы `uzytkownicy`
--

CREATE TABLE `uzytkownicy` (
  `Id` int(11) NOT NULL,
  `Imie` varchar(100) NOT NULL,
  `Nazwisko` varchar(100) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Telefon` varchar(20) DEFAULT NULL,
  `DataRejestracji` date DEFAULT curdate(),
  `IdTypUzytkownika` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `uzytkownicy`
--

INSERT INTO `uzytkownicy` (`Id`, `Imie`, `Nazwisko`, `Email`, `Telefon`, `DataRejestracji`, `IdTypUzytkownika`) VALUES
(1, 'Anna', 'Kowalska', 'anna@example.com', '111222333', '2025-11-02', 1),
(2, 'Piotr', 'Nowak', 'piotr@example.com', '222333444', '2025-11-02', 1),
(3, 'Kasia', 'Wiśniewska', 'kasia@example.com', '333444555', '2025-11-02', 2),
(4, 'Tomasz', 'Zieliński', 'tomasz@example.com', '444555666', '2025-11-02', 3),
(5, 'Ola', 'Dąbrowska', 'ola@example.com', '555666777', '2025-11-02', 1),
(6, 'Marek', 'Lewandowski', 'marek@example.com', '666777888', '2025-11-02', 2),
(7, 'Julia', 'Wójcik', 'julia@example.com', '777888999', '2025-11-02', 1),
(8, 'Kuba', 'Kamiński', 'kuba@example.com', '888999000', '2025-11-02', 3),
(9, 'Natalia', 'Krawczyk', 'natalia@example.com', '999000111', '2025-11-02', 1),
(10, 'Bartek', 'Pawłowski', 'bartek@example.com', '000111222', '2025-11-02', 2),
(11, 'Wiktoria', 'Michalska', 'wiktoria@example.com', '111222333', '2025-11-02', 1),
(12, 'Szymon', 'Sikora', 'szymon@example.com', '222333444', '2025-11-02', 3),
(13, 'Zuzanna', 'Wróbel', 'zuzanna@example.com', '333444555', '2025-11-02', 1),
(14, 'Filip', 'Jabłoński', 'filip@example.com', '444555666', '2025-11-02', 2),
(15, 'Lena', 'Król', 'lena@example.com', '555666777', '2025-11-02', 1),
(16, 'Igor', 'Pietrzak', 'igor@example.com', '666777888', '2025-11-02', 3),
(17, 'Milena', 'Kubiak', 'milena@example.com', '777888999', '2025-11-02', 1),
(18, 'Dominik', 'Zając', 'dominik@example.com', '888999000', '2025-11-02', 2),
(19, 'Emilia', 'Wieczorek', 'emilia@example.com', '999000111', '2025-11-02', 1),
(20, 'Patryk', 'Jaworski', 'patryk@example.com', '000111222', '2025-11-02', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `uzytkownicy_adresy`
--

CREATE TABLE `uzytkownicy_adresy` (
  `IdUzytkownik` int(11) NOT NULL,
  `IdTypAdresu` int(11) NOT NULL,
  `Ulica` varchar(100) DEFAULT NULL,
  `Miasto` varchar(100) DEFAULT NULL,
  `KodPocztowy` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `uzytkownicy_adresy`
--

INSERT INTO `uzytkownicy_adresy` (`IdUzytkownik`, `IdTypAdresu`, `Ulica`, `Miasto`, `KodPocztowy`) VALUES
(1, 1, 'ul. Floriańska 1', 'Kraków', '30-001'),
(2, 1, 'ul. Marszałkowska 10', 'Warszawa', '00-001'),
(3, 1, 'ul. Gdańska 5', 'Bydgoszcz', '85-001'),
(4, 1, 'ul. Świdnicka 20', 'Wrocław', '50-001'),
(5, 1, 'ul. Piotrkowska 100', 'Łódź', '90-001'),
(6, 1, 'ul. Dworcowa 3', 'Katowice', '40-001'),
(7, 1, 'ul. Grunwaldzka 15', 'Gdańsk', '80-001'),
(8, 1, 'ul. Świętokrzyska 7', 'Poznań', '60-001'),
(9, 1, 'ul. Mickiewicza 12', 'Szczecin', '70-001'),
(10, 1, 'ul. 3 Maja 8', 'Lublin', '20-001'),
(11, 1, 'ul. Reymonta 4', 'Rzeszów', '35-001'),
(12, 1, 'ul. Sienkiewicza 9', 'Kielce', '25-001'),
(13, 1, 'ul. Kopernika 2', 'Olsztyn', '10-001'),
(14, 1, 'ul. Moniuszki 6', 'Białystok', '15-001'),
(15, 1, 'ul. Chopina 11', 'Gorzów Wlkp.', '66-001'),
(16, 1, 'ul. Słowackiego 3', 'Zielona Góra', '65-001'),
(17, 1, 'ul. Piłsudskiego 5', 'Opole', '45-001'),
(18, 1, 'ul. Legionów 7', 'Częstochowa', '42-001'),
(19, 1, 'ul. Traugutta 1', 'Radom', '26-001'),
(20, 1, 'ul. Wyszyńskiego 10', 'Sosnowiec', '41-001');

-- --------------------------------------------------------

--
-- Структура таблицы `wydawcy`
--

CREATE TABLE `wydawcy` (
  `Id` int(11) NOT NULL,
  `Nazwa` varchar(100) NOT NULL,
  `Adres` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `wydawcy`
--

INSERT INTO `wydawcy` (`Id`, `Nazwa`, `Adres`) VALUES
(1, 'Znak', 'Kraków'),
(2, 'MAG', 'Warszawa'),
(3, 'Rebis', 'Poznań'),
(4, 'Prószyński', 'Warszawa'),
(5, 'Wydawnictwo Literackie', 'Kraków'),
(6, 'C&T', 'Toruń'),
(7, 'Helion', 'Gliwice'),
(8, 'PWN', 'Warszawa'),
(9, 'Albatros', 'Warszawa'),
(10, 'Muza', 'Warszawa'),
(11, 'Agora', 'Warszawa'),
(12, 'Otwarte', 'Kraków'),
(13, 'Sonia Draga', 'Katowice'),
(14, 'Czarne', 'Wołowiec'),
(15, 'Karakter', 'Kraków'),
(16, 'WAB', 'Warszawa'),
(17, 'Zysk i S-ka', 'Poznań'),
(18, 'Fabryka Słów', 'Lublin'),
(19, 'Powergraph', 'Warszawa'),
(20, 'Nasza Księgarnia', 'Warszawa');

-- --------------------------------------------------------

--
-- Структура таблицы `wypozyczenia`
--

CREATE TABLE `wypozyczenia` (
  `Id` int(11) NOT NULL,
  `IdUzytkownik` int(11) NOT NULL,
  `IdEgzemplarz` int(11) NOT NULL,
  `DataWypozyczenia` date DEFAULT curdate(),
  `DataPlanowanegoZwrotu` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `wypozyczenia`
--

INSERT INTO `wypozyczenia` (`Id`, `IdUzytkownik`, `IdEgzemplarz`, `DataWypozyczenia`, `DataPlanowanegoZwrotu`) VALUES
(1, 1, 1, '2025-11-02', '2025-11-10'),
(2, 2, 3, '2025-11-02', '2025-11-12'),
(3, 3, 5, '2025-11-02', '2025-11-08'),
(4, 4, 8, '2025-11-02', '2025-11-15'),
(5, 5, 10, '2025-11-02', '2025-11-11'),
(6, 6, 13, '2025-11-02', '2025-11-14'),
(7, 7, 15, '2025-11-02', '2025-11-09'),
(8, 8, 17, '2025-11-02', '2025-11-13'),
(9, 9, 19, '2025-11-02', '2025-11-16'),
(10, 10, 2, '2025-11-02', '2025-11-10'),
(11, 11, 4, '2025-11-02', '2025-11-12'),
(12, 12, 6, '2025-11-02', '2025-11-08'),
(13, 13, 9, '2025-11-02', '2025-11-15'),
(14, 14, 11, '2025-11-02', '2025-11-11'),
(15, 15, 14, '2025-11-02', '2025-11-14'),
(16, 16, 16, '2025-11-02', '2025-11-09'),
(17, 17, 18, '2025-11-02', '2025-11-13'),
(18, 18, 20, '2025-11-02', '2025-11-16'),
(19, 19, 1, '2025-11-02', '2025-11-17'),
(20, 20, 3, '2025-11-02', '2025-11-18');

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `wypozyczeniapoterminie`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `wypozyczeniapoterminie` (
`Id` int(11)
,`Imie` varchar(100)
,`Nazwisko` varchar(100)
,`Tytul` varchar(255)
,`DataWypozyczenia` date
,`DataPlanowanegoZwrotu` date
,`DniOpóznienia` int(7)
);

-- --------------------------------------------------------

--
-- Структура таблицы `zwroty`
--

CREATE TABLE `zwroty` (
  `Id` int(11) NOT NULL,
  `IdWypozyczenie` int(11) NOT NULL,
  `DataZwrotu` date DEFAULT curdate(),
  `StanZwrotu` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Дамп данных таблицы `zwroty`
--

INSERT INTO `zwroty` (`Id`, `IdWypozyczenie`, `DataZwrotu`, `StanZwrotu`) VALUES
(1, 1, '2025-11-09', 'Dobry'),
(2, 3, '2025-11-07', 'Lekko uszkodzony'),
(3, 5, '2025-11-10', 'Dobry'),
(4, 7, '2025-11-08', 'Dobry'),
(5, 9, '2025-11-15', 'Zniszczony'),
(6, 11, '2025-11-11', 'Dobry'),
(7, 13, '2025-11-14', 'Dobry'),
(8, 15, '2025-11-08', 'Dobry'),
(9, 17, '2025-11-12', 'Dobry'),
(10, 19, '2025-11-16', 'Dobry');

-- --------------------------------------------------------

--
-- Структура для представления `aktywnewypozyczenia`
--
DROP TABLE IF EXISTS `aktywnewypozyczenia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `aktywnewypozyczenia`  AS SELECT `w`.`Id` AS `Id`, `u`.`Imie` AS `Imie`, `u`.`Nazwisko` AS `Nazwisko`, `k`.`Tytul` AS `Tytul`, `w`.`DataWypozyczenia` AS `DataWypozyczenia`, `w`.`DataPlanowanegoZwrotu` AS `DataPlanowanegoZwrotu` FROM ((((`wypozyczenia` `w` join `uzytkownicy` `u` on(`w`.`IdUzytkownik` = `u`.`Id`)) join `egzemplarze` `e` on(`w`.`IdEgzemplarz` = `e`.`Id`)) join `ksiazki` `k` on(`e`.`IdKsiazka` = `k`.`Id`)) left join `zwroty` `z` on(`w`.`Id` = `z`.`IdWypozyczenie`)) WHERE `z`.`Id` is null ;

-- --------------------------------------------------------

--
-- Структура для представления `niedostepneksiazki`
--
DROP TABLE IF EXISTS `niedostepneksiazki`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `niedostepneksiazki`  AS SELECT DISTINCT `k`.`Id` AS `Id`, `k`.`Tytul` AS `Tytul`, `a`.`Imie` AS `Imie`, `a`.`Nazwisko` AS `Nazwisko`, 'Wypożyczona' AS `Status` FROM (((`ksiazki` `k` join `autorzy` `a` on(`k`.`IdAutor` = `a`.`Id`)) join `egzemplarze` `e` on(`k`.`Id` = `e`.`IdKsiazka`)) join `statusyksiazek` `s` on(`e`.`IdStatus` = `s`.`Id`)) WHERE `s`.`Nazwa` = 'Wypożyczona'union select `k`.`Id` AS `Id`,`k`.`Tytul` AS `Tytul`,`a`.`Imie` AS `Imie`,`a`.`Nazwisko` AS `Nazwisko`,'Zarezerwowana' AS `Zarezerwowana` from ((`ksiazki` `k` join `autorzy` `a` on(`k`.`IdAutor` = `a`.`Id`)) join `rezerwacje` `r` on(`k`.`Id` = `r`.`IdKsiazka`))  ;

-- --------------------------------------------------------

--
-- Структура для представления `wypozyczeniapoterminie`
--
DROP TABLE IF EXISTS `wypozyczeniapoterminie`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wypozyczeniapoterminie`  AS SELECT `w`.`Id` AS `Id`, `u`.`Imie` AS `Imie`, `u`.`Nazwisko` AS `Nazwisko`, `k`.`Tytul` AS `Tytul`, `w`.`DataWypozyczenia` AS `DataWypozyczenia`, `w`.`DataPlanowanegoZwrotu` AS `DataPlanowanegoZwrotu`, to_days(curdate()) - to_days(`w`.`DataPlanowanegoZwrotu`) AS `DniOpóznienia` FROM ((((`wypozyczenia` `w` join `uzytkownicy` `u` on(`w`.`IdUzytkownik` = `u`.`Id`)) join `egzemplarze` `e` on(`w`.`IdEgzemplarz` = `e`.`Id`)) join `ksiazki` `k` on(`e`.`IdKsiazka` = `k`.`Id`)) left join `zwroty` `z` on(`w`.`Id` = `z`.`IdWypozyczenie`)) WHERE `z`.`Id` is null AND `w`.`DataPlanowanegoZwrotu` < curdate() ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `autorzy`
--
ALTER TABLE `autorzy`
  ADD PRIMARY KEY (`Id`);

--
-- Индексы таблицы `egzemplarze`
--
ALTER TABLE `egzemplarze`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `NumerSeryjny` (`NumerSeryjny`),
  ADD KEY `IdKsiazka` (`IdKsiazka`),
  ADD KEY `IdStatus` (`IdStatus`),
  ADD KEY `IdLokalizacja` (`IdLokalizacja`);

--
-- Индексы таблицы `kary`
--
ALTER TABLE `kary`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `IdWypozyczenie` (`IdWypozyczenie`);

--
-- Индексы таблицы `kategorie`
--
ALTER TABLE `kategorie`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Nazwa` (`Nazwa`);

--
-- Индексы таблицы `ksiazki`
--
ALTER TABLE `ksiazki`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `ISBN` (`ISBN`),
  ADD KEY `IdAutor` (`IdAutor`),
  ADD KEY `IdWydawca` (`IdWydawca`),
  ADD KEY `IdKategoria` (`IdKategoria`),
  ADD KEY `IdTypKsiazki` (`IdTypKsiazki`);

--
-- Индексы таблицы `lokalizacje`
--
ALTER TABLE `lokalizacje`
  ADD PRIMARY KEY (`Id`);

--
-- Индексы таблицы `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD PRIMARY KEY (`Id`);

--
-- Индексы таблицы `rezerwacje`
--
ALTER TABLE `rezerwacje`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `IdUzytkownik` (`IdUzytkownik`),
  ADD KEY `IdKsiazka` (`IdKsiazka`);

--
-- Индексы таблицы `statusyksiazek`
--
ALTER TABLE `statusyksiazek`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Nazwa` (`Nazwa`);

--
-- Индексы таблицы `typyksiazek`
--
ALTER TABLE `typyksiazek`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Nazwa` (`Nazwa`);

--
-- Индексы таблицы `typyuzytkownikow`
--
ALTER TABLE `typyuzytkownikow`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Nazwa` (`Nazwa`);

--
-- Индексы таблицы `typy_adresow`
--
ALTER TABLE `typy_adresow`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Typ` (`Typ`);

--
-- Индексы таблицы `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `IdTypUzytkownika` (`IdTypUzytkownika`);

--
-- Индексы таблицы `uzytkownicy_adresy`
--
ALTER TABLE `uzytkownicy_adresy`
  ADD PRIMARY KEY (`IdUzytkownik`,`IdTypAdresu`),
  ADD KEY `IdTypAdresu` (`IdTypAdresu`);

--
-- Индексы таблицы `wydawcy`
--
ALTER TABLE `wydawcy`
  ADD PRIMARY KEY (`Id`);

--
-- Индексы таблицы `wypozyczenia`
--
ALTER TABLE `wypozyczenia`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `IdUzytkownik` (`IdUzytkownik`),
  ADD KEY `IdEgzemplarz` (`IdEgzemplarz`);

--
-- Индексы таблицы `zwroty`
--
ALTER TABLE `zwroty`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `IdWypozyczenie` (`IdWypozyczenie`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `autorzy`
--
ALTER TABLE `autorzy`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `egzemplarze`
--
ALTER TABLE `egzemplarze`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT для таблицы `kary`
--
ALTER TABLE `kary`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `kategorie`
--
ALTER TABLE `kategorie`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблицы `ksiazki`
--
ALTER TABLE `ksiazki`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `lokalizacje`
--
ALTER TABLE `lokalizacje`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `pracownicy`
--
ALTER TABLE `pracownicy`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `rezerwacje`
--
ALTER TABLE `rezerwacje`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `statusyksiazek`
--
ALTER TABLE `statusyksiazek`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `typyksiazek`
--
ALTER TABLE `typyksiazek`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `typyuzytkownikow`
--
ALTER TABLE `typyuzytkownikow`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `typy_adresow`
--
ALTER TABLE `typy_adresow`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `wydawcy`
--
ALTER TABLE `wydawcy`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `wypozyczenia`
--
ALTER TABLE `wypozyczenia`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `zwroty`
--
ALTER TABLE `zwroty`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `egzemplarze`
--
ALTER TABLE `egzemplarze`
  ADD CONSTRAINT `egzemplarze_ibfk_1` FOREIGN KEY (`IdKsiazka`) REFERENCES `ksiazki` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `egzemplarze_ibfk_2` FOREIGN KEY (`IdStatus`) REFERENCES `statusyksiazek` (`Id`) ON DELETE SET NULL,
  ADD CONSTRAINT `egzemplarze_ibfk_3` FOREIGN KEY (`IdLokalizacja`) REFERENCES `lokalizacje` (`Id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `kary`
--
ALTER TABLE `kary`
  ADD CONSTRAINT `kary_ibfk_1` FOREIGN KEY (`IdWypozyczenie`) REFERENCES `wypozyczenia` (`Id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `ksiazki`
--
ALTER TABLE `ksiazki`
  ADD CONSTRAINT `ksiazki_ibfk_1` FOREIGN KEY (`IdAutor`) REFERENCES `autorzy` (`Id`) ON DELETE SET NULL,
  ADD CONSTRAINT `ksiazki_ibfk_2` FOREIGN KEY (`IdWydawca`) REFERENCES `wydawcy` (`Id`) ON DELETE SET NULL,
  ADD CONSTRAINT `ksiazki_ibfk_3` FOREIGN KEY (`IdKategoria`) REFERENCES `kategorie` (`Id`) ON DELETE SET NULL,
  ADD CONSTRAINT `ksiazki_ibfk_4` FOREIGN KEY (`IdTypKsiazki`) REFERENCES `typyksiazek` (`Id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `rezerwacje`
--
ALTER TABLE `rezerwacje`
  ADD CONSTRAINT `rezerwacje_ibfk_1` FOREIGN KEY (`IdUzytkownik`) REFERENCES `uzytkownicy` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rezerwacje_ibfk_2` FOREIGN KEY (`IdKsiazka`) REFERENCES `ksiazki` (`Id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  ADD CONSTRAINT `uzytkownicy_ibfk_1` FOREIGN KEY (`IdTypUzytkownika`) REFERENCES `typyuzytkownikow` (`Id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `uzytkownicy_adresy`
--
ALTER TABLE `uzytkownicy_adresy`
  ADD CONSTRAINT `uzytkownicy_adresy_ibfk_1` FOREIGN KEY (`IdUzytkownik`) REFERENCES `uzytkownicy` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `uzytkownicy_adresy_ibfk_2` FOREIGN KEY (`IdTypAdresu`) REFERENCES `typy_adresow` (`Id`);

--
-- Ограничения внешнего ключа таблицы `wypozyczenia`
--
ALTER TABLE `wypozyczenia`
  ADD CONSTRAINT `wypozyczenia_ibfk_1` FOREIGN KEY (`IdUzytkownik`) REFERENCES `uzytkownicy` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wypozyczenia_ibfk_2` FOREIGN KEY (`IdEgzemplarz`) REFERENCES `egzemplarze` (`Id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `zwroty`
--
ALTER TABLE `zwroty`
  ADD CONSTRAINT `zwroty_ibfk_1` FOREIGN KEY (`IdWypozyczenie`) REFERENCES `wypozyczenia` (`Id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
