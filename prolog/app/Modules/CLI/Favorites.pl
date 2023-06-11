:- module(FavoritesModule,[registerFavorite/1, sizeList/3, removeFavorite/1, listFavorites/1]).
:- use_module('../BookModule.pl').
:- use_module('../UserModule.pl').
:- use_module('../CsvModule.pl').
:- use_module("../UtilModule.pl").
:- use_module('../ValidInput/Validation.pl').
:- use_module('MainMenu.pl').

registerFavorite(User) :-
    nth0(5, User, Favorites),
    nth0(0, Favorites, Elem),
    split_string(Elem, ",", "", L),
    sizeList(L, 0, ListLenght),
    ListLenght > 9 -> 
    writeln("Lista de favoritos cheia!"),
    printUserMenu(User)
    ;
    addBookToFavorites(User),!.

addBookToFavorites(User) :- 
    nth0(5, User, Favorites),
    checkEmpty(User, Favorites),!.

checkEmpty(User, Favorites) :- 
    sizeList(Favorites, 0, L),
    L =:= 0 -> 
    writeln("Insira o titulo do livro a ser adicionado:"),
    read(Titulo),
    getBookByName(Titulo, Book),
    nth0(0, Book, ID),
    addBook(User, ID, [], 'notFav')
    ;
    writeln("Insira o titulo do livro a ser adicionado:"),
    read(Titulo),
    getBookByName(Titulo, Book),
    nth0(0, Book, ID),
    nth0(0, Favorites, Elem),
    split_string(Elem, ",", "", List),
    checkFavorite(ID, List, R),
    addBook(User, ID, List, R),!.

addBook(User, ID, Favorites, Check) :- 
    Check = 'fav' ->
    writeln("Livro ja se encontra na lista de favoritos"),
    printUserMenu(User)
    ;
    append([ID], Favorites, R),
    attUserFavorites(User, R),
    getUsers(Users),
    nth0(1, User, Email),
    checkUserRegister(Email, Users, NewUser),
    writeln("Livro adicionado aos favoritos com sucesso!"),
    printUserMenu(NewUser),!.


removeFavorite(User) :- 
    nth0(5, User, Favorites),
    nth0(0, Favorites, Elem),
    split_string(Elem, ",", "", L),
    sizeList(L, 0, ListLenght),
    ListLenght =:= 0 ->
    writeln("Lista de favoritos vazia!"),
    printUserMenu(User)
    ;
    removeBookFromFavorites(User),!.

removeBookFromFavorites(User) :- 
    nth0(5, User, Favorites),
    listBeforeRemove(User),
    writeln("Insira o titulo do livro a ser removido:"),
    read(Titulo),
    getBookByName(Titulo, Book),
    nth0(0, Book, ID),
    nth0(0, Favorites, Elem),
    split_string(Elem, ",", "", L),
    checkFavorite(ID, L, R),
    removeBook(User, ID, Favorites, R),!.

removeBook(User, ID, Favorites, Check) :- 
    Check = 'notFav' -> 
    writeln("Livro nao se encontra na lista de favoritos"),
    printUserMenu(User)
    ;
    nth0(0, Favorites, Elem),
    split_string(Elem, ",", "", L),
    number_string(ID, Num),
    removeBookFromList(Num, L, [],  R),
    attUserFavorites(User, R),
    getUsers(Users),
    nth0(1, User, Email),
    checkUserRegister(Email, Users, NewUser),
    writeln("Livro removido dos favoritos com sucesso!"),
    printUserMenu(NewUser),!.

listBeforeRemove(User) :-
    centeredText("Lista de favoritos",40),
    writeln(""),
    nth0(5, User, Favorites),
    nth0(0, Favorites, Elem),
    split_string(Elem, ",", "", L),
    writeln(""),
    printBeforeRemove(L),!.

printBeforeRemove([]) :- 
    writeln(""),!.
printBeforeRemove([H|T]) :-
    atom_number(H,X),
    getBookById(X, Book),
    printBooks([Book]),
    printBeforeRemove(T),!.

listFavorites(User) :- 
    centeredText("Lista de favoritos",40),
    writeln(""),
    nth0(5, User, Favorites),
    sizeList(Favorites, 0, S),
    S =\= 0 ->
    nth0(0, Favorites, Elem),
    split_string(Elem, ",", "", L),
    writeln(""),
    printBooksList(User, L)
    ;
    writeln(""),
    writeln("Lista de favoritos vazia!"),
    writeln(""),
    printUserMenu(User),!.

printBooksList(User, []) :- 
    writeln(""),
    printUserMenu(User),!.
printBooksList(User, [H|T]) :- 
    atom_number(H,X),
    getBookById(X, Book),
    printBooks([Book]),
    printBooksList(User, T),!.

checkFavorite(_, [], R) :- R = 'notFav',!.
checkFavorite(E, [H|T], R) :- 
    atom_number(H, X),
    E =:= X -> 
    R = 'fav' 
    ; 
    checkFavorite(E, T, R),!.

removeBookFromList(_, [], _, _).
removeBookFromList(E, [H|T], Aux, R) :- 
    E = H -> 
    append(Aux, T, R)
    ;
    append(Aux, [H], L),
    removeBookFromList(E, T, L, R).

sizeList([], C, L) :- L is C,!.
sizeList([H|T], C, L) :- sizeList(T, C + 1, L),!.