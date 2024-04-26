create schema ksiegowosc;


create table ksiegowosc.pracownicy ("id_pracownika" serial primary key not null, 
"imie" varchar(50) not null, "nazwisko" varchar(50) not null, "adres" varchar(100), "telefon" varchar(20));
create table ksiegowosc.godziny ("id_godziny" serial primary key not null, "data" date not null, 
"liczba_godzin" integer not null, "id_pracownika" integer not null); 
create table ksiegowosc.pensja ("id_pensji" serial primary key not null, "stanowisko" varchar(50) not null, 
"kwota" money, "id_premii" integer not null); 
create table ksiegowosc.premia ("id_premii" serial primary key not null, "rodzaj" varchar(50) not null, "kwota" money);
create table ksiegowosc.wynagrodzenie ("id_wynagrodzenia" serial primary key not null, "data" date not null, 
"id_pracownika" integer not null, "id_godziny" integer not null, "id_pensji" integer not null,
"id_premii" integer not null);

alter table ksiegowosc.godziny add foreign key (id_pracownika) references ksiegowosc.pracownicy (id_pracownika);
alter table ksiegowosc.pensja add foreign key (id_premii) references ksiegowosc.premia (id_premii);
alter table ksiegowosc.wynagrodzenie  add foreign key (id_pracownika) references ksiegowosc.pracownicy (id_pracownika);
alter table ksiegowosc.wynagrodzenie  add foreign key (id_godziny) references ksiegowosc.godziny (id_godziny);
alter table ksiegowosc.wynagrodzenie  add foreign key (id_pensji) references ksiegowosc.pensja (id_pensji);
alter table ksiegowosc.wynagrodzenie  add foreign key (id_premii) references ksiegowosc.premia (id_premii);

comment on table ksiegowosc.pracownicy is 'tabela z danymi pracownikow';
comment on table ksiegowosc.godziny is 'tabela dat i godzin, powiazana z tabela pracownicy';
comment on table ksiegowosc.pensja is 'tabela danych na temat stanowiska i pensji, powiazana z tabela premia';
comment on table ksiegowosc.premia is 'tabela danych premii';
comment on table ksiegowosc.wynagrodzenie is 'tabela zawierajaca date, powiazana z tabelami pracownicy, godziny, pensja i premia';


INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
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
insert into ksiegowosc.godziny (data, liczba_godzin, id_pracownika) values ('2024-01-10', '163', 1),
('2024-01-25', '152', 2),
('2024-02-02', '189', 3),
('2024-02-24', '178', 4),
('2024-03-07', '154', 5),
('2024-03-26', '162', 6),
('2024-03-30', '150', 7),
('2024-04-02', '143', 8),
('2024-04-05', '118', 9),
('2024-04-11', '181', 10);

insert into ksiegowosc.premia (rodzaj, kwota) values ('stażowa', '750'),
('stażowa', '1000'),
('uznaniowa', '200'),
('uznaniowa', '300'),
('motywacyjna', '400'),
('motywacyjna', '250'),
('motywacyjna', '200'),
('świąteczna', '200'),
('świąteczna', '300'),
('świąteczna', '250');

insert into ksiegowosc.pensja (stanowisko, kwota, id_premii) values ('Specjalista ds. Obsługi Klienta', '3200', 1),
('Analityk Finansowy', '6500', 2),
('Inżynier Oprogramowania', '11400', 3),
('Kierownik Zasobów Ludzkich', '8600', 4),
('Doradca ds. Marketingu', '5200', 5),
('Technik Serwisu', '5500', 6),
('Projektant Graficzny', '7300', 7),
('Kierownik Projektu', '10600', 8),
('Specjalista ds. Sprzedaży', '6700', 9),
('Administrator Sieci Komputerowej', '6800', 10);


insert into ksiegowosc.wynagrodzenie  (data, id_pracownika , id_godziny, id_pensji, id_premii) values 
('2023-01-20', '1', '1', '1', '1'),
('2023-02-21', '2', '2', '2', '2'),
('2023-03-22', '3', '3', '3', '3'),
('2023-04-23', '4', '4', '4', '4'),
('2023-05-24', '5', '5', '5', '5'),
('2023-06-25', '6', '6', '6', '6'),
('2023-07-26', '7', '7', '7', '7'),
('2023-08-27', '8', '8', '8', '8'),
('2023-09-28', '9', '9', '9', '9'),
('2023-10-29', '10', '10', '10', '10');

--a)
select ksiegowosc.pracownicy.id_pracownika, ksiegowosc.pracownicy.nazwisko from ksiegowosc.pracownicy; 

--b)
select ksiegowosc.pracownicy.id_pracownika, ksiegowosc.pensja.kwota from ksiegowosc.pracownicy inner join 
ksiegowosc.wynagrodzenie on ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika 
inner join ksiegowosc.pensja on ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji where 
ksiegowosc.pensja.kwota > '1000';

--c)
select ksiegowosc.pracownicy.id_pracownika, pensja.kwota as pensja, premia.kwota as premia from ksiegowosc.pracownicy inner join
ksiegowosc.wynagrodzenie on pracownicy.id_pracownika = wynagrodzenie.id_pracownika inner join ksiegowosc.pensja on
wynagrodzenie.id_pensji = pensja.id_pensji inner join ksiegowosc.premia on premia.id_premii = pensja.id_premii 
where pensja.kwota > '2000' and premia.kwota is null;

--d)
select * from ksiegowosc.pracownicy where ksiegowosc.pracownicy.imie like 'J%';

--e)
select * from ksiegowosc.pracownicy where ksiegowosc.pracownicy.imie like 'N%' and ksiegowosc.pracownicy.imie like '%a';

--f)
select ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, (ksiegowosc.godziny.liczba_godzin-160) as nadgodziny from ksiegowosc.pracownicy inner join
ksiegowosc.godziny on ksiegowosc.godziny.id_pracownika = ksiegowosc.pracownicy.id_pracownika where ksiegowosc.godziny.liczba_godzin > '160';

--g)
select pracownicy.imie, pracownicy.nazwisko, pensja.kwota from ksiegowosc.pracownicy inner join ksiegowosc.wynagrodzenie on 
pracownicy.id_pracownika = wynagrodzenie.id_pracownika inner join ksiegowosc.pensja on 
wynagrodzenie.id_pensji = pensja.id_pensji where pensja.kwota between '1500' and '3000';

--h)
select pracownicy.imie, pracownicy.nazwisko, (godziny.liczba_godzin-160) as nadgodziny from ksiegowosc.pracownicy inner join
ksiegowosc.godziny on pracownicy.id_pracownika = godziny.id_pracownika inner join ksiegowosc.wynagrodzenie on 
godziny.id_godziny  = wynagrodzenie.id_godziny inner join ksiegowosc.pensja on wynagrodzenie.id_pensji = pensja.id_pensji inner join 
ksiegowosc.premia on premia.id_premii = pensja.id_premii where premia.kwota is null and godziny.liczba_godzin > '160';

--i)
select pensja.kwota, pracownicy.* from ksiegowosc.pracownicy inner join ksiegowosc.wynagrodzenie on 
pracownicy.id_pracownika = wynagrodzenie.id_pracownika inner join ksiegowosc.pensja on wynagrodzenie.id_pensji = pensja.id_pensji 
order by pensja.kwota;

--j)
select pensja.kwota as pensja, premia.kwota as premia, pracownicy.* from ksiegowosc.pracownicy inner join
ksiegowosc.wynagrodzenie on pracownicy.id_pracownika = wynagrodzenie.id_pracownika inner join ksiegowosc.pensja on
wynagrodzenie.id_pensji = pensja.id_pensji inner join ksiegowosc.premia on premia.id_premii = pensja.id_premii 
order by pensja.kwota, premia.kwota desc;

--k)
select pensja.stanowisko, count(pracownicy.id_pracownika) from ksiegowosc.pensja inner join ksiegowosc.wynagrodzenie on 
pensja.id_pensji = wynagrodzenie.id_pensji inner join ksiegowosc.pracownicy on wynagrodzenie.id_pracownika = pracownicy.id_pracownika 
group by pensja.stanowisko;

--l)
select avg(pensja.kwota::numeric), min(pensja.kwota), max(pensja.kwota) from ksiegowosc.pensja where pensja.stanowisko = 'Analityk Finansowy';

--m)
select sum(pensja.kwota+premia.kwota) from ksiegowosc.pensja inner join ksiegowosc.premia on pensja.id_premii = premia.id_premii;

--n)
select pensja.stanowisko, sum(pensja.kwota+premia.kwota) from ksiegowosc.pensja inner join ksiegowosc.premia on 
pensja.id_premii = premia.id_premii group by pensja.stanowisko;

--o)
select pensja.stanowisko, count(premia.id_premii) from ksiegowosc.pensja inner join ksiegowosc.premia on 
pensja.id_premii = premia.id_premii group by pensja.stanowisko; 

--p)
delete from ksiegowosc.pracownicy using ksiegowosc.wynagrodzenie, ksiegowosc.pensja where pracownicy.id_pracownika = wynagrodzenie.id_pracownika and 
wynagrodzenie.id_pensji = pensja.id_pensji and pensja.kwota < '1200';


