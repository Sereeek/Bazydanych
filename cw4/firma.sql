-- Database: firma

-- DROP DATABASE IF EXISTS firma;

CREATE DATABASE firma;
USE firma;
CREATE SCHEMA rozliczenia;



CREATE TABLE rozliczenia.pracownicy (
    id_pracownika INT PRIMARY KEY NOT NULL,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    adres VARCHAR(100) NOT NULL,
    telefon VARCHAR(20)
);

CREATE TABLE rozliczenia.godziny (
    id_godziny INT PRIMARY KEY NOT NULL,
    data DATE,
    liczba_godzin INT,
    id_pracownika INT NOT NULL
);

CREATE TABLE rozliczenia.pensje (
    id_pensji INT PRIMARY KEY NOT NULL,
    stanowisko VARCHAR(50),
    kwota INT NOT NULL,
    id_premii INT
);

CREATE TABLE rozliczenia.premie (
    id_premii INT PRIMARY KEY NOT NULL,
    rodzaj VARCHAR(50),
    kwota INT NOT NULL
);



ALTER TABLE rozliczenia.godziny ADD FOREIGN key (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);
ALTER TABLE rozliczenia.pensje ADD FOREIGN key (id_premii) REFERENCES rozliczenia.premie(id_premii);



INSERT INTO rozliczenia.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES
(1, 'Jan', 'Kowalski', 'Lipowa 10, Warszawa', '123456789'),
(2, 'Anna', 'Nowak', 'Kwiatowa 5, Wrocław', '987654321'),
(3, 'Michał', 'Wiśniewski', 'Słoneczna 22, Kraków', '555777888'),
(4, 'Agnieszka', 'Kowalczyk', 'Polna 15, Łódź', '543867123'),
(5, 'Piotr', 'Jankowski', 'Różana 3, Gdańsk', '325876624'),
(6, 'Katarzyna', 'Woźniak', 'Leśna 8, Lublin', '947291931'),
(7, 'Andrzej', 'Lewandowski', 'Słowackiego 12, Katowice', '987539543'),
(8, 'Marta', 'Dąbrowska', 'Piastowska 7, Szczecin', '846329126'),
(9, 'Marcin', 'Kamiński', 'Krzywa 4, Poznań', '897243123'),
(10, 'Ewa', 'Zając', 'Nadwislanskie 2, Olsztyn', '589345321');

INSERT INTO rozliczenia.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
(1, '2024-01-10', 163, 1),
(2, '2024-01-25', 152, 2),
(3, '2024-02-02', 189, 3),
(4, '2024-02-24', 178, 4),
(5, '2024-03-07', 154, 5),
(6, '2024-03-26', 162, 6),
(7, '2024-03-30', 150, 7),
(8, '2024-04-02', 143, 8),
(9, '2024-04-05', 118, 9),
(10, '2024-04-11', 181, 10);

INSERT INTO rozliczenia.premie (id_premii, rodzaj, kwota)
VALUES
(1, 'stażowa', 750),
(2, 'stażowa', 1000),
(3, 'uznaniowa', 200),
(4, 'uznaniowa', 300),
(5, 'motywacyjna', 400),
(6, 'motywacyjna', 250),
(7, 'motywacyjna', 200),
(8, 'świąteczna', 200),
(9, 'świąteczna', 300),
(10, 'świąteczna', 250);

INSERT INTO rozliczenia.pensje (id_pensji, stanowisko, kwota, id_premii)
VALUES
(1, 'Specjalista ds. Obsługi Klienta', 3200, 4),
(2, 'Analityk Finansowy', 6500, 8),
(3, 'Inżynier Oprogramowania', 11400, 2),
(4, 'Kierownik Zasobów Ludzkich', 8600, 5),
(5, 'Doradca ds. Marketingu', 5200, 3),
(6, 'Technik Serwisu', 5500, 1),
(7, 'Projektant Graficzny', 7300, 9),
(8, 'Kierownik Projektu', 10600, 6),
(9, 'Specjalista ds. Sprzedaży', 6700, 10),
(10, 'Administrator Sieci Komputerowej', 6800, 7);




SELECT nazwisko, adres FROM rozliczenia.pracownicy;




SELECT datepart(weekday, data) AS dzien, datepart(Month, data) AS miesiąc FROM rozliczenia.godziny;




EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
ALTER TABLE rozliczenia.pensje ADD kwota_netto INT;
UPDATE rozliczenia.pensje SET kwota_netto = kwota_brutto*0.77;
