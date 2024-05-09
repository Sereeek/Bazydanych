CREATE OR REPLACE FUNCTION Fibonacci (n INT)
RETURNS INT AS $$
DECLARE
    a INT := 0; -- aktualna pozycja w ciągu
    l1 INT := 0; -- pierwszy element
    l2 INT := 1; -- drugi element
    i INT := 2;
BEGIN
    IF n = 0 THEN
        RETURN n1;
    ELSEIF n = 1 THEN
        RETURN n2;
    ELSE
        WHILE i <= n LOOP
            a := l1 + l2;
            l1 := l2;
            l2 := a;
            i := i + 1;
        END LOOP;
        RETURN a;
    END IF;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE Wynik(n INT) AS $$
DECLARE
    i INT := 0;
BEGIN
    RAISE NOTICE 'Ciąg Fibonacciego dla % elementów:', n;
    WHILE i < n LOOP
        RAISE NOTICE '% ', Fibonacci(i);
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

CALL Wynik(9);