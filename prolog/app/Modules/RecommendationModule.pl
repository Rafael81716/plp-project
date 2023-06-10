:- module(RecommendationModule,[recommendation/2]).
:- use_module('./BookModule.pl').
:- use_module('./UtilModule.pl').


recommendation(User, Recommendation):-
    nth0(6, User, ForbbidenBooksId),
    getBooksById(ForbbidenBooksId, ForbbidenBooks),
    nth0(3, User, BooksGenres),

    (BooksGenres = [] ->
    randomRecommendation(ForbbidenBooks, Recommendation)
    ; custom_recommendation(ForbbidenBooks, Recommendation)).

randomRecommendation(ForbbidenBooks, Recommendation):-
    generateRandomNumbers(10, 1, 204, RandomNumbers),
    getBooksById(RandomNumbers, RandomBooks),
    removeDoubles(RandomBooks, ForbbidenBooks, Recommendation).

customRecommendation(ForbbidenBooks, Recommendation):-
    write('TODO').