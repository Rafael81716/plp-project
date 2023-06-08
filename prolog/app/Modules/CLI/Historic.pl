:- module(HistoricModule, []).

printAddToHistoric(User, Book) :-
    nth1(7, User, Historic),
    nth1(2, User, ActualEmail),
    checkIsValidSize(User, Historic, ActualHistoric),
    attUserHistoric(User, ActualHistoric),
    getUsers(Users),
    checkUserRegister(ActualEmail, Users, NewUsers),
    nth1(1,NewUsers, NewUser),
    
    writeln('Voce leu esse livro?\n'),
    write('Digite <1> para Sim ou <2> para Não: '),
    read(IsRead),
    nth1(1, Book, Id),
    bookHistoric(NewUser, Id, IsRead),!.

checkIsValidSize(User, Historic, ActualHistoric):-
    length(Historic, Size),
    Size <= 9,
    ActualHistoric = Historic, !.
checkIsValidSize(User, [H|T], ActualHistoric) :-
    length(Historic, Size),
    Size >= 10,
    ActualHistoric = T,!.
