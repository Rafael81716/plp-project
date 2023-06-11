:- module(MainMenuModule,[printMainMenu/0, readMainMenu/1,printUserMenu/1,readUserMenu/2]).
:- use_module("../UtilModule.pl").
:- use_module("LoginAndRegisterModule.pl").
:- use_module("Loan.pl").
:- use_module("../../Data/Data.pl").
:- use_module("../ValidInput/Validation.pl").
:- use_module("../BookModule.pl").
:- use_module("Historic.pl").
:- use_module('Favorites.pl').
:- use_module("../UserModule.pl").
:- use_module("SetProfileModule.pl").
:- use_module(library(readutil)).


printMainMenu:-
verifyFileExists('Data/users.csv'),
centeredText("Inicio",40),
writeln("\n1 - Entrar\n2 - Cadastrar\nEscolha uma opcao: "),
read_line_to_codes(user_input ,StringOption),
verificaIntegridadeOption(StringOption, Option),
readMainMenu(Option),!.

readMainMenu(Option):- Option =:= 1, %clearSc, 
loginMenu.
readMainMenu(Option):- Option =:= 2, %clearSc, 
registerUserMenu,!.
readMainMenu(Option):- Option \== 1, Option \== 2, write("Opcao invalida, digite novamente!\n"), printMainMenu,!.


checkOption(User,Option):- Option < 1, write("\nOpcao invalida!\nDigite novamente: \n"), printUserMenu(User),!.
checkOption(User,Option):- Option > 11, write("\nOpcao invalida!\nDigite novamente: \n"), printUserMenu(User),!.
checkOption(User,Option):- Option >= 1, Option =< 11,!.

verificaIntegridadeOption(Numero, Number) :- 
valid_codes(Numero),
number_codes(Number, Numero). 
verificaIntegridadeOption(Numero, _) :- \+ valid_codes(Numero), readMainMenu(5).



printUserMenu(User):- 
centeredText("Menu Principal",63),
write("\n1 - Realizar Emprestimo\n2 - Ver livros emprestados\n3 - Devolver livro\n4 - Ver todos os livros do sistema\n5 - Exibir recomendacoes\n6 - Cadastrar favoritos\n7 - Remover favoritos\n8 - Listar favoritos\n9 - Exibir historico de leitura\n10 - Editar Perfil\n11 - Logout\nEscolha uma opcao: "),
read_line_to_codes(user_input, StringOption),
verificaIntegridadeUserOption(StringOption, Option, User),
checkOption(User, Option),
readUserMenu(Option, User),!.


readUserMenu(1, User):- printMakeLoan(User),!. 
readUserMenu(2, User):- printAllLoans(User),!. 
readUserMenu(3, User):- printReturnBook(User),!. 
readUserMenu(4, User):- printBooksMenu(User),!. 
readUserMenu(5, User):- write('todo 5'),!. 
readUserMenu(6, User):- registerFavorite(User),!. 
readUserMenu(7, User):- removeFavorite(User),!. 
readUserMenu(8, User):- listFavorites(User),!. 
readUserMenu(9, User):- printHistoric(User),!. 
readUserMenu(10, User):- printSetProfile(User),!. 
readUserMenu(11, User):- write("tchau tchau \n"),abort,!.


verificaIntegridadeUserOption(Numero, Number, User) :- 
valid_codes(Numero),
number_codes(Number, Numero). 
verificaIntegridadeUserOption(Numero, _, User) :- \+ valid_codes(Numero), write("Opção inválida!, Digite novamente!\n"), printUserMenu(User), !.