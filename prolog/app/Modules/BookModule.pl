:- module(_, [getBookById/2, getBookByName/2, getBooksByGenre/2, getBooksByAuthor/2, printAllBooks/0, printBooks/1, getBooksById/2, getAllBooks/1, printBooksMenu/1, getBooksFromSourceByGenre/3, printBooksWithLink/1]).
:- use_module('CsvModule.pl').
:- use_module('UtilModule.pl').
:- use_module(library(lists)).
:- use_module(library(readutil)).
:- use_module('CLI/LoginAndRegisterModule.pl').



printBooksMenu(User) :-
clearScreen,
centeredText("Biblioteca", 63),
write("\n"),
printAllBooks,
write("\n"),
write("1-Voltar\n2-Ver Livro\nEscolha uma opção:\n"),
read_line_to_codes(user_input, StringOption),
validarIntegridadeOptionBookMenu(StringOption, Option, User),
verificaEntrada(Option, User).

verificaEntrada(1, User) :- printUserMenu(User).
verificaEntrada(2, User) :- 
clearScreen,
centeredText("Biblioteca", 63),
write("\n"),
printAllBooks,
write("\n"),
write("Informe o id do livro:\n"),
read_line_to_codes(user_input, StringId),
validarIntegridadeOptionVerifica(StringId, Id, User),
verificaId(Id, User).
verificaEntrada(_, User) :- writeln("\nEntrada inválida, Tente novamente"), waitOnScreen, printBooksMenu(User).

verificaId(Id, User) :- Id =< 204, Id >= 1, getBookById(Id, Book), nth0(5, Book, Sinopse), nth0(1, Book, NomeLivro), printSinopse(NomeLivro, Sinopse), printUserMenu(User),!.
verificaId(_, User) :- writeln("\nId inválido, Tente novamente\n"), waitOnScreen, verificaEntrada(2,User).

validarIntegridadeOptionBookMenu(Numero, Number, _) :- 
valid_codes(Numero),
number_codes(Number, Numero). 
validarIntegridadeOptionBookMenu(Numero, _, User) :- \+ valid_codes(Numero), write("\nOpção inválida! Tente novamente. \n"), printBooksMenu(User), !.

validarIntegridadeOptionVerifica(Numero, Number, _) :- 
valid_codes(Numero),
number_codes(Number, Numero). 
validarIntegridadeOptionVerifica(Numero, _, User) :- \+ valid_codes(Numero), write("\nOpção inválida! Tente novamente. \n"), verificaEntrada(2,User), !.

printSinopse(NomeLivro, Sinopse) :-
centeredText(NomeLivro, 63),
write("\n"),
write(Sinopse),
write("\n"),
waitOnScreen.


getAllBooks(AllBooks) :-
    getBooks(Books),
    AllBooks = Books, !.


getBooksById([],[]):-!.
getBooksById([H|T],[H1|T1]):-
    (integer(H) -> IdFormated is H; atom_number(H, IdFormated)),
    getBookById(IdFormated, Book),
    H1 = Book,
    getBooksById(T, T1),!.

getBookById(Id, Book) :- 
    getAllBooks(Books), 
    getBookByIdAux(Books, Id, Book),!.
getBookByName(Name, Book):- 
    getAllBooks(Books), 
    getBookByNameAux(Books, Name, Book), !.
getBooksByAuthor(Author, Book) :- 
    getAllBooks(Books), 
    length(Books, Len), 
    getBooksByAuthorAux(Books, 0, Len, Author, [], Book), !.
getBooksByGenre(Genre, Book) :- 
    getAllBooks(Books), 
    length(Books, Len), 
    getBooksByGenreAux(Books, 0, Len, Genre, [], Book),!.

getBooksFromSourceByGenre(Source, Genre, Result) :-
    include(bookHasGenre(Genre), Source, Result).

bookHasGenre(Genre, Book) :-
    nth0(3, Book, BookGenre),

    atom_string(Genre, GenreString),

    Book = [_, _, _, BookGenre | _],
    atom_string(BookGenre, BookGenreString),
    BookGenreString = GenreString.

printAllBooks :-
    getAllBooks(Books),
    printBooks(Books),!.

