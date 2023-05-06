module Modules.UserModule where

import Modules.CsvModule as CSV
import Model.Book
import Modules.UtilModule (wordsWhen)
import Data.Maybe
import Model.User as User
import Modules.BookModule
import Data.List
import Model.User (User(bookGenres))
import Modules.ValidInput.Validation (filterUserList)


registerUser :: String -> String -> String -> [String] -> [Int]  -> [Int] -> IO ()
registerUser readName readEmail readPassword readGenres readFavorites readBooksLoan = do
  let user = User readName readEmail readPassword readGenres readFavorites readBooksLoan
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

makeLoanByTitle:: User -> Int -> IO()
makeLoanByTitle user bookId = do
  let newBooks = (booksLoan user) ++ [bookId]
  let actualUser = User (nameUser user) (email user) (password user) (bookGenres user) (favoriteBooks user) newBooks

  userList <- getUserList
  let newList = actualUser:filterUserList (email user) userList
  writeFile "users.csv" ""
  CSV.append newList "users.csv"
  putStrLn "Livro emprestado com sucesso!"

listLoans::[Int] -> Int -> IO()
listLoans [] cont = putStrLn ""
listLoans (h:t) cont = do
  book <- getBookById h 
  putStrLn (show (cont + 1) ++ ") " ++ name (book !! 0) ++ " - " ++ author (book !! 0) ++ " (" ++ genre (book !! 0) ++ ")")
  listLoans t (cont + 1)

removeBookLoan:: User -> [Book] -> IO()
removeBookLoan user  book = do
  let bookId =  num (head book)
  let listBooksLoan = booksLoan user 
  let bookLoansAtt = removeElement2 bookId listBooksLoan
  let userActual = User (nameUser user) (email user) (password user) (bookGenres user) (favoriteBooks user) (bookLoansAtt)
  userList <- getUserList
  let newList = userActual:filterUserList (email user) userList
  writeFile "users.csv" ""
  CSV.append newList "users.csv"
  putStrLn "Livro removido com sucesso!"

removeElement2 :: Eq a => a -> [a] -> [a]
removeElement2 x xs = filter (/= x) xs

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
