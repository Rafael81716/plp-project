module Modules.UserModule where

import Data.List
import Data.Maybe
import Model.User as User
import Modules.BookModule
import Modules.CsvModule as CSV
import Modules.UtilModule (wordsWhen)

registerUser :: String -> String -> String -> [String] -> [Int] -> IO ()
registerUser readName readEmail readPassword readGenres readFavorites = do
  let user = User readName readEmail readPassword readGenres readFavorites
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
    (u : _) -> return (Just u)

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
treatFavorites [] = ""
treatFavorites (x : xs) = show (num x) ++ " - " ++ showBookName x ++ "\n" ++ treatFavorites xs

returnFavoriteBooks :: [Int] -> IO [Book]
returnFavoriteBooks [] = return []
returnFavoriteBooks (x : xs) = do
  livro <- getBookById x
  livros <- returnFavoriteBooks xs
  let result = livro ++ livros
  return result

editEmail :: User -> String -> IO User
editEmail user newEmail = do
  let newUser = User (User.name user) newEmail (password user) (bookGenres user) (favoriteBooks user)
  updateUser user newUser
  return newUser

editName :: User -> String -> IO User
editName user newName = do
  let newUser = User newName (email user) (password user) (bookGenres user) (favoriteBooks user)
  updateUser user newUser
  return newUser

editPassword :: User -> String -> IO User
editPassword user newPassword = do
  let newUser = User (User.name user) (email user) newPassword (bookGenres user) (favoriteBooks user)
  updateUser user newUser
  return newUser

updateUser :: User -> User -> IO User
updateUser user newUser = do
  allUsers <- getUserList
  let updatedAllUsers = map (\u -> if email u == email user then newUser else u) allUsers
  CSV.write updatedAllUsers "users.csv"
  return user
