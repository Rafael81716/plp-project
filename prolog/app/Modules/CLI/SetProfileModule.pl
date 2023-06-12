:- module(SetProfileModule, [printSetProfile/1]).
:- use_module("MainMenu.pl").
:- use_module("../UtilModule.pl").
:- use_module("LoginAndRegisterModule.pl").
:- use_module("../ValidInput/Validation.pl").
:- use_module("../CsvModule.pl").
:- use_module("../UserModule.pl").

printSetProfile(User):-
    centeredText("Editar Perfil", 63),
    % NOME ============================================
    getName(ReadName),
    % EMAIL ============================================
    nth0(1, User, UserEmail),
    getEmail(UserEmail, ReadEmail),
    % PASSWORD =========================================
    getPassword(ReadPassword),
    % GENRE ============================================
    getGenre(ReadGenres),


    attUserEmail(User, ReadEmail),
    getUsers(Users),
    checkUserRegister(ReadEmail, Users, ActualUser),

    attUserName(ActualUser, ReadName),
    getUsers(Users1),
    checkUserRegister(ReadEmail, Users1, ActualUser2),

    attUserPassword(ActualUser2, ReadPassword),
    getUsers(Users2),
    checkUserRegister(ReadEmail, Users2, ActualUser3),

    attUserListGenres(ActualUser3, ReadGenres),

    getUsers(Users3),
    checkUserRegister(ReadEmail, Users3, ActualUser4),

    printUserMenu(ActualUser4).

getName(Name):-
    writeln("\nDigite seu novo nome: "),
    read_line_to_string(user_input, StringName),
    atom_string(ReadName, StringName),

    string_length(ReadName, Len),

    (Len > 3, isValidName(ReadName) ->
        Name = ReadName
        ;
        writeln("Nome invalido, tente novamente!"),
        getName(Name)).

getPassword(Password):-
    writeln("\nDigite sua nova senha: "),
    read_line_to_codes(user_input, PasswordCodes),
    isValidPassword(PasswordCodes, PasswordResult),

    (PasswordResult == 'valido', valid_codes(PasswordCodes) ->
        atom_codes(StringPassword, PasswordCodes),
        Password = StringPassword
        ;
        writeln("Senha invalida, tente novamente!"),
        getPassword(Password)).

getEmail(UserEmail, Email):-
    writeln("\nDigite seu novo email: "),
    read_line_to_string(user_input, StringEmail),
    atom_string(ReadEmail, StringEmail),

    getUsers(Users),
    checkUserRegister(ReadEmail, Users, ListUser),
    isValidEmail(ReadEmail, EmailResult),

    (EmailResult == 'valido', checkEmail(UserEmail, ListUser) ->
        Email = ReadEmail
        ;
        writeln("Email inválido ou em uso, tente novamente!"),
        getEmail(UserEmail, Email)).

getGenre(Genres):-
    printGenres,
    readOptions(Numbers),
    mapGenres(Numbers, Genres).

checkEmail(_, []):- true.
checkEmail(Email, [_, Email | _]):- true.
checkEmail(UserEmail, [_, Email | _]):- false.

printGenres:-

centeredText("Editar perfil",63),
write("\nEscolha ate 5 generos literarios pelos seus respectivos numeros\nem ordem de preferencia e separados por espaços:\n1 - Ficcao Cientifica\n2 - Fantasia\n3 - Infantil\n4 - Misterio\n5 - Historia\n6 - Aventura\n7 - Romance\n"), !.
