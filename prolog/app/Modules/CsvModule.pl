:- module(CsvModule,[getUsers/1,getBooks/1, ler_arquivo_csv/2, row_to_list/2, rows_to_lists/2,nth/3,string_to_list/2,atualizar_posicao/4,len/2,atualizaUsers/4]).

:- use_module(library(csv)).
:- use_module('../Data/Data.pl').

getUsers(Users) :- 
caminhar_ate_diretorio_atual(Diretorio),
string_concat(Diretorio, '/users.csv', Path),
ler_arquivo_csv(Path, DadosT), 
len(DadosT, R),
atualizaUsers(DadosT, R, 1, Users).

getBooks(X) :- caminhar_ate_diretorio_atual(Diretorio),
string_concat(Diretorio, '/books.csv', Path), ler_arquivo_csv(Path, X).

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

atualizaUsers(Users, R, C, Users) :- C > R,!.
atualizaUsers(Users, R, C, Retorno) :-
nth(C, Users, Usuario),
nth(4, Usuario, Genres),
nth(5, Usuario, Loans),
nth(6, Usuario, Favorites),
nth(7, Usuario, Historic),
string_to_list(Genres, ListGenres),
string_to_list(Loans, ListLoans),
string_to_list(Favorites, ListFavorites),
string_to_list(Historic, ListHistoric),
atualizar_posicao(3, ListGenres, Usuario, Usuarioatt1),
atualizar_posicao(4, ListLoans, Usuarioatt1, Usuarioatt2),
atualizar_posicao(5, ListFavorites, Usuarioatt2, Usuarioatt3),
atualizar_posicao(6, ListHistoric, Usuarioatt3, Usuarioatt4),
Index is C - 1,
atualizar_posicao(Index, Usuarioatt4, Users, Usersatt),
C2 is C + 1,
atualizaUsers(Usersatt, R, C2, Retorno).


string_to_list('[]', []).
string_to_list(String, Lista) :- %converte '[Fantasia, Terror]' para ['Fantasia', 'Terror'].
    string_concat('[', Substring, String), 
    string_concat(ElementosString, ']', Substring),
    atomic_list_concat(Elementos, ', ', ElementosString),
    maplist(atom_string, Lista, Elementos).

atualizar_posicao(_, _, [], []).
atualizar_posicao(0, NovoElemento, [_|T], [NovoElemento|T]).
atualizar_posicao(Posicao, NovoElemento, [H|T], [H|Resto]) :-
    Posicao > 0,
    NovaPosicao is Posicao - 1,
    atualizar_posicao(NovaPosicao, NovoElemento, T, Resto).

len([],0).
len([_|T],R) :- len(T,R2), R is R2 + 1.
