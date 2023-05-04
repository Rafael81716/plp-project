module Modules.UserModule where

import Modules.CsvModule as CSV
import Model.User
import Modules.UtilModule (wordsWhen)
import Modules.BookModule as BookModule
import Data.Maybe
import Model.Book


registerUser :: String -> String -> String -> [String] -> [Book] -> IO ()
registerUser readName readEmail readPassword readGenres readBook = do
  let user = User readName readEmail readPassword readGenres readBook
  CSV.append [user] "users.csv"

userIsNotRegistered :: String -> IO Bool
userIsNotRegistered email = do
  maybeUser <- getUser email
  return $ isNothing maybeUser

getUser :: String -> IO (Maybe User)
getUser em = do
  userList <- CSV.read (\s -> Prelude.read s :: User) "users.csv"
  let user = filter (\u -> email u == em) userList

  case user of
    [] -> return Nothing
    (u:_) -> return (Just u)

loginUser :: String -> String -> IO (Maybe User)
loginUser em pass = do
  result <- getUser em

  case result of
    Nothing -> return Nothing
    Just user -> if password user == pass then return (Just user) else return Nothing


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
