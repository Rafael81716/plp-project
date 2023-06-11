:- module(RecommendationModule,[recommendation/2]).
:- use_module('./BookModule.pl').
:- use_module('./UtilModule.pl').

% Não funciona com User tendo algum forbiddenbook
recommendation(User, Recommendation):-
    nth0(6, User, DirtyForbiddenBooksId),
    nth0(3, User, DirtyBookGenres),
    length(DirtyBookGenres, DirtyBookGenresLen),
    length(DirtyForbiddenBooksId, DirtyForbiddenBooksIdLen),

    (DirtyBookGenresLen > 0 -> nth0(0, DirtyBookGenres, TempBooksGenres);TempBooksGenres = "" ),
    (DirtyForbiddenBooksIdLen > 0 -> nth0(0, DirtyForbiddenBooksId, TempForbiddenBooksId);TempForbiddenBooksId = "" ),
    
    (TempForbiddenBooksId = "" -> ForbiddenBooksId = [];split_string(TempForbiddenBooksId, ",", "", ForbiddenBooksId)),
    (TempBooksGenres = "" -> BooksGenres = [];split_string(TempBooksGenres, ",", "", BooksGenres)),

    (BooksGenres = [] ->
    randomRecommendation(ForbiddenBooksId, Recommendation)
    ; customRecommendation(ForbiddenBooksId, BooksGenres, Recommendation)).

getNotForbiddenList(ForbiddenBooksId, SafeAllIds):-
    range(1, 204, AllIds),
    (ForbiddenBooksId = [] -> 
        SafeAllIds = AllIds
        ;
        removeFrom(AllIds, ForbiddenBooksId, SafeAllIds)).

randomRecommendation(ForbiddenBooksId, Recommendation):-
    getNotForbiddenList(ForbiddenBooksId, SafeAllIds),
    getRandomElements(SafeAllIds, 10, RandomIds),
    getBooksById(RandomIds, Recommendation).

customRecommendation(ForbiddenBooksId, BooksGenres, Recommendation):-
    getNotForbiddenList(ForbiddenBooksId, SafeAllIds),
    getBooksById(SafeAllIds, BookSource),
    
    length(BooksGenres, GenreAmount),
    AmountPerGenre is max(1, 10 // GenreAmount),
    
    getRandomBooksFromGenres(BookSource, BooksGenres, AmountPerGenre, TempRecommendation),

    length(TempRecommendation, Len),
    nth0(0, BooksGenres, FavoriteGenre),
    MissingBooks is 10 - Len,
    
    (MissingBooks > 0 ->
    getRandomBooksByGenre(BookSource, FavoriteGenre, MissingBooks, RemainingBooks),
    append(RemainingBooks, TempRecommendation, Recommendation)
    ;
    Recommendation = TempRecommendation).

getRandomBooksFromGenres(_, [], _, []):-!.
getRandomBooksFromGenres(BookSource, [H | T], AmountPerGenre, RandomBooksByGenre):-
    getRandomBooksByGenre(BookSource, H, AmountPerGenre, BooksByGenre),
    getRandomBooksFromGenres(BookSource, T, AmountPerGenre, RandomBooksByGenreAux),
    append(BooksByGenre, RandomBooksByGenreAux, RandomBooksByGenre),!.

getRandomBooksByGenre(BookSource, Genre, Amount, Books):-
    getBooksFromSourceByGenre(BookSource, Genre, BooksByGenre),
    getRandomElements(BooksByGenre, Amount, Books),!.