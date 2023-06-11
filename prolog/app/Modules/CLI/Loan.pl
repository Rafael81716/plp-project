:- module(LoanModule,[printMakeLoan/1,readMakeLoan/2, printMakeLoanByTitle/1,printAllLoans/1, printReturnBook/1, checkIsValidSize/1]).

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
    %clearScreen,
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


validarIntegridadeOptionLoanReturn(Numero, Number, User) :- 
valid_codes(Numero),
number_codes(Number, Numero). 
validarIntegridadeOptionLoanReturn(Numero, _, User) :- \+ valid_codes(Numero), write("Opção inválida, tente novamente! \n"), printReturnBook(User),!.

readReturnBook(User, BookName, Option):-
    getBookByName(BookName, Book),
    checkBook2(User,Book),
    nth1(1,Book, BookId),
    returnBook(User, BookId, Option),!.


printAllLoans(User):-
    %clearScreen,
    centeredText("Emprestimos", 63),
    printLoans(User),!.

printMakeLoan(User):-
    checkIsValidSize(User),
    centeredText("Emprestimo",63),
    write("\nEscolha uma forma de consulta:\n1 - Titulo\n2 - Autor\n3 - Genero\nEscolha uma opcao: \n"),
    read_line_to_codes(user_input, StringOption),
    validarIntegridadeOptionLoan(StringOption, Option),
    readMakeLoan(User, Option),!.


readMakeLoan(User,1):- printMakeLoanByTitle(User),!.
readMakeLoan(User,2):- printMakeLoanByAuthor(User),!.
readMakeLoan(User,3):- printMakeLoanByGenre(User),!.
readMakeLoan(User, _):- 
    clearScreen,
    write("\nOpção inválida!\nDigite novamente: \n"),
    waitOnScreen,
    printMakeLoan(User),!.

validarIntegridadeOptionLoan(Numero, Number) :- 
valid_codes(Numero),
number_codes(Number, Numero),!. 
validarIntegridadeOptionLoan(Numero, _) :- \+ valid_codes(Numero), write("Opção inválida, tente novamente! \n"),!.

printMakeLoanByGenre(User):-
    
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
    %TODO Verificar se o usuario ja tem esse livro emprestado
    bookLoan(User, Id),!.


checkBooksRepetitions(User, BookId):-
    numberToString(BookId,Id),
    nth1(5,User, Loans),
    nth1(1,Loans,First),
    split_string(First,",",'',FormatedLoans),

    (member(Id, FormatedLoans) -> clearScreen, write("\nVocê já possui esse livro emprestado!\nEscolha outro: "), waitOnScreen, printMakeLoan(User); !).




checkIsValidSize(User):- 
 clearScreen,
 nth1(5, User, Loans),
 nth1(1, Loans, First),
 split_string(First,",",'',FormatedLoans),
 length(FormatedLoans, Size),
 Size >= 10, 
 write("Voce ja atingiu o numero maximo de emprestimos!\nDevolva um livro ou escolha outra opcao!\n\n"), 
 waitOnScreen,
 printUserMenu(User),!.

checkIsValidSize(_):-!.

checkBook(User, []):-  write("Este livro nao consta na base de dados!\nEscolha novamente: \n"), printMakeLoanByTitle(User), !.

checkBook(_,[H|T]):- !.

checkBook2(User, []):- 
clearScreen, 
write("Este livro nao consta na base de dados!\nEscolha novamente: \n"),
waitOnScreen, 
printReturnBook(User), !.

checkBook2(_,[H|T]):- !.

checkAuthor(User, []):-  write("\nEste autor nao esta cadastrado na base de dados!\nEscolha outro: \n"), printMakeLoanByAuthor(User),!.
checkAuthor(_,[H|T]):- !.


checkUserLoans(User , 'existe'):-  write("voce ja tem esse livro emprestado!\n Escolha outro: \n"), printMakeLoanByTitle(User),!.
checkUserLoans(_,'nao existe'):- !.

checkGenres(User, []):-  %clearScreen ,
write("Este genero nao esta cadastrado no sistema!\nEscolha outro: \n"), printMakeLoanByGenre(User),!.
checkGenres(_,[H|T]):-!.







