:- module(DataModule,[caminhar_ate_diretorio_atual/1]).
:- use_module(library(csv)).

caminhar_ate_diretorio_atual(Diretorio) :-
    source_file(Predicado, Arquivo),
    file_directory_name(Arquivo, Diretorio).