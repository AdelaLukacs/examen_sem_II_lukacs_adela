CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE IF NOT EXISTS oras
(
    id_oras SERIAL PRIMARY KEY,
    nume VARCHAR(50),
    judet VARCHAR(50),
    cod_siruta VARCHAR(10),
    populatie INTEGER,
    municipiu BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS primarie
(
    id_primarie SERIAL PRIMARY KEY,
    denumire VARCHAR(50),
    adresa VARCHAR(50),
    telefon VARCHAR(20),
    email VARCHAR(50),
	id_oras INTEGER UNIQUE REFERENCES oras(id_oras)
);

CREATE TABLE IF NOT EXISTS apa_line
(
    fid_apa_line SERIAL PRIMARY KEY,
    geom geometry(LineString, 4326),
	nume VARCHAR (50),
	lungime DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS statii_transport_apa
(
    fid_statii_transport_apa SERIAL PRIMARY KEY,
    geom geometry(Point, 4326),
	nume VARCHAR (50),
	id_apa_line INTEGER REFERENCES apa_line(fid_apa_line)
);

CREATE TABLE IF NOT EXISTS apa_poly (
    fid_apa_poly SERIAL PRIMARY KEY,
    geom geometry(Polygon, 4326),
	nume VARCHAR (50)
);

CREATE TABLE IF NOT EXISTS apa_point (
    fid_apa_point SERIAL PRIMARY KEY,
    geom geometry(Point, 4326),
	nume VARCHAR (50)
);

CREATE TABLE IF NOT EXISTS apa
(
    id_apa SERIAL PRIMARY KEY,
    id_oras INTEGER REFERENCES oras(id_oras),
    id_apa_poly INTEGER REFERENCES apa_poly(fid_apa_poly),
    id_apa_point INTEGER REFERENCES apa_point(fid_apa_point),
    id_apa_line INTEGER REFERENCES apa_line(fid_apa_line)
);

CREATE TABLE IF NOT EXISTS piste_biciclete
(
    fid_pista_biciclete SERIAL PRIMARY KEY,
    geom geometry(LineString, 4326),
	id_oras INTEGER REFERENCES oras(id_oras)
);

CREATE TABLE IF NOT EXISTS tip_spatii_verzi
(
    id_tip_spatii_verzi SERIAL PRIMARY KEY,
    denumire_tip VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS spatii_verzi
(
    fid_spatii_verzi SERIAL PRIMARY KEY,
	geom geometry(Polygon, 4326),
	denumire VARCHAR (100),
	suprafata DOUBLE PRECISION,
    id_oras INTEGER REFERENCES oras(id_oras),
    id_tip_spatii_verzi INTEGER REFERENCES tip_spatii_verzi(id_tip_spatii_verzi)
);

CREATE TABLE IF NOT EXISTS alei
(
    fid_alei SERIAL PRIMARY KEY,
	geom geometry(LineString, 4326),
	lungime DOUBLE PRECISION,
    id_spatii_verzi INTEGER REFERENCES spatii_verzi(fid_spatii_verzi)
);

CREATE TABLE IF NOT EXISTS tip_arbori
(
    id_tip_arbori SERIAL PRIMARY KEY,
    denumire_specie VARCHAR(50),
	denumire_stiintifica VARCHAR (50)
);

CREATE TABLE IF NOT EXISTS arbori
(
    fid_arbori SERIAL PRIMARY KEY,
	geom geometry(Point, 4326),
	inaltime DOUBLE PRECISION,
    id_spatii_verzi INTEGER REFERENCES spatii_verzi(fid_spatii_verzi),
    id_tip_arbori INTEGER REFERENCES tip_arbori(id_tip_arbori)
);

CREATE TABLE IF NOT EXISTS tip_mobilier_urban
(
    id_tip_mobilier_urban SERIAL PRIMARY KEY,
    denumire_tip VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS mobilier_urban
(
    fid_mobilier_urban SERIAL PRIMARY KEY,
	geom geometry(Point, 4326),
	stare VARCHAR (50),
    id_spatii_verzi INTEGER REFERENCES spatii_verzi(fid_spatii_verzi),
    id_tip_mobilier_urban INTEGER REFERENCES tip_mobilier_urban(id_tip_mobilier_urban)
);

CREATE TABLE IF NOT EXISTS locuri_de_joaca
(
    fid_loc_joaca SERIAL PRIMARY KEY,
	geom geometry(Polygon, 4326),
	varsta_recomandata VARCHAR (50),
    id_spatii_verzi INTEGER REFERENCES spatii_verzi(fid_spatii_verzi)
);

CREATE TABLE IF NOT EXISTS tip_activitate_recreativa
(
    id_tip_activitate_recreativa SERIAL PRIMARY KEY,
    denumire_tip VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS zone_recreative
(
    fid_zone_recreative SERIAL PRIMARY KEY,
	geom geometry(Polygon, 4326),
    id_spatii_verzi INTEGER REFERENCES spatii_verzi(fid_spatii_verzi)
);

CREATE TABLE IF NOT EXISTS zone_recreative_tip_activitate
(
    id_zone_recreative INTEGER REFERENCES zone_recreative(fid_zone_recreative),
    id_tip_activitate_recreativa INTEGER REFERENCES tip_activitate_recreativa(id_tip_activitate_recreativa),
    PRIMARY KEY (id_zone_recreative, id_tip_activitate_recreativa)
);