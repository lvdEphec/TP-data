"use strict";

/* ************ variables ***************** */

let acteurSelectionne;
let filmSelectionne;

/* ************ fonctions utilitaires ***************** */

let gid = document.getElementById.bind(document);
let qs = document.querySelector.bind(document);

function lancerRequeteAjaxGet(url, callback) {
	let xhr = new XMLHttpRequest();
	xhr.open('get', url, true);
        xhr.onload = callback;
	xhr.send();
}

/* ************ fonctions principales de la page ***************** */

function initPage() {
	getActeurs();
}

/* ***** acteurs ***** */

function getActeurs() {	
	lancerRequeteAjaxGet('getActeurs', afficherActeurs);	
}

function afficherActeurs(){	
	gid('acteurs').innerHTML = creerTable(JSON.parse(this.responseText), 'acteurs');
	//au cas où la fonction serait appelée en dehors de l'init
	cacherFilms();
	cacherAutresActeurs();
	retirerSelection(acteurSelectionne);
}

function creerTable(reponseRequete, idBodyTable ) {
	let lignes = '';
	for (let e of reponseRequete) {
		lignes += '<tr>' +
			'<td onclick="getFilms(\'' + e.id + '\');">'
			+ e.identite +
			'</td>' + 
			'</tr>' + '\n';
	}
	return lignes;	
}

/* ***** films ***** */

function getFilms(acteur) {
	retirerSelection(acteurSelectionne);
	acteurSelectionne = acteur;
	ajouterSelection(acteurSelectionne);	
	
	lancerRequeteAjaxGet('getFilmsAct?act=' + acteur, afficherFilms);
}

function afficherFilms() {
	cacherAutresActeurs();
	gid('films').innerHTML = this.response;	
	gid('art').style.display = 'block';
}

function cacherFilms() {
	gid('films').innerHTML = '';	
	gid('art').style.display = 'none';
}

/* ***** autres acteurs ***** */

function getAutres(film) {	
	retirerSelection(filmSelectionne);
	filmSelectionne = film;
	ajouterSelection(filmSelectionne);
	
	lancerRequeteAjaxGet('getActsFilm?film=' + film + '&act=' + acteurSelectionne, afficherAutresActeurs);
}

function afficherAutresActeurs() {
	gid('autres').innerHTML = this.response;	
	gid('asi').style.display = 'block';
}

function cacherAutresActeurs() {
	gid('autres').innerHTML = "";	
	gid('asi').style.display = 'none';
	
}

function suite(film) {
	getFilms(film);
}

/* ************ fonctions mises en forme ***************/

// on se base sur le fait que les onclick contiennent les id. pas idéal.
// Les fonctions liées aux "onclick" auraient pu envoyer leur référence "this" en paramètre, pour les stocker et les utiliser
// ou on pourrait ajouter les id des acteurs et films en id des éléments html. 

function ajouterSelection(code) {
	// si il existe (pas à undefined par exemple)
	if (code) {
		let elementHtml = qs("[onclick*=\'" + code + "\']");
		// si l'élément correspondant à ce code existe
		if (elementHtml) {
			elementHtml.classList.add("selected");
		}
	}
}

function retirerSelection(code) {
	if (code) {
		let elementHtml = qs("[onclick*=\'" + code + "\']");
		if (elementHtml) {
			elementHtml.classList.remove("selected");
		}
	}
}
