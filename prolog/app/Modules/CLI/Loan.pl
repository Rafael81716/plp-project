:- module(LoanModule,[printMakeLoan/1,readMakeLoan/2, printMakeLoanByTitle/1]).
:- use_module('../UtilModule.pl').
:- use_module('../ValidInput/Validation.pl').
:- use_module('MainMenu.pl').
:- use_module('../CsvModule.pl').
:- use_module('../UserModule.pl').
:- use_module('../BookModule.pl').
:- use_module('Historic.pl').

printMakeLoan(User):-
    centeredText("Emprestimo",63),
    write("\nEscolha uma forma de consulta:\n1 - Titulo\n2 - Autor\n3 - Genero\nEscolha uma opcao: \n"),
    read(Option),
    readMakeLoan(User, Option),!.


readMakeLoan(User,1):- printMakeLoanByTitle(User),!.
readMakeLoan(User,2):- printMakeLoanByAuthor(User),!.
readMakeLoan(User,3):- printMakeLoanByGenre(User),!.


printMakeLoanByGenre(User):-
%Verificar se o usuario ainda pode fazer emprestimo
nth1(5, User, Loans),
nth1(1, Loans, First),
split_string(First,",","", FormatedLoans),
write(FormatedLoans),
checkIsValidSize(User, FormatedLoans),
centeredText("Emprestimo",63),
write("\n Informe um genero para pesquisa: \n"),
read(Genre),
getBooksByGenre(Genre, Books),
checkGenres(User ,Books),

centeredText("Livros\n", 63),
write("\n"),
printBooks(Books),
write("\nInforme o titulo do livro:\n"),
read(Title), 
getBookByName(Title, Book),
nth1(1, Book, Id),
%TODO Verificar se o usuario ja tem esse livro emprestado
bookLoan(User, Id),!.

printMakeLoanByAuthor(User):-
%Verificar se o usuario ainda pode fazer emprestimo
nth1(5, User, Loans),
nth1(1, Loans, First),
split_string(First,",","", FormatedLoans),
checkIsValidSize(User, FormatedLoans),
centeredText("Emprestimo",63),
write("\n Informe um autor para pesquisa: \n"),
read(Author),
getBooksByAuthor(Author, Books),
checkAuthor(User ,Books),

centeredText("Livros\n", 63),
write("\n"),
printBooks(Books),
write("\nInforme o titulo do livro:\n"),
read(Title), 
getBookByName(Title, Book),
nth1(1, Book, Id),
%TODO Verificar se o usuario ja tem esse livro emprestado
bookLoan(User, Id),!.


printMakeLoanByTitle(User):-
%Verificar se o usuario ainda pode fazer emprestimo
nth1(5, User, Loans),
length(Loan, Size),
Size >= 1,
nth1(1, Loans, First),

split_string(First,",","", FormatedLoans),
checkIsValidSize(User, FormatedLoans),

centeredText("Emprestimo",63),
write("\nInforme o titulo do livro:\n"),
read(Title), 
getBookByName(Title, Book),
checkBook(User, Book),
nth1(1, Book, Id),
%TODO Verificar se o usuario ja tem esse livro emprestado
bookLoan(User, Id),!.

checkIsValidSize(User,Loans):- 
length(Loans, Size), Size >= 10, write("Voce ja atingiu o numero maximo de emprestimos!\n Devolva um livro ou escolha outra opcao!\n"), printUserMenu(User),!.

checkIsValidSize(_,_):-!.

checkBook(User, []):-  write("Este livro nao consta na base de dados!\nEscolha novamente: \n"), printMakeLoanByTitle(User), !.

checkBook(_,[H|T]):- !.

checkAuthor(User, []):-  write("\nEste autor nao esta cadastrado na base de dados!\nEscolha outro: \n"), printMakeLoanByAuthor(User),!.
checkAuthor(_,[H|T]):- !.


checkUserLoans(User , 'existe'):-  write("voce ja tem esse livro emprestado!\n Escolha outro: \n"), printMakeLoanByTitle(User),!.
checkUserLoans(_,'nao existe'):- !.

checkGenres(User, []):-  clearScreen ,write("Este genero nao esta cadastrado no sistema!\nEscolha outro: \n"), printMakeLoanByGenre(User),!.
checkGenres(_,[H|T]):-!.




