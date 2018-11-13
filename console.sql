ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';

CREATE TABLE Bandy (
  nr_bandy   NUMBER(2) CONSTRAINT nr_bandy_primiary_key PRIMARY KEY,
  nazwa      VARCHAR2(20) CONSTRAINT nazwa_not_null NOT NULL,
  teren      VARCHAR2(15) CONSTRAINT teren_unique UNIQUE,
  szef_bandy VARCHAR2(15) CONSTRAINT szef_bandy_unique UNIQUE
);

CREATE TABLE Funkcje (
  funkcja   VARCHAR2(10) CONSTRAINT funkcja_primary_key PRIMARY KEY,
  min_myszy NUMBER(3) CONSTRAINT min_myszy_check CHECK (min_myszy > 5),
  max_myszy NUMBER(3) CONSTRAINT max_myszy_check CHECK (200 > max_myszy),
  CONSTRAINT max_myszy_min_myszy CHECK (max_myszy > min_myszy)
);

CREATE TABLE Wrogowie (
  imie_wroga       VARCHAR2(15) CONSTRAINT mie_wroga_primiary_key PRIMARY KEY,
  stopien_wrogosci NUMBER(2) CONSTRAINT stopien_wrogosci_check CHECK (stopien_wrogosci BETWEEN 1 AND 10),
  gatunek          VARCHAR2(15),
  lapowka          VARCHAR2(20)
);

CREATE TABLE Kocury (
  imie            VARCHAR2(15) CONSTRAINT imie_not_null NOT NULL,
  plec            VARCHAR2(1) CONSTRAINT plec_check CHECK (plec IN ('M', 'D')),
  pseudo          VARCHAR2(15) CONSTRAINT pseudo_primary_key PRIMARY KEY,
  funkcja         VARCHAR2(10) CONSTRAINT funkcja_references REFERENCES Funkcje (funkcja),
  szef            VARCHAR2(15) CONSTRAINT szef_references REFERENCES Kocury (pseudo),
  w_stadku_od     DATE DEFAULT SYSDATE,
  przydzial_myszy NUMBER(3),
  myszy_extra     NUMBER(3),
  nr_bandy        NUMBER(2) CONSTRAINT nr_bandy_references REFERENCES Bandy (nr_bandy)
);

CREATE TABLE Wrogowie_Kocurow (
  pseudo         VARCHAR2(15) CONSTRAINT pseudo_references_kocury REFERENCES Kocury (pseudo),
  imie_wroga     VARCHAR2(15) CONSTRAINT imie_wroga_references_wrogowie REFERENCES Wrogowie (imie_wroga),
  data_incydentu DATE CONSTRAINT data_incydentu_not_null NOT NULL,
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
VALUES ('CHYTRY',
        'M',
        'BOLEK',
        'DZIELCZY',
        'TYGRYS',
        '2002-05-05',
        50,
        NULL,
        1);
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
VALUES ('PLACEK',
        'BAZYLI',
        '2010-07-12',
        'DZIOBIAC UNIEMOZLIWIL PODEBRANIE KURCZAKA');
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
SELECT imie,
       NVL(przydzial_myszy, 0) * 3 AS "MYSZY KWARTALNE",
       NVL(myszy_extra, 0) * 3     AS "KWARTALNE DODATKI"
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
WHERE plec != 'M'AND funkcja != 'SZEFUNIO'
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
SELECT pseudo          AS "POLUJE W POLU",
       przydzial_myszy AS "PRZYDZIAL MYSZY",
       nazwa           AS "BANDA"
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
SELECT K.imie    AS Imie,
       K.funkcja AS Funkcja,
       S1.imie   AS "Szef 1",
       S2.imie   AS "Szef 2",
       S3.imie   AS "Szef 3"
FROM Kocury K
       LEFT JOIN Kocury S1 ON K.szef = S1.pseudo
       LEFT JOIN Kocury S2 ON S1.szef = S2.pseudo
       LEFT JOIN Kocury S3 ON S2.szef = S3.pseudo
WHERE K.funkcja IN ('KOT', 'MILUSIA');

-- b
-- SELECT *
-- FROM (
SELECT K.imie AS Imie, K.funkcja AS Funkcja, CONNECT_BY_ROOT S1.imie AS Szef
FROM Kocury K,
     Kocury S1
CONNECT BY K.szef = S1.pseudo;

--      )


-- c


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
SELECT B.nazwa                       AS "Nazwa bandy",
       COUNT(DISTINCT Kocury.pseudo) AS "Koty z wrogami"
FROM Kocury
       JOIN Wrogowie_Kocurow ON Kocury.pseudo = Wrogowie_Kocurow.pseudo
       JOIN Bandy B ON Kocury.nr_bandy = B.nr_bandy
GROUP BY B.nazwa;

-- Zad22
SELECT Kocury.funkcja   AS "Funkcja",
       Kocury.pseudo    AS "Pseudonim kota",
       COUNT(WK.pseudo) AS "Liczba wrogow"
FROM Kocury
       JOIN Wrogowie_Kocurow WK ON Kocury.pseudo = WK.pseudo
HAVING COUNT(WK.pseudo) > 1
GROUP BY Kocury.pseudo, Kocury.funkcja;

-- Zad23
SELECT imie,
       ((NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) * 12) AS "DAWKA ROCZNA",
       'powyżej 864'
FROM Kocury
WHERE ((NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) * 12) > 864
  AND NVL(myszy_extra, 0) > 0
UNION
SELECT imie,
       ((NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) * 12) AS "DAWKA ROCZNA",
       '864'
FROM Kocury
WHERE ((NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) * 12) = 864
  AND NVL(myszy_extra, 0) > 0
UNION
SELECT imie,
       ((NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) * 12) AS "DAWKA ROCZNA",
       'poniżej 864'
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
                                         JOIN Bandy B
                                           on KM.nr_bandy = B.nr_bandy
                                  WHERE KM.funkcja = 'MILUSIA'
                                    AND B.teren IN ('SAD', 'CALOSC')
                                    AND ROWNUM <= 1
                                  ORDER BY przydzial_myszy DESC))
