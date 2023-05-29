:- module(UserModule,[registerUser/6, addUser/4]).
:- use_module(library(csv)).


readCsv(FilePath, File):- csv_read_file(FilePath,File).

addUser(FilePath, Name, Email, Password, ReadGenres):-
readCsv(FilePath,File),
registerUser(FilePath,File,Name, Email, Password, ReadGenres).

registerUser(FilePath,File, Name, Email, Password, ReadGenres):-
    append(File, [row(Name, Email, Password)], Saida),
    csv_write_file(FilePath, Saida),
    write("Usuario cadastrado com sucesso!"),!.
