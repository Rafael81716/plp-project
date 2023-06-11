:- module(RecommendationModule,[recommendation/2]).
:- use_module('./BookModule.pl').
:- use_module('./UtilModule.pl').


recommendation(User, Recommendation):-
    nth0(6, User, ForbiddenBooksId),
    nth0(3, User, BooksGenres),

    (BooksGenres = [] ->
    randomRecommendation(ForbiddenBooksId, Recommendation)
    ; customRecommendation(ForbiddenBooksId, BooksGenres, Recommendation)).

getNotForbiddenList(ForbiddenBooksId, SafeAllIds):-
    range(1, 204, AllIds),
    removeDoubles(AllIds, ForbiddenBooksId, SafeAllIds).

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