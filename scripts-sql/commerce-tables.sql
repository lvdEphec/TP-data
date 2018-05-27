-------------------------------------------------
-- script de création de la base de données
-- janvier 2016 - ChL
--------------------------------------------------

-------------------------------------------------
--   Create user types
-------------------------------------------------
CREATE DOMAIN DNbPositif int check(@col > 0);
CREATE DOMAIN Dsexe char(1) NOT NULL DEFAULT 'F' check(@col in( 'M','F' ) );
CREATE DOMAIN DCateg char(1) check(@col between 'A' and 'E');
CREATE DOMAIN DMois tinyint check(@col between 1 and 12);
CREATE DOMAIN DPrix decimal(6,2) check(@col > 0.0);

-------------------------------------------------
--   Create tables
-------------------------------------------------
CREATE TABLE tbVilles (
  vilId     int NOT NULL,
  vilLib    char(50) NOT NULL,
  CONSTRAINT pkVill PRIMARY KEY (vilId) 
);

CREATE TABLE tbVendeurs (
  vendId        char(3) NOT NULL,
  vendNom       char(50) NOT NULL,
  vendPrenom    char(30) NULL,
  vendSexe      Dsexe,
  vilId         int NOT NULL,
  vendDateNaiss  date NULL,
  CONSTRAINT pkVend PRIMARY KEY (vendId),
  CONSTRAINT fkVendVil FOREIGN KEY (vilId) REFERENCES tbVilles (vilId)
);

CREATE TABLE tbObjectifs (
  vendId        char(3) NOT NULL,
  moisId        DMois, 
  objChiffre    DNbPositif,
  CONSTRAINT pkObj PRIMARY KEY (vendId,moisId), 
  CONSTRAINT fkObjVend FOREIGN KEY (vendId) REFERENCES tbVendeurs (vendId)
);

CREATE TABLE tbCategories (
  categId       DCateg, 
  categLib      char(30) NOT NULL,
  categTaxe     numeric(2,2) NULL,
  CONSTRAINT pkCateg PRIMARY KEY (categId) 
);

CREATE TABLE tbProduits (
  prodId        char(3) NOT NULL,
  prodLib       char(50) NOT NULL,
  prodPrix      DPrix, 
  categId       char(1) NULL,
  CONSTRAINT pkProd PRIMARY KEY (prodId), 
  CONSTRAINT fkProdCat FOREIGN KEY (categId) REFERENCES tbCategories (categId)
);

CREATE TABLE tbCommandes (
  commId     int NOT NULL,
  vendId     char(3) NULL,
  moisId     DMois, 
  CONSTRAINT pkComm PRIMARY KEY (commId), 
  CONSTRAINT fkCommProd FOREIGN KEY (vendId) REFERENCES tbVendeurs (vendId)
);

CREATE TABLE tbVentes (
  commId       int NOT NULL,
  ligneNo      smallint NOT NULL CONSTRAINT chkLign check(@col > 0),
  prodId       char(3) NOT NULL,
  prodQuant    DNbPositif,
  CONSTRAINT pkVent PRIMARY KEY (commId, ligneNo),
  CONSTRAINT fkVentComm FOREIGN KEY (commId) REFERENCES tbCommandes (commId),
  CONSTRAINT fkVentProd FOREIGN KEY (prodId) REFERENCES tbProduits (prodId)
);

------------------------------------------------------------------------------
