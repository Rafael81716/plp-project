:-module(LoginAndRegister, [readLoginOrRegister/0,loginOrRegisterMenu/0]).
:-use_module('../UtilModule').

readLoginOrRegister(Option, "Logar"):- Option =:= 1,!.
readLoginOrRegister(Option, "Cadastrar"):- Option =:= 2,!.
readLoginOrRegister(_,"Opcao invalida"):- write("Opcao invalida, digite novamente!\n"),clear,loginOrRegisterMenu.



loginOrRegisterMenu:-
write("1 - Entrar\n2 - Cadastrar\nEscolha uma opcao: "),
read(Option),
readLoginOrRegister(Option,Return),
write(Return),
halt.