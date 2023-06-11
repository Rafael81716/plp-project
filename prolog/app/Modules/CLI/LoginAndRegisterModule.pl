:- module(LoginAndRegisterModule,[registerUserMenu/0, printGenres/0, checkEmail/1, loginMenu/0, valid_codes/1]).
:- use_module('../UserModule.pl').
:- use_module('../UtilModule.pl').
:- use_module('../CsvModule.pl').
:- use_module('../ValidInput/Validation.pl').
:- use_module('Favorites.pl').
:- use_module('MainMenu.pl').
:- use_module(library(readutil)).

loginMenu :-
centeredText('Login',40),
write('\n'),
write('Digite seu email: '),
write('\n'),
read_line_to_string(user_input, StringEmail),
write("\n"),
atom_string(ReadEmail, StringEmail),
getUsers(Users),
checkUserRegister(ReadEmail, Users,ActualUser),
checkLogin(ActualUser),

writeln("Digite a sua senha: "),
read_line_to_codes(user_input, StringPassword),
validar(StringPassword, ReadPassword),
checkUserPassword(ReadPassword, ActualUser, IsValidPassword),
checkPassword2(IsValidPassword),
printUserMenu(ActualUser),!.

registerUserMenu :-
centeredText("Cadastre-se",40),
writeln("\nDigite seu nome: "),
write('\n'),
read_line_to_string(user_input, StringName),
atom_string(ReadName, StringName),
writeln("\nDigite seu email: "),
write('\n'),
read_line_to_string(user_input, StringEmail),
atom_string(ReadEmail, StringEmail),
isValidEmail(ReadEmail, EmailResult),
checkEmailFormat(EmailResult),
getUsers(Users),
checkUserRegister(ReadEmail, Users,ListUser),
checkEmail(ListUser),

writeln("\nDigite sua senha: "),
write('\n'),
read_line_to_codes(user_input, StringPassword),
verificaIntegridadeSenha(StringPassword, ReadPassword),
isValidPassword(ReadPassword, PasswordResult),
checkPassword(PasswordResult),
printGenres,
readOptions(Numbers),
mapGenres(Numbers, ReadGenres),
addUser(ReadName, ReadEmail, ReadPassword, ReadGenres,[],[],[]),
getUsers(AtualUsers),
checkUserRegister(ReadEmail,AtualUsers, AtualUser),
printUserMenu(AtualUser),!.

printGenres:-

centeredText("Cadastre-se",63),
write("\nEscolha ate 5 generos literarios pelos seus respectivos numeros\nem ordem de preferencia e separados por espaços:\n1 - Ficcao\n2 - Fantasia\n3 - Infantil\n4 - Misterio\n5 - Historia\n6 - Aventura\n7 - Romance\n"), !.


checkEmail([]):- !.
checkEmail(_):- write("Este email ja esta cadastrado!\nEscolha outro:\n"), registerUserMenu,!.


checkEmailFormat('invalido'):- write("Este email nao e valido!\nEscolha outro\n"), registerUserMenu,!.

checkEmailFormat('valido'):- !.

checkPassword('invalido'):-  clearScreen ,write("A senha tem que conter no minimo 6 digitos!\nDigite novamente: \n"), registerUserMenu,!.

checkPassword('valido'):- !.

checkPassword2('invalida'):-  write("Senha incorreta!\nInsira seus dados novamente: \n"), loginMenu,!.

checkPassword2('valida'):- !.

checkLogin([]):-  write("Este email nao esta cadastrado no sistema!\nInsira seus dados novamente: \n"), loginMenu,!.
checkLogin(_) :- !.

verificaIntegridadeSenha(Numero, Number) :- 
valid_codes(Numero),
number_codes(Number, Numero). 
verificaIntegridadeSenha(Numero, _) :- \+ valid_codes(Numero), write("Senha inválida!, Ela deve conter apenas digitos!\n"), registerUserMenu, !.

validar(Numero, Number) :- 
valid_codes(Numero),
number_codes(Number, Numero). 
validar(Numero, _) :- \+ valid_codes(Numero), checkPassword2('invalida').

valid_codes(Codes) :-
    foreach(member(Code, Codes), valid_code(Code)).

valid_code(Code) :-
    Code >= 48, % Código ASCII para "0"
    Code =< 57. % Código ASCII para "9"

