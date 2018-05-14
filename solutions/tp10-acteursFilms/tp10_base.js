"use strict";

// variable globale pour utilisé l'acteur sélectionné dans différentes fonctions: pas beau, mais simple 
let acteurSelectionne;

function initPage() {
	let xhr = new XMLHttpRequest();
	xhr.open('get', 'getActeurs', true);
    xhr.onload = function() {
		creerTable(JSON.parse(this.responseText), 'acteurs');
	};
	xhr.send();
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
	document.getElementById(idBodyTable).innerHTML = lignes;
}

function getFilms(acteur) {
	document.getElementById('autres').innerHTML = '';
	document.getElementById('asi').style.display = 'none';
	
	acteurSelectionne = acteur; // variable globale utilisée, pas de var ou let ici !
	
	let xhr = new XMLHttpRequest();
	xhr.open('get', 'getFilmsAct?act=' + acteur, true); // attention à la construction d'url
    xhr.onload = function () {
			document.getElementById('films').innerHTML = xhr.response;	
			document.getElementById('art').style.display = 'block';
	}
	xhr.send();
	// attention, ne pas mettre l'afichage ici!
}

function getAutres(film) {	
	let xhr = new XMLHttpRequest();
	// attention : préparer webservice et procédure avec 2 paramètres, le film et l'acteur qu'on ne veut pas afficher
	xhr.open('get', 'getActsFilm?film=' + film + '&act=' + acteurSelectionne, true); 
    xhr.onload = function () {
			document.getElementById('autres').innerHTML = xhr.response;	
			document.getElementById('asi').style.display = 'block';
	}
	xhr.send();
}

function suite(film) {
	getFilms(film);
}
