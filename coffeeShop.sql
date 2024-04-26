-- IDS project 2.part
-- Authors:
-- Artem Dvorychanskyi  xdvory00
-- Aryna Zhukava        xzhuka01

---- DROPs ----
DROP TABLE Cupping_akce;
DROP TABLE Kavarna;
DROP TABLE Kavova_Zrna;
DROP TABLE Kava;
DROP TABLE Komentar;
DROP TABLE Zamestnanec;
DROP TABLE Recenze;
DROP TABLE Zakaznik;
DROP TABLE Uzivatel;

----CREATE TABLES----

CREATE TABLE Kavova_Zrna(
    Zrna_ID NUMBER GENERATED always as IDENTITY(START with 1 INCREMENT by 1) NOT NULL PRIMARY KEY,
    Odruda VARCHAR(50) NOT NULL,
    Stupen_Kyselosti VARCHAR(50),
    Popis_Aromatu VARCHAR(50),
    Popis_Chuti VARCHAR(100),
    Oblast_Puvodu VARCHAR(50)
);

CREATE TABLE Kava(
    Kava_ID NUMBER GENERATED always as IDENTITY(START with 1 INCREMENT by 1) NOT NULL PRIMARY KEY,
    Slozeni VARCHAR(50) NOT NULL,
    Popis_Chuti VARCHAR(100) NOT NULL,
    Kvalita INT NOT NULL
        CHECK(Kvalita >= 1 AND Kvalita <= 10 )
);

CREATE TABLE Cupping_akce(
    Akce_ID NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL PRIMARY KEY,
    DATUM DATE NOT NULL,
    CAS TIMESTAMP NOT NULL,
    Cena_ohutnavky NUMBER,
    Kapacita INT NOT NULL
        CHECK(Kapacita >= 0),
    Info_o_volnych_mistech INT NOT NULL
        CHECK(Info_o_volnych_mistech >= 0)
);

CREATE TABLE Recenze(
    Recenze_ID NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL PRIMARY KEY,
    Datum DATE NOT NULL,
    Cas TIMESTAMP NOT NULL,
    Pocet_liku INT NOT NULL
        CHECK (Pocet_liku >= 0),
    Pocet_disliku INT NOT NULL
        CHECK (Pocet_disliku >= 0),
    Dojem VARCHAR(100),
    Pocet_Hvezdicek INT NOT NULL
        CHECK (Pocet_Hvezdicek >= 0),
    Datum_navstevy DATE NOT NULL
);

CREATE TABLE Kavarna(
    Kavarna_ID NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL PRIMARY KEY,
    Adresa VARCHAR(100) NOT NULL,
    Cas_otevreni TIMESTAMP NOT NULL,
    Cas_zavreni TIMESTAMP NOT NULL,
    Kapacita NUMBER(5)
        CHECK (Kapacita >= 0),
    Popis VARCHAR(100)
);

CREATE TABLE Uzivatel(
    User_ID NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL PRIMARY KEY,
    Jmeno VARCHAR(30) NOT NULL,
    Prijmeni VARCHAR(30) NOT NULL,
    Telefenni_cislo VARCHAR(13)
);

CREATE TABLE Zakaznik(
    Oblibeny_druh_kavy VARCHAR(50),
    Oblibeny_zpusob_pripravy VARCHAR(50),
    Oblibena_Kavarna CHAR(50),
    Pocet_kav_denne NUMBER,
    Napsane_rezence VARCHAR(20),
    User_ID NUMBER NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES Uzivatel(User_ID)
);

CREATE TABLE Zamestnanec(
    Pozice VARCHAR(50) NOT NULL,
    User_ID NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES Uzivatel(User_ID)
);

CREATE TABLE Komentar(
    Reakce VARCHAR(100),
    Komentar_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    --Recence_ID Number,
    User_ID NOT NULL,
    PRIMARY KEY (Komentar_ID),
    FOREIGN KEY (User_ID) REFERENCES Uzivatel(User_ID)
);

---- ALTER TABLE ----

ALTER TABLE Komentar
ADD Recenze_ID NUMBER
ADD CONSTRAINT fk_komentar_recenze FOREIGN KEY (Recenze_ID) REFERENCES Recenze(Recenze_ID);

---- INSERT REQUESTS -----

-- Inserting data into Kavova_Zrna
INSERT INTO Kavova_Zrna (Odruda, Stupen_Kyselosti, Popis_Aromatu, Popis_Chuti, Oblast_Puvodu) VALUES ('Arabica', 'Stredni', 'Cokolada', 'Vyvazena s nutou cokolady', 'Etiopie');
INSERT INTO Kavova_Zrna (Odruda, Stupen_Kyselosti, Popis_Aromatu, Popis_Chuti, Oblast_Puvodu) VALUES ('Robusta', 'Vysoka', 'Orechy', 'Intenzivni s nutou orechu', 'Vietnam');

-- Inserting data into Kava
INSERT INTO Kava (Slozeni, Popis_Chuti, Kvalita) VALUES ('Arabica 100%', 'Hladka a aromaticka', 5);
INSERT INTO Kava (Slozeni, Popis_Chuti, Kvalita) VALUES ('Arabica 80%, Robusta 20%', 'Silna s kremovou penu', 4);

-- Inserting data into Cupping_akce
INSERT INTO Cupping_akce (DATUM, CAS, Cena_ohutnavky, Kapacita, Info_o_volnych_mistech) VALUES (TO_DATE('2024-04-01','YYYY-MM-DD'), TO_TIMESTAMP('15:00:00', 'HH24:MI:SS'), 200, 20, 20);
INSERT INTO Cupping_akce (DATUM, CAS, Cena_ohutnavky, Kapacita, Info_o_volnych_mistech) VALUES (TO_DATE('2024-04-15','YYYY-MM-DD'), TO_TIMESTAMP('10:00:00', 'HH24:MI:SS'), 150, 15, 15);

-- Inserting data into Recenze
INSERT INTO Recenze (Datum, Cas, Pocet_liku, Pocet_disliku, Dojem, Pocet_Hvezdicek, Datum_navstevy) VALUES (TO_DATE('2024-03-20','YYYY-MM-DD'), TO_TIMESTAMP('14:00:00', 'HH24:MI:SS'), 10, 2, 'Uzasna kava!', 5, TO_DATE('2024-03-19','YYYY-MM-DD'));
INSERT INTO Recenze (Datum, Cas, Pocet_liku, Pocet_disliku, Dojem, Pocet_Hvezdicek, Datum_navstevy) VALUES (TO_DATE('2024-03-22','YYYY-MM-DD'), TO_TIMESTAMP('16:00:00', 'HH24:MI:SS'), 5, 3, 'Prijemne prostredi, ale kava mohla byt lepsi.', 3, TO_DATE('2024-03-21','YYYY-MM-DD'));

-- Inserting data into Kavarna
INSERT INTO Kavarna (Adresa, Cas_otevreni, Cas_zavreni, Kapacita, Popis) VALUES ('Praha, Vodickova 10', TO_TIMESTAMP('08:00:00', 'HH24:MI:SS'), TO_TIMESTAMP('20:00:00', 'HH24:MI:SS'), 30, 'Utociste pro milovniky kavy.');
INSERT INTO Kavarna (Adresa, Cas_otevreni, Cas_zavreni, Kapacita, Popis) VALUES ('Brno, Koblizna 5', TO_TIMESTAMP('09:00:00', 'HH24:MI:SS'), TO_TIMESTAMP('22:00:00', 'HH24:MI:SS'), 20, 'Moderni prostredi a vynikajici kava.');

-- Inserting data into Uzivatel
INSERT INTO Uzivatel (Jmeno, Prijmeni, Telefenni_cislo) VALUES ('Jan', 'Novak', '+420123456789');
INSERT INTO Uzivatel (Jmeno, Prijmeni, Telefenni_cislo) VALUES ('Eva', 'Svobodova', '+420987654321');

-- Inserting data into Zakaznik
INSERT INTO Zakaznik (Oblibeny_druh_kavy, Oblibeny_zpusob_pripravy, Oblibena_Kavarna, Pocet_kav_denne, Napsane_rezence, User_ID) VALUES ('Espresso', 'Presova kava', 'Kavarna Alfa', 3, 'Pozitivni', 1);
INSERT INTO Zakaznik (Oblibeny_druh_kavy, Oblibeny_zpusob_pripravy, Oblibena_Kavarna, Pocet_kav_denne, Napsane_rezence, User_ID) VALUES ('Latte', 'Tlakova kava', 'Kavarna Beta', 2, 'Mix', 2);

-- Inserting data into Zamestnanec
INSERT INTO Zamestnanec (Pozice) VALUES ('Barista');
INSERT INTO Zamestnanec (Pozice) VALUES ('Manager');

-- Inserting data into Komentar
INSERT INTO Komentar (Reakce,User_ID, Recenze_ID) VALUES ('Vynikajici obsluha!', 1, 1);
INSERT INTO Komentar (Reakce,User_ID, Recenze_ID) VALUES ('Kava mohla byt teplejsi.', 2 , 2);

-------- SELECT REQUESTS --------

