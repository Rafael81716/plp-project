:- module(UserModule,[registerUser/9, addUser/8,checkUserRegister/3]).
:- use_module(library(csv)).
:- use_module(library(lists)).
:- use_module("CsvModule.pl").

readCsv(FilePath, File):- csv_read_file(FilePath,File),!.

addUser(FilePath, Name, Email, Password, ReadGenres, Loans, Favorites, Historic):-
readCsv(FilePath,File),
registerUser(FilePath,File,Name, Email, Password, ReadGenres, Loans, Favorites, Historic),!.

registerUser(FilePath, File, Name, Email, Password, ReadGenres, Loans, Favorites, Historic) :-
    open(FilePath, append, Stream),
    format(Stream, "~w;~w;~w;~w;~w;~w;~w~n", [Name, Email, Password, ReadGenres, Loans, Favorites, Historic]),
    close(Stream),
    write("Usuário cadastrado com sucesso!"), halt.

checkUserRegister(_,[],'valido'):- !.
checkUserRegister(Email,[H|T],Resp):- nth1(2,H,UserEmail), Email == UserEmail, Resp = 'invalido',!.
checkUserRegister(Email,[H|T],Resp):- nth1(2,H,UserEmail), Email \== UserEmail, checkUserRegister(Email,T,Resp),!.


attUserName(User, NewName) :- attUserAtribute(User, NewName, 0).
attUserEmail(User, NewEmail) :- attUserAtribute(User, NewEmail, 1).
attUserListGenres(User, NewListGenres) :- attUserAtribute(User, NewListGenres, 3).
attUserLoans(User, NewLoans) :- attUserAtribute(User, NewLoans, 4).
attUserFavorites(User, NewFavorites) :- attUserAtribute(User, NewFavorites, 5).
attUserHistoric(User, NewHistoric) :- attUserAtribute(User, NewHistoric, 6).

getPosUser([A|AS], Email, Count, Pos) :- nth(2, A, EmailUser), Email == EmailUser, Pos is Count, !.
getPosUser([A|AS], Email, Count, Pos) :- nth(2, A, EmailUser), Email \= EmailUser, P2 is Count + 1, getPosUser(AS, Email, P2, Pos).

addAllUsers([A]) :- nth(1,A,Name), nth(2,A,Email), nth(3,A,Password), nth(4,A,ReadGenres), nth(5,A,Loans), nth(6,A,Favorites), nth(7,A,Historic),
registerUser2('users.csv', Name, Email, Password, ReadGenres, Loans, Favorites, Historic).
addAllUsers([A|AS]) :- nth(1,A,Name), nth(2,A,Email), nth(3,A,Password), nth(4,A,ReadGenres), nth(5,A,Loans), nth(6,A,Favorites), nth(7,A,Historic),
registerUser2('users.csv', Name, Email, Password, ReadGenres, Loans, Favorites, Historic), addAllUsers(AS).

attUser(User, NewUser) :-
getUsers(Users),
nth(2, User, UserEmail),
getPosUser(Users, UserEmail, 0, Pos),
atualizar_posicao(Pos, NewUser, Users, NewUsers),
writeln(NewUsers),
erase_csv_data('users.csv'),
addAllUsers(NewUsers).

attUserAtribute(User, NewAtribute, AtributePos) :-
atualizar_posicao(AtributePos, NewAtribute, User, Useratt),
writeln(Useratt),
attUser(User, Useratt).

erase_csv_data(FilePath) :-
    open(FilePath, write, Stream),
    write(Stream, ''),
    close(Stream).

registerUser2(FilePath, Name, Email, Password, ReadGenres, Loans, Favorites, Historic) :-
    open(FilePath, append, Stream),
    format(Stream, "~w;~w;~w;~w;~w;~w;~w~n", [Name, Email, Password, ReadGenres, Loans, Favorites, Historic]),
    close(Stream).



