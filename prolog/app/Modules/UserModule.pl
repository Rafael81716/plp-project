:- module(UserModule,[registerUser/9, addUser/8,checkUserRegister/4,checkUserPassword/3]).
:- use_module(library(csv)).


readCsv(FilePath, File):- csv_read_file(FilePath,File),!.

addUser(FilePath, Name, Email, Password, ReadGenres, Loans, Favorites, Historic):-
    readCsv(FilePath,File),
    registerUser(FilePath,File,Name, Email, Password, ReadGenres, Loans, Favorites, Historic),!.

registerUser(FilePath, File, Name, Email, Password, ReadGenres, Loans, Favorites, Historic) :-
    open(FilePath, append, Stream),
    format(Stream, "~w;~w;~w;~w;~w;~w;~w~n", [Name, Email, Password, ReadGenres, Loans, Favorites, Historic]),
    close(Stream),
    write("Usuário cadastrado com sucesso!"), halt.

checkUserRegister(_,[],'valido', []):- !.
checkUserRegister(Email,[H|T],Resp, H):- nth1(2,H,UserEmail), Email == UserEmail, Resp = 'invalido',!.

checkUserRegister(Email,[H|T],Resp, [H1|T1]):- nth1(2,H,UserEmail), Email \== UserEmail, checkUserRegister(Email,T,Resp,[H1|T1]),!.

checkUserPassword(Password, [H|T], Result):- nth1(3,[H|T], UserPassword), Password == UserPassword, write('valida') ,Result = 'valida',!.

checkUserPassword(Password, [H|T], Result):- nth1(3,[H|T], UserPassword), Password \== UserPassword, write('invalida'), Result = 'invalida',!.



