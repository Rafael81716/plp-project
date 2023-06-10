:- module(MainMenuModule,[printMainMenu/0, readMainMenu/2,printUserMenu/1,readUserMenu/2]).
:- use_module("../UtilModule.pl").
:- use_module("LoginAndRegisterModule.pl").
:- use_module("Loan.pl").
:- use_module("../../Data/Data.pl").
:- use_module("../ValidInput/Validation.pl").
:- use_module("Historic.pl").
:- use_module('Favorites.pl').

printMainMenu:-
verifyFileExists('Data/users.csv'),
centeredText("Inicio",40),
write("\n1 - Entrar\n2 - Cadastrar\nEscolha uma opcao: "),
read(Option),
readMainMenu(Option),
write(R),!.

readMainMenu(Option):- Option =:= 1, loginMenu, !.
readMainMenu(Option):- Option =:= 2, registerUserMenu,!.
readMainMenu(_,R):- write("Opcao invalida, digite novamente!\n"), printMainMenu,!.

printUserMenu(User):- 
centeredText("Menu Principal",63),
write("\n1 - Realizar Emprestimo\n2 - Ver livros emprestados\n3 - Devolver livro\n4 - Ver todos os livros do sistema\n5 - Exibir recomendacoes\n6 - Cadastrar favoritos\n7 - Remover favoritos\n8 - Listar favoritos\n9 - Exibir historico de leitura\n10 - Editar Perfil\n11 - Logout\nEscolha uma opcao: "),
read(Option),
readUserMenu(Option, User),!.

readUserMenu(1, User):- printMakeLoan(User),!. 
readUserMenu(2, User):- printAllLoans(User),!. 
readUserMenu(3, User):- write('todo 3'),!. 
readUserMenu(4, User):- write('todo 4'),!. 
readUserMenu(5, User):- write('todo 5'),!. 
readUserMenu(6, User):- registerFavorite(User),!. 
readUserMenu(7, User):- removeFavorite(User),!. 
readUserMenu(8, User):- listFavorites(User),!. 
readUserMenu(9, User):- printBookHistoric(User),!. 
readUserMenu(10, User):- write('todo 10'),!. 
readUserMenu(11, User):- write("tchau tchau \n"),abort,!.
readUserMenu(_, User) :- write("Opcao invalida, digite novamente!\n"), printUserMenu(User),!.

