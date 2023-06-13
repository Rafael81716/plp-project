:- module(_,[registerFavorite/1, sizeList/3, removeFavorite/1, listFavorites/1]).
:- use_module('../BookModule.pl').
:- use_module('../UserModule.pl').
:- use_module('../CsvModule.pl').
:- use_module("../UtilModule.pl").
:- use_module('../ValidInput/Validation.pl').
:- use_module('MainMenu.pl').
:- use_module(library(readutil)).

registerFavorite(User) :-
    clearScreen,
    centeredText("Registrar Favorito", 63),
    write("\n"),
    nth0(5, User, Favorites),
    nth0(0, Favorites, Elem),
    split_string(Elem, ",", "", L),
    sizeList(L, 0, ListLenght),
    ListLenght > 9 -> 
    writeln("Lista de favoritos cheia!"),
    waitOnScreen,
    clearScreen,
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
    read_line_to_string(user_input, StringTitulo),
    atom_string(Titulo, StringTitulo),
    getBookByName(Titulo, Book),
    checkValidBook(User, Book, 'register'),
    nth0(0, Book, ID),
    addBook(User, ID, [], 'notFav')
    ;
    writeln("Insira o titulo do livro a ser adicionado:"),
    read_line_to_string(user_input, StringTitulo),
    atom_string(Titulo, StringTitulo),
    getBookByName(Titulo, Book),
    checkValidBook(User, Book, 'register'),
    nth0(0, Book, ID),
    nth0(0, Favorites, Elem),
    split_string(Elem, ",", "", List),
    checkFavorite(ID, List, R),
    addBook(User, ID, List, R),!.

addBook(User, ID, Favorites, Check) :- 
    Check = 'fav' ->
    writeln("Livro ja se encontra na lista de favoritos"),
    waitOnScreen,
    clearScreen,
    printUserMenu(User)
    ;
    append([ID], Favorites, R),
    attUserFavorites(User, R),
    getUsers(Users),
    nth0(1, User, Email),
    checkUserRegister(Email, Users, NewUser),
    writeln("Livro adicionado aos favoritos com sucesso!"),
    waitOnScreen,
    clearScreen,
    printUserMenu(NewUser),!.


removeFavorite(User) :- 
    clearScreen,
    centeredText("Remover Favorito", 63),
    nth0(5, User, Favorites),
    sizeList(Favorites, 0, L),
    L =:= 0 ->
    write("\n"),
    writeln("Lista de favoritos vazia!"),
    waitOnScreen,
    clearScreen,
    printUserMenu(User)
    ;
    removeBookFromFavorites(User),!.

removeBookFromFavorites(User) :- 
    nth0(5, User, Favorites),
    listBeforeRemove(User),
    writeln("Insira o titulo do livro a ser removido:"),
    read_line_to_string(user_input, StringTitulo),
    atom_string(Titulo, StringTitulo),
    getBookByName(Titulo, Book),
    checkValidBook(User, Book, 'remove'),
    nth0(0, Book, ID),
    nth0(0, Favorites, Elem),
    split_string(Elem, ",", "", L),
    checkFavorite(ID, L, R),
    removeBook(User, ID, Favorites, R),!.

removeBook(User, ID, Favorites, Check) :- 
    Check = 'notFav' -> 
    writeln("Livro nao se encontra na lista de favoritos"),
    waitOnScreen,
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
    waitOnScreen,
    clearScreen,
    printUserMenu(NewUser),!.

listBeforeRemove(User) :-
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
    clearScreen,
    centeredText("Lista de favoritos",63),
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
    waitOnScreen,
    clearScreen,
    printUserMenu(User),!.

printBooksList(User, []) :- 
    writeln(""),
    waitOnScreen,
    clearScreen,
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
sizeList([_|T], C, L) :- sizeList(T, C + 1, L),!.

checkValidBook(User, Book, Option) :- 
    sizeList(Book, 0, L),
    L =:= 0 -> 
    writeln("Livro nao encontrado!"),
    repeatFav(User, Option)
    ;
    write(""),!.

repeatFav(User, 'register') :- waitOnScreen, registerFavorite(User),!.
repeatFav(User, 'remove') :- waitOnScreen, removeFavorite(User),!.