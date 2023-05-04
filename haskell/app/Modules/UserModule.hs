module Modules.UserModule where

import Modules.CsvModule as CSV
import Model.User
import Modules.UtilModule (wordsWhen)
import Modules.BookModule as BookModule
import Data.Maybe
<<<<<<< HEAD
import Modules.BookModule
import Data.List

registerUser :: String -> String -> String -> [String] -> [Int]  -> [Int] -> IO ()
registerUser readName readEmail readPassword readGenres readFavorites readBooksLoan = do
  let user = User readName readEmail readPassword readGenres readFavorites readBooksLoan
=======
import Model.Book


registerUser :: String -> String -> String -> [String] -> [Book] -> IO ()
registerUser readName readEmail readPassword readGenres readBook = do
  let user = User readName readEmail readPassword readGenres readBook
>>>>>>> 58e506ba67210db64f5089fba639e86aa0016899
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

<<<<<<< HEAD
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

makeLoanByTitle:: User -> String -> IO()
makeLoanByTitle user title = do 
  print("entrou")
=======

makeLoanByTitle:: User -> String -> IO()
makeLoanByTitle user title = do
  book2 <- BookModule.getBookByName title
<<<<<<< HEAD
  registerUser (nameUser user) (email user) (password user) (bookGenres user) book2
  print ("Emprestimo realizado com sucesso!")
=======
  registerUser (nameUser user) (email user) (password user) (bookGenres user) (books user ++ book2)
  print("Empréstimo Realizado com Sucesso!")


  



>>>>>>> d31bff4afd6a8689076c072e7b60d2815daa6118
>>>>>>> 58e506ba67210db64f5089fba639e86aa0016899
