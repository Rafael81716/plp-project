module Main where
import Modules.InterfaceModule as Interface
import Modules.BookModule as Book
import Language.Haskell.TH (pprint)

main :: IO ()
main = do
    Interface.loginOrRegisterMenu
    --Interface.mainMenu
