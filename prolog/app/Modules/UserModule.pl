:- module(UserModule,[registerUser/9, addUser/8,checkUserRegister/3]).
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

checkUserRegister(_,[],'valido'):- !.
checkUserRegister(Email,[H|T],Resp):- nth1(2,H,UserEmail), Email == UserEmail, Resp = 'invalido',!.
checkUserRegister(Email,[H|T],Resp):- nth1(2,H,UserEmail), Email \== UserEmail, checkUserRegister(Email,T,Resp),!.

