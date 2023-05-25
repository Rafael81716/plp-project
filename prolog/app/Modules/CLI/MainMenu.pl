:- module(MainMenuModule,[printMainMenu/0, readMainMenu/2]).
:- use_module("../UtilModule.pl").

printMainMenu:-
centeredText("Inicio",40),
write("\n1 - Entrar\n2 - Cadastrar\nEscolha uma opcao: "),
read(Option),
readMainMenu(Option,R),
write(R).

readMainMenu(Option,"todo login"):- Option =:= 1,!.
readMainMenu(Option,"todo register"):- Option =:= 2,!.
readMainMenu(_,R):- clearScreen,write("Opcao invalida, digite novamente!\n"), printMainMenu.