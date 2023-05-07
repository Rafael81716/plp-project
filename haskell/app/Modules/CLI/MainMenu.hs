module Modules.CLI.MainMenu where

import Model.User
import Modules.BookModule (getAllBooks, printAllBooks)
import Modules.CLI.Loan (printListLoan, printMakeLoan, printRemoveBookLoan)
import Modules.UserModule (printRecent)
import Modules.ValidInput.Getter (getMainMenuOption)

mainMenu :: User -> IO ()
mainMenu user = do
  option <- getMainMenuOption "Menu Principal"
  updatedUser <- readMainMenu user option
  if option == "11"
    then return ()
    else mainMenu updatedUser

readMainMenu :: User -> String -> IO User
readMainMenu user option
  | option == "1" = printMakeLoan user
  | option == "2" = printListLoan user
  | option == "3" = printRemoveBookLoan user
  | option == "4" = do
      printAllBooks
      return user
  | option == "5" = do
      print "TODO"
      return user
  | option == "6" = do
      print "TODO"
      return user
  | option == "7" = do
      print "TODO"
      return user
  | option == "8" = do
      print "TODO"
      return user
  | option == "9" = printRecent user
  | option == "10" = do
      print "TODO"
      return user
  | option == "11" = return user
