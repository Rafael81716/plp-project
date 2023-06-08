:- module(LoanModule,[printMakeLoan/1,readMakeLoan/2, printMakeLoanByTitle/1]).
:- use_module('../UtilModule.pl').
:- use_module('../ValidInput/Validation.pl').
:- use_module('MainMenu.pl').
:- use_module('../CsvModule.pl').
:- use_module('../UserModule.pl').
:- use_module('../BookModule.pl').

printMakeLoan(User):-
    clearScreen,
    centeredText("Emprestimo",63),
    write("\nEscolha uma forma de consulta:\n1 - Titulo\n2 - Autor\n3 - Genero\nEscolha uma opcao: \n"),
    read(Option),
    readMakeLoan(User, Option),!.


readMakeLoan(User,1):- printMakeLoanByTitle(User),!.
readMakeLoan(User,2):- printMakeLoanByAuthor(User),!.
readMakeLoan(User,3):- printMakeLoanByGenre(User),!.


printMakeLoanByAuthor(User):-
clearScreen,
%Verificar se o usuario ainda pode fazer emprestimo
nth1(5, User, Loans),
isValidSize(Loans, Result),
checkIsValidSize(User,Result),
centeredText("Emprestimo",63),
write("\n Informe um autor para pesquisa: \n"),
read(Author),
getBooksByAuthor(Author, Books),
checkAuthor(User ,Books),
printBooks(Books),
write('foi'),!.


printMakeLoanByTitle(User):-
clearScreen,
%Verificar se o usuario ainda pode fazer emprestimo
nth1(5, User, Loans),
isValidSize(Loans, Result),
checkIsValidSize(User,Result),

centeredText("Emprestimo",63),
write("\nInforme o titulo do livro:\n"),
read(Title), 
getBookByName(Title, Book),
nth1(1, Book, Id),
%TODO Verificar se o usuario ja tem esse livro emprestado
bookLoan(User, Id),!.

checkIsValidSize(User,'invalido'):- clearScreen, write("Voce ja atingiu o numero maximo de emprestimos!\n Devolva um livro ou escolha outra opcao!\n"), printUserMenu(User),!.

checkIsValidSize(_,'valido'):-!.

checkBook(User, []):- clearScreen, write("Este livro nao consta na base de dados!\nEscolha novamente: \n"), printMakeLoanByTitle(User), !.

checkBook(_,[H|T]):- !.

checkAuthor(User, []):- clearScreen, write("\nEste autor nao esta cadastrado na base de dados!\nEscolha outro: \n"), printMakeLoanByAuthor(User),!.
checkAuthor(_,[H|T]):- !.


checkUserLoans(User , 'existe'):- clearScreen, write("voce ja tem esse livro emprestado!\n Escolha outro: \n"), printMakeLoanByTitle(User),!.
checkUserLoans(_,'nao existe'):- !.




