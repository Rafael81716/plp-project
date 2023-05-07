module Main where

import Modules.CLI.LoginAndRegisterModule as LRM
import Modules.CLI.MainMenu as MM
import Modules.UtilModule (ensureUserFilesExists)

main :: IO ()
main = do
  ensureUserFilesExists
  user <- LRM.loginOrRegisterMenu
  MM.mainMenu user
