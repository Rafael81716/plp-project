:- module(UserModule,[registerUser/8, addUser/7,checkUserRegister/3,checkUserPassword/3, bookLoan/2, checkLoan/3, printLoans/1, attUserFavorites/2,printLoansReturn/1, returnBook/3, printHistoric/1]).
:- use_module(library(csv)).
:- use_module(library(lists)).
:- use_module("CsvModule.pl").
:- use_module('../Data/Data.pl').
:- use_module('CLI/MainMenu.pl').
:- use_module("BookModule.pl").
:- use_module("UtilModule.pl").




printHistoric(User):-
    centeredText("Histórico", 63),
    nth1(7,User, Historic),
    Historic = [],
    write("\nHistórico vazio!\n"),
    waitOnScreen,
    printUserMenu(User),!.

printHistoric(User):-
    %clearScreen,
    centeredText("Histórico", 63),
    nth1(7, User, Historic),
    nth1(1, Historic, First),
    split_string(First,",",'', FormatedHistoric),
    getBooksById(FormatedHistoric, Books),
    write("\n"),
    printBooks(Books),
    waitOnScreen,
    printUserMenu(User),!.




returnBook(User, BookId,1):- 
    %clearScreen,
    nth1(7, User, Historic),
    nth1(2,User, ActualEmail),

    append(Historic, [BookId], FinalHistoric),
    
    attUserHistoric(User, FinalHistoric),
   
    getUsers(Users),

    checkUserRegister(ActualEmail, Users, NewUser), 
   
    write("\nLivro salvo no histórico com sucesso!\n"),
    waitOnScreen,
    returnBook(NewUser, BookId, 2),!.

returnBook(User, BookId,2):- 
    %clearScreen,
    nth1(2,User, ActualEmail),
    nth1(5, User, Loans),
    nth1(1, Loans, First),
    split_string(First,",",'', FormatedLoans),
    numberToString(BookId, Id),
    removeElement(Id, FormatedLoans, ActualLoans),
    append([],ActualLoans, FinalLoans),
    attUserLoans(User, FinalLoans),
    getUsers(Users),
    checkUserRegister(ActualEmail, Users, NewUser),    
    write("\nLivro devolvido com sucesso!\n"),
    waitOnScreen,
    printUserMenu(NewUser),!.

printLoans(User):-
    nth1(5, User, Loans),
    Loans == [],
    write("\nVocê não possui emprestimos!\n\n"),
    waitOnScreen,
    printUserMenu(User),!.


printLoans(User):-
    nth1(5, User, Loans),
    nth1(1, Loans, First),
    split_string(First,",",'', FormatedLoans),
   
    getBooksById(FormatedLoans, Books),
    write("\n"),
    printBooks(Books),
    waitOnScreen,
    printUserMenu(User),!.

printLoansReturn(User):-
    nth1(5, User, Loans),
    nth1(1, Loans, First),
    split_string(First,",",'', FormatedLoans),
    getBooksById(FormatedLoans, Books),
    write("\n"),
    printBooks(Books),!.
    

checkLoan([],_,'nao existe'):- !.
checkLoan([H|T], BookId, Result):- H =:= BookId, Result = 'existe',!.
checkLoan([H|T], BookId, Result):- H \== BookId, checkLoan(T, BookId, Result),!. 

bookLoan(User, BookId):-
    write("Livro emprestado com sucesso!\n"),
    nth1(5, User, Loans),
    nth1(2, User, ActualEmail),
    append(Loans, [BookId], ActualLoans),
    attUserLoans(User, ActualLoans),
    getUsers(Users),
    checkUserRegister(ActualEmail, Users, NewUser),    
    printUserMenu(NewUser),!.

bookHistoric(User, BookId, 2) :- !.
bookHistoric(User, BookId, 1) :-
    write("Livro adicionar ao historico de leitura!\n"),
    nth1(7, User, Historic),
    nth1(2, User, ActualEmail),
    append(Historic, [BookId], ActualHistoric),
    attUserLoans(User, ActualHistoric),
    getUsers(Users),
    checkUserRegister(ActualEmail, Users, NewUsers),
    nth1(1,NewUsers, NewUser),
    
    printUserMenu(NewUser),!.


addUser(Name, Email, Password, ReadGenres, Loans, Favorites, Historic):-
    caminhar_ate_diretorio_atual(Diretorio),
    string_concat(Diretorio, '/users.csv', FilePath),
    registerUser(FilePath, Name, Email, Password, ReadGenres, Loans, Favorites, Historic),!.


