:- module(HistoricModule, []).

printAddToHistoric(User, Book) :-
    nth1(7, User, Historic),
    checkIsValidSize(User, Historic),

    writeln('Voce leu esse livro?\n'),
    write('Digite <1> para Sim ou <2> para Não: '),
    read(IsRead),
    nth1(1, Book, Id),
    bookHistoric(User, Id, IsRead),!.

checkIsValidSize(User, Historic):-!.