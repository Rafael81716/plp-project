:- module(ValidationModule,[isValidEmail/1, isValidPassword/1]).
:- use_module("../UtilModule.pl").

isValidEmail(Email):-
    ValidDomainList = ["gmail.com", "hotmail.com", "ccc.ufcg.edu.br", "estudante.ufcg.edu.br", "outlook.com", "yahoo.com"],
    string_chars(Email, EmailChars),
    countCharInString(EmailChars, '@', Count),
    (Count == 1 ->
        split_string(Email, '@', '', [Username, Domain]),
        member(Domain, ValidDomainList),
        string_chars(Username, UsernameChars),
        length(UsernameChars, Len),
        Len >= 3
        ;
        false),!.

isValidPassword(Password):-
    string_chars(Password, Chars),
    length(Chars, Len),
    Len >= 6.

isValidName(Name) :-
    \+ (atom_chars(Name, Chars), member(Char, Chars), char_type(Char, digit)).

isValidIndex(_, []).
isValidIndex(N, [X|Xs]) :-
    N \= X,
    isValidIndex(N, Xs).

isValidSize([]).
isValidSize(L1) :-
    length(L1, Len),
    Len < 10.

%isValidGenre :: String -> Bool
%isValidGenre genre = do
%  let genreList = words genre
%  let validSize = length genreList <= 5
%  let validChoices = all (\num -> num >= 1 && num <= 7) (map read genreList :: [Int])
%  validSize && validChoices
%
%filterUserList :: String -> [User] -> [User]
%filterUserList _ [] = []
%filterUserList em (x : xs) =
%  if email x == em
%    then filterUserList em xs
%    else x : filterUserList em xs
%