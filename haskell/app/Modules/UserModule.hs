module Modules.UserModule where  

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
import Text.CSV
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Lazy.Char8 as BC
import GHC.Generics
import System.IO.Unsafe
import System.IO
import System.Directory

data User = User{
        name::String,
        email::String,
        password::String,
        bookGenres:: [String]
    } deriving(Show,Eq,Read)

registerUser:: String -> String -> String -> [String] -> IO()
registerUser readName readEmail readPassword readGenres = do
    let user = User readName readEmail readPassword readGenres
    putStrLn $ show user
