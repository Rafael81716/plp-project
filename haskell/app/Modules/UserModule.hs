{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
module Modules.UserModule where

import Modules.CsvModule as CSV
import Model.User
import Model.Book
import Modules.UtilModule (wordsWhen)
import Data.Maybe
import Modules.BookModule
import Data.List
import Model.User (User(bookGenres))
import System.IO (putStrLn)
import Modules.ValidInput.Validation (filterUserList)


registerUser :: String -> String -> String -> [String] -> [Int]  -> [Int] -> [Int] -> IO ()
registerUser readName readEmail readPassword readGenres readFavorites readBooksLoan readBooksHistoric = do
  let user = User readName readEmail readPassword readGenres readFavorites readBooksLoan readBooksHistoric
  CSV.append [user] "users.csv"

userIsNotRegistered :: String -> IO Bool
userIsNotRegistered email = do
  maybeUser <- getUser email
  return $ isNothing maybeUser

getUser :: String -> IO (Maybe User)
getUser em = do
  userList <- CSV.read "users.csv"
  let user = filter (\u -> email u == em) userList

  case user of
    [] -> return Nothing
    (u:_) -> return (Just u)

getUserList :: IO [User]
getUserList = CSV.read "users.csv"

loginUser :: String -> String -> IO (Maybe User)
loginUser em pass = do
  result <- getUser em

  case result of
    Nothing -> return Nothing
    Just user -> if password user == pass then return (Just user) else return Nothing

showFavorites :: User -> IO String
showFavorites user = do
  let favorites = sort (favoriteBooks user)
  books <- returnFavoriteBooks favorites
  let result = treatFavorites books
  return result

treatFavorites :: [Book] -> String
treatFavorites []  = ""
treatFavorites (x:xs) = show (num x) ++ " - " ++ showBookName x ++ "\n" ++ treatFavorites xs

returnFavoriteBooks :: [Int] -> IO [Book]
returnFavoriteBooks [] = return []
returnFavoriteBooks (x:xs) = do
  livro <- getBookById x
  livros <- returnFavoriteBooks xs
  let result = livro ++ livros
  return result

makeLoanByTitle:: User -> Int -> IO()
makeLoanByTitle user bookId = do
  let newBooks = (booksLoan user) ++ [bookId]
  let actualUser = User (nameUser user) (email user) (password user) (bookGenres user) (favoriteBooks user) newBooks (booksHistoric user)

  userList <- getUserList
  let newList = actualUser:filterUserList (email user) userList
  writeFile "users.csv" ""
  CSV.append newList "users.csv"
  putStrLn "Livro emprestado com sucesso!"

addToHistoric :: User -> Int -> IO()
addToHistoric user bookId = do
  let newBooks = (booksHistoric user) ++ [bookId]
  let actualUser = User (nameUser user) (email user) (password user) (bookGenres user) (favoriteBooks user) (booksLoan user) newBooks

  userList <- getUserList
  let newList = actualUser:filterUserList (email user) userList
  writeFile "users.csv" ""
  CSV.append newList "users.csv"
  putStrLn "Livro Adicionado ao Historico de Leitura!"

printHistoricBooks :: [Int] -> IO()
printHistoricBooks  (x:xs)
  | null (x:xs) = putStrLn ""
  | null xs = do
    book <- getBookById x
    putStrLn (printAllBooks book)
  | otherwise = do
    book <- getBookById x
    putStrLn (printAllBooks book)
    printHistoricBooks xs