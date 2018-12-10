ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';

CREATE TABLE Bandy
(
  nr_bandy   NUMBER(2)
    CONSTRAINT nr_bandy_primiary_key PRIMARY KEY,
  nazwa      VARCHAR2(20)
    CONSTRAINT nazwa_not_null NOT NULL,
  teren      VARCHAR2(15)
    CONSTRAINT teren_unique UNIQUE,
  szef_bandy VARCHAR2(15)
    CONSTRAINT szef_bandy_unique UNIQUE
);

CREATE TABLE Funkcje
(
  funkcja   VARCHAR2(10)
    CONSTRAINT funkcja_primary_key PRIMARY KEY,
  min_myszy NUMBER(3)
    CONSTRAINT min_myszy_check CHECK (min_myszy > 5),
  max_myszy NUMBER(3)
    CONSTRAINT max_myszy_check CHECK (200 > max_myszy),
  CONSTRAINT max_myszy_min_myszy CHECK (max_myszy > min_myszy)
);

CREATE TABLE Wrogowie
(
  imie_wroga       VARCHAR2(15)
    CONSTRAINT mie_wroga_primiary_key PRIMARY KEY,
  stopien_wrogosci NUMBER(2)
    CONSTRAINT stopien_wrogosci_check CHECK (stopien_wrogosci BETWEEN 1 AND 10),
  gatunek          VARCHAR2(15),
  lapowka          VARCHAR2(20)
);

CREATE TABLE Kocury
(
  imie            VARCHAR2(15)
    CONSTRAINT imie_not_null NOT NULL,
  plec            VARCHAR2(1)
    CONSTRAINT plec_check CHECK (plec IN ('M', 'D')),
  pseudo          VARCHAR2(15)
    CONSTRAINT pseudo_primary_key PRIMARY KEY,
  funkcja         VARCHAR2(10)
    CONSTRAINT funkcja_references REFERENCES Funkcje (funkcja),
  szef            VARCHAR2(15)
    CONSTRAINT szef_references REFERENCES Kocury (pseudo),
  w_stadku_od     DATE DEFAULT SYSDATE,
  przydzial_myszy NUMBER(3),
  myszy_extra     NUMBER(3),
  nr_bandy        NUMBER(2)
    CONSTRAINT nr_bandy_references REFERENCES Bandy (nr_bandy)
);

CREATE TABLE Wrogowie_Kocurow
(
  pseudo         VARCHAR2(15)
    CONSTRAINT pseudo_references_kocury REFERENCES Kocury (pseudo),
  imie_wroga     VARCHAR2(15)
    CONSTRAINT imie_wroga_references_wrogowie REFERENCES Wrogowie (imie_wroga),
  data_incydentu DATE
    CONSTRAINT data_incydentu_not_null NOT NULL,
  opis_incydentu VARCHAR2(50),
  CONSTRAINT primiary_key PRIMARY KEY (pseudo, imie_wroga)
);

ALTER TABLE Bandy
  ADD CONSTRAINT szef_foreign_key FOREIGN KEY (szef_bandy) REFERENCES Kocury (pseudo);

-- Funkcje
INSERT INTO Funkcje
VALUES ('SZEFUNIO', 90, 110);
INSERT INTO Funkcje
VALUES ('BANDZIOR', 70, 90);
INSERT INTO Funkcje
VALUES ('LOWCZY', 60, 70);
INSERT INTO Funkcje
VALUES ('LAPACZ', 50, 60);
INSERT INTO Funkcje
VALUES ('KOT', 40, 50);
INSERT INTO Funkcje
VALUES ('MILUSIA', 20, 30);
INSERT INTO Funkcje
VALUES ('DZIELCZY', 45, 55);
INSERT INTO Funkcje
VALUES ('HONOROWA', 6, 25);

-- Wrogowie
INSERT INTO Wrogowie
VALUES ('KAZIO', 10, 'CZLOWIEK', 'FLASZKA');
INSERT INTO Wrogowie
VALUES ('GLUPIA ZOSKA', 1, 'CZLOWIEK', 'KORALIK');
INSERT INTO Wrogowie
VALUES ('SWAWOLNY DYZIO', 7, 'CZLOWIEK', 'GUMA DO ZUCIA');
INSERT INTO Wrogowie
VALUES ('BUREK', 4, 'PIES', 'KOSC');
INSERT INTO Wrogowie
VALUES ('DZIKI BILL', 10, 'PIES', NULL);
INSERT INTO Wrogowie
VALUES ('REKSIO', 2, 'PIES', 'KOSC');
INSERT INTO Wrogowie
VALUES ('BETHOVEN', 1, 'PIES', 'PEDIGRIPALL');
INSERT INTO Wrogowie
VALUES ('CHYTRUSEK', 5, 'LIS', 'KURCZAK');
INSERT INTO Wrogowie
VALUES ('SMUKLA', 1, 'SOSNA', NULL);
INSERT INTO Wrogowie
VALUES ('BAZYLI', 3, 'KOGUT', 'KURA DO STADA');

-- Kocury
ALTER TABLE Kocury
  disable CONSTRAINT szef_references;
ALTER TABLE Kocury
  disable CONSTRAINT nr_bandy_references;

INSERT INTO Kocury
VALUES ('JACEK', 'M', 'PLACEK', 'LOWCZY', 'LYSY', '2008-12-01', 67, NULL, 2);
INSERT INTO Kocury
VALUES ('BARI', 'M', 'RURA', 'LAPACZ', 'LYSY', '2009-09-01', 56, NULL, 2);
INSERT INTO Kocury
VALUES ('MICKA', 'D', 'LOLA', 'MILUSIA', 'TYGRYS', '2009-10-14', 25, 47, 1);
INSERT INTO Kocury
VALUES ('LUCEK', 'M', 'ZERO', 'KOT', 'KURKA', '2010-03-01', 43, NULL, 3);
INSERT INTO Kocury
VALUES ('SONIA', 'D', 'PUSZYSTA', 'MILUSIA', 'ZOMBI', '2010-11-18', 20, 35, 3);
INSERT INTO Kocury
VALUES ('LATKA', 'D', 'UCHO', 'KOT', 'RAFA', '2011-01-01', 40, NULL, 4);
INSERT INTO Kocury
VALUES ('DUDEK', 'M', 'MALY', 'KOT', 'RAFA', '2011-05-15', 40, NULL, 4);
INSERT INTO Kocury
VALUES ('MRUCZEK', 'M', 'TYGRYS', 'SZEFUNIO', NULL, '2002-01-01', 103, 33, 1);
INSERT INTO Kocury
VALUES ('CHYTRY', 'M', 'BOLEK', 'DZIELCZY', 'TYGRYS', '2002-05-05', 50, NULL, 1);
INSERT INTO Kocury
VALUES ('KOREK', 'M', 'ZOMBI', 'BANDZIOR', 'TYGRYS', '2004-03-16', 75, 13, 3);
INSERT INTO Kocury
VALUES ('BOLEK', 'M', 'LYSY', 'BANDZIOR', 'TYGRYS', '2006-08-15', 72, 21, 2);
INSERT INTO Kocury
VALUES ('ZUZIA', 'D', 'SZYBKA', 'LOWCZY', 'LYSY', '2006-07-21', 65, NULL, 2);
INSERT INTO Kocury
VALUES ('RUDA', 'D', 'MALA', 'MILUSIA', 'TYGRYS', '2006-09-17', 22, 42, 1);
INSERT INTO Kocury
VALUES ('PUCEK', 'M', 'RAFA', 'LOWCZY', 'TYGRYS', '2006-10-15', 65, NULL, 4);
INSERT INTO Kocury
VALUES ('PUNIA', 'D', 'KURKA', 'LOWCZY', 'ZOMBI', '2008-01-01', 61, NULL, 3);
INSERT INTO Kocury
VALUES ('BELA', 'D', 'LASKA', 'MILUSIA', 'LYSY', '2008-02-01', 24, 28, 2);
INSERT INTO Kocury
VALUES ('KSAWERY', 'M', 'MAN', 'LAPACZ', 'RAFA', '2008-07-12', 51, NULL, 4);
INSERT INTO Kocury
VALUES ('MELA', 'D', 'DAMA', 'LAPACZ', 'RAFA', '2008-11-01', 51, NULL, 4);

-- Bandy
INSERT INTO Bandy
VALUES (1, 'SZEFOSTWO', 'CALOSC', 'TYGRYS');
INSERT INTO Bandy
VALUES (2, 'CZARNI RYCERZE', 'POLE', 'LYSY');
INSERT INTO Bandy
VALUES (3, 'BIALI LOWCY', 'SAD', 'ZOMBI');
INSERT INTO Bandy
VALUES (4, 'LACIACI MYSLIWI', 'GORKA', 'RAFA');
INSERT INTO Bandy
VALUES (5, 'ROCKERSI', 'ZAGRODA', NULL);

ALTER TABLE Kocury
  ENABLE CONSTRAINT szef_references;
ALTER TABLE Kocury
  ENABLE CONSTRAINT nr_bandy_references;

