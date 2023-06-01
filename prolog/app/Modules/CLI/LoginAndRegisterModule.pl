:- module(LoginAndRegisterModule,[registerUserMenu/0, printGenres/0, checkEmail/1]).
:- use_module('../UserModule.pl').
:- use_module('../UtilModule.pl').
:- use_module('../CsvModule.pl').

registerUserMenu :-
centeredText("Cadastre-se",40),
write("\nDigite seu nome: "),
read(ReadName),

write("\nDigite seu email: "),
read(ReadEmail),
getUsers(Users),
checkUserRegister(ReadEmail, Users,IsValidEmail),
checkEmail(IsValidEmail),

write("\nDigite sua senha: "),
read(ReadPassword),
printGenres(),
readOptions(Numbers),
mapGenres(Numbers, ReadGenres),
listToString(ReadGenres, StringReadGenres),
addUser('../users.csv', ReadName, ReadEmail, ReadPassword, StringReadGenres).

printGenres:-
clearScreen,
centeredText("Cadastre-se",63),
write("\nEscolha ate 5 generos literarios pelos seus respectivos numeros\nem ordem de preferencia e digite -1 para finzalizar a digitação:\n1 - Ficcao\n2 - Fantasia\n3 - Infantil\n4 - Misterio\n5 - Historia\n6 - Aventura\n7 - Romance\n").


checkEmail('invalido'):- clearScreen,write("Este email ja esta cadastrado!\nEscolha outro:\n"), registerUserMenu.
checkEmail('valido'):- !.






