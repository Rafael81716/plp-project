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
import Data.List.Split

data User = User{
        name::String,
        email::String,
        password::String,
        bookGenres:: [String]
    } deriving(Show,Eq,Read)


registerUser:: String -> String -> String -> [String] -> IO()
registerUser readName readEmail readPassword readGenres = do
    let user = User readName readEmail readPassword readGenres
    let user1 = [user]
    putStrLn $  show user
    saveCsv user1 "users.csv"


saveCsv :: (Show u) => [u] -> FilePath -> IO ()
saveCsv valores caminhoArquivo = appendFile caminhoArquivo conteudoCSV
  where conteudoCSV = unlines $ map show valores

parsePessoa :: String -> User
parsePessoa linhaCSV = User name email password bookGenres
  where [name, email, password, bookGenres] = splitOn "," linhaCSV
        

        
 