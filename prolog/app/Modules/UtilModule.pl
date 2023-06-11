:- module(UtilModule,[centeredText/2, clearScreen/0, readOptions/1,mapGenres/2, listToString/2, toUpperCase/2, stringToChar/2,charToNum/2,waitOnScreen/0, getRandomElements/3, removeFrom/3, range/3, removeElement/3, numberToString/2]).

getRandomElements(_, 0, []).
getRandomElements(List, N, [Element | Elements]) :-
    N > 0,
    length(List, Length),
    UpperLimit is Length - 1,
    random(0, UpperLimit, Index),
    nth0(Index, List, Element),
    N1 is N - 1,
    delete(List, Element, UpdatedList),
    getRandomElements(UpdatedList, N1, Elements).

range(Start, End, List) :-
    Start =< End,
    rangeHelper(Start, End, [], List).

rangeHelper(End, End, Acc, [End|Acc]).
rangeHelper(Start, End, Acc, List) :-
    Start < End,
    NewStart is Start + 1,
    rangeHelper(NewStart, End, [Start|Acc], List).

numberToString(Numero, String) :-
    number_codes(Numero, Codigo),
    string_codes(String, Codigo).

removeElement(_, [], []):- !.
removeElement(Elemento, [Elemento|Resto], Resto) :-!.
removeElement(Elemento, [Cabeca|Resto], [Cabeca|NovaLista]) :-
    removeElement(Elemento, Resto, NovaLista),!.

charToNum(Caractere, Numero) :-
    char_code(Caractere, Codigo),
    Numero is Codigo - 48.

stringToChar(String, Caractere) :-
    string_chars(String, [Caractere|_]).


centeredText(Text, Width) :-
    string_length(Text, Length),
    Line1SpacesBefore is (Width - Length) // 2,
    Line1SpacesAfter is Width - Length - Line1SpacesBefore,
    write_dashed_line(Width),
    nl,
    write_spaces(Line1SpacesBefore),
    write(Text),
    write_spaces(Line1SpacesAfter),
    nl,
    write_dashed_line(Width),!.

write_dashed_line(Width) :-
    Width > 0,
    write('-'),
    Width1 is Width - 1,
    write_dashed_line(Width1),!.
write_dashed_line(0):-!.

write_spaces(N) :-
    N > 0,
    write(' '),
    N1 is N - 1,
    write_spaces(N1),!.
write_spaces(0):-!.


clearScreen :-
    current_prolog_flag(windows, true), !,
    shell('cls'),!.

clearScreen :-
    current_prolog_flag(unix, true), !,
    shell('clear'),!.


readOptions([Number| Rest]) :-
    read(Number),
    Number \= -1,
    readOptions(Rest), !.
readOptions([]):-!.


mapGenres([], []):-!.
mapGenres([1|T], ['Ficcao'|MappedTail]) :-
    mapGenres(T, MappedTail),!.
mapGenres([2|T], ['Fantasia'|MappedTail]) :-
    mapGenres(T, MappedTail),!.
mapGenres([3|T], ['Infantil'|MappedTail]) :-
    mapGenres(T, MappedTail),!.
mapGenres([4|T], ['Misterio'|MappedTail]) :-
    mapGenres(T, MappedTail),!.
mapGenres([5|T], ['Historia'|MappedTail]) :-
    mapGenres(T, MappedTail),!.
mapGenres([6|T], ['Aventura'|MappedTail]) :-
    mapGenres(T, MappedTail),!.
mapGenres([7|T], ['Romance'|MappedTail]) :-
    mapGenres(T, MappedTail),!.
mapGenres([_|T], MappedList) :-
    mapGenres(T, MappedList),!.

listToString(List, String) :-
    atomic_list_concat(List, ',', String),!.

toUpperCase(String, StringMaiuscula) :-
    atom_string(Atom, String),
    upcase_atom(Atom, AtomMaiusculo),
    atom_string(AtomMaiusculo, StringMaiuscula),!.

waitOnScreen:-
    write("Digite Enter para continuar:\n"),
    get_char(_),
    get_char(_),!.

removeFrom([], _, []).
removeFrom([X|Xs], RemoveList, Result) :-
    removeFrom(Xs, RemoveList, Temp),

    (contains(X, RemoveList) -> 
        Result = Temp
        ;
        Result = [X | Temp]),!.

contains(_, []):-!, fail.
contains(X, [Y|Ys]):-
    atom_number(Y, YNumber),

    (X == YNumber -> true
    ;
    contains(X, Ys)).
