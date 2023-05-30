:- module(LoginAndRegisterModule,[registerUserMenu/0]).
:- use_module('../UserModule.pl').
:- use_module('../UtilModule.pl').

registerUserMenu :-
centeredText("Cadastre-se",40),
write("\nDigite seu nome: "),
read(ReadName),

write("\nDigite seu email: "),
read(ReadEmail),
write("\nDigite sua senha: "),
read(ReadPassword),
printGenres(),
readOptions(Numbers),
mapGenres(Numbers, ReadGenres),
listToString(ReadGenres, StrinlistToStringgReadGenres),
write(StrinlistToStringgReadGenres),
addUser('../users.csv', ReadName, ReadEmail, ReadPassword, StrinlistToStringgReadGenres).

printGenres:-
clearScreen,
centeredText("Cadastre-se",63),
write("\nEscolha ate 5 generos literarios pelos seus respectivos numeros\nem ordem de preferencia e digite -1 para finzalizar a digitação:\n1 - Ficcao\n2 - Fantasia\n3 - Infantil\n4 - Misterio\n5 - Historia\n6 - Aventura\n7 - Romance\n").





