:- module(LoginAndRegisterModule,[registerUserMenu/0, printGenres/0, checkEmail/1]).
:- use_module('../UserModule.pl').
:- use_module('../UtilModule.pl').
:- use_module('../CsvModule.pl').
:- use_module('../ValidInput/Validation.pl').

registerUserMenu :-
centeredText("Cadastre-se",40),
write("\nDigite seu nome: "),
read(ReadName),

write("\nDigite seu email: "),
read(ReadEmail),
isValidEmail(ReadEmail, EmailResult),
checkEmailFormat(EmailResult),
getUsers(Users),
write(Users),
%checkUserRegister(ReadEmail, Users,IsValidEmail),
%checkEmail(IsValidEmail),

write("\nDigite sua senha: "),
read(ReadPassword),
isValidPassword(ReadPassword,PasswordResult),
checkPassword(PasswordResult),
printGenres(),
readOptions(Numbers),
mapGenres(Numbers, ReadGenres),
listToString(ReadGenres, StringReadGenres),
addUser('../users.csv', ReadName, ReadEmail, ReadPassword, ReadGenres,[],[],[]),!.

printGenres:-
clearScreen,
centeredText("Cadastre-se",63),
write("\nEscolha ate 5 generos literarios pelos seus respectivos numeros\nem ordem de preferencia e digite -1 para finzalizar a digitação:\n1 - Ficcao\n2 - Fantasia\n3 - Infantil\n4 - Misterio\n5 - Historia\n6 - Aventura\n7 - Romance\n"), !.


checkEmail('invalido'):- clearScreen,write("Este email ja esta cadastrado!\nEscolha outro:\n"), registerUserMenu,!.
checkEmail('valido'):- !.

checkEmailFormat('invalido'):- clearScreen,write("Este email nao e valido!\nEscolha outro:\n"), registerUserMenu,!.
checkEmailFormat('valido'):- !.

checkPassword('invalido'):-  clearScreen ,write("A senha tem que conter no minimo 6 digitos!\nDigite novamente: \n"), registerUserMenu,!.
checkPassword('valido'):- !.