-- Wrogowie_Kocurow
INSERT INTO Wrogowie_Kocurow
VALUES ('TYGRYS', 'KAZIO', '2004-10-13', 'USILOWAL NABIC NA WIDLY');
INSERT INTO Wrogowie_Kocurow
VALUES ('ZOMBI', 'SWAWOLNY DYZIO', '2005-03-07', 'WYBIL OKO Z PROCY');
INSERT INTO Wrogowie_Kocurow
VALUES ('BOLEK', 'KAZIO', '2005-03-29', 'POSZCZUL BURKIEM');
INSERT INTO Wrogowie_Kocurow
VALUES ('SZYBKA', 'GLUPIA ZOSKA', '2006-09-12', 'UZYLA KOTA JAKO SCIERKI');
INSERT INTO Wrogowie_Kocurow
VALUES ('MALA', 'CHYTRUSEK', '2007-03-07', 'ZALECAL SIE');
INSERT INTO Wrogowie_Kocurow
VALUES ('TYGRYS', 'DZIKI BILL', '2007-06-12', 'USILOWAL POZBAWIC ZYCIA');
INSERT INTO Wrogowie_Kocurow
VALUES ('BOLEK', 'DZIKI BILL', '2007-11-10', 'ODGRYZL UCHO');
INSERT INTO Wrogowie_Kocurow
VALUES ('LASKA', 'DZIKI BILL', '2008-12-12', 'POGRYZL ZE LEDWO SIE WYLIZALA');
INSERT INTO Wrogowie_Kocurow
VALUES ('LASKA', 'KAZIO', '2009-01-07', 'ZLAPAL ZA OGON I ZROBIL WIATRAK');
INSERT INTO Wrogowie_Kocurow
VALUES ('DAMA', 'KAZIO', '2009-02-07', 'CHCIAL OBEDRZEC ZE SKORY');
INSERT INTO Wrogowie_Kocurow
VALUES ('MAN', 'REKSIO', '2009-04-14', 'WYJATKOWO NIEGRZECZNIE OBSZCZEKAL');
INSERT INTO Wrogowie_Kocurow
VALUES ('LYSY', 'BETHOVEN', '2009-05-11', 'NIE PODZIELIL SIE SWOJA KASZA');
INSERT INTO Wrogowie_Kocurow
VALUES ('RURA', 'DZIKI BILL', '2009-09-03', 'ODGRYZL OGON');
INSERT INTO Wrogowie_Kocurow
VALUES ('PLACEK', 'BAZYLI', '2010-07-12', 'DZIOBIAC UNIEMOZLIWIL PODEBRANIE KURCZAKA');
INSERT INTO Wrogowie_Kocurow
VALUES ('PUSZYSTA', 'SMUKLA', '2010-11-19', 'OBRZUCILA SZYSZKAMI');
INSERT INTO Wrogowie_Kocurow
VALUES ('KURKA', 'BUREK', '2010-12-14', 'POGONIL');
INSERT INTO Wrogowie_Kocurow
VALUES ('MALY', 'CHYTRUSEK', '2011-07-13', 'PODEBRAL PODEBRANE JAJKA');
INSERT INTO Wrogowie_Kocurow
VALUES ('UCHO', 'SWAWOLNY DYZIO', '2011-07-14', 'OBRZUCIL KAMIENIAMI');


COMMIT;

-- Zad1
SELECT imie_wroga, opis_incydentu
FROM Wrogowie_Kocurow
WHERE (EXTRACT(YEAR FROM data_incydentu) = 2009);

-- Zad2
SELECT imie, funkcja, w_stadku_od
FROM Kocury
WHERE plec = 'D'
  AND w_stadku_od BETWEEN TO_DATE('2005-09-01', 'YYYY-MM-DD') AND TO_DATE('2007-07-31', 'YYYY-MM-DD');

-- Zad3
SELECT imie_wroga, gatunek, stopien_wrogosci
FROM Wrogowie
WHERE lapowka IS NULL
ORDER BY stopien_wrogosci ASC;

-- Zad4
SELECT imie || ' zwany ' || pseudo || ' (fun. ' || funkcja || ' ) ' ||
       ' lowi myszki w bandzie ' || nr_bandy ||
       ' od ' ||
       w_stadku_od
FROM Kocury
ORDER BY w_stadku_od DESC, pseudo ASC;

-- Zad5
SELECT pseudo,
       REGEXP_REPLACE(REGEXP_REPLACE(pseudo, 'L', '%', 1, 1, 'i'), 'A', '#', 1,
                      1, 'i')
FROM KOCURY;

-- Zad6
SELECT imie,
       w_stadku_od                     AS "W stadku",
       przydzial_myszy                 AS Zjadal,
       ADD_MONTHS(w_stadku_od, 6)      AS Podwyzka,
       ROUND(przydzial_myszy * 1.1, 0) AS Zjada
FROM Kocury
WHERE (2018 - EXTRACT(YEAR FROM w_stadku_od) > 9)
  AND ((EXTRACT(MONTH FROM w_stadku_od)) BETWEEN 3 AND 9);

-- Zad7
SELECT imie, NVL(przydzial_myszy, 0) * 3 AS "MYSZY KWARTALNE", NVL(myszy_extra, 0) * 3 AS "KWARTALNE DODATKI"
FROM Kocury
WHERE NVL(przydzial_myszy, 0) > 2 * NVL(myszy_extra, 0)
  AND NVL(przydzial_myszy, 0) > 54
ORDER BY "MYSZY KWARTALNE" DESC;

-- Zad8
SELECT imie,
       CASE
         WHEN (NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) * 12 > 660
           THEN TO_CHAR(
             (NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) * 12)
         WHEN ((NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) * 12) = 660
           THEN 'Limit'
         ELSE 'Ponizej 660' END AS "Zjada rocznie"
FROM Kocury
ORDER BY imie;

-- Zad 9
-- 25.09
SELECT pseudo,
       w_stadku_od,
       CASE
         WHEN EXTRACT(DAY FROM w_stadku_od) < 16 AND
              NEXT_DAY(LAST_DAY(TO_DATE('2018-09-25', 'YYYY-MM-DD')) -
                       INTERVAL '7' DAY,
                       'WEDNESDAY') > TO_DATE('2018-09-25', 'YYYY-MM-DD')
           THEN NEXT_DAY(LAST_DAY(TO_DATE('2018-09-25', 'YYYY-MM-DD')) -
                         INTERVAL '7' DAY,
                         'WEDNESDAY')
         ELSE NEXT_DAY(LAST_DAY(TO_DATE('2018-09-25', 'YYYY-MM-DD')) +
                       INTERVAL '1' MONTH, 'WEDNESDAY') END AS WYPLATA
FROM Kocury;

-- 27.09
SELECT pseudo,
       w_stadku_od,
       CASE
         WHEN EXTRACT(DAY FROM w_stadku_od) < 16 AND
              NEXT_DAY(LAST_DAY(TO_DATE('2018-09-27', 'YYYY-MM-DD')) -
                       INTERVAL '7' DAY,
                       'WEDNESDAY') > TO_DATE('2018-09-27', 'YYYY-MM-DD')
           THEN NEXT_DAY(LAST_DAY(TO_DATE('2018-09-27', 'YYYY-MM-DD')) -
                         INTERVAL '7' DAY,
                         'WEDNESDAY')
         ELSE NEXT_DAY(LAST_DAY(TO_DATE('2018-09-27', 'YYYY-MM-DD')) +
                       INTERVAL '1' MONTH, 'WEDNESDAY') END AS WYPLATA
FROM Kocury;

-- Zad 10
-- pseudo
SELECT (pseudo || CASE
                    WHEN COUNT(pseudo) = 1 THEN ' - Unikalny'
                    ELSE '- nieunikalny' END) AS "Unikalnosc atr. PSEUDO"
FROM Kocury
GROUP BY pseudo;

-- szef
SELECT (szef || CASE
                  WHEN COUNT(pseudo) = 1 THEN ' - Unikalny'
                  ELSE '- nieunikalny' END) AS "Unikalnosc atr. SZEF"
FROM Kocury
GROUP BY szef;

-- Zad 11
SELECT pseudo, COUNT(imie_wroga) AS "Liczba wrogow"
FROM Wrogowie_Kocurow
HAVING COUNT(imie_wroga) > 1
GROUP BY pseudo;

-- Zad 12
SELECT 'Liczba kotow= ' || COUNT(*) || ' lowi jako ' || funkcja ||
       ' i zjada max. ' ||
       (MAX(NVL(przydzial_myszy, 0)) + MAX(NVL(myszy_extra, 0))) ||
       ' myszy miesiecznie'
FROM Kocury
WHERE plec != 'M'
  AND funkcja != 'SZEFUNIO'
HAVING AVG(NVL(przydzial_myszy, 0)) + AVG(NVL(myszy_extra, 0)) > 50
GROUP BY funkcja;

-- Zad 13
SELECT nr_bandy, plec, MIN(przydzial_myszy) AS "Minimalny przydzial"
FROM Kocury
GROUP BY nr_bandy, plec;

-- Zad 14
SELECT level AS "Poziom", pseudo, funkcja, nr_bandy AS "Nr bandy"
FROM Kocury
WHERE plec = 'M'
CONNECT BY PRIOR pseudo = szef
START WITH funkcja = 'BANDZIOR'
ORDER BY level;

-- Zad 15
SELECT RPAD(LPAD((LEVEL - 1), (LEVEL - 1) * 4 + 1, '==>'), 16) ||
       LPAD(' ', (LEVEL - 1) * 4) || imie AS "Hierarchia",
       NVL(szef, 'Sam sobie panem')       AS "Pseudo szefa",
       funkcja                            AS "Funkcja"
FROM Kocury
WHERE myszy_extra IS NOT NULL
CONNECT BY PRIOR pseudo = szef
START WITH szef IS NULL;

-- Zad 16
SELECT LPAD(' ', (LEVEL - 1) * 3) || pseudo AS "Droga sluzbowa"
FROM Kocury
CONNECT BY pseudo = PRIOR szef
START WITH plec = 'M'
       AND MONTHS_BETWEEN(SYSDATE, w_stadku_od) > (9 * 12)
       AND NVL(myszy_extra, 0) = 0;

