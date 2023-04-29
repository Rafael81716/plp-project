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
import Data.Data (typeOf)
--import Data.List.Split

data User = User{
        name::String,
        email::String,
        password::String,
        bookGenres:: [String]
    } deriving(Eq,Read)

instance Show User where
    show( User name email password bookGenres) = name ++ "," ++ email ++ "," ++ password ++ "," ++ show bookGenres


registerUser:: String -> String -> String -> [String] -> IO()
registerUser readName readEmail readPassword readGenres = do
    let user = User readName readEmail readPassword readGenres
    let user1 = [user]
    print "entrou"
    saveCsv user1 "users.csv"

saveCsv :: (Show u) => [u] -> FilePath -> IO ()
saveCsv valores caminhoArquivo = appendFile caminhoArquivo conteudoCSV
  where conteudoCSV = unlines $ map show valores

        
getUserCsv :: String -> IO [User]
getUserCsv em = do
    let fileName = "Test.csv"
    csvData <- readFile fileName
    let lines = wordsWhen (=='\n') csvData
    let temp = map (\s -> wordsWhen (== ';') s) lines
    let userList = map (\[n, e, s, l] -> registerUser n e s (parseStrToList l)) temp
    let jet = filter (\u -> email(u) == em) userList
    return jet

--usuario <- getUserCsv "Lucas@gmail.com"
--print (name (tiboca !!0))
parseStrToList :: String -> [String]
parseStrToList str = do
    let temp = filter (/= '\\') str
    let lst = read temp :: [String]
    lst
    
wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'
                    
splitBy :: Char -> String -> [String]
splitBy sep str = wordsWhen (== sep) str

 