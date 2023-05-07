module Main where

import Modules.CLI.LoginAndRegisterModule as NotAuthInterface
import Modules.CLI.MainMenu as AuthInterface
import Modules.UtilModule (ensureUserFilesExists)

main :: IO ()
main = do
  ensureUserFilesExists
  user <- NotAuthInterface.loginOrRegisterMenu
  AuthInterface.mainMenu user
  putStrLn "Tchau Tchau :)"