-- Zad17
SELECT pseudo AS "POLUJE W POLU", przydzial_myszy AS "PRZYDZIAL MYSZY", nazwa AS "BANDA"
FROM Kocury
       JOIN Bandy ON Kocury.nr_bandy = Bandy.nr_bandy
WHERE przydzial_myszy > 50
  AND teren IN ('POLE', 'CALOSC')
ORDER BY przydzial_myszy DESC;

-- Zad18
SELECT K1.imie AS IMIE, K1.w_stadku_od AS "POLUJE OD"
FROM Kocury K1
       JOIN Kocury KotJacek ON K1.w_stadku_od < KotJacek.w_stadku_od
WHERE KotJacek.imie = 'JACEK'
ORDER BY K1.w_stadku_od DESC;

-- Zad19
-- a
SELECT K.imie AS Imie, K.funkcja AS Funkcja, S1.imie AS "Szef 1", S2.imie AS "Szef 2", S3.imie AS "Szef 3"
FROM Kocury K
       LEFT JOIN Kocury S1 ON K.szef = S1.pseudo
       LEFT JOIN Kocury S2 ON S1.szef = S2.pseudo
       LEFT JOIN Kocury S3 ON S2.szef = S3.pseudo
WHERE K.funkcja IN ('KOT', 'MILUSIA');

-- b
SELECT *
FROM (SELECT CONNECT_BY_ROOT IMIE AS "Imie", CONNECT_BY_ROOT FUNKCJA AS "Funkcja", IMIE AS "szefunio", LEVEL AS "lvl"
      FROM KOCURY
      CONNECT BY PSEUDO = PRIOR SZEF
      START WITH FUNKCJA IN ('KOT', 'MILUSIA'))
       PIVOT (MIN("szefunio")
              FOR "lvl"
              IN (2 "Szef 1", 3 "Szef 2", 4 "Szef 3"));

-- c
SELECT IMIE, FUNKCJA, "Imiona kolejnych szefow"
FROM KOCURY K
       JOIN (SELECT CONNECT_BY_ROOT PSEUDO "PSEUDO", SYS_CONNECT_BY_PATH(IMIE, ' | ') "Imiona kolejnych szefow"
             FROM KOCURY
             WHERE CONNECT_BY_ISLEAF = 1
             CONNECT BY PSEUDO = PRIOR SZEF
             START WITH PSEUDO IN (SELECT SZEF FROM KOCURY WHERE FUNKCJA IN ('KOT', 'MILUSIA'))) x on K.SZEF = x.PSEUDO
WHERE FUNKCJA IN ('KOT', 'MILUSIA');

-- Zad20
SELECT K.imie             AS "Imie Kotki",
       B.nazwa            AS "Nazwa Bandy",
       W.imie_wroga       AS "Imie Wroga",
       W.stopien_wrogosci AS "Ocena wroga",
       WK.data_incydentu  AS "Data inc."
From Kocury K
       JOIN Bandy B on K.nr_bandy = B.nr_bandy
       JOIN Wrogowie_Kocurow WK on K.pseudo = WK.pseudo
       JOIN Wrogowie W on WK.imie_wroga = W.imie_wroga
WHERE K.plec = 'D'
  AND WK.data_incydentu > TO_DATE('2007-01-01', 'YYYY-MM-DD');

-- Zad21
SELECT B.nazwa AS "Nazwa bandy", COUNT(DISTINCT Kocury.pseudo) AS "Koty z wrogami"
FROM Kocury
       JOIN Wrogowie_Kocurow ON Kocury.pseudo = Wrogowie_Kocurow.pseudo
       JOIN Bandy B ON Kocury.nr_bandy = B.nr_bandy
GROUP BY B.nazwa;

-- Zad22
SELECT Kocury.funkcja AS "Funkcja", Kocury.pseudo AS "Pseudonim kota", COUNT(WK.pseudo) AS "Liczba wrogow"
FROM Kocury
       JOIN Wrogowie_Kocurow WK ON Kocury.pseudo = WK.pseudo
HAVING COUNT(WK.pseudo) > 1
GROUP BY Kocury.pseudo, Kocury.funkcja;

-- Zad23
SELECT imie, ((NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) * 12) AS "DAWKA ROCZNA", 'powyżej 864'
FROM Kocury
WHERE ((NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) * 12) > 864
  AND NVL(myszy_extra, 0) > 0
UNION
SELECT imie, ((NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) * 12) AS "DAWKA ROCZNA", '864'
FROM Kocury
WHERE ((NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) * 12) = 864
  AND NVL(myszy_extra, 0) > 0
UNION
SELECT imie, ((NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) * 12) AS "DAWKA ROCZNA", 'poniżej 864'
FROM Kocury
WHERE ((NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) * 12) < 864
  AND NVL(myszy_extra, 0) > 0
GROUP BY imie, przydzial_myszy, myszy_extra
ORDER BY "DAWKA ROCZNA" DESC;

-- Zad24
-- bez podzapytań i operatorow zbiorowych
SELECT B.nr_bandy AS "NAZWA BANDY", B.nazwa, B.teren
FROM Bandy B
       LEFT JOIN Kocury K ON B.nr_bandy = K.nr_bandy
HAVING COUNT(pseudo) = 0
GROUP BY B.nr_bandy, B.nazwa, B.teren;

-- z operatorem zbiorowym
SELECT nr_bandy AS "NAZWA BANDY", nazwa, teren
FROM Bandy
MINUS
SELECT B.nr_bandy AS "NAZWA BANDY", B.nazwa, B.teren
FROM Bandy B
       JOIN Kocury K on B.nr_bandy = K.nr_bandy
GROUP BY B.nr_bandy, B.nazwa, B.teren;

-- Zad25
SELECT K.imie, K.funkcja, K.przydzial_myszy
FROM Kocury K
WHERE K.przydzial_myszy >= 3 *
                           (SELECT *
                            FROM (SELECT NVL(KM.przydzial_myszy, 0)
                                  FROM Kocury KM
                                         JOIN Bandy B on KM.nr_bandy = B.nr_bandy
                                  WHERE KM.funkcja = 'MILUSIA'
                                    AND B.teren IN ('SAD', 'CALOSC')
                                    AND ROWNUM <= 1
                                  ORDER BY przydzial_myszy DESC))
ORDER BY imie;

-- Zad26
-- WITH, DEFINE
SELECT K.funkcja AS "Funkcja", ROUND(AVG(NVL(K.przydzial_myszy, 0) + NVL(K.myszy_extra, 0)), 0)
FROM Kocury K
HAVING ROUND(AVG(NVL(K.przydzial_myszy, 0) + NVL(K.myszy_extra, 0)), 0) IN ((SELECT Przydzial
                                                                             FROM (SELECT K.funkcja,
                                                                                          ROUND(
                                                                                              AVG(
                                                                                                    NVL(K.przydzial_myszy, 0) +
                                                                                                    NVL(K.myszy_extra, 0)),
                                                                                              0) AS Przydzial
                                                                                   FROM Kocury K
                                                                                   HAVING K.funkcja <> 'SZEFUNIO'
                                                                                   GROUP BY K.funkcja
                                                                                   ORDER BY Przydzial DESC)
                                                                             WHERE ROWNUM <= 1), (SELECT Przydzial
                                                                                                  FROM (SELECT K.funkcja,
                                                                                                               ROUND(
                                                                                                                   AVG(
                                                                                                                         NVL(K.przydzial_myszy, 0) +
                                                                                                                         NVL(K.myszy_extra, 0)),
                                                                                                                   0) AS Przydzial
                                                                                                        FROM Kocury K
                                                                                                        HAVING K.funkcja <> 'SZEFUNIO'
                                                                                                        GROUP BY K.funkcja
                                                                                                        ORDER BY Przydzial ASC)
                                                                                                  WHERE ROWNUM <= 1))
GROUP BY funkcja;

-- Zad27
-- wykorzystując podzapytanie skorelowane
SELECT K.pseudo, (NVL(K.przydzial_myszy, 0) + NVL(K.myszy_extra, 0)) AS "ZJADA"
FROM Kocury K
WHERE 12 > (SELECT COUNT(DISTINCT (NVL(K2.przydzial_myszy, 0) + NVL(K2.myszy_extra, 0)))
            FROM Kocury K2
            WHERE (NVL(K.przydzial_myszy, 0) +
                   NVL(K.myszy_extra, 0)) <
                  (NVL(K2.przydzial_myszy, 0) +
                   NVL(K2.myszy_extra, 0)))
ORDER BY ZJADA DESC;

-- wykorzystując pseudokolumnę ROWNUM
SELECT pseudo, (NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) AS "ZJADA"
FROM Kocury
WHERE (NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) IN
      (SELECT *
       FROM (SELECT DISTINCT (NVL(K.przydzial_myszy, 0) + NVL(K.myszy_extra, 0)) AS "ZJADA"
             FROM Kocury K
             ORDER BY ZJADA DESC)
       WHERE ROWNUM <= 5);

-- wykorzystując złączenie relacji Kocury z relacją Kocury
SELECT K.pseudo, (NVL(K.przydzial_myszy, 0) + NVL(K.myszy_extra, 0)) AS "ZJADA"
FROM Kocury K,
     Kocury K2
WHERE (NVL(K.przydzial_myszy, 0) +
       NVL(K.myszy_extra, 0)) <=
      (NVL(K2.przydzial_myszy, 0) +
       NVL(K2.myszy_extra, 0))
