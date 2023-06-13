:- module(_,[printRecommendation/1]).
:- use_module('../RecommendationModule.pl').
:- use_module('../UtilModule.pl').
:- use_module('../BookModule.pl').
:- use_module('MainMenu.pl').

printRecommendation(User):-
    clearScreen,
    centeredText("Recomendacoes",63),
    writeln("\nAguarde alguns segundos..."),
    nl,
    recommendation(User, Recommendation),
    clearScreen,
    centeredText("Recomendacoes",63),
    nl,
    printBooks(Recommendation),
    waitOnScreen,
    printUserMenu(User),!.