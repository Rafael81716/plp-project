{-# LANGUAGE OverloadedStrings #-}
module Main where
import Modules.InterfaceModule as Sout

main::IO ()
main = do
    Sout.printLoginRegister
    
    