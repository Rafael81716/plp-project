:- module(ValidationModule,[isValidEmail/2, isValidPassword/2, isValidSize/2, isValidName/1]).
:- use_module("../UtilModule.pl").

validDomain("gmail.com"):-!.
validDomain("hotmail.com"):- !.
validDomain("ccc.ufcg.edu.br"):- !.
validDomain("estudante.ufcg.edu.br"):- !.
validDomain("outlook.com"):- !.
validDomain("yahoo.com"):- !.


isValidEmail(Email, Result) :-
    split_string(Email, "@", "", [_, Domain]),
    validDomain(Domain),
    Result = 'valido',!.

isValidEmail(_, Result) :-
    Result = 'invalido',!.


isValidPassword(Password, Result):- string_length(Password, Size), Size < 6, Result = 'invalido',!.
isValidPassword(Password,Result):- string_length(Password, Size), Size >= 6, Result = 'valido',!.

isValidName(Name) :-
    \+ (atom_chars(Name, Chars), member(Char, Chars), char_type(Char, digit)),!.

isValidIndex(_, []).
isValidIndex(N, [X|Xs]) :-
    N \= X,
    isValidIndex(N, Xs),!.


isValidSize(L, R) :-
length(L, Size),
Size =< 9,  R = 'valido',!.

isValidSize(_, R):- R = 'invalido',!.