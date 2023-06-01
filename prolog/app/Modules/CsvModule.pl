:- use_module(library(csv)).

ler_csv(Linhas, NameFile) :-
    open(NameFile, read, Arquivo),
    csv_read_file(NameFile, Linhas, []),
    close(Arquivo).


getUsers(Users) :- ler_csv(X, 'users.csv'), rows_to_lists(X, Users).

getBooks(Books) :- ler_csv(X, 'books.csv'), rows_to_lists(X, Books).

%para pegar os dados, pode ser usado o nth para acessar uma posicao da lista.

%main :-
%getUsers(Users),
%nth(1, Users, Resp),
%write(Resp),
%nth(4, Resp, Genres),
%write(Genres).

row_to_list(Row, Data) :-
    Row =.. [_|Data].
    
rows_to_lists([], []).
rows_to_lists([Row|Rows], [Data|DataList]) :-
    row_to_list(Row, Data),
    rows_to_lists(Rows, DataList).

nth(1, [X|_], X).
nth(N, [_|T], X) :-
    N > 1,
    N1 is N - 1,
    nth(N1, T, X).