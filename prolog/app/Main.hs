module Main where

import Modules.CLI.LoginAndRegisterModule as NotAuthInterface
import Modules.CLI.MainMenu as AuthInterface
import Modules.UtilModule (clear, ensureNeededFilesExist)

main :: IO ()
main = do
  ensureNeededFilesExist
  clear
  user <- NotAuthInterface.loginOrRegisterMenu
  AuthInterface.mainMenu user
  putStrLn "Tchau Tchau :)"
