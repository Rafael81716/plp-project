:- module(_,[printMakeLoan/1,readMakeLoan/2, printMakeLoanByTitle/1,printAllLoans/1, printReturnBook/1, checkIsValidSize/1]).

:- use_module('../UtilModule.pl').
:- use_module('../ValidInput/Validation.pl').
:- use_module('MainMenu.pl').
:- use_module('../CsvModule.pl').
:- use_module('../UserModule.pl').
:- use_module('../BookModule.pl').
:- use_module('Historic.pl').
:- use_module('LoginAndRegisterModule.pl').
:- use_module(library(readutil)).



printReturnBook(User):- 
    clearScreen,
    checkDevolution(User),
    centeredText("Devolucao", 63),
    write("\nEstes são seus empréstimos: \n"),
    printLoansReturn(User),
    write("\nEscolha um livro para devolver pelo título: \n"),
    read_line_to_string(user_input, StringBookName),
    atom_string(BookName, StringBookName),
    write("\n Você já leu esse livro?\n Digite <1> para Sim ou <2> para Não: \n"),
    read_line_to_codes(user_input, StringOption),
    validarIntegridadeOptionLoanReturn(StringOption, Option, User),
    readReturnBook(User, BookName, Option),!.


validarIntegridadeOptionLoanReturn(Numero, Number, _) :- 
valid_codes(Numero),
number_codes(Number, Numero). 
validarIntegridadeOptionLoanReturn(Numero, _, User) :- \+ valid_codes(Numero), write("Opção inválida, tente novamente! \n"), printReturnBook(User),!.

readReturnBook(User, BookName, Option):-
    getBookByName(BookName, Book),
    checkBook2(User,Book),
    nth1(1,Book, BookId),
    returnBook(User, BookId, Option),!.


printAllLoans(User):-
    clearScreen,
    centeredText("Emprestimos", 63),
    printLoans(User),!.

printMakeLoan(User):-
    checkIsValidSize(User),
    centeredText("Emprestimo",63),
    write("\nEscolha uma forma de consulta:\n1 - Titulo\n2 - Autor\n3 - Genero\nEscolha uma opcao: \n"),
    read_line_to_codes(user_input, StringOption),
    validarIntegridadeOptionLoan(StringOption, Option, User),
    readMakeLoan(User, Option),!.


readMakeLoan(User,1):- printMakeLoanByTitle(User),!.
readMakeLoan(User,2):- printMakeLoanByAuthor(User),!.
readMakeLoan(User,3):- printMakeLoanByGenre(User),!.
readMakeLoan(User, _):- 
    write("\nOpção inválida!\nDigite novamente: \n"),
    printMakeLoan(User),!.

validarIntegridadeOptionLoan(Numero, Number, _) :- 
valid_codes(Numero),
number_codes(Number, Numero),!. 
validarIntegridadeOptionLoan(Numero, _,User) :- \+ valid_codes(Numero), readMakeLoan(User, 4),!.

printMakeLoanByGenre(User):-
    clearScreen,
    centeredText("Emprestimo",63),
    write("\n Informe um genero para pesquisa: \n"),
    read_line_to_string(user_input, StringGenre),
    atom_string(Genre, StringGenre),
    getBooksByGenre(Genre, Books),
    checkGenres(User ,Books),

    centeredText("Livros\n", 63),
    write("\n"),
    reverse(Books, SortedBooks),
    printBooks(SortedBooks),
    printMakeLoanByTitle(User),!.

printMakeLoanByAuthor(User):-
    clearScreen,
    centeredText("Emprestimo",63),
    write("\n Informe um autor para pesquisa: \n"),
    read_line_to_string(user_input, StringAuthor),
    atom_string(Author, StringAuthor),
    getBooksByAuthor(Author, Books),
    checkAuthor(User ,Books),
    centeredText("Livros\n", 63),
    write("\n"),
    reverse(Books, SortedBooks),
    printBooks(SortedBooks),
    printMakeLoanByTitle(User).

printMakeLoanByTitle(User):-
    centeredText("Emprestimo",63),
    write("\nInforme o titulo do livro:\n"),
    read_line_to_string(user_input, StringTitle),
    atom_string(Title, StringTitle),
    getBookByName(Title, Book),
    checkBook(User, Book),
    nth1(1, Book, Id),
    checkBooksRepetitions(User, Id),
    bookLoan(User, Id),!.


checkDevolution(User):-
    nth1(5,User,Loans),
    length(Loans,0),
    centeredText("Devolucao", 63),
    write("\nVoce nao possui emprestimos!\n\n"),
    waitOnScreen,
    clearScreen,
    printUserMenu(User),!.

checkDevolution(_):- !.

checkBooksRepetitions(User, BookId):-
    numberToString(BookId,Id),
    nth1(5,User, Loans),
    Loans \== [],
    nth1(1,Loans,First),
    split_string(First,",",'',FormatedLoans),

    (member(Id, FormatedLoans) -> write("\nVocê já possui esse livro emprestado! \n"), waitOnScreen, clearScreen, printMakeLoan(User); !).

checkBooksRepetitions(_,_):- !.




checkIsValidSize(User):- 
 nth1(5, User, Loans),
 nth1(1, Loans, First),
 split_string(First,",",'',FormatedLoans),
 length(FormatedLoans, Size),
 Size >= 10,
 centeredText("Emprestimo",63),
 write("\nVoce ja atingiu o numero maximo de emprestimos!\nDevolva um livro ou escolha outra opcao!\n\n"), 
 waitOnScreen,
 clearScreen,
 printUserMenu(User),!.

checkIsValidSize(_):-!.

checkBook(User, []):-  write("Este livro nao consta na base de dados! Tente novamente. \n"), printMakeLoanByTitle(User), !.

checkBook(_, _):- !.

checkBook2(User, []):- 

write("Este livro nao consta na base de dados! Tente novamente. \n"),
waitOnScreen, 
clearScreen,
printReturnBook(User), !.

checkBook2(_, _):- !.

checkAuthor(User, []):-  write("\nEste autor nao esta cadastrado na base de dados!\nEscolha outro: \n"), printMakeLoanByAuthor(User),!.
checkAuthor(_,_):- !.


checkUserLoans(User , 'existe'):-  write("voce ja tem esse livro emprestado!\n Escolha outro: \n"), printMakeLoanByTitle(User),!.
checkUserLoans(_,'nao existe'):- !.

checkGenres(User, []):-  

write("Este genero nao esta cadastrado no sistema!\nEscolha outro: \n"), printMakeLoanByGenre(User),!.
checkGenres(_, _):-!.







