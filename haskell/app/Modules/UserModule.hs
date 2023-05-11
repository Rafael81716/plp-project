module Modules.UserModule where

import Data.List
import Data.Maybe
import Model.Book as Book
import Model.User as User
import Modules.BookModule
import Modules.CsvModule as CSV
import Modules.UtilModule (centeredText, removeFromList)
import Modules.ValidInput.Getter (getIsRead)
import Modules.ValidInput.Validation (filterUserList, isValidIndex, isValidSize)

registerUser :: String -> String -> String -> [String] -> [Int] -> [Int] -> [Int] -> IO User
registerUser n e p g fB bL rB = do
  let user = User n e p g fB bL rB
  CSV.append [user] "users.csv"
  return user

userIsNotRegistered :: String -> IO Bool
userIsNotRegistered email = do
  maybeUser <- getUser email
  return $ isNothing maybeUser

getUser :: String -> IO (Maybe User)
getUser em = do
  userList <- getUserList
  let user = filter (\u -> email u == em) userList

  case user of
    [] -> return Nothing
    (u : _) -> return (Just u)

getUserList :: IO [User]
getUserList = CSV.read strToUser "users.csv"

loginUser :: String -> String -> IO (Maybe User)
loginUser e p = do
  result <- getUser e

  case result of
    Nothing -> return Nothing
    Just user -> if password user == p then return (Just user) else return Nothing

listFavorites :: User -> IO String
listFavorites u = do
  favorites <- getFavorites u
  let result = map bookToNumName favorites
  return (intercalate "\n" result)

getFavorites :: User -> IO [Book]
getFavorites u = do
  allBooks <- getAllBooks
  let favorites = favoriteBooks u
  let result = filter (\b -> num b `elem` favorites) allBooks
  return result

makeLoanByTitle :: User -> Int -> IO User
makeLoanByTitle user bookId = do
  let newBooks = booksLoan user ++ [bookId]
  let updatedUser = User (User.name user) (email user) (password user) (bookGenres user) (favoriteBooks user) newBooks (recentBooks user)

  updateUser user updatedUser
  putStrLn "Livro emprestado com sucesso!"
  return updatedUser

listLoans :: User -> IO ()
listLoans u = do
  let targets = booksLoan u
  books <- getBookById targets
  mapM_ (putStrLn . (++ "\n") . formatBookWithLoan) books

removeBookLoan :: User -> Book -> IO User
removeBookLoan u b = do
  isReadBook <- getIsRead
  let bookId = num b
  let listBooksLoan = booksLoan u
  let bookLoansAtt = removeFromList bookId listBooksLoan

  if isReadBook == "2"
    then do
      let updatedUser = User (User.name u) (email u) (password u) (bookGenres u) (favoriteBooks u) bookLoansAtt (recentBooks u)
      updateUser u updatedUser
      putStrLn "Livro removido com sucesso!"
      return updatedUser
    else do
      let newBooks = recentBooks u ++ [bookId]
      let updateuser = User (User.name u) (email u) (password u) (bookGenres u) (favoriteBooks u) (bookLoansAtt) (newBooks)
      updateUser u updateuser
      putStrLn "Livro adicionado no histórico de leitura!\nLivro removido com sucesso!"
      return updateuser

setUser :: User -> String -> String -> [String] -> IO User
setUser user newEmail newPassword newBookGenres = do
  let newUser = User (User.name user) newEmail newPassword newBookGenres (favoriteBooks user) (booksLoan user) (recentBooks user)
  updateUser user newUser
  return newUser

updateUser :: User -> User -> IO User
updateUser user newUser = do
  allUsers <- getUserList
  let updatedAllUsers = map (\u -> if email u == email user then newUser else u) allUsers
  CSV.write updatedAllUsers "users.csv"
  return user

addToRecent :: User -> Int -> IO User
addToRecent user bookId = do
  let newBooks = recentBooks user ++ [bookId]
  let updatedUser = User (User.name user) (email user) (password user) (bookGenres user) (favoriteBooks user) (booksLoan user) newBooks

  updateUser user updatedUser
  putStrLn "Livro Adicionado ao Historico de Leitura!"
  return updatedUser

printRecent :: User -> IO User
printRecent user = do
  let targets = recentBooks user
  books <- getBookByIdSorted targets
  putStrLn (centeredText "Histórico de Leitura:")
  mapM_ (putStrLn . formatBook) (take 10 (reverse books))
  return user

addFavorites :: User -> [Int] -> Int -> IO User
addFavorites user favoriteList bookId = do
  let favoriteListAtt = favoriteList ++ [bookId]
  let updatedUser = User (User.name user) (email user) (password user) (bookGenres user) favoriteListAtt (booksLoan user) (recentBooks user)
  updateUser user updatedUser
  putStrLn "Livro favoritado com sucesso!"
  return updatedUser

removeFavorites :: User -> [Int] -> Int -> IO User
removeFavorites user favoriteList bookId = do
  let favoriteList = favoriteBooks user
  let favoriteListAtt = removeFromList bookId favoriteList
  let updatedUser = User (User.name user) (email user) (password user) (bookGenres user) favoriteListAtt (booksLoan user) (recentBooks user)
  updateUser user updatedUser
  putStrLn "Favorito removido com sucesso!"
  return updatedUser
