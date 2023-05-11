module Modules.CLI.Recomendation where

import Model.User
import Modules.BookModule (printBooks)
import Modules.RecomendationModule (recomendation)
import Modules.UtilModule (centeredText)
import System.Console.ANSI

printRecomendations :: User -> IO User
printRecomendations user = do
  setSGR [SetColor Foreground Vivid Green]
  putStrLn (centeredText "Recomendações")
  setSGR [Reset]
  recomendations <- recomendation user
  printBooks recomendations
  return user
