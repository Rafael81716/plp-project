:- module(LoginAndRegisterModule,[registerUserMenu/0, printGenres/0, checkEmail/1, loginMenu/0]).
:- use_module('../UserModule.pl').
:- use_module('../UtilModule.pl').
:- use_module('../CsvModule.pl').
:- use_module('../ValidInput/Validation.pl').
:- use_module('MainMenu.pl').

loginMenu :-
centeredText("Login",40),
writeln("\nDigite seu email: "),
read(ReadEmail),
getUsers(Users),
checkUserRegister(ReadEmail, Users,ActualUser),
checkLogin(ActualUser),

writeln("Digite a sua senha: "),
read(ReadPassword),
checkUserPassword(ReadPassword, ActualUser, IsValidPassword),
checkPassword2(IsValidPassword),
nth0(0, ActualUser, User),
printUserMenu(User),!.

registerUserMenu :-
centeredText("Cadastre-se",40),
writeln("\nDigite seu nome: "),
read(ReadName),

writeln("\nDigite seu email: "),
read(ReadEmail),
isValidEmail(ReadEmail, EmailResult),
checkEmailFormat(EmailResult),

getUsers(Users),
checkUserRegister(ReadEmail, Users,ListUser), 
checkEmail(ListUser),

writeln("\nDigite sua senha: "),
read(ReadPassword),
isValidPassword(ReadPassword,PasswordResult),
checkPassword(PasswordResult),
printGenres(),
readOptions(Numbers),
mapGenres(Numbers, ReadGenres),
listToString(ReadGenres, StringReadGenres),
addUser(ReadName, ReadEmail, ReadPassword, ReadGenres,[],[],[]),!.

printGenres:-
clearScreen,
centeredText("Cadastre-se",63),
write("\nEscolha ate 5 generos literarios pelos seus respectivos numeros\nem ordem de preferencia e digite -1 para finzalizar a digitação:\n1 - Ficcao\n2 - Fantasia\n3 - Infantil\n4 - Misterio\n5 - Historia\n6 - Aventura\n7 - Romance\n"), !.


checkEmail([_]):- clearScreen,write("Este email ja esta cadastrado!\nEscolha outro:\n"), registerUserMenu,!.

checkEmail([]):- !.

checkEmailFormat('invalido'):- clearScreen,write("Este email nao e valido!\nEscolha outro:\n"), registerUserMenu,!.

checkEmailFormat('valido'):- !.

checkPassword('invalido'):-  clearScreen ,write("A senha tem que conter no minimo 6 digitos!\nDigite novamente: \n"), registerUserMenu,!.

checkPassword('valido'):- !.

checkPassword2('invalida'):- clearScreen, write("Senha incorreta!\nInsira seus dados novamente: \n"), loginMenu,!.

checkPassword2('valida'):- !.

checkLogin(['']):- clearScreen, write("Este email nao esta cadastrado no sistema!\nInsira seus dados novamente: \n"), loginMenu,!.
checkLogin(_):- !.








