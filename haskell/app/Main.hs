module Main where

import Modules.CLI.LoginAndRegisterModule as NotAuthInterface
import Modules.CLI.MainMenu as AuthInterface
import Modules.UtilModule (ensureNeededFilesExist)

main :: IO ()
main = do
  ensureNeededFilesExist
  user <- NotAuthInterface.loginOrRegisterMenu
  AuthInterface.mainMenu user
  putStrLn "Tchau Tchau :)"
