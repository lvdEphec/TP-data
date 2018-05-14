// examen juin 2015
// ----------------
// VOTRE CLASSE / NOM / PRENOM ICI
// -------------------------------

var acteurSelectionne = undefined;

function initPage() {
  xhrReqJson('getActeurs', makeTbActeurs, 'acteurs');
}

function getFilms(act) {
  xhrReqHtml('getFilmsAct?act=' +  act, 'films', showFilms);
  acteurSelectionne = act;  
}

function getAutres(film) {
  xhrReqHtml('getActsFilm?film=' + film + '&act=' + acteurSelectionne, 'autres', showAutres);    
}

function suite(act) {
  getFilms(act);
}

function makeTbActeurs(reponse, id) {
  lignes = '';
  for (i in reponse) {
    lignes += '<tr>' + '<td onclick="getFilms(\'' + reponse[i].id + '\')";>' + reponse[i].identite + '</td>' + '</tr>';
  }  
  setElem(id, lignes);
}

function showFilms() {
  getEl('art').style.display = "block";
}

function showAutres() {
  getEl('asi').style.display = "block";
}


