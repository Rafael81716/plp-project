module Main where

import Modules.InterfaceModule as Sout
import Modules.UserModule

main :: IO ()
main = do
  Sout.printLoginRegister
  user <- Modules.UserModule.getUserCsv "joao@gmail.com"
  print (name (user !! 0))