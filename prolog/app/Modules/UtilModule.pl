:- module(UtilModule,[centeredText/2, clearScreen/0, readOptions/1,mapGenres/2, listToString/2, toUpperCase/2, stringToChar/2,charToNum/2,waitOnScreen/0,removeElement/3, numberToString/2,clearSc/0,reverseList/2]).
:- use_module(library(readutil)).
:- use_module('CLI/LoginAndRegisterModule.pl').
:- use_module(library(ansi_term)).

numberToString(Numero, String) :-
    number_codes(Numero, Codigo),
    string_codes(String, Codigo).

removeElement(_, [], []):- !.
removeElement(Elemento, [Elemento|Resto], Resto) :-!.
removeElement(Elemento, [Cabeca|Resto], [Cabeca|NovaLista]) :-
    removeElement(Elemento, Resto, NovaLista),!.


reverseList([], []).
reverseList([X|Xs], Reversed) :-
    reverseList(Xs, ReversedTail),
    append(ReversedTail, [X], Reversed).


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
    format('\e[32m~w\e[0m',[Text]),
    write_spaces(Line1SpacesAfter),
    nl,
    write_dashed_line(Width),!.

write_dashed_line(Width) :-
    Width > 0,
    Text = '-',
    format('\e[32m~w\e[0m',[Text]),
    Width1 is Width - 1,
    write_dashed_line(Width1),!.
write_dashed_line(0):-!.

write_spaces(N) :-
    N > 0,
    write(' '),
    N1 is N - 1,
    write_spaces(N1),!.
write_spaces(0):-!.

clearSc :- shell(clear).

clearScreen :-
    current_prolog_flag(windows, true),
    shell('cls'),!.

clearScreen :-
    current_prolog_flag(unix, true),
    shell('clear'),!.



readOptions(ListaNumeros) :-
    write('Digite os números separados por espaços: '),
    read_line_to_codes(user_input, Entrada),
    (Entrada = [] ->
        ListaNumeros = []
    ;   split_string(Entrada, " ", "", Palavras),
        (validar_numeros(Palavras, ListaNumeros) ->
            validar_letras(ListaNumeros)
        ;   write('Entrada inválida. Digite apenas números entre 1 e 7, separados por espaços.'), nl,
            readOptions(ListaNumeros)
        )
    ).

validar_numeros([], []).
validar_numeros([Palavra|Palavras], [Numero|Numeros]) :-
    atom_number(Palavra, Numero),
    Numero >= 1,
    Numero =< 7,
    validar_numeros(Palavras, Numeros).

validar_letras(ListaNumeros) :-
    (contains_letters(ListaNumeros) ->
        write('A entrada não pode conter letras.'), nl,
        readOptions(ListaNumeros)
    ;   verificar_tamanho(ListaNumeros)
    ).

contains_letters(ListaNumeros) :-
    member(Elemento, ListaNumeros),
    atom(Elemento),
    not(number(Elemento)).

verificar_tamanho(ListaNumeros) :-
    length(ListaNumeros, Len),
    (Len > 5 ->
        write('A lista não pode conter mais de 5 números.'), nl,
        readOptions(ListaNumeros)
    ;   true
    ).

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
    read_line_to_string(user_input, _),!.
