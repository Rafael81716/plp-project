module Main where
import Modules.InterfaceModule as Sout
import Modules.UserModule

main::IO ()
main = do
    Sout.printLoginRegister
    user <- Modules.UserModule.getUserCsv "gabriel@gmail.com"
    print (name (user !!0))
    