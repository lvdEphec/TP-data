
/* L'objectif est de prédire les résultats de ces lignes de script avant de les exécuter,
tout en comprenant et en sachant expliquer précisément les comportements obtenus. */

-- DROP TABLE categories;
CREATE TABLE "DBA"."categories" (
	"categId" CHAR(1) NOT NULL,
	"categLib" VARCHAR(20) NULL,
	CONSTRAINT "pk__Categories" PRIMARY KEY ( "categId" ASC )
);
select * from categories

-- DROP TABLE aliments;
CREATE TABLE "DBA"."aliments" (
	"alimId" INTEGER NOT NULL DEFAULT AUTOINCREMENT,
	"alimLib" VARCHAR(25) NULL,
	"alimPrixKg" DECIMAL(4,2) NULL,
	"categId" CHAR(1) NULL,
	CONSTRAINT "pk__aliments" PRIMARY KEY ( "alimId" ASC )
);
select * from aliments;


/* NOT NULL, ON UPDATE CASCADE */
ALTER TABLE "DBA"."aliments" ADD CONSTRAINT "fk__aliments_categories" NOT NULL
FOREIGN KEY ( "categId" ASC ) REFERENCES "DBA"."categories" ( "categId" ) ON UPDATE CASCADE;
/***/

/* QUE VA-T-IL SE PASSER ? */
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('ananas',2.99,'F');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('orange',1.50,'F');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('pomme',1.79,'F');

/***********************************************/
INSERT INTO "DBA"."categories" ("categId","categLib") VALUES('E','Epices');
INSERT INTO "DBA"."categories" ("categId","categLib") VALUES('F','Fruits');
INSERT INTO "DBA"."categories" ("categId","categLib") VALUES('H','Herbes');
INSERT INTO "DBA"."categories" ("categId","categLib") VALUES('L','Légumes');
INSERT INTO "DBA"."categories" ("categId","categLib") VALUES('P','Pokemon');

INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('ananas',2.99,'F');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('orange',1.50,'F');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('pomme',1.79,'F');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('banane',2.31,'F');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('citron',3.70,'F');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('dattes',6.25,'F');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('poire',4.16,'F');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('raisin',2.49,'F');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('noix',7.80,'F');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('prune',4.52,'F');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('carotte',1.05,'L');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('oignon',0.55,'L');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('ail',1.49,'L');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('céleri',1.71,'L');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('patate',1.32,'L');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('navet',0.93,'L');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('potiron',1.14,'L');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('persil',0.21,'H');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('cibloulette',0.19,'H');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('basilic',0.22,'H');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('coriandre',0.17,'H');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('poivre',0.19,'E');
INSERT INTO "DBA"."aliments" ("alimLib","alimPrixKg","categId") VALUES('girofle',0.21,'E');
/*********************************************/
SELECT * from categories;
SELECT * from aliments;


/*********************************************/
/* QUE VA-T-IL SE PASSER ? */
DELETE from categories where categID = 'E'
//* QUE VA-T-IL SE PASSER ? */
DELETE from categories where categID = 'P'
SELECT * from aliments where categID = 'P'

/*********************************************/
/* QUE VA-T-IL SE PASSER ? */
UPDATE categories set categID = 'Z' where categID = 'F';
SELECT * from categories;
/* QUE VA-T-IL SE PASSER ? */
SELECT * from aliments;
/* QUE VA-T-IL SE PASSER ? */
UPDATE categories set categID = NULL where categID = 'Z';
/* QUE VA-T-IL SE PASSER ? */
UPDATE aliments set categID = 'Y' where categID = 'Z';


/*********************************************/
ALTER TABLE "DBA"."aliments" DROP CONSTRAINT "fk__aliments_categories";
/* NOT NULL, ON UPDATE RESTRICT */
ALTER TABLE "DBA"."aliments" ADD CONSTRAINT "fk__aliments_categories" NOT NULL
FOREIGN KEY ( "categId" ASC ) REFERENCES "DBA"."categories" ( "categId" ) ON UPDATE RESTRICT;
SELECT * from aliments;
/* QUE VA-T-IL SE PASSER ? */
UPDATE categories set categID = 'F' where categID = 'Z';
SELECT * from aliments;
/* QUE VA-T-IL SE PASSER ? */
UPDATE aliments set categID = 'Y' where categID = 'Z';
/* QUE VA-T-IL SE PASSER ? */
UPDATE aliments set categID = NULL where categID = 'Z';


/*********************************************/
ALTER TABLE "DBA"."aliments" DROP CONSTRAINT "fk__aliments_categories";
/*(NULL), ON UPDATE RESTRICT */
ALTER TABLE "DBA"."aliments" ADD CONSTRAINT "fk__aliments_categories" FOREIGN KEY ( "categId" ASC )
REFERENCES "DBA"."categories" ( "categId" ) ON UPDATE RESTRICT;
/***/
SELECT * from aliments;
/* QUE VA-T-IL SE PASSER ? */
UPDATE aliments set categID = 'Y' where categID = 'Z';
/* QUE VA-T-IL SE PASSER ? */
UPDATE aliments set categID = NULL where categID = 'Z';
UPDATE aliments set categID = 'Z' where categID IS NULL;
/* QUE VA-T-IL SE PASSER ? */
DELETE from categories;


