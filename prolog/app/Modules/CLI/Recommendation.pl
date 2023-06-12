:- module(_,[printRecommendation/1]).
:- use_module('../RecommendationModule.pl').
:- use_module('../UtilModule.pl').
:- use_module('../BookModule.pl').
:- use_module('MainMenu.pl').

printRecommendation(User):-
    clearScreen,
    centeredText("Recomendacoes",63),
    nl,
    recommendation(User, Recommendation),
    printBooks(Recommendation),
    waitOnScreen,
    printUserMenu(User),!.