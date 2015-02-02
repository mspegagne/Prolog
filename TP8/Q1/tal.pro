/**
TP 8 Traitement Automatique de la Langue (TAL) - Prolog
*/

article(le).
article(les).
article(la).
article(un).

nom_commun(chien).
nom_commun(enfants).
nom_commun(steack).
nom_commun(pull).
nom_commun(rue).
nom_commun(femme).

verbe(aboie).
verbe(jouent).
verbe(marche).
verbe(porte).
verbe(mange).
verbe(dort).

nom_propre(paul).

preposition(dans).

pronom(qui).

adjectif(noir).
adjectif(petit).

/*
===============================================================================
===============================================================================
 Définition des prédicats
===============================================================================
*/
/**
 * Les propositions subordonnees relatives ont ete sorties du groupe nominal pour simplifier le code.
 */
phrase_simple(List, Rest):-
	gn(List, Rest1),
	gv(Rest1, Rest).

gn(List, Rest):-
	gn_simple(List, Rest).
gn(List, Rest):-
	gn_simple(List, Rest1),
	prop_relative(Rest1, Rest).

gn_simple([Elem|List], List):-
	nom_propre(Elem).
gn_simple([First, Second|List], List):-
	article(First),
	nom_commun(Second).
gn_simple([First, Second, Third|List], List):-
	article(First),
	nom_commun(Second),
	adjectif(Third).
gn_simple([First, Second, Third|List], List):-
	article(First),
	adjectif(Second),
	nom_commun(Third).
gn_simple([First, Second, Third, Fourth|List], List):-
	article(First),
	adjectif(Second),
	nom_commun(Third),
	adjectif(Fourth).

gv([Elem|List], List):-
	verbe(Elem).
gv([First|List], Rest):-
	verbe(First),
	gn(List, Rest).
gv([First|List], Rest):-
	verbe(First),
	gn(List, Rest1),
	gp(Rest1, Rest).
gv([First|List], Rest):-
	verbe(First),
	gp(List, Rest).

gp([First|List], Rest):-
	preposition(First),
	gn(List, Rest).

prop_relative([First|List], Rest):-
	pronom(First),
	gv(List, Rest).

analyse(List):-
	phrase_simple(List, []).

/*
===============================================================================
===============================================================================
 Tests
===============================================================================
*/

% Quelques phrases de test à copier coller pour vous faire gagner du temps, mais
% n'hésitez pas à en définir d'autres

/*
analyse([le, chien, aboie]).
analyse([les, enfants, jouent]).
analyse([paul, marche, dans, la, rue]).
analyse([la, femme, qui, porte, un, pull, noir, mange, un, steack]).
analyse([les, chien, aboie]).
analyse([la, femme, qui, porte, un, pull, noir, mange, un, chien]).
analyse([la, petit, chien, noir, qui, dort, mange]).
analyse(Sentence).
*/