/***  ajouter contrainte incorrecte? existence?  *************************/
ALTER TABLE "DBA"."aliments" DROP CONSTRAINT "fk__aliments_categories";
ALTER TABLE "DBA"."aliments" ADD CONSTRAINT "incorrect" NOT NULL FOREIGN KEY ( "categId" ASC )
REFERENCES "DBA"."categories" ( "categLib" ) ON UPDATE RESTRICT;

/*********************************************/
ALTER TABLE "DBA"."aliments" DROP CONSTRAINT "fk__aliments_categories";
/* NOT NULL ON UPDATE CASCADE ON DELETE CASCADE */
ALTER TABLE "DBA"."aliments" ADD CONSTRAINT "fk__aliments_categories" NOT NULL FOREIGN KEY ( "categId" ASC )
REFERENCES "DBA"."categories" ( "categId" ) ON UPDATE CASCADE ON DELETE CASCADE;
/***/
SELECT * from aliments;
/* QUE VA-T-IL SE PASSER ? */
DELETE FROM categories where categID = 'E';
SELECT * from aliments;
SELECT * from categories;
/* QUE VA-T-IL SE PASSER ? */
DELETE from categories;
SELECT * from aliments;
/* QUE VA-T-IL SE PASSER ? */
ALTER TABLE "DBA"."aliments" ADD CONSTRAINT "incorrect" NOT NULL
FOREIGN KEY ( "categId" ASC ) REFERENCES "DBA"."categories" ( "categLib" ) ON UPDATE RESTRICT;


/************* ET MAINTENANT??? **************************/

INSERT INTO "DBA"."categories" ("categId","categLib") VALUES('E','Epices');
INSERT INTO "DBA"."categories" ("categId","categLib") VALUES('H','Herbes');

INSERT INTO "DBA"."aliments" ("alimId","alimLib","alimPrixKg","categId") VALUES(18,'persil',0.21,'H');
INSERT INTO "DBA"."aliments" ("alimId","alimLib","alimPrixKg","categId") VALUES(19,'cibloulette',0.19,'H');
INSERT INTO "DBA"."aliments" ("alimId","alimLib","alimPrixKg","categId") VALUES(20,'basilic',0.22,'H');
INSERT INTO "DBA"."aliments" ("alimId","alimLib","alimPrixKg","categId") VALUES(21,'coriandre',0.17,'H');
INSERT INTO "DBA"."aliments" ("alimId","alimLib","alimPrixKg","categId") VALUES(22,'poivre',0.19,'E');
INSERT INTO "DBA"."aliments" ("alimId","alimLib","alimPrixKg","categId") VALUES(23,'girofle',0.21,'E');

ALTER TABLE "DBA"."aliments" DROP CONSTRAINT "fk__aliments_categories";
ALTER TABLE "DBA"."aliments" ADD CONSTRAINT "fk__aliments_categories" NOT NULL FOREIGN KEY ( "categId" ASC )
REFERENCES "DBA"."categories" ( "categId" ) ON UPDATE RESTRICT ON DELETE CASCADE; /* particulier! */

SELECT * from categories;
SELECT * from aliments;

/* QUE VA-T-IL SE PASSER ? */
update aliments set categId = 'E' where categId = 'H';
SELECT * from aliments;
SELECT * from categories;

/* QUE VA-T-IL SE PASSER ? */
INSERT INTO "DBA"."categories" ("categId","categLib") VALUES('T','Test');
SELECT * from aliments;
SELECT * from categories;

/* QUE VA-T-IL SE PASSER ? */
delete from categories where categId = 'E'
SELECT * from aliments;
SELECT * from categories;


/********************************************/
















/***  Pour le fun *************************/
/*  Foreign key doit toujours faire référence à primary key ou unique */
/*  PK et unique ne peuvent pas être null */
/* donc il est impossible qu'une FK pointe vers null */
/*  Supprimer une table peut supprimer les contraintes qui y font référence */
DROP TABLE categories;


CREATE TABLE "DBA"."categories" (
	"categId" CHAR(1) NOT NULL,
	"categLib" VARCHAR(20) NULL,
    	"testId" CHAR(1) NOT NULL,
	CONSTRAINT "pk__categories" PRIMARY KEY ( "categId" ASC )
);

SELECT * from aliments;
SELECT * from categories;

INSERT INTO "DBA"."categories" ("categId","categLib","testId") VALUES('E','Epices','E');
INSERT INTO "DBA"."categories" ("categId","categLib","testId") VALUES('F','Fruits','F');
INSERT INTO "DBA"."categories" ("categId","categLib","testId") VALUES('H','Herbes','H');
INSERT INTO "DBA"."categories" ("categId","categLib","testId") VALUES('L','Légumes','L');

ALTER TABLE "DBA"."categories" ADD UNIQUE (testId);




