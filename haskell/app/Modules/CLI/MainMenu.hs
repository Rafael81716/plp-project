module Modules.CLI.MainMenu where

import Model.User
import Modules.BookModule (getAllBooks, printAllBooks)
import Modules.CLI.Loan (printListLoan, printMakeLoan, printRemoveBookLoan)
import Modules.ValidInput.Getter (getMainMenuOption)

mainMenu :: User -> IO ()
mainMenu user = do
  option <- getMainMenuOption "Menu Principal"
  readMainMenu user option
  mainMenu user

readMainMenu :: User -> String -> IO ()
readMainMenu user option
  | option == "1" = printMakeLoan user
  | option == "2" = printListLoan user
  | option == "3" = printRemoveBookLoan user
  | option == "4" = do
      books <- getAllBooks
      putStrLn (printAllBooks books)
      putStrLn "Pressione qualquer tecla para voltar ao menu principal"
      getLine
      putStrLn ""
  | option == "5" = printRemoveBookLoan user
  | option == "6" = printRemoveBookLoan user
  | option == "7" = printRemoveBookLoan user
  | option == "8" = printRemoveBookLoan user
  | option == "9" = printRemoveBookLoan user
  | option == "10" = printRemoveBookLoan user
  | option == "11" = printRemoveBookLoan user
