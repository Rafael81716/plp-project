module Modules.CLI.MainMenu where

import Model.User
import Modules.BookModule (getAllBooks, printLibrary)
import Modules.CLI.Loan (printListLoan, printMakeLoan, printRemoveBookLoan)
import Modules.CLI.Favorites(printAddFavorites, printRemoveFavorites, printListFavorites)
import Modules.CLI.SetProfile(printSetProfile)
import Modules.CLI.Recomendation(printRecomendations)
import Modules.UserModule (printRecent)
import Modules.RecomendationModule(recomendation)

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
      printLibrary
      return user
  | option == "5" = do
      printRecomendations user 
  | option == "6" = do
      printAddFavorites user 
  | option == "7" = do
    printRemoveFavorites user
  | option == "8" = do
      printListFavorites user
      return user
  | option == "9" = printRecent user
  | option == "10" = do
      printSetProfile user
  | option == "11" = return user