GROUP BY K.pseudo, (NVL(K.przydzial_myszy, 0) + NVL(K.myszy_extra, 0))
HAVING 4 >= COUNT(DISTINCT (NVL(K2.PRZYDZIAL_MYSZY, 0) + NVL(K2.MYSZY_EXTRA, 0)))
ORDER BY ZJADA DESC;

-- wykorzystując funkcje analityczne.
SELECT PSEUDO, "ZJADA"
FROM (SELECT PSEUDO,
             (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0))         AS "ZJADA",
             DENSE_RANK() OVER (ORDER BY (NVL(PRZYDZIAL_MYSZY, 0) +
                                          NVL(MYSZY_EXTRA, 0)) DESC) AS "RANK"
      FROM KOCURY)
WHERE "RANK" <= 12;

-- Zad28
SELECT TO_CHAR(EXTRACT(YEAR FROM w_stadku_od)) AS "ROK", COUNT(*) AS "LICZBA WSTAPIEN "
FROM Kocury
GROUP BY EXTRACT(YEAR FROM w_stadku_od)
HAVING COUNT(*) =
       (SELECT MAX(COUNT(*))
        FROM KOCURY
        GROUP BY EXTRACT(YEAR FROM w_stadku_od)
        HAVING COUNT(*) <=
               (SELECT AVG(COUNT(*)) FROM KOCURY GROUP BY EXTRACT(YEAR FROM w_stadku_od)))

UNION ALL
SELECT 'Srednia', ROUND(AVG(COUNT(*)), 7)
FROM Kocury
GROUP BY EXTRACT(YEAR FROM w_stadku_od)

UNION ALL
SELECT TO_CHAR(EXTRACT(YEAR FROM w_stadku_od)), COUNT(*)
FROM Kocury
GROUP BY EXTRACT(YEAR FROM w_stadku_od)
HAVING COUNT(*) =
       (SELECT MIN(COUNT(*))
        FROM KOCURY
        GROUP BY EXTRACT(YEAR FROM w_stadku_od)
        HAVING COUNT(*) >=
               (SELECT AVG(COUNT(*)) FROM KOCURY GROUP BY EXTRACT(YEAR FROM w_stadku_od)));

-- Zad29
-- a
SELECT K.imie                                            AS "IMIE",
       NVL(K.przydzial_myszy, 0) + NVL(K.myszy_extra, 0) AS "ZJADA",
       K.nr_bandy                                        AS "NR BANDY",
       AVG(NVL(K2.przydzial_myszy, 0) + NVL(K2.myszy_extra, 0))
                                                         AS "SREDNIA BANDY"
FROM Kocury K
       JOIN Kocury K2 on K.nr_bandy = K2.nr_bandy
WHERE K.plec = 'M'
GROUP BY K.imie, NVL(K.przydzial_myszy, 0) + NVL(K.myszy_extra, 0), K.nr_bandy
HAVING NVL(K.przydzial_myszy, 0) + NVL(K.myszy_extra, 0) <=
       AVG(NVL(K2.przydzial_myszy, 0) + NVL(K2.myszy_extra, 0))
ORDER BY "SREDNIA BANDY";

-- b
SELECT imie                                            AS "IMIE",
       (NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) AS "ZJADA",
       nr_bandy                                        AS "NR BANDY",
       "SREDNIA BANDY"
FROM KOCURY
       JOIN (SELECT nr_bandy                                             AS "banda",
                    AVG(
                        (NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0))) AS "SREDNIA BANDY"
             FROM KOCURY
             GROUP BY nr_bandy) ON nr_bandy = "banda"
WHERE (NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) < "SREDNIA BANDY"
  AND plec = 'M'
ORDER BY "NR BANDY" DESC;

-- c
SELECT imie                                            AS "IMIE",
       (NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) AS "ZJADA",
       nr_bandy                                        AS "NR BANDY",
       (SELECT AVG(
                   (NVL(K2.przydzial_myszy, 0) + NVL(K2.myszy_extra, 0)))
        FROM Kocury K2
        WHERE K2.nr_bandy = Kocury.nr_bandy
        GROUP BY K2.nr_bandy)                          AS "SREDNIA BANDY"
FROM Kocury
WHERE Kocury.plec = 'M'
  AND (NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) <=
      (SELECT AVG(
                  (NVL(K2.przydzial_myszy, 0) + NVL(K2.myszy_extra, 0)))
       FROM Kocury K2
       WHERE K2.nr_bandy = Kocury.nr_bandy
       GROUP BY K2.nr_bandy)
ORDER BY "NR BANDY" DESC;

-- Zad30
SELECT imie,
       w_stadku_od ||
       ' <--- NAJMlODSZY STAZEM W BANDZIE ' ||
       nazwa AS "WSTAPIL DO STADKA"
FROM Kocury
       LEFT JOIN Bandy B on Kocury.nr_bandy = B.nr_bandy
WHERE w_stadku_od = (SELECT MAX(K.w_stadku_od)
                     FROM Kocury K
                     WHERE K.nr_bandy
                       = B.nr_bandy
                     GROUP BY K
                                .nr_bandy)

UNION
SELECT imie,
       w_stadku_od ||
       ' <--- NAJSTARSZY STAZEM W BANDZIE ' ||
       nazwa
FROM Kocury
       LEFT JOIN Bandy B on Kocury.nr_bandy = B.nr_bandy
WHERE w_stadku_od = (SELECT MIN(K.w_stadku_od)
                     FROM Kocury K
                     WHERE K.nr_bandy
                       = B.nr_bandy
                     GROUP BY K
                                .nr_bandy)

UNION
SELECT imie, TO_CHAR(w_stadku_od)
FROM Kocury
WHERE w_stadku_od NOT IN ((SELECT MIN(K.w_stadku_od)
                           FROM Kocury K
                           WHERE K.nr_bandy
                             = Kocury.nr_bandy
                           GROUP BY K
                                      .nr_bandy), (SELECT MAX(K.w_stadku_od)
                                                   FROM Kocury K
                                                   WHERE K.nr_bandy
                                                     = Kocury.nr_bandy
                                                   GROUP BY K
                                                              .nr_bandy))
ORDER BY imie;

-- Zad31
DROP VIEW Zad31;

CREATE VIEW Zad31 (NAZWA_BANDY, SRE_SPOZ, MAX_SPOZ, MIN_SPOZ, KOTY, KOTY_Z_DOD
  ) AS
SELECT nazwa,
       AVG(
           (NVL(przydzial_myszy, 0))),
       MAX(NVL(przydzial_myszy, 0)),
       MIN(NVL(przydzial_myszy, 0)),
       COUNT(*),
       COUNT(myszy_extra)
FROM Bandy
       JOIN Kocury K on Bandy.nr_bandy = K.nr_bandy
GROUP BY Bandy.nazwa;

SELECT *
FROM Zad31;

SELECT pseudo                                  AS "PSEUDONIM",
       imie                                    AS "IMIE",
       funkcja                                 AS "FUNKCJA",
       PRZYDZIAL_MYSZY                         AS "ZJADA",
       'OD ' || MIN_SPOZ || ' DO ' || MAX_SPOZ AS "GRANICE SPOZYCIA",
       W_STADKU_OD                             AS "LOWI OD"
FROM Kocury
       JOIN Bandy USING (nr_bandy)
       JOIN Zad31 ON Bandy.nazwa = Zad31.NAZWA_BANDY
WHERE pseudo = ?;

-- Zad32
SELECT pseudo              AS "Pseudonim",
       plec                AS "Plec",
       przydzial_myszy     AS "Myszy przed podw.",
       NVL(myszy_extra, 0) AS "Extra przed podw."
FROM Kocury
WHERE pseudo IN (SELECT pseudo
                 FROM ((SELECT pseudo, DENSE_RANK() OVER (ORDER BY w_stadku_od) "rank"
                        FROM KOCURY
                               JOIN BANDY USING (nr_bandy)
                        WHERE nazwa = 'CZARNI RYCERZE')
                       UNION ALL
                       (SELECT pseudo, DENSE_RANK() OVER (ORDER BY w_stadku_od) "rank"
                        FROM KOCURY
                               JOIN BANDY USING (nr_bandy)
                        WHERE nazwa = 'LACIACI MYSLIWI'))
                 WHERE "rank" <= 3)
ORDER BY nr_bandy, w_stadku_od;

UPDATE KOCURY K1
SET PRZYDZIAL_MYSZY = CASE
                        WHEN PLEC = 'D' THEN NVL(PRZYDZIAL_MYSZY, 0) + 0.1 *
                                                                       (SELECT MIN(NVL(PRZYDZIAL_MYSZY, 0))
                                                                        FROM KOCURY)
                        WHEN PLEC = 'M' THEN NVL(PRZYDZIAL_MYSZY, 0) + 10
  END,
    MYSZY_EXTRA     = NVL(MYSZY_EXTRA, 0) +
                      0.15 * (SELECT AVG(NVL(MYSZY_EXTRA, 0))
                              FROM KOCURY
                              WHERE K1.NR_BANDY = KOCURY.NR_BANDY)
WHERE pseudo IN (SELECT pseudo
                 FROM ((SELECT pseudo, DENSE_RANK() OVER (ORDER BY w_stadku_od) "rank"
                        FROM KOCURY
                               JOIN BANDY USING (nr_bandy)
                        WHERE nazwa = 'CZARNI RYCERZE')
                       UNION
                       (SELECT pseudo, DENSE_RANK() OVER (ORDER BY w_stadku_od) "rank"
                        FROM KOCURY
                               JOIN BANDY USING (nr_bandy)
                        WHERE nazwa = 'LACIACI MYSLIWI'))
                 WHERE "rank" <= 3);

