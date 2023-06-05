:- module(MainMenuModule,[printMainMenu/0, readMainMenu/2,printUserMenu/1,readUserMenu/2]).
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

printUserMenu(User):- 
centeredText("Menu Principal",63),
write("1 - Realizar Emprestimo\n2 - Ver livros emprestados\n3 - Devolver livro\n4 - Ver todos os livros do sistema\n5 - Exibir recomendacoes\n6 - Cadastrar favoritos\n7 - Remover favoritos\n8 - Listar favoritos\n9 - Exibir historico de leitura\n10 - Editar Perfil\n11 - Logout\nEscolha uma opcao: "),
read(Option),
readUserMenu(Option, User).

readUserMenu(1, User):- write('todo 1'),!. 
readUserMenu(2, User):- write('todo 2'),!. 
readUserMenu(3, User):- write('todo 3'),!. 
readUserMenu(4, User):- write('todo 4'),!. 
readUserMenu(5, User):- write('todo 5'),!. 
readUserMenu(6, User):- write('todo 6'),!. 
readUserMenu(7, User):- write('todo 7'),!. 
readUserMenu(8, User):- write('todo 8'),!. 
readUserMenu(9, User):- write('todo 9'),!. 
readUserMenu(10, User):- write('todo 10'),!. 
readUserMenu(11, User):- write('todo 11'),!. 

