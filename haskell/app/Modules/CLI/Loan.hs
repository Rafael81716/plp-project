module Modules.CLI.Loan where

import Model.Book
import Model.User
import Modules.BookModule
import Modules.UserModule as UserModule
import Modules.UtilModule (centeredText)
import Modules.ValidInput.Getter (getAuthorWithContext, getGenreWithContext, getOptionsBookLoan, getTitleWithContext)
import Modules.ValidInput.Validation (isValidSize)

printMakeLoan :: User -> IO ()
printMakeLoan user = do
  option <- getOptionsBookLoan "Empréstimo"

  case option of
    "1" -> printMakeLoanByTitle user
    "2" -> printMakeLoanByAuthor user
    "3" -> printMakeLoanByGender user

printMakeLoanByTitle :: User -> IO ()
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
        else
          if contentLoanInUser (booksLoan user) bookId == True
            then do
              putStrLn ("Este usuario ja tem esse livro emprestado, escolha outro!")
              printMakeLoanByTitle user
            else do
              UserModule.makeLoanByTitle user bookId
              printHistoric user

printMakeLoanByAuthor :: User -> IO ()
printMakeLoanByAuthor user = do
  author <- getAuthorWithContext "Empréstimo"
  books <- getBookByAuthor author
  if isValidSize (booksLoan user) == False
    then do
      putStrLn ("O Usuario ja atingiu o numero maximo de emprestimos")
    else
      if books == []
        then do
          putStrLn ("Este autor nao esta cadastrado no sistema!")
          printMakeLoanByAuthor user
        else do
          let booksAuthor = printAllBooks books
          putStrLn (booksAuthor)
          putStrLn "Escolha um livro pelo titulo: "
          printMakeLoanByTitle user

printMakeLoanByGender :: User -> IO ()
printMakeLoanByGender user = do
  genre <- getGenreWithContext "Empréstimo"
  books <- getBookByGenre genre
  if isValidSize (booksLoan user) == False
    then do
      putStrLn ("O Usuario ja atingiu o numero maximo de emprestimos.")
    else
      if books == []
        then do
          putStrLn ("Nao ha livros desse genero cadastrados no sistema.")
          printMakeLoanByGender user
        else do
          let booksGenre = printAllBooks books
          putStrLn (booksGenre)
          putStrLn "Escolha um livro pelo titulo: "
          printMakeLoanByTitle user

printListLoan :: User -> IO ()
printListLoan user = do
  let books = (booksLoan user)
  UserModule.listLoans books 0

printRemoveBookLoan :: User -> IO ()
printRemoveBookLoan user = do
  putStrLn (centeredText "Devolucao" ++ "\n" ++ "Este sao os seus emprestimos:\n")
  printListLoan user
  putStr ("\n" ++ "Escolha um livro para devolver pelo titulo: ")
  title <- getLine
  book <- getBookByName title
  let bookId = num (head book)

  if length (booksLoan user) == 0
    then do
      putStrLn "Voce nao possui emprestimos!"
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
            else UserModule.removeBookLoan user book
