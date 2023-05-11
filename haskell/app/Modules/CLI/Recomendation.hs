module Modules.CLI.Recomendation where

import Model.Book
import Model.User
import Modules.BookModule (getBookById)
import Modules.RecomendationModule(recomendation)
import Model.User (User (bookGenres))


printRecomendations:: User -> IO User
printRecomendations user = do
    recomendation user
   

-- recommend :: User -> IO [Book]
-- recommend (User _ _ _ [] _ _ _) = do
--     -- Gere um 10 números aleatório entre 1 e 21
--     randomBooksId <- sequence $ replicate 10 (randomRIO (1, 21)) :: IO [Int]
--     -- Busque o livro com esse id
--     getBookById randomBooksId
-- recommend u = do
--     let readBooks = recentBooks u
--     -- getBookById readBooks
--     let genres = bookGenres u
--     let allBooks = allBooksFromGenres genres
--     return $ filter (\book -> notElem book books) allBooks

-- Pegar todos os livros
-- Pegar todos os livros lidos
-- Remover todos os livros lidos da lista de todos os livros
-- Pegar os gêneros do usuário
--