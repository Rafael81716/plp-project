module Modules.CLI.Loan where

import Model.Book
import Model.User
import Modules.BookModule
import Modules.UserModule as UserModule
import Modules.UtilModule (centeredText, waitOnScreen)
import Modules.ValidInput.Getter (getAuthorWithContext, getGenreWithContext, getOptionsBookLoan, getTitleWithContext)
import Modules.ValidInput.Validation (isValidSize)

printMakeLoan :: User -> IO User
printMakeLoan user = do
  option <- getOptionsBookLoan "Empréstimo"

  case option of
    "1" -> printMakeLoanByTitle user
    "2" -> printMakeLoanByAuthor user
    "3" -> printMakeLoanByGenre user

printMakeLoanByTitle :: User -> IO User
printMakeLoanByTitle user = do
  title <- getTitleWithContext "Empréstimo"
  book <- getBookByName title
  let bookId = num (head book)
  if book == []
    then do
      putStrLn ("Livro nao consta na base de dados!")
      printMakeLoanByTitle user
    else
      if isValidSize (booksLoan user) == False
        then do
          putStrLn ("O Usuario ja atingiu o numero maximo de emprestimos")
          return user
        else
          if contentLoanInUser (booksLoan user) bookId == True
            then do
              putStrLn ("Este usuario ja tem esse livro emprestado, escolha outro!")
              printMakeLoanByTitle user
            else do
              updatedUser <- makeLoanByTitle user bookId
              printRecent updatedUser
              return updatedUser

printMakeLoanByAuthor :: User -> IO User
printMakeLoanByAuthor user = do
  author <- getAuthorWithContext "Empréstimo"
  books <- getBookByAuthor author
  if isValidSize (booksLoan user) == False
    then do
      putStrLn ("O Usuario ja atingiu o numero maximo de emprestimos")
      return user
    else
      if books == []
        then do
          putStrLn ("Este autor nao esta cadastrado no sistema!")
          printMakeLoanByAuthor user
        else do
          printBooks books
          putStrLn "Escolha um livro pelo titulo: "
          updatedUser <- printMakeLoanByTitle user
          return updatedUser

printMakeLoanByGenre :: User -> IO User
printMakeLoanByGenre user = do
  genre <- getGenreWithContext "Empréstimo"
  books <- getBookByGenre genre
  if isValidSize (booksLoan user) == False
    then do
      putStrLn ("O Usuario ja atingiu o numero maximo de emprestimos.")
      return user
    else
      if books == []
        then do
          putStrLn ("Nao ha livros desse genero cadastrados no sistema.")
          printMakeLoanByGenre user
        else do
          printBooks books
          putStrLn "Escolha um livro pelo titulo: "
          updatedUser <- printMakeLoanByTitle user
          return updatedUser

printListLoan :: User -> IO User
printListLoan user = do
  UserModule.listLoans user
  waitOnScreen
  return user

printListLoanRemove :: User -> IO User
printListLoanRemove user = do
  UserModule.listLoans user
  return user

printRemoveBookLoan :: User -> IO User
printRemoveBookLoan user = do
  putStrLn (centeredText "Devolucao" ++ "\n" ++ "Este sao os seus emprestimos:\n")
  printListLoanRemove user
  putStrLn ("\n" ++ "Escolha um livro para devolver pelo titulo: ")
  title <- getLine
  book <- getBookByName title
  let bookId = num (head book)

  if length (booksLoan user) == 0
    then do
      putStrLn "Voce nao possui emprestimos!"
      return user
    else
      if book == []
        then do
          putStrLn ("Livro nao consta na base de dados, escolha outro!")
          printRemoveBookLoan user
        else
          if contentLoanInUser (booksLoan user) bookId == False
            then do
              putStrLn ("Este usuario nao tem esse livro emprestado, escolha outro!")
              printRemoveBookLoan user
            else do
              updatedUser <- UserModule.removeBookLoan user (head book)
              return updatedUser
