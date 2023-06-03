:- module(CsvModule,[getUsers/1,getBooks/1, ler_arquivo_csv/2, row_to_list/2, rows_to_lists/2,nth/3,convertCsvStringGenresToList/4,string_to_list/2,atualizar_posicao/4,len/2]).
:- use_module(library(csv)).


getUsers(Users) :- 
ler_arquivo_csv('../users.csv', DadosT), 
len(DadosT, R),
convertCsvStringGenresToList(DadosT, R, 1, Users).

getBooks(X) :- ler_arquivo_csv('books.csv', X).

ler_arquivo_csv(NomeArquivo, Dados) :-
    open(NomeArquivo, read, Arquivo),
    csv_read_file(NomeArquivo, Linhas, [separator(0';)]),
    rows_to_lists(Linhas, Dados),
    close(Arquivo).

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

convertCsvStringGenresToList(Users, R, C, Users) :- C > R,!.
convertCsvStringGenresToList(Users, R, C, Retorno) :-
nth(C, Users, Usuario),
nth(4, Usuario, Genres),
string_to_list(Genres, ListGenres),
atualizar_posicao(3, ListGenres, Usuario, Usuarioatt),
Index is C - 1,
atualizar_posicao(Index, Usuarioatt, Users, Usersatt),
C2 is C + 1,
convertCsvStringGenresToList(Usersatt, R, C2, Retorno).


string_to_list(String, Lista) :-
    atomic_list_concat(Substrings, ', ', String),
    maplist(atom_string, Lista, Substrings).


atualizar_posicao(_, _, [], []). %troca um elemento do array por outro
atualizar_posicao(0, NovoElemento, [_|T], [NovoElemento|T]).
atualizar_posicao(Posicao, NovoElemento, [H|T], [H|Resto]) :-
    Posicao > 0,
    NovaPosicao is Posicao - 1,
    atualizar_posicao(NovaPosicao, NovoElemento, T, Resto).

len([],0).
len([_|T],R) :- len(T,R2), R is R2 + 1.
