:- module(_,[caminhar_ate_diretorio_atual/1, verifyFileExists/1]).
:- use_module(library(csv)).
:- use_module(library(filesex)).

caminhar_ate_diretorio_atual(Diretorio) :-
    source_file(_, Arquivo),
    file_directory_name(Arquivo, Diretorio),!.

verifyFileExists(Name) :-
    exists_file(Name), nl.
verifyFileExists(Name) :-
    \+ exists_file(Name),
    open(Name, write, Stream),
    close(Stream), nl.