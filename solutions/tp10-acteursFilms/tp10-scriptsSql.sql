

/* ********** CREATION FONCTION ET PROCEDURES ********** */
/* ***************************************************** */
/* alter à adapter */


ALTER PROCEDURE "DBA"."sp_getActeurs"()
result( id char(4),identite char(61) )
begin
-- 
  select actId,actPrenom || ' ' || actNom
  from tbActeurs
  order by actNom asc
-- 
end;

/* ***************************************************** */

ALTER PROCEDURE "DBA"."sp_getFilmsAct"(in id char(4) ) 
result( html long varchar )
begin
-- 
  call sa_set_http_header('Content-Type','text/html; charset=utf-8'); // header http
  select list('<li onclick="getAutres('''
     || F.filmId || ''');" >' || filmTitre || '</li>','' order by filmTitre asc)
  from tbFilms as F
  join tbRoles as R on F.filmId = R.filmId
  where actId = id
-- 
end;

/* ***************************************************** */

ALTER PROCEDURE "DBA"."sp_getActsFilm"(in film char(4),in act char(4) ) 
result( html long varchar )
begin
-- 
  call sa_set_http_header('Content-Type','text/html; charset=utf-8'); // header http
  select list('<li onclick="suite(''' || A.actId || ''');" >'
     || actPrenom || ' ' || actNom || '</li>','' order by actNom asc)
  from tbActeurs as A
  join tbRoles as R on A.actId = R.actId
  where filmId = film
  and not(A.actId = act)
-- 
end;


/* ********** CREATION WEBSERVICES ********************** */
/* ****************************************************** */

CREATE SERVICE "getActeurs" TYPE 'JSON' AUTHORIZATION OFF USER "DBA" URL ON METHODS 'GET' AS call sp_getActeurs();

CREATE SERVICE "getFilmsAct" TYPE 'RAW' AUTHORIZATION OFF USER "DBA" URL ON METHODS 'GET' AS call sp_getFilmsAct(:act);

CREATE SERVICE "getActsFilm" TYPE 'RAW' AUTHORIZATION OFF USER "DBA" URL ON METHODS 'GET' AS call sp_getActsFilm(:film,:act);



