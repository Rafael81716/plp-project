:- module(ValidationModule,[isValidEmail/2, isValidPassword/2, isValidSize/2, isValidName/1, validationName/1]).
:- use_module("../UtilModule.pl").


validationName(Name) :-
    atomic(Name),               % Verifica se o argumento é um átomo
    atom_length(Name, Size), % Obtém o comprimento do átomo
    Tamanho > 0,                % O tamanho do Name deve ser maior que zero
    atom_chars(Name, Chars),    % Divide o átomo em uma lista de caracteres
    validar_chars(Chars).       % Verifica se os caracteres são válidos

validar_chars([]).                % Caso base: lista vazia
validar_chars([Char | Resto]) :-
    char_type(Char, alpha),      % Verifica se o caractere é uma letra
    validar_chars(Resto).        % Verifica o restante da lista




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