registerUser(FilePath, Name, Email, Password, ReadGenres, Loans, Favorites, Historic) :-
    open(FilePath, append, Stream),
    format(Stream, "~w;~w;~w;~w;~w;~w;~w~n", [Name, Email, Password, ReadGenres, Loans, Favorites, Historic]),
    close(Stream),
    write("Usuário cadastrado com sucesso!\n").


checkUserRegister(ReadEmail, Users, ActualUser) :- length(Users, L), checkUserRegisterAux(ReadEmail, Users, 0, L, ActualUser).


checkUserRegisterAux(_,_,C, C, []) :- !.
checkUserRegisterAux(ReadEmail, Users, C, L, ActualUser) :- 
nth0(C, Users, User),
nth0(1, User, Email),
ReadEmail == Email,
ActualUser = User.
checkUserRegisterAux(ReadEmail, Users, C, L, ActualUser) :-
nth0(C, Users, User),
nth0(1, User, Email),
ReadEmail \== Email,
C2 is C + 1,
checkUserRegisterAux(ReadEmail, Users, C2, L, R2), ActualUser = R2.


checkUserPassword(Password, Lista, Result):- nth1(3,Lista, UserPassword), Password == UserPassword,Result = 'valida',!.

checkUserPassword(Password, Lista, Result):- nth1(3, Lista, UserPassword), Password \== UserPassword, Result = 'invalida',!.


attUserName(User, NewName) :- attUserAtribute(User, NewName, 0).
attUserEmail(User, NewEmail) :- attUserAtribute(User, NewEmail, 1).
attUserListGenres(User, NewListGenres) :- attUserAtribute(User, NewListGenres, 3),!.

attUserLoans(User, NewLoans) :-attUserAtribute(User, NewLoans,4),!.
attUserFavorites(User, NewFavorites) :- attUserAtribute(User, NewFavorites, 5),!.
attUserHistoric(User, NewHistoric) :- attUserAtribute(User, NewHistoric, 6),!.

getPosUser([A|AS], Email, Count, Pos) :- nth(2, A, EmailUser), Email == EmailUser, Pos is Count, !.
getPosUser([A|AS], Email, Count, Pos) :- nth(2, A, EmailUser), Email \= EmailUser, P2 is Count + 1, getPosUser(AS, Email, P2, Pos),!.

addAllUsers([A]) :- nth(1,A,Name), nth(2,A,Email), nth(3,A,Password), nth(4,A,ReadGenres), nth(5,A,Loans), nth(6,A,Favorites), nth(7,A,Historic),
caminhar_ate_diretorio_atual(Diretorio),
string_concat(Diretorio, '/users.csv', Path),
registerUser2(Path, Name, Email, Password, ReadGenres, Loans, Favorites, Historic),!.
addAllUsers([A|AS]) :- nth(1,A,Name), nth(2,A,Email), nth(3,A,Password), nth(4,A,ReadGenres), nth(5,A,Loans), nth(6,A,Favorites), nth(7,A,Historic),
caminhar_ate_diretorio_atual(Diretorio),
string_concat(Diretorio, '/users.csv', Path),
registerUser2(Path, Name, Email, Password, ReadGenres, Loans, Favorites, Historic), addAllUsers(AS),!.

attUser(User, NewUser) :-
getUsers(Users),
nth(2, User, UserEmail),
getPosUser(Users, UserEmail, 0, Pos),
atualizar_posicao(Pos, NewUser, Users, NewUsers),
caminhar_ate_diretorio_atual(Diretorio),
string_concat(Diretorio, '/users.csv', Path),
erase_csv_data(Path),
addAllUsers(NewUsers),!.

attUserAtribute(User, NewAtribute, AtributePos) :-
atualizar_posicao(AtributePos, NewAtribute, User, Useratt),
attUser(User, Useratt),!.

erase_csv_data(FilePath) :-
    open(FilePath, write, Stream),
    write(Stream, ''),
    close(Stream),!.

registerUser2(FilePath, Name, Email, Password, ReadGenres, Loans, Favorites, Historic) :-
    open(FilePath, append, Stream),
    format(Stream, "~w;~w;~w;~w;~w;~w;~w~n", [Name, Email, Password, ReadGenres, Loans, Favorites, Historic]),
    close(Stream),!.



