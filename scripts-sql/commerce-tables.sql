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
  CONSTRAINT pk__tbVilles PRIMARY KEY (vilId) 
);

CREATE TABLE tbVendeurs (
  vendId        char(3) NOT NULL,
  vendNom       char(50) NOT NULL,
  vendPrenom    char(30) NULL,
  vendSexe      Dsexe,
  vilId         int NOT NULL,
  vendDateNaiss  date NULL,
  CONSTRAINT pk__tbVendeurs PRIMARY KEY (vendId),
  CONSTRAINT fk__tbVendeurs__tbVilles FOREIGN KEY (vilId) REFERENCES tbVilles (vilId)
);

CREATE TABLE tbObjectifs (
  vendId        char(3) NOT NULL,
  moisId        DMois, 
  objChiffre    DNbPositif,
  CONSTRAINT pk__tbObjectifs PRIMARY KEY (vendId,moisId), 
  CONSTRAINT fk__tbObjectifs__tbVendeurs FOREIGN KEY (vendId) REFERENCES tbVendeurs (vendId)
);

CREATE TABLE tbCategories (
  categId       DCateg, 
  categLib      char(30) NOT NULL,
  categTaxe     numeric(2,2) NULL,
  CONSTRAINT pk__tbCategories PRIMARY KEY (categId) 
);

CREATE TABLE tbProduits (
  prodId        char(3) NOT NULL,
  prodLib       char(50) NOT NULL,
  prodPrix      DPrix, 
  categId       char(1) NULL,
  CONSTRAINT pk__tbProduits PRIMARY KEY (prodId), 
  CONSTRAINT fk__tbProduits__tbCategories FOREIGN KEY (categId) REFERENCES tbCategories (categId)
);

CREATE TABLE tbCommandes (
  commId     int NOT NULL,
  vendId     char(3) NULL,
  moisId     DMois, 
  CONSTRAINT pk__tbCommandes PRIMARY KEY (commId), 
  CONSTRAINT fk__tbCommandes__tbProduits FOREIGN KEY (vendId) REFERENCES tbVendeurs (vendId)
);

CREATE TABLE tbVentes (
  commId       int NOT NULL,
  ligneNo      smallint NOT NULL CONSTRAINT chkLign check(@col > 0),
  prodId       char(3) NOT NULL,
  prodQuant    DNbPositif,
  CONSTRAINT pk__tbVentes PRIMARY KEY (commId, ligneNo),
  CONSTRAINT fk__tbVentes__tbCommandes FOREIGN KEY (commId) REFERENCES tbCommandes (commId),
  CONSTRAINT fk__tbVenttes_tbProduits FOREIGN KEY (prodId) REFERENCES tbProduits (prodId)
);

------------------------------------------------------------------------------