SELECT pseudo              AS "Pseudonim",
       plec                AS "Plec",
       przydzial_myszy     AS "Myszy po podw.",
       NVL(myszy_extra, 0) AS "Extra po podw."
FROM Kocury
WHERE pseudo IN (SELECT pseudo
                 FROM ((SELECT pseudo, DENSE_RANK() OVER (ORDER BY w_stadku_od) "rank"
                        FROM KOCURY
                               JOIN BANDY USING (nr_bandy)
                        WHERE nazwa = 'CZARNI RYCERZE')
                       UNION
                       (SELECT pseudo, DENSE_RANK() OVER (ORDER BY w_stadku_od) "rank"
                        FROM KOCURY
                               JOIN BANDY USING (nr_bandy)
                        WHERE nazwa = 'LACIACI MYSLIWI'))
                 WHERE "rank" <= 3)
ORDER BY nr_bandy, w_stadku_od;

ROLLBACK;

-- Zad33

-- a
SELECT DECODE("PLEC", 'KOCOR', ' ', NAZWA) "NAZWA BANDY",
       "PLEC",
       "ILE",
       "SZEFUNIO",
       "BANDZIOR",
       "LOWCZY",
       "LAPACZ",
       "KOT",
       "MILUSIA",
       "DZIELCZY",
       "SUMA"
FROM (SELECT NAZWA,
             DECODE(PLEC, 'M', 'KOCOR', 'KOTKA')                         "PLEC",
             TO_CHAR(COUNT(*))                                           "ILE",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'SZEFUNIO',
                                (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)),
                                0)))                                     "SZEFUNIO",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'BANDZIOR',
                                (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)),
                                0)))                                     "BANDZIOR",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'LOWCZY',
                                (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)),
                                0)))                                     "LOWCZY",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'LAPACZ',
                                (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)),
                                0)))                                     "LAPACZ",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'KOT',
                                (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)),
                                0)))                                     "KOT",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'MILUSIA',
                                (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)),
                                0)))                                     "MILUSIA",
             TO_CHAR(SUM(DECODE(FUNKCJA, 'DZIELCZY',
                                (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)),
                                0)))                                     "DZIELCZY",
             TO_CHAR(SUM(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0))) "SUMA"
      FROM KOCURY K
             JOIN BANDY B ON K.NR_BANDY = B.NR_BANDY
      GROUP BY NAZWA, PLEC

      UNION
      SELECT 'Z-----------------',
             '------',
             '-------',
             '-----------',
             '-----------',
             '----------',
             '----------',
             '----------',
             '----------',
             '-----------',
             '----------'
      FROM dual

      UNION
      SELECT 'ZJADA RAZEM',
             ' ',
             ' ',
             TO_CHAR(SUM(DECODE(FUNKCJA, 'SZEFUNIO',
                                (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)),
                                0))),
             TO_CHAR(SUM(DECODE(FUNKCJA, 'BANDZIOR',
                                (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)),
                                0))),
             TO_CHAR(SUM(DECODE(FUNKCJA, 'LOWCZY',
                                (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)),
                                0))),
             TO_CHAR(SUM(DECODE(FUNKCJA, 'LAPACZ',
                                (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)),
                                0))),
             TO_CHAR(SUM(DECODE(FUNKCJA, 'KOT',
                                (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)),
                                0))),
             TO_CHAR(SUM(DECODE(FUNKCJA, 'MILUSIA',
                                (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)),
                                0))),
             TO_CHAR(SUM(DECODE(FUNKCJA, 'DZIELCZY',
                                (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)),
                                0))),
             TO_CHAR(
                 SUM(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)))
      FROM KOCURY K
      ORDER BY 1, 2 DESC);

-- b
SELECT DECODE("PLEC", 'Kocor', ' ', "NAZWA BANDY") "NAZWA BANDY",
       "PLEC",
       "ILE",
       "SZEFUNIO",
       "BANDZIOR",
       "LOWCZY",
       "LAPACZ",
       "KOT",
       "MILUSIA",
       "DZIELCZY",
       "SUMA"
FROM (SELECT "NAZWA BANDY",
             "PLEC",
             "ILE",
             "SZEFUNIO",
             "BANDZIOR",
             "LOWCZY",
             "LAPACZ",
             "KOT",
             "MILUSIA",
             "DZIELCZY",
             "SUMA"
      FROM (SELECT NAZWA                                         "NAZWA BANDY",
                   DECODE(PLEC, 'D', 'Kotka', 'Kocor')           "PLEC",
                   TO_CHAR((SELECT COUNT(*)
                            FROM KOCURY K2
                            WHERE K2.NR_BANDY = B.NR_BANDY
                              AND K2.PLEC = K.PLEC))             "ILE",
                   NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0) "myszy_calk",
                   FUNKCJA,
                   TO_CHAR(
                       (SELECT SUM(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0))
                        FROM KOCURY K2
                        WHERE K2.NR_BANDY = K.NR_BANDY
                        GROUP BY K2.NR_BANDY))                   "SUMA"
            FROM KOCURY K
                   JOIN BANDY B on K.NR_BANDY = B.NR_BANDY)
             PIVOT (
                    MAX(TO_CHAR("myszy_calk"))
                    FOR FUNKCJA
                    IN ('SZEFUNIO' "SZEFUNIO", 'BANDZIOR' "BANDZIOR", 'LOWCZY' "LOWCZY", 'LAPACZ' "LAPACZ", 'KOT' "KOT", 'MILUSIA' "MILUSIA", 'DZIELCZY' "DZIELCZY")
          )

      UNION
      SELECT 'Z-------------------',
             '------',
             '------',
             '-------------',
             '-------------',
             '------------',
             '-----------',
             '--------',
             '-----------',
             '-------------',
             '---------'
      FROM dual

      UNION
      SELECT 'ZJADA RAZEM',
             ' ',
             ' ',
             TO_CHAR("SZEFUNIO"),
             TO_CHAR("BANDZIOR"),
             TO_CHAR("LOWCZY"),
             TO_CHAR("LAPACZ"),
             TO_CHAR("KOT"),
             TO_CHAR("MILUSIA"),
             TO_CHAR("DZIELCZY"),
             TO_CHAR(
                 (SELECT SUM(NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0)) FROM KOCURY)) "suma"
      FROM (SELECT FUNKCJA, NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0) "myszy_calk" FROM KOCURY)
             PIVOT (
                    SUM("myszy_calk")
                    FOR FUNKCJA
                    IN ('SZEFUNIO' "SZEFUNIO", 'BANDZIOR' "BANDZIOR", 'LOWCZY' "LOWCZY", 'LAPACZ' "LAPACZ", 'KOT' "KOT", 'MILUSIA' "MILUSIA", 'DZIELCZY' "DZIELCZY")
          )
      ORDER BY 1, 2 DESC);

--   34
DECLARE
  numberOfCatFounds NUMBER       := 0;
  functionOfCat     VARCHAR2(30) := ?;
BEGIN

  SELECT COUNT(*) INTO numberOfCatFounds FROM Kocury WHERE funkcja = functionOfCat;

  IF numberOfCatFounds = 0
  THEN
    DBMS_OUTPUT.PUT_LINE('Nie znaleziono');
  ELSIF numberOfCatFounds > 0
  THEN
    DBMS_OUTPUT.PUT_LINE('Znaleziono ' || functionOfCat);
  END IF;

END;

-- 35
DECLARE
  requestedCatPseudo VARCHAR2(30) := 'ZERO';
  totalMouseRation   NUMBER       := 0;
  name               VARCHAR2(30);
  dateOfAddition     DATE;

BEGIN
  SELECT imie INTO name FROM Kocury WHERE Kocury.pseudo = requestedCatPseudo;
  SELECT NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0) INTO totalMouseRation FROM Kocury WHERE imie = name;
  SELECT w_stadku_od INTO dateOfAddition FROM Kocury WHERE imie = name;

  IF totalMouseRation * 12 > 700
  THEN
    DBMS_OUTPUT.PUT_LINE(name || ' calkowity roczny przydzial myszy >700');
  ELSIF INSTR(name, 'a') != 0 OR INSTR(name, 'A') != 0
  THEN
    DBMS_OUTPUT.PUT_LINE(name || ' imię zawiera litere A');
  ELSIF EXTRACT(MONTH FROM dateOfAddition) = 1
  THEN
    DBMS_OUTPUT.PUT_LINE(name || ' styczeń jest miesiacem przystapienia do stada');
  ELSE
    DBMS_OUTPUT.PUT_LINE(name || ' nie odpowiada kryteriom');
  END IF;

  EXCEPTION
  WHEN NO_DATA_FOUND
  THEN DBMS_OUTPUT.PUT_LINE('Nie znaleziono kota o podanym pseudonimie');
  WHEN OTHERS
  THEN DBMS_OUTPUT.PUT_LINE('Niestety Wystapil wyjatek');
END;

-- 36
DECLARE
  sumPrzydzial  NUMBER;
  nowyPrzydzial NUMBER;
  zmianCounter  NUMBER := 0;
  CURSOR kotKursor IS SELECT pseudo,przydzial_myszy,max_myszy
                      FROM Kocury
                             JOIN Funkcje F on Kocury.funkcja = F.funkcja
                      ORDER BY przydzial_myszy FOR UPDATE OF przydzial_myszy;

