ALTER TABLE ONLY kwiaciarnia.zapotrzebowanie DROP CONSTRAINT zapotrzebowanie_idkompozycji_fkey;
ALTER TABLE ONLY kwiaciarnia.zamowienia DROP CONSTRAINT zamowienia_idodbiorcy_fkey;
ALTER TABLE ONLY kwiaciarnia.zamowienia DROP CONSTRAINT zamowienia_idkompozycji_fkey;
ALTER TABLE ONLY kwiaciarnia.zamowienia DROP CONSTRAINT zamowienia_idklienta_fkey;
ALTER TABLE ONLY kwiaciarnia.zapotrzebowanie DROP CONSTRAINT zapotrzebowanie_pkey;
ALTER TABLE ONLY kwiaciarnia.zamowienia DROP CONSTRAINT zamowienia_pkey;
ALTER TABLE ONLY kwiaciarnia.odbiorcy DROP CONSTRAINT odbiorcy_pkey;
ALTER TABLE ONLY kwiaciarnia.kompozycje DROP CONSTRAINT kompozycje_pkey;
ALTER TABLE ONLY kwiaciarnia.klienci DROP CONSTRAINT klienci_pkey;
ALTER TABLE ONLY kwiaciarnia.historia DROP CONSTRAINT historia_pkey;
ALTER TABLE kwiaciarnia.odbiorcy ALTER COLUMN idodbiorcy DROP DEFAULT;

DROP TABLE kwiaciarnia.zapotrzebowanie CASCADE;
DROP TABLE kwiaciarnia.zamowienia CASCADE;
DROP SEQUENCE kwiaciarnia.odbiorcy_idodbiorcy_seq CASCADE;
DROP TABLE kwiaciarnia.odbiorcy CASCADE;
DROP TABLE kwiaciarnia.kompozycje CASCADE;
DROP TABLE kwiaciarnia.klienci CASCADE;
DROP TABLE kwiaciarnia.historia CASCADE;
DROP SCHEMA kwiaciarnia CASCADE;

CREATE SCHEMA kwiaciarnia;
begin;


CREATE TABLE kwiaciarnia.klienci (
  idklienta   integer primary key,
  haslo       varchar(10) not null,
  nazwa       varchar(40) not null,
  miasto      varchar(45) not null,
  kod         char(6) not null,
  adres       varchar(40) not null,
  email       varchar(40) not null,
  telefon     varchar(16) not null,
  fax         varchar(16) not null,
  nip         char(13) not null,
  regon       char(9) not null,
  CONSTRAINT haslo_min CHECK ((length((haslo)::test) >= 4))
);

CREATE TABLE kwiaciarnia.kompozycja (
  idkompozycji   char(5)  primary key,
  nazwa          varchar(40) not null,
  opis           varchar(100) not null,
  cena           numeric(10,2) not null,
  minimum        integer not null,
  stan           integer,
  CONSTRAINT cin_min CHECK ((cena >= 40.00))
);

CREATE TABLE kwiaciarnia.odbiorcy (
  idodbiorcy     serial  primary key,
  nazwa          varchar(40) not null,
  miasto         varchar(40) not null,
  kod            char(6),
  adres       varchar(40) not null,
);

CREATE TABLE kwiaciarnia.zamowienia (
  idzamowienia   integer primary key,
  idklienta      varchar(10) not null references klienci(idklienta),
  idodbiorcy     integer not null references odbiorcy(idodbiorcy),
  idkompozycji   char(5) not null references kompozycja(idkompozycji),
  termin         date not null
  cena           numeric(10,2) not null,
  zaplacone      boolean,
  uwagi          varchar(200),
);

CREATE TABLE kwiaciarnia.historia (
  idzamowienia   integer primary key,
  idklienta      varchar(10) not null references klienci(idklienta),
  idkompozycji   char(5) not null references kompozycja(idkompozycji),
  termin         date not null
  cena           numeric(10,2) not null,
);

CREATE TABLE kwiaciarnia.zapotrzebowanie (
  idkompozycji   char(5) not null references kompozycja(idkompozycji),
  data         date not null
);
