:- module(UserModule,[registerUser/4]).
:- use_module(library(csv)).

registerUser(File, Name, Email, Password):-
append(File, [row(Name, Email, Password)], Exit),
csv_write_file(File, Exit),
writeln("Usuário cadastrado com sucesso!").