BEGIN
  SELECT SUM(przydzial_myszy) INTO sumPrzydzial FROM Kocury;
  DBMS_OUTPUT.PUT_LINE('Suma przydzialow przed zmianami ' || sumPrzydzial);
  <<zew>>
    LOOP
      FOR kot IN kotKursor
        LOOP
          IF sumPrzydzial > 1050 THEN
            EXIT zew;
          END IF;
          nowyPrzydzial := ROUND(kot.przydzial_myszy * 1.1);
          IF nowyPrzydzial > kot.max_myszy THEN
            nowyPrzydzial := kot.max_myszy;
          END IF;
          IF nowyPrzydzial <> kot.przydzial_myszy THEN
            UPDATE Kocury SET przydzial_myszy = nowyPrzydzial WHERE pseudo = kot.pseudo;
            zmianCounter := zmianCounter + 1;
          END IF;
          SELECT SUM(przydzial_myszy) INTO sumPrzydzial FROM Kocury;
        END LOOP;
    END LOOP zew;
  DBMS_OUTPUT.PUT_LINE('Suma przydzialow po zmianach ' || sumPrzydzial);
  DBMS_OUTPUT.PUT_LINE('Zmian ' || zmianCounter);
  DBMS_OUTPUT.PUT_LINE(' ');

  DBMS_OUTPUT.PUT_LINE('IMIE          MYSZY PO PODWYZCE');
  DBMS_OUTPUT.PUT_LINE('------------- -----------------');

  FOR kot IN kotKursor
    LOOP
      DBMS_OUTPUT.PUT_LINE(RPAD(kot.pseudo, 10) || ' ' || LPAD(kot.przydzial_myszy, 20));
    END LOOP;
  ROLLBACK;
END;

-- 37
DECLARE
  CURSOR kotKursor IS SELECT pseudo,przydzial_myszy,myszy_extra
                      FROM Kocury
                      ORDER BY NVL(przydzial_myszy, 0) + NVL
                        (myszy_extra, 0) DESC;
  counter NUMBER := 1;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Nr    Pseudonim    Zjada');
  DBMS_OUTPUT.PUT_LINE('------------------------');
  FOR kot IN kotKursor
    LOOP
      IF counter > 5 THEN
        EXIT;
      END IF;
      DBMS_OUTPUT.PUT_LINE(RPAD(counter, 5) || ' ' || RPAD(kot.pseudo, 12) || ' ' || (NVL(kot.przydzial_myszy, 0)
        + NVL(kot.myszy_extra, 0)));
      counter := counter + 1;
    END LOOP;
END;

-- 38
DECLARE
  CURSOR kotKursor IS SELECT imie,funkcja,szef
                      FROM Kocury
                      WHERE funkcja IN ('MILUSIA', 'KOT');
  szefNumber       NUMBER := ?;
  aktualnySzef     KOCURY.SZEF%TYPE;
  imieAktualnySzef KOCURY.IMIE%TYPE;

BEGIN
  DBMS_OUTPUT.PUT(RPAD('IMIE', 10));

  FOR szefIter IN 1..szefNumber
    LOOP
      DBMS_OUTPUT.PUT(RPAD('SZEF ' || (szefIter), 10));
    END LOOP;
  dbms_output.new_line();
  DBMS_OUTPUT.PUT_LINE(RPAD('-', 10 * (szefNumber + 1), '-'));

  FOR kot IN kotKursor
    LOOP
      DBMS_OUTPUT.PUT(RPAD(kot.imie, 10));
      aktualnySzef := kot.szef;
      FOR szef IN 1..szefNumber
        LOOP
          EXIT WHEN aktualnySzef IS NULL;
          SELECT imie, szef into imieAktualnySzef, aktualnySzef FROM KOCURY WHERE PSEUDO = aktualnySzef;
          DBMS_OUTPUT.PUT(RPAD(imieAktualnySzef, 10));
        end loop;
      dbms_output.new_line();
    end loop;
END;

-- 39
DECLARE
  CURSOR bandyTerenKursor IS SELECT nr_bandy,nazwa,teren
                             FROM Bandy;
  nrBandy      NUMBER       := 0;
  nazwaBandy   VARCHAR2(20) := 'Dupna ';
  terenBandy   VARCHAR2(15) := 'Dupneeee';
  errorMesage  VARCHAR2(50) := '';
  errorCounter NUMBER       := 0;

  NIEPOPRAWNE_DANE EXCEPTION;

BEGIN
  FOR banda IN bandyTerenKursor
    LOOP
      IF banda.nr_bandy = nrBandy THEN
        errorMesage := errorMesage || nrBandy || ', ';
        errorCounter := errorCounter + 1;
      end if;
      IF banda.nazwa = nazwaBandy THEN
        errorMesage := errorMesage || nazwaBandy || ', ';
        errorCounter := errorCounter + 1;
      end if;
      IF banda.teren = terenBandy THEN
        errorMesage := errorMesage || terenBandy || ', ';
        errorCounter := errorCounter + 1;
      end if;
    end loop;
  IF errorCounter > 0 THEN
    RAISE NIEPOPRAWNE_DANE;
  end if;

  INSERT INTO Bandy VALUES (nrBandy, nazwaBandy, terenBandy, NULL);
  ROLLBACK;
  EXCEPTION
  WHEN NIEPOPRAWNE_DANE THEN DBMS_OUTPUT.PUT_LINE(errorMesage || ': już istnieje');
  WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Inny error ' || SQLERRM);

END;

-- 40
CREATE OR REPLACE PROCEDURE DodajBande(nrBandy number, nazwaBandy varchar2, terenBandy varchar2) AS
  CURSOR bandyTerenKursor IS SELECT nr_bandy,nazwa,teren
                             FROM Bandy;
  errorMesage VARCHAR2(50) := '';
  errorCounter NUMBER := 0;

  NIEPOPRAWNE_DANE EXCEPTION;

BEGIN
  FOR banda IN bandyTerenKursor
    LOOP
      IF banda.nr_bandy = nrBandy THEN
        errorMesage := errorMesage || nrBandy || ', ';
        errorCounter := errorCounter + 1;
      end if;
      IF banda.nazwa = nazwaBandy THEN
        errorMesage := errorMesage || nazwaBandy || ', ';
        errorCounter := errorCounter + 1;
      end if;
      IF banda.teren = terenBandy THEN
        errorMesage := errorMesage || terenBandy || ', ';
        errorCounter := errorCounter + 1;
      end if;
    end loop;
  IF errorCounter > 0 THEN
    RAISE NIEPOPRAWNE_DANE;
  end if;

  INSERT INTO Bandy VALUES (nrBandy, nazwaBandy, terenBandy, NULL);

  EXCEPTION
  WHEN NIEPOPRAWNE_DANE THEN DBMS_OUTPUT.PUT_LINE(errorMesage || ': już istnieje');
  WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Inny error ' || SQLERRM);

END;

SELECT *
FROM Bandy;

rollback;

BEGIN
  DodajBande(nrBandy=>10, nazwaBandy=>'dup1a', terenBandy=>'Wr1oclaw');
  --   rollback;
end;

-- 41
CREATE OR REPLACE TRIGGER zawszeOJedenWiekszyNumerBandy
  BEFORE INSERT
  ON Bandy
  FOR EACH ROW
DECLARE
  maxNumerBandy NUMBER;
BEGIN
  SELECT MAX(nr_bandy) INTO maxNumerBandy FROM Bandy;
  :NEW.nr_bandy := maxNumerBandy + 1;
end;

-- 42

CREATE OR REPLACE PACKAGE wirusPakiet AS
  przydzialTygrysa NUMBER;
  przydzialTygrysaMyszExtra NUMBER;
  ukarzNagrodzTygrysa NUMBER DEFAULT 0;
END wirusPakiet;

CREATE OR REPLACE TRIGGER setPrzydzialTygrysaInWirus
  BEFORE UPDATE OF przydzial_myszy
  ON Kocury
BEGIN
  SELECT przydzial_myszy INTO wirusPakiet.przydzialTygrysa FROM Kocury WHERE pseudo = 'TYGRYS';
  SELECT myszy_extra INTO wirusPakiet.przydzialTygrysaMyszExtra FROM Kocury WHERE pseudo = 'TYGRYS';
end;

CREATE OR REPLACE TRIGGER wirus
  BEFORE UPDATE OF przydzial_myszy
  ON Kocury
  FOR EACH ROW
DECLARE
  min_funkcji NUMBER DEFAULT 0;
  max_funkcji NUMBER DEFAULT 0;
BEGIN
  IF :new.funkcja = 'MILUSIA' THEN
    DBMS_OUTPUT.PUT_LINE('Wykryto update dla kota o funkcji milusia');
    IF :NEW.przydzial_myszy > :OLD.przydzial_myszy THEN
      DBMS_OUTPUT.PUT_LINE('zmiana jest dodatnia');
      IF (0.1 * wirusPakiet.przydzialTygrysa) > (:new.przydzial_myszy - :old.przydzial_myszy) THEN
        DBMS_OUTPUT.PUT_LINE('zmiana jest mniejsza niz 10% aktualnego przydzialu tygrysa - karzemy tygrysa');
        :new.myszy_extra := :new.myszy_extra + 5;
        wirusPakiet.ukarzNagrodzTygrysa := -1;
      ELSE
        DBMS_OUTPUT.PUT_LINE('zmiana jest wieksza niz 10% aktualnego przydzialu tygrysa - nagradzamy tygrysa' || ' ' ||
                             '10% tygrysa: ' || 0.1 * wirusPakiet.przydzialTygrysa || 'roznica zmiany: ' ||
                             (:new.przydzial_myszy - :old.przydzial_myszy));
        wirusPakiet.ukarzNagrodzTygrysa := 1;
      END IF;
    ELSE
      :new.przydzial_myszy := :old.przydzial_myszy;
      DBMS_OUTPUT.PUT_LINE('Jakis wirus wkradł się do systemu i nie można obniżyć przydziału Milusich');
    END IF;
  end if;

  SELECT min_myszy, max_myszy INTO min_funkcji, max_funkcji
  FROM Funkcje
  WHERE funkcja = :new.funkcja;

  IF :new.przydzial_myszy < min_funkcji THEN
    :new.przydzial_myszy := min_funkcji;
  ELSIF :new.przydzial_myszy > max_funkcji THEN
    :new.przydzial_myszy := max_funkcji;
  END IF;