printBooks([]) :- write(""),!.
printBooks([Head]) :- 
    nth0(0, Head, Id),
    nth0(1, Head, Name),
    nth0(2, Head, Author),
    nth0(3, Head, Genre),
    write(Id),
    write(" - "),
    write(Name),
    write(" - "),
    write(Author),
    write(" - "),
    write(Genre),
    writeln("\n").
    
printBooks([Head|Tail]) :- 
    nth0(0, Head, Id),
    nth0(1, Head, Name),
    nth0(2, Head, Author),
    nth0(3, Head, Genre),
    write(Id),
    write(" - "),
    write(Name),
    write(" - "),
    write(Author),
    write(" - "),
    write(Genre),
    writeln("\n"),
    printBooks(Tail).


printBooksWithLink([]):- write(""), !.
printBooksWithLink([Head]):- 
    nth0(0, Head, Id),
    nth0(1, Head, Name),
    nth0(2, Head, Author),
    nth0(3, Head, Genre),
    nth0(4, Head, Link),
    write(Id),
    write(" - "),
    write(Name),
    write(" - "),
    write(Author),
    write(" - "),
    write(Genre),
    write(" - "),
    write(Link),
    writeln("\n"),!.
    
printBooksWithLink([Head|Tail]) :- 
    nth0(0, Head, Id),
    nth0(1, Head, Name),
    nth0(2, Head, Author),
    nth0(3, Head, Genre),
    nth0(4, Head, Link),
    write(Id),
    write(" - "),
    write(Name),
    write(" - "),
    write(Author),
    write(" - "),
    write(Genre),
    write(" - "),
    write(Link),
    writeln("\n"),
    printBooksWithLink(Tail).

   


getBooksByAuthorAux(_, Cont, Len, _, Books, Books):-
    Cont =:= Len, !.
getBooksByAuthorAux(Array, Cont, Len, Author, Books, Resposta):-
    nth0(Cont, Array, Output),
    nth0(2, Output, NameAuthor), toUpperCase(NameAuthor, NameAuthorUpper), toUpperCase(Author, AuthorUpper),
    NameAuthorUpper == AuthorUpper,
    append([Output], Books, Array1),
    Cont2 is (Cont + 1),
    getBooksByAuthorAux(Array, Cont2, Len, Author, Array1, Resposta),!.
getBooksByAuthorAux(Array, Cont, Len, Author, Books, Resposta):-
    nth0(Cont, Array, Output),
    nth0(2, Output, NameAuthor), toUpperCase(NameAuthor, NameAuthorUpper), toUpperCase(Author, AuthorUpper),
    NameAuthorUpper \= AuthorUpper,
    Cont2 is Cont + 1,
    getBooksByAuthorAux(Array, Cont2, Len, Author, Books, Resposta),!.

getBookByIdAux([], _, []) :- !.
getBookByIdAux([Head|Tail],Id,Books) :- 
    nth0(0, Head, Out), 
    (Out=:=Id -> Books = Head, !; getBookByIdAux(Tail,Id,Books)),!.

getBookByNameAux([], _, []) :- !.
getBookByNameAux([Head|Tail], Name, Books):- 
    toUpperCase(Name, NameUpper),
    nth0(1, Head, Out), 
    toUpperCase(Out, OutUpper),
    (OutUpper==NameUpper -> Books = Head, !; getBookByNameAux(Tail,Name,Books)),!.



getBooksByGenreAux(_, Cont, Len, _, Books, Books):-
    Cont =:= Len, !.
getBooksByGenreAux(Array, Cont, Len, Genre, Books, Resposta):-
    nth0(Cont, Array, Output),
    nth0(3, Output, NameGenre), toUpperCase(NameGenre, NameGenreUpper), toUpperCase(Genre, GenreUpper),
    NameGenreUpper == GenreUpper,
    append([Output], Books, Array1),
    Cont2 is (Cont + 1),
    getBooksByGenreAux(Array, Cont2, Len, Genre, Array1, Resposta),!.
    
getBooksByGenreAux(Array, Cont, Len, Genre, Books, Resposta):-
    nth0(Cont, Array, Output),
    nth0(3, Output, NameGenre), toUpperCase(NameGenre, NameGenreUpper), toUpperCase(Genre, GenreUpper),
    NameGenreUpper \= GenreUpper,
    Cont2 is Cont + 1,
    getBooksByGenreAux(Array, Cont2, Len, Genre, Books, Resposta),!.
    