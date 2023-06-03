:- module(UserModule,[registerUser/6, addUser/5]).
:- use_module(library(csv)).


readCsv(FilePath, File):- csv_read_file(FilePath,File).

addUser(FilePath, Name, Email, Password, ReadGenres):-
readCsv(FilePath,File),
registerUser(FilePath,File,Name, Email, Password, ReadGenres).

registerUser(FilePath, File, Name, Email, Password, ReadGenres) :-
    open(FilePath, append, Stream),
    format(Stream, "~w;~w;~w;~w~n", [Name, Email, Password, ReadGenres]),
    close(Stream),
    write("Usuário cadastrado com sucesso!"), !.

