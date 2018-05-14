"use strict";

/* lvd august 2017 */
/* Script pour tester des requêtes en utilisant ajax et pour construire dynmiquement du code HTMLt */

/************ CONSTANTES et variables globales **************/
var filmsLiensPersonnages;

/************ Gestions du chargement initial de la page **************/

window.addEventListener('load', initialiser);

function initialiser() {
    document.getElementById("choixFilm").addEventListener('change', chargerPersonnages);

    chargerTitres();
}

/************ Chargement de la liste des choix de film **************/

function chargerTitres() {
    let xhr = new XMLHttpRequest();
    xhr.open('get', 'https://swapi.co/api/films/', true);
    xhr.onload = remplirListeFilm;
    xhr.send()
}

function remplirListeFilm() {
    let reponse = JSON.parse(this.responseText);

    let options = "";
    filmsLiensPersonnages = {};
    for (let film of reponse.results) {
        options += "<option value=\"" + film.episode_id + "\">" + film.title + "</option>\n";

        filmsLiensPersonnages[film.episode_id] = film.characters;
    }

    document.getElementById("choixFilm").innerHTML = options;
}

/************ Affichage des personnages du film sélectionné **************/

function chargerPersonnages() {
    document.getElementById("listePersonnages").innerHTML = "";

    for (let lien of filmsLiensPersonnages[this.value]) {
        let xhr = new XMLHttpRequest();
        xhr.open('get', lien, true);
        xhr.onload = ajouterPersonnage;
        xhr.send();
    }
}

function ajouterPersonnage() {
    let personnage = JSON.parse(this.responseText);
    let element = "<li>" + personnage.name + "</li>";
    document.getElementById("listePersonnages").innerHTML += element;
}





