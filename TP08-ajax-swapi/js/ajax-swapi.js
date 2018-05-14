/* Script pour tester des requêtes en utilisant ajax et pour construire dynmiquement du code HTMLt */

/************ CONSTANTES et variables globales **************/

const ID_LISTE_FILMS = "choixFilm";
const ID_LISTE_PERSONNAGES = "listePersonnages";

// Objet faisant le lien entre le numéro de l'épisode du film et les personnages.
// exemple : { "4" : ["https://swapi.co/api/people/1/", "https://swapi.co/api/people/2/", ...],  "1" : [...], ... } 
var filmsLiensActeurs;


/************ Fonctions utilitaires **************/
function gid(id) {
    return document.getElementById(id);
}


/************ Gestions du chargement initial de la page **************/

// Définit quelle fonction est appelée lorsque la page est chargée.
// Attention, ici on référence la fonction, on ne l'exécute pas, donc pas de parenthèses ( ).
window.addEventListener('load', initialiser);

function initialiser() {
    // Définit quelle fonction est appelée lorsque le choix de film change.
    // L'élément avec l'id "choixFilm" doit exister pour pouvoir lui ajouter un évènement,
    // cela est donc effectué après le chargement initial de la page dans la fonction "initialiser".
    gid(ID_LISTE_FILMS).addEventListener('change',chargerPersonnages);

    // Requête Ajax et remplissage des titres dans la liste de choix.
    chargerTitres();
}


/************ Chargement de la liste des choix de film **************/

// Effectue une requête AJAX pour remplir la liste des films.
// Ici la requête Ajax est minimaliste (on ne teste pas les états, les cas d'erreur, etc...)
function chargerTitres() {
    // on crée une nouvelle requête
    let xhr = new XMLHttpRequest();

    // on précise qu'il s'agit d'un GET, l'adresse et le fait qu'elle soit asynchrone
    xhr.open('get', 'https://swapi.co/api/films/', true);

    // on indique quelle fonction exécuter lorsqu'on reçoit la réponse et que tout va bien
    xhr.onload = remplirListeFilm;

    // on exécute la requête
    xhr.send()
}


function remplirListeFilm() {
    // Attention, "this" ici est... subtile.
    // Il fait référence au contexte dans lequel la fonction est appelée.
    // Quand est-ce que "remplirListeFilm" est appelé? Lors du xhr.onload, soit lorsque le xhr recoit une bonne réponse.
    // C'est le xhr qui appelle la fonction à ce moment. Le "this" dans cette fonction est donc la requête xhr.
    // Cela nous permet d'accéder au responseText du xhr (n'hésitez pas à regarder les attributs de cet objet en console).
    // Le JSON.parse permet simplement de convertir la réponse JSON en objet javascript.
    let reponse = JSON.parse(this.responseText);

    // Maintenant, comment allez vous faire pour parcourir et récupérer tous les films dans lla réponse ?
    // On désire afficher la liste des noms de films et avoir comme value l'id de l'épisode.
    // ... et si on désire trier les films sur base de l'id de l'épisode?

    console.log("TODO : Traiter la réponse pour charger les titres des films dans la liste déroulante");
    console.log(reponse);
    
    // TODO : sur base de la réponse, remplir la variable globale filmsLiensActeurs 
    // pour garder le lien entre le numéro de l'épisode et les acteurs du film
    
}


/************ Affichage des personnages du film sélectionné **************/

function chargerPersonnages() {

    console.log("TODO : charger les personnages du film sélectionner, avec requête Ajax puis construction HTML");
    console.log(this.value);
}

function ajouterPersonnage() {
    console.log("TODO : ajouter un personnage à la liste dans la page HTML");
}

function mettreListeItalique() {
    console.log("TODO : mettre tous les élément <li> de la page en italique");
}