ORDER BY imie;

-- Zad26
-- WITH, DEFINE
SELECT K.funkcja AS "Funkcja",
       ROUND(AVG(NVL(K.przydzial_myszy, 0) + NVL(K.myszy_extra, 0)), 0)
FROM Kocury K
HAVING ROUND(AVG(NVL(K.przydzial_myszy, 0) + NVL(K.myszy_extra, 0)), 0) IN
       ((SELECT Przydzial
         FROM (SELECT K.funkcja, ROUND(
                                   AVG(NVL(K.przydzial_myszy, 0) +
                                       NVL(K.myszy_extra, 0)),
                                   0) AS Przydzial
               FROM Kocury K
               HAVING K.funkcja <> 'SZEFUNIO'
               GROUP BY K.funkcja
               ORDER BY Przydzial DESC)
         WHERE ROWNUM <= 1), (SELECT Przydzial
                              FROM (SELECT K.funkcja, ROUND(
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
WHERE 6 > (SELECT COUNT(*)
           FROM Kocury K2
           WHERE (NVL(K.przydzial_myszy, 0) +
                  NVL(K.myszy_extra, 0)) <
                 (NVL(K2.przydzial_myszy, 0) +
                  NVL(K2.myszy_extra, 0)))
ORDER BY ZJADA DESC;

-- wykorzystując pseudokolumnę ROWNUM
SELECT *
FROM (SELECT pseudo, (NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) AS "ZJADA"
      FROM Kocury
      WHERE (NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) IN
            (SELECT (NVL(K.przydzial_myszy, 0) + NVL(K.myszy_extra, 0))
             FROM Kocury K)
      ORDER BY ZJADA DESC)
WHERE ROWNUM < ?;

-- wykorzystując złączenie relacji Kocury z relacją Kocury
-- czemu mniejsze rowne i COUNT K2?
SELECT K.pseudo, (NVL(K.przydzial_myszy, 0) + NVL(K.myszy_extra, 0)) AS "ZJADA"
FROM Kocury K,
     Kocury K2
WHERE (NVL(K.przydzial_myszy, 0) +
       NVL(K.myszy_extra, 0)) <=
      (NVL(K2.przydzial_myszy, 0) +
       NVL(K2.myszy_extra, 0))
GROUP BY K.pseudo, (NVL(K.przydzial_myszy, 0) + NVL(K.myszy_extra, 0))
HAVING ? > COUNT(DISTINCT (NVL(K2.PRZYDZIAL_MYSZY, 0) + NVL(K2.MYSZY_EXTRA, 0)))
ORDER BY ZJADA DESC;

-- wykorzystując funkcje analityczne.
SELECT PSEUDO, "ZJADA"
FROM (SELECT PSEUDO,
             (NVL(PRZYDZIAL_MYSZY, 0) + NVL(MYSZY_EXTRA, 0))         AS "ZJADA",
             DENSE_RANK() OVER (ORDER BY (NVL(PRZYDZIAL_MYSZY, 0) +
                                          NVL(MYSZY_EXTRA, 0)) DESC) AS "RANK"
      FROM KOCURY)
WHERE "RANK" <= 6;

-- Zad28
SELECT TO_CHAR(EXTRACT(YEAR FROM w_stadku_od)) AS "ROK",
       COUNT(*)                                AS "LICZBA WSTAPIEN "
FROM Kocury
GROUP BY EXTRACT(YEAR FROM w_stadku_od)
HAVING COUNT(*) =
       (SELECT MAX(COUNT(*))
        FROM KOCURY
        GROUP BY EXTRACT(YEAR FROM w_stadku_od)
        HAVING COUNT(*) <=
               (SELECT AVG(COUNT(*))
                FROM KOCURY
                GROUP BY EXTRACT(YEAR FROM w_stadku_od)))
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
               (SELECT AVG(COUNT(*))
                FROM KOCURY
                GROUP BY EXTRACT(YEAR FROM w_stadku_od)));

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
       JOIN (SELECT nr_bandy                                                                AS "banda",
                    AVG(
                      (NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)))                      AS "SREDNIA BANDY"
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
SELECT imie, w_stadku_od ||
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
SELECT imie, w_stadku_od ||
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
)AS
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
SELECT pseudo AS "Pseudonim",
       plec,
       PRZYDZIAL_MYSZY "Myszy przed podw.",
       MYSZY_EXTRA     "Extra przed podw."
FROM KOCURY
WHERE PSEUDO IN (SELECT PSEUDO
                 FROM ((SELECT PSEUDO,
                               DENSE_RANK() OVER (ORDER BY W_STADKU_OD) "rank"
                        FROM KOCURY
                               JOIN BANDY USING (NR_BANDY)
                        WHERE NAZWA = 'CZARNI RYCERZE')
                       UNION
                       (SELECT PSEUDO,
                               DENSE_RANK() OVER (ORDER BY W_STADKU_OD) "rank"
                        FROM KOCURY
                               JOIN BANDY USING (NR_BANDY)
                        WHERE NAZWA = 'LACIACI MYSLIWI'))
                 WHERE "rank" <= 3)

ORDER BY NR_BANDY, W_STADKU_OD;

