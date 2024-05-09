CREATE OR REPLACE FUNCTION uppercase_lastname()
RETURNS TRIGGER AS $$
BEGIN
    NEW.lastname := UPPER(NEW.lastname);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER uppercase_lastname_trigger
BEFORE INSERT OR UPDATE ON Person.Person
FOR EACH ROW
EXECUTE FUNCTION uppercase_lastname();


INSERT INTO Person.businessentity (businessentityid)
values ('1')


INSERT INTO Person.Person (FirstName, LastName, BusinessEntityID, PersonType)
VALUES ('Adam', 'Kowalski', 1, 'EM'); 