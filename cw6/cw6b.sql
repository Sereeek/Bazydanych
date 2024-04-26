
--a)
update ksiegowosc.pracownicy set telefon = concat('(+48) ',telefon);

--b)
update ksiegowosc.pracownicy set telefon = concat(substring(telefon,1,9),'-',substring(telefon,10,3),'-',substring(telefon,13,3));

--c)
select upper(nazwisko) from ksiegowosc.pracownicy order by length(nazwisko) desc limit 1;

--d)
select pracownicy.imie, pracownicy.nazwisko, md5(pensja.kwota::varchar) from ksiegowosc.pracownicy join 
ksiegowosc.wynagrodzenie on pracownicy.id_pracownika = wynagrodzenie.id_pracownika join 
ksiegowosc.pensja on pensja.id_pensji = wynagrodzenie.id_pensji;

--e)
select pracownicy.imie, pracownicy.nazwisko, pensja.kwota, premia.kwota from ksiegowosc.pracownicy left join 
ksiegowosc.wynagrodzenie on pracownicy.id_pracownika = wynagrodzenie.id_pracownika left join 
ksiegowosc.pensja on pensja.id_pensji = wynagrodzenie.id_pensji left join ksiegowosc.premia on 
premia.id_premii = pensja.id_premii;

--f)
select concat('Pracownik ',pracownicy.imie,' ',pracownicy.nazwisko,', w dniu ',wynagrodzenie."data",
' otrzymał pensję całkowitą na kwotę ',pensja.kwota+premia.kwota,', gdzie wynagrodzenie zasadnicze wynosiło: ',
pensja.kwota,' zł, premia: ',premia.kwota,' zł, nadgodziny: ', CASE WHEN godziny.liczba_godzin > 160 THEN ((godziny.liczba_godzin - 160)* 25) ELSE 0 END, ' zł') 
FROM ksiegowosc.pracownicy JOIN ksiegowosc.godziny ON pracownicy.id_pracownika = godziny.id_pracownika JOIN ksiegowosc.wynagrodzenie ON 
godziny.id_godziny  = wynagrodzenie.id_godziny JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji JOIN 
ksiegowosc.premia ON premia.id_premii = pensja.id_premii;