END;

CREATE OR REPLACE TRIGGER ukarz_lub_nagrodz_tygrysa
  AFTER UPDATE OF przydzial_myszy
  ON Kocury
BEGIN
  IF wirusPakiet.ukarzNagrodzTygrysa > 0 THEN
    wirusPakiet.ukarzNagrodzTygrysa := 0;
    UPDATE Kocury SET myszy_extra = myszy_extra + 5 WHERE pseudo = 'TYGRYS';
    DBMS_OUTPUT.PUT_LINE('Tygrysa przydzial zwiekszony!');
  ELSIF wirusPakiet.ukarzNagrodzTygrysa < 0 THEN
    wirusPakiet.ukarzNagrodzTygrysa := 0;
    UPDATE Kocury SET przydzial_myszy = przydzial_myszy * 0.9 WHERE pseudo = 'TYGRYS';
    DBMS_OUTPUT.PUT_LINE('Tygrysa przydzial zmniejszony');
  END IF;
END;

SELECT *
FROM Kocury;

UPDATE Kocury
SET przydzial_myszy = przydzial_myszy + 11
WHERE pseudo = 'LOLA';

SELECT *
FROM Kocury
WHERE pseudo = 'LOLA'
   OR pseudo = 'TYGRYS';

ROLLBACK;

ALTER TRIGGER ukarz_lub_nagrodz_tygrysa DISABLE;
ALTER TRIGGER wirus DISABLE;
ALTER TRIGGER setPrzydzialTygrysaInWirus DISABLE;

-- 42 compound
CREATE OR REPLACE TRIGGER compundWirus
  FOR UPDATE OF przydzial_myszy
  ON Kocury
  COMPOUND TRIGGER
  przydzialTygrysa NUMBER;
  przydzialTygrysaMyszExtra NUMBER;
  ukarzNagrodzTygrysa NUMBER := 0;

BEFORE STATEMENT IS
BEGIN
  SELECT przydzial_myszy,myszy_extra INTO przydzialTygrysa, przydzialTygrysaMyszExtra
  FROM Kocury
  WHERE pseudo = 'TYGRYS';
END BEFORE STATEMENT;
  BEFORE EACH ROW IS
    min_funkcji NUMBER := 0;
    max_funkcji NUMBER := 0;
  BEGIN
    IF :new.funkcja = 'MILUSIA' THEN
      DBMS_OUTPUT.PUT_LINE('Wykryto update dla kota o funkcji milusia');
      IF :NEW.przydzial_myszy > :OLD.przydzial_myszy THEN
        DBMS_OUTPUT.PUT_LINE('zmiana jest dodatnia');
        IF (0.1 * przydzialTygrysa) > (:new.przydzial_myszy - :old.przydzial_myszy) THEN
          DBMS_OUTPUT.PUT_LINE('zmiana jest mniejsza niz 10% aktualnego przydzialu tygrysa - karzemy tygrysa');
          :new.myszy_extra := :new.myszy_extra + 5;
          ukarzNagrodzTygrysa := -1;
        ELSE
          DBMS_OUTPUT.PUT_LINE(
                'zmiana jest wieksza niz 10% aktualnego przydzialu tygrysa - nagradzamy tygrysa' || ' ' ||
                '10% tygrysa: ' || 0.1 * przydzialTygrysa || 'roznica zmiany: ' ||
                (:new.przydzial_myszy - :old.przydzial_myszy));
          ukarzNagrodzTygrysa := 1;
        END IF;
      ELSE
        :new.przydzial_myszy := :old.przydzial_myszy;
        DBMS_OUTPUT.PUT_LINE('Jakis wirus wkradł się do systemu i nie można obniżyć przydziału Milusich');
      END IF;
    END IF;

    SELECT min_myszy, max_myszy INTO min_funkcji, max_funkcji
    FROM Funkcje
    WHERE funkcja = :new.funkcja;

    IF :new.przydzial_myszy < min_funkcji THEN
      :new.przydzial_myszy := min_funkcji;
      DBMS_OUTPUT.PUT_LINE('nowy przydzial jest mniejszy niz min funkcji -> nowy przydzial = min funkcji');
    ELSIF :new.przydzial_myszy > max_funkcji THEN
      DBMS_OUTPUT.PUT_LINE('nowy przydzial jest wiekszy niz max funkcji -> nowy przydzial = max funkcji');
      :new.przydzial_myszy := max_funkcji;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Stary przydzial: ' || :old.przydzial_myszy || ' nowy: ' || :new.przydzial_myszy);
  END BEFORE EACH ROW;

  AFTER STATEMENT IS
  BEGIN
    IF ukarzNagrodzTygrysa > 0 THEN
      ukarzNagrodzTygrysa := 0;
      UPDATE Kocury SET myszy_extra = myszy_extra + 5 WHERE pseudo = 'TYGRYS';
      DBMS_OUTPUT.PUT_LINE('Tygrysa przydzial zwiekszony!');
    ELSIF ukarzNagrodzTygrysa < 0 THEN
      ukarzNagrodzTygrysa := 0;
      UPDATE Kocury SET przydzial_myszy = przydzial_myszy * 0.9 WHERE pseudo = 'TYGRYS';
      DBMS_OUTPUT.PUT_LINE('Tygrysa przydzial zmniejszony');
    END IF;
  END AFTER STATEMENT;
  END compundWirus;

SELECT *
FROM Kocury
WHERE pseudo = 'LOLA'
   OR pseudo = 'TYGRYS';

ROLLBACK;

ALTER TRIGGER compundWirus DISABLE;

UPDATE KOCURY
SET przydzial_myszy = przydzial_myszy - 5
WHERE pseudo = 'LOLA';

UPDATE KOCURY
SET myszy_extra = myszy_extra - 5
WHERE pseudo = 'TYGRYS';

-- 43
-- (33) Napisać zapytanie, w ramach którego obliczone zostaną sumy całkowitego spożycia myszy przez koty sprawujące
-- każdą z funkcji z podziałem na bandy i płcie kotów. Podsumować przydziały dla każdej z funkcji.

DECLARE
  CURSOR bandaKursor IS SELECT Kocury.NR_BANDY,
                               NAZWA,
                               PLEC,
                               count(*) AS ILE
                        from BANDY
                               JOIN KOCURY on BANDY.NR_BANDY = KOCURY.NR_BANDY
                        group by BANDY.NAZWA, PLEC, KOCURY.NR_BANDY
                        order by BANDY.NAZWA, PLEC;
  CURSOR funkcjeKursor IS SELECT funkcja
                          FROM Funkcje;
  sumaFunkcjaBandaPlec NUMBER;
  sumFunkcja           NUMBER;
  sumBandaPlec         NUMBER;
  sumaTotal            NUMBER;
BEGIN
  DBMS_OUTPUT.PUT(RPAD('NAZWA BANDY', 20));
  DBMS_OUTPUT.PUT(RPAD('PLEC', 10));
  DBMS_OUTPUT.PUT(RPAD('ILE', 5));

  FOR funkcja IN funkcjeKursor
    LOOP
      DBMS_OUTPUT.PUT(RPAD(funkcja.funkcja, 15));
    end loop;

  DBMS_OUTPUT.PUT_LINE(RPAD('SUMA', 15));
  DBMS_OUTPUT.PUT_LINE(LPAD(' ', 161, '-'));

  FOR banda IN bandaKursor
    LOOP
      DBMS_OUTPUT.PUT(RPAD(banda.nazwa, 20));
      IF banda.plec = 'M' THEN
        DBMS_OUTPUT.PUT(RPAD('Kocur', 10));
      ELSIF banda.plec = 'D' THEN
        DBMS_OUTPUT.PUT(RPAD('Kotka', 10));
      END IF;

      DBMS_OUTPUT.PUT(RPAD(banda.ILE, 5));

      FOR funkcjaIter IN funkcjeKursor
        LOOP
          SELECT SUM(CASE
                       WHEN Kocury.funkcja = funkcjaIter.funkcja THEN NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)
                       ELSE 0 END)
                 INTO sumaFunkcjaBandaPlec
          FROM Kocury
          WHERE Kocury.nr_bandy = banda.nr_bandy
            AND Kocury.plec = banda.plec;

          DBMS_OUTPUT.PUT(RPAD(sumaFunkcjaBandaPlec, 15));
        end loop;

      SELECT SUM(NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) INTO sumBandaPlec
      FROM Kocury
      WHERE banda.plec =
            Kocury.plec
        AND banda.nr_bandy = Kocury.nr_bandy;

      DBMS_OUTPUT.PUT_LINE(RPAD(sumBandaPlec, 15));

    END LOOP;
  DBMS_OUTPUT.PUT_LINE(LPAD(' ', 161, '-'));
  DBMS_OUTPUT.PUT_LINE('');
  DBMS_OUTPUT.PUT('Zjada razem');
  DBMS_OUTPUT.PUT(LPAD(' ', 24, ' '));

  FOR funkcjaIter IN funkcjeKursor
    LOOP
      SELECT SUM(CASE
                   WHEN Kocury.funkcja = funkcjaIter.funkcja THEN NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)
                   ELSE 0 END)
             INTO sumFunkcja
      FROM Kocury;
      DBMS_OUTPUT.PUT(RPAD(sumFunkcja, 15));
    end loop;

  SELECT SUM(NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) INTO sumaTotal
  FROM Kocury;

  DBMS_OUTPUT.PUT(RPAD(sumaTotal, 15));

  DBMS_OUTPUT.PUT_LINE('');
