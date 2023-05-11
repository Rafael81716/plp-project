module Modules.RecomendationModule where

import Data.List (nub)
import Data.Typeable
import Model.Book
import Model.User
import Modules.BookModule (getAllBooks, getBookByGenre, getBookById, getBookByIdSorted, printBooks)
import Modules.UtilModule (centeredText, clear, waitOnScreen)
import System.Console.ANSI
import System.Random

recomendation :: User -> IO [Book]
recomendation u = do
  allBooks <- getAllBooks
  if (bookGenres u) == []
    then randomRecomendation
    else do
      let genres = bookGenres u
      let booksPerGenre = floor (10.0 / fromIntegral (length genres))
      result <- getRandomBooksFromGenres genres booksPerGenre
      let missingBooks = 10 - (length result)
      restOfBooks <- getRandomBooksFromGenres [(head genres)] missingBooks
      let concatenatedList = concat [restOfBooks, result]
      return concatenatedList

randomRecomendation :: IO [Book]
randomRecomendation = do
  -- Gere um 10 números aleatório entre 1 e 204
  randomBooksId <- sequence $ replicate 10 (randomRIO (1, 204)) :: IO [Int]
  -- Busque o livro com esse id
  getBookById randomBooksId

getRandomBooksFromGenres :: [String] -> Int -> IO [Book]
getRandomBooksFromGenres genres amount = do
  let allBooksByEachGenre = map (\g -> getRandomBooksByGenre g amount) genres
  flatten allBooksByEachGenre

flatten :: [IO [Book]] -> IO [Book]
flatten [] = return []
flatten (x : xs) = do
  x' <- x
  xs' <- flatten xs
  return (x' ++ xs')

getRandomBooksByGenre :: String -> Int -> IO [Book]
getRandomBooksByGenre genre amount = do
  allBooksByGenre <- getBookByGenre genre
  result <- getNRandomBooks allBooksByGenre amount
  return result

getNRandomBooks :: [Book] -> Int -> IO [Book]
getNRandomBooks bookList n = do
  gen <- newStdGen
  let randomBooksIdx = take n $ nub $ randomRs (0, (length bookList) - 1) gen :: [Int]
  let randomBooks = filterByIndex bookList randomBooksIdx 0
  return randomBooks

filterByIndex :: [Book] -> [Int] -> Int -> [Book]
filterByIndex [] _ _ = []
filterByIndex (x : xs) indexes idx = do
  if idx `elem` indexes
    then x : filterByIndex xs indexes (idx + 1)
    else filterByIndex xs indexes (idx + 1)

getBookByIdFromSource :: [Book] -> [Int] -> IO [Book]
getBookByIdFromSource bookList targets = do
  let result = filter (\u -> num u `elem` targets) bookList
  return result