-- Jmeno a Prijmeni + their reviews with 5 starts
SELECT Jmeno, Prijmeni, Recenze.Dojem FROM Uzivatel NATURAL JOIN Recenze WHERE Pocet_Hvezdicek = 5;

-- Users + their favorite coffee
SELECT DISTINCT Jmeno, Prijmeni, Oblibeny_druh_kavy FROM Uzivatel NATURAL JOIN Zakaznik;

-- Stuff reaction to review --
SELECT Pozice, Jmeno, Reakce, Komentar_id FROM Zamestnanec NATURAL JOIN Uzivatel NATURAL JOIN Komentar;

-- Average number of stars in particular day --
SELECT Datum, AVG(Pocet_Hvezdicek) AS Prumerne_hodnoceni
FROM Recenze
GROUP BY Datum;

-- Number of types of grains from the country --
SELECT Oblast_Puvodu, COUNT(Zrna_ID) AS Pocet_Odrud
FROM Kavova_Zrna
GROUP BY Oblast_Puvodu;

-- All reviews that have at least 1 comment  --
SELECT R.Recenze_ID, R.Dojem, R.Pocet_Hvezdicek
FROM Recenze R
WHERE EXISTS (
    SELECT 1
    FROM Komentar K
    WHERE K.Recenze_ID = R.Recenze_ID
);

--All users who have written a comment--
SELECT U.Jmeno, U.Prijmeni
FROM Uzivatel U
WHERE U.User_ID IN (
    SELECT K.User_ID
    FROM Komentar K
);

-------- TRIGGERS --------
-- removes all comments from the user being deleted from the Zakaznik table
    CREATE OR REPLACE TRIGGER delete_after_not_exist
    AFTER DELETE ON Zakaznik
    FOR EACH ROW
    BEGIN
        DELETE FROM Komentar WHERE User_ID = :OLD.User_ID;
    END;
-- trigger check (I guess rabotaet tak)
    DELETE FROM Zakaznik WHERE User_ID = 7;

-- prevents the deletion of highly rated review by raising an error
    CREATE OR REPLACE TRIGGER prevent_delete_review
    BEFORE DELETE ON Recenze
    FOR EACH ROW
    BEGIN
    IF (:OLD.Pocet_Hvezdicek >= 4) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Vysoce hodnocené recenze nelze smazat!');
    END IF;
    END;
-- trigger check
    DELETE FROM Recenze WHERE Pocet_Hvezdicek > 4;


-------- PROCEDURES --------
-- procedure that identifies and displays customers who drink more than 2 cups of coffee per day
    CREATE OR REPLACE PROCEDURE more_than_one_cup
    IS
    CURSOR highCoffeeLovers_zakaznici IS -- fetch customers who drink more than one cup of coffee per day
        SELECT U.Jmeno, U.Prijmeni, Z.Pocet_kav_denne
        FROM Uzivatel U
                 JOIN Zakaznik Z ON U.User_ID = Z.User_ID -- from customer table through the User_ID
        WHERE Z.Pocet_kav_denne > 2;
    BEGIN
        OPEN highCoffeeLovers_zakaznici; -- open cursor
        IF NOT highCoffeeLovers_zakaznici%FOUND THEN
            dbms_output.put_line('Nebyli nalezeni zákazníci s vyšší spotřebou kávy (více než 2 šálky denně).');
            ELSE
                dbms_output.put_line('Zákazníci s vyšší spotřebou kávy:');
                dbms_output.put_line('-----------------------------------');
                FOR zakaznik IN highCoffeeLovers_zakaznici LOOP
                        dbms_output.put_line('Jméno: ' || zakaznik.Jmeno || ' ' || zakaznik.Prijmeni);
                        dbms_output.put_line('Počet šálků za den: ' || zakaznik.Pocet_kav_denne);
                        dbms_output.put_line('-----------------------------------');
                    END LOOP;
        END IF;

        CLOSE highCoffeeLovers_zakaznici;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Došlo k chybě: ' || SQLERRM);
    END;


-------- INDEX A EXPLAIN PLAN --------





-------- PRISTUPOVE PRAVA PRO xdvory00 --------
GRANT ALL ON Cupping_akce TO xdvory00;
GRANT ALL ON Kava TO xdvory00;
GRANT ALL ON Kavarna TO xdvory00;
GRANT ALL ON Kavova_Zrna TO xdvory00;
GRANT ALL ON Komentar TO xdvory00;
GRANT ALL ON Recenze TO xdvory00;
GRANT ALL ON Uzivatel TO xdvory00;
GRANT ALL ON Zakaznik TO xdvory00;
GRANT ALL ON Zamestnanec TO xdvory00;


