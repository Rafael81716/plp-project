:- module(UtilModule,[centeredText/2, clearScreen/0]).

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
    write_dashed_line(Width).

write_dashed_line(Width) :-
    Width > 0,
    write('-'),
    Width1 is Width - 1,
    write_dashed_line(Width1).
write_dashed_line(0).

write_spaces(N) :-
    N > 0,
    write(' '),
    N1 is N - 1,
    write_spaces(N1).
write_spaces(0).


clearScreen :-
    current_prolog_flag(windows, true), !,
    shell('cls').

clearScreen :-
    current_prolog_flag(unix, true), !,
    shell('clear').