END;

-- 44
  CREATE OR REPLACE PACKAGE zad44 AS
  FUNCTION podatekPoglowny(
    pseudoKota KOCURY.PSEUDO%TYPE
  )
    RETURN NUMBER;

  --   PROCEDURE DodajBande(nowy_nr BANDY.NR_BANDY%TYPE, nowa_nazwa BANDY.NAZWA%TYPE,
  --                        nowy_teren BANDY.TEREN%TYPE);
END zad44;

CREATE OR REPLACE PACKAGE BODY zad44 AS
  FUNCTION podatekPoglowny(
    pseudoKota Kocury.pseudo%TYPE
  )
    RETURN NUMBER IS
    sumaPodatku NUMBER;

    totalMyszy NUMBER;
    totalMyszyPoPodatku NUMBER;

    iloscPodwladnych NUMBER;
    iloscWrogow NUMBER;
    plec Kocury.plec%TYPE;

    minFunkcji NUMBER := 0;
    maxFunkcji NUMBER := 0;
  BEGIN
    SELECT CEIL(0.05 * (NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0))),
           (NVL(przydzial_myszy, 0) + NVL(myszy_extra,
                                          0))
           INTO sumaPodatku,totalMyszy
    FROM Kocury
    WHERE pseudo = pseudoKota;

    DBMS_OUTPUT.PUT_LINE('Naliczono 5%: ' || sumaPodatku);

    SELECT COUNT(*) INTO iloscPodwladnych FROM Kocury WHERE szef = pseudoKota;
    IF iloscPodwladnych < 1 THEN
      sumaPodatku := sumaPodatku + 2;
      DBMS_OUTPUT.PUT_LINE('Naliczono dodatkowy podatek za brak podwladnych, suma podatku ' || sumaPodatku);
    end if;

    SELECT COUNT(*) INTO iloscWrogow FROM Wrogowie_Kocurow WHERE pseudo = pseudoKota;
    IF iloscWrogow < 1 THEN
      sumaPodatku := sumaPodatku + 1;
      DBMS_OUTPUT.PUT_LINE('Naliczono dodatkowy podatek za brak wrogow, Suma podatku ' || sumaPodatku);
    end if;

    --     podatek wzmacniajacy women pay gap
    SELECT plec INTO plec FROM Kocury WHERE pseudoKota = pseudo;
    IF plec = 'D' THEN
      sumaPodatku := sumaPodatku + 10;
      DBMS_OUTPUT.PUT_LINE('Naliczono dodatkowy podatek za bycie Kotka, Suma podatku: ' || sumaPodatku);
    end if;

    totalMyszyPoPodatku := totalMyszy - sumaPodatku;

    SELECT min_myszy,
           max_myszy
           INTO minFunkcji,maxFunkcji
    FROM Funkcje,
         Kocury
    WHERE Funkcje.funkcja = Kocury.funkcja
      AND Kocury.pseudo = pseudoKota;


    -- gwarantowane swiadczenie socjalne obowiazuje
    IF totalMyszyPoPodatku < minFunkcji THEN
      totalMyszyPoPodatku := minFunkcji;
      DBMS_OUTPUT.PUT_LINE('Przychod myszy przed podatkiem: ' || totalMyszy);
      DBMS_OUTPUT.PUT_LINE('Podatek naliczony bez ulgi funkcyjnej: ' || sumaPodatku);
      sumaPodatku := totalMyszy - totalMyszyPoPodatku;
      DBMS_OUTPUT.PUT_LINE('Wliczono ulge podatkowo - min funkcji:' || minFunkcji || ' Należny podatek wyniosl: ' ||
                           sumaPodatku);
    END IF;

    DBMS_OUTPUT.PUT_LINE('Przychod po opodatkowaniu: ' || totalMyszyPoPodatku);
    RETURN sumaPodatku;
  END;
END zad44;

DECLARE
  rezult NUMBER;
BEGIN
  rezult := zad44.podatekPoglowny('LOLA');
  dbms_output.put_line('Wynik metody podatek myszowy: ' || rezult);
  rollback;
END;

-- 45
/*
CREATE TABLE Funkcje
(
  funkcja   VARCHAR2(10)
    CONSTRAINT funkcja_primary_key PRIMARY KEY,
  min_myszy NUMBER(3)
    CONSTRAINT min_myszy_check CHECK (min_myszy > 5),
  max_myszy NUMBER(3)
    CONSTRAINT max_myszy_check CHECK (200 > max_myszy),
  CONSTRAINT max_myszy_min_myszy CHECK (max_myszy > min_myszy)
);
 */
DROP TABLE Dodatki_extra;
CREATE TABLE Dodatki_extra
(
  pseudo        VARCHAR2(15)
    CONSTRAINT dodatki_extra_pseudo REFERENCES Kocury (pseudo),
  dodatek_extra NUMBER(3) NOT NULL
);

CREATE OR REPLACE TRIGGER kara_dla_milus
  BEFORE UPDATE OF PRZYDZIAL_MYSZY
  ON KOCURY
  FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  IF LOGIN_USER <> 'TYGRYS' AND :NEW.FUNKCJA = 'MILUSIA' AND :NEW.PRZYDZIAL_MYSZY - :OLD.PRZYDZIAL_MYSZY > 0
  THEN
    EXECUTE IMMEDIATE 'INSERT INTO Dodatki_extra(PSEUDO,dodatek_extra) VALUES (''' || :NEW.PSEUDO || ''',-10)';
    EXECUTE IMMEDIATE 'COMMIT';
  END IF;
END;

BEGIN
  UPDATE KOCURY SET PRZYDZIAL_MYSZY = 34 WHERE pseudo = 'LOLA';
  ROLLBACK;
END;

SELECT *
FROM Kocury
WHERE pseudo = 'LOLA';
ROLLBACK;

SELECT *
FROM DODATKI_EXTRA;

-- 46

DROP TABLE HISTORIA_WYKROCZEN;

CREATE TABLE HISTORIA_WYKROCZEN
(
  LOGIN            VARCHAR2(255)        NOT NULL,
  DATA_WYKROCZENIA DATE DEFAULT sysdate NOT NULL,
  PSEUDO           VARCHAR2(30)
    CONSTRAINT WYKROCZENIE_PSEUDO REFERENCES KOCURY (PSEUDO),
  OPERACJA         VARCHAR2(255)
);

CREATE OR REPLACE TRIGGER skipFunctionRestriction
  BEFORE INSERT OR UPDATE OF przydzial_myszy,funkcja
  ON Kocury
  FOR EACH ROW
DECLARE
  pseudonim    Kocury.pseudo%TYPE;
  przydzial    Kocury.przydzial_myszy%TYPE;
  funkcja_kota Kocury.funkcja%TYPE;
  operacja     VARCHAR2(255);

  PROCEDURE tygrysCheck IS
    uzytkownik VARCHAR2(255) := LOGIN_USER;

    max_m Funkcje.max_myszy%TYPE;
    min_m Funkcje.min_myszy%TYPE;
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN

    SELECT funkcja INTO funkcja_kota FROM Kocury WHERE pseudo = pseudonim;

    SELECT min_myszy,
           max_myszy
           INTO min_m, max_m
    FROM FUNKCJE
    WHERE FUNKCJE.FUNKCJA = funkcja_kota;

    IF przydzial > max_m OR przydzial < min_m
    THEN
      INSERT INTO HISTORIA_WYKROCZEN (LOGIN, PSEUDO, OPERACJA)
      VALUES (uzytkownik, pseudonim, operacja);
      COMMIT;
      :new.przydzial_myszy := :old.przydzial_myszy;
      RAISE_APPLICATION_ERROR(-20105, 'Nowy przydzial myszy nie miesci sie w przedziale dla funkcji! ' ||
                                      funkcja_kota || ' dla kota o pseudonimie: ' || pseudonim);
    END IF;
  END;

BEGIN
  IF INSERTING
  THEN
    pseudonim := :NEW.pseudo;
    przydzial := :NEW.przydzial_myszy;
    funkcja_kota := :NEW.FUNKCJA;
    operacja := 'Dodawanie nowego kota z funkcja ' || funkcja_kota;
    tygrysCheck();
  END IF;
  IF UPDATING
  THEN
    przydzial := :NEW.przydzial_myszy;
    pseudonim := :OLD.pseudo;
    operacja := 'Zmiana przydzialu myszy z ' || :OLD.PRZYDZIAL_MYSZY || ' na ' || :NEW.PRZYDZIAL_MYSZY;
    tygrysCheck();
  END IF;

  EXCEPTION
  WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error ' || SQLERRM);
END;


BEGIN
  UPDATE KOCURY SET PRZYDZIAL_MYSZY = 0 WHERE funkcja = 'MILUSIA';
  ROLLBACK;
END;

SELECT *
FROM Kocury
WHERE pseudo = 'LOLA';
ROLLBACK;

SELECT *
FROM HISTORIA_WYKROCZEN;

UPDATE KOCURY
SET PRZYDZIAL_MYSZY = 104
WHERE pseudo = 'PLACEK';


ALTER TRIGGER skipFunctionRestriction ENABLE;