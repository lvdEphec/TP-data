"use strict";

/* lvd august 2017 */
/* Script pour tester des requêtes en utilisant ajax et pour construire dynmiquement du code HTMLt */

(function ajouterEvenements() {
    /************ CONSTANTES et variables globales **************/

    const ID = {};
    ID.listeFilms = "choixFilm";
    ID.listePersonnages = "listePersonnages";

    const GLOBAL = {};
    GLOBAL.filmsLiensPersonnages = {};
    GLOBAL.mesures = [];
    GLOBAL.messageErreur = "Erreur, désolé!";

    /************ Fonctions utilitaires **************/

    function gid(id) {
        return document.getElementById(id);
    }

    /************ Gestions du chargement initial de la page **************/
    
    document.addEventListener('DOMContentLoaded', initialiser);
    // window.addEventListener('load', initialiser); //ok aussi, un chouia moins performant

    function initialiser() {
        gid(ID.listeFilms).addEventListener('change', chargerPersonnages);

        chargerTitres();
    }

    /************ Chargement de la liste des choix de film **************/

    /*
     readyState :
     0	UNSENT	Client has been created. open() not called yet.
     1	OPENED	open() has been called.
     2	HEADERS_RECEIVED	send() has been called, and headers and status are available.
     3	LOADING	Downloading; responseText holds partial data.
     4	DONE	The operation is complete.
     */

    function chargerTitres() {
        let xhr = new XMLHttpRequest();

        console.log(`status: ${xhr.status}, readyState: ${xhr.readyState}`);

        //xhr.open('get', 'https://swapi.co/api/films/', true);
        xhr.open('get', 'https://badAddress/', true);

        xhr.onload = remplirListeFilm;
        xhr.onerror = prevenirErreur;
        xhr.onreadystatechange = function () {
            GLOBAL.mesures.push(performance.now());
            console.log("délai : " + (GLOBAL.mesures[GLOBAL.mesures.length - 1] - GLOBAL.mesures[GLOBAL.mesures.length - 2]) + " ms");
            console.log(`status: ${xhr.status}, readyState: ${xhr.readyState}`);
        };

        console.log(`status: ${xhr.status}, readyState: ${xhr.readyState}`);
        xhr.send();
        GLOBAL.mesures.push(performance.now());
    }

    function remplirListeFilm() {
        let reponse = JSON.parse(this.responseText);

        let options = "";
        GLOBAL.filmsLiensPersonnages = {};
        for (let film of reponse.results.sort((x, y) => x.episode_id - y.episode_id)) {
            options += `<option value="${film.episode_id}">${film.title}</option>\n`;
            GLOBAL.filmsLiensPersonnages[film.episode_id] = film.characters;
        }

        gid(ID.listeFilms).innerHTML = options;
    }

    function prevenirErreur() {
        gid(ID.listePersonnages).innerHTML = `${GLOBAL.messageErreur} status: ${this.status}, readyState: ${this.readyState}`;
    }

    /************ Affichage des personnages du film sélectionné **************/

    function chargerPersonnages() {

        gid(ID.listePersonnages).innerHTML = "";

        let ajouterPersonnageSynchrone =
            (function fabriquerFonctionPersonnage() {
                let compteur = 0;
                let personnages = [];
                let total = GLOBAL.filmsLiensPersonnages[gid(ID.listeFilms).value].length;

                return function () {
                    let personnage = JSON.parse(this.responseText);
                    personnages.push(personnage.name);
                    compteur++;
                    if (compteur >= total) {
                        let html = personnages
                            .sort((x, y) => x.localeCompare(y))
                            .map(x => `<li>${x}</li>`)
                            .join("");
                        gid(ID.listePersonnages).innerHTML = html;
                        mettreListeItalique();
                    }
                }
            })();

        for (let lien of GLOBAL.filmsLiensPersonnages[this.value]) {
            let xhr = new XMLHttpRequest();
            xhr.open('get', lien, true);
            xhr.onload = ajouterPersonnageSynchrone;
            xhr.onerror = prevenirErreur;
            xhr.send();
        }
    }

    function mettreListeItalique() {
        let lis = document.querySelectorAll("li");
        for (let i = 0; i < lis.length; i++) {
            lis[i].style.fontStyle = "italic";
        }
    }
})();


