module Modules.BookModule where
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

data Book = Book{
    num::Int,
    name::String,
    author::String,
    genre::String,
    link::String
} deriving (Eq, Read)

instance Show Book where
    show(Book id name author genre link) = show id ++ ";" ++name ++ ";" ++ author ++ ";" ++ genre ++ ";" ++ link


registerBookAux :: Int -> String -> String -> String -> String -> Book
registerBookAux id name author genre link = Book id name author genre link

getBookCsv :: String -> String -> IO [Book]
getBookCsv em att = do
    let fileName = "books.csv"
    csvData <- readFile fileName
    let lines = wordsWhen (=='\n') csvData
    let temp = map (\s -> wordsWhen (== ';') s) lines
    let bookList = map strToBook temp
    if att == "name" then return $ filter (\u -> name(u) == em) bookList
    else if att == "author" then return $ filter (\u -> author(u) == em) bookList
    else  return $ filter (\u -> genre(u) == em) bookList

getBookByName :: String -> IO [Book]
getBookByName em = getBookCsv em "name"

getBookByAuthor :: String -> IO [Book]
getBookByAuthor em = getBookCsv em "author"

getBookByGenre :: String -> IO [Book]
getBookByGenre em = getBookCsv em "genre"

getBookById :: Int -> IO [Book]
getBookById em  = do
    let fileName = "books.csv"
    csvData <- readFile fileName
    let lines = wordsWhen (=='\n') csvData
    let temp = map (\s -> wordsWhen (== ';') s) lines
    let bookList = map strToBook temp
    let jet = filter (\u -> num(u) == em) bookList
    return jet

strToBook:: [String] -> Book
strToBook x = do
    let n = read (head x)
    let e = x !! 1
    let s = x !! 2
    let g = x !! 3
    let j = x !! 4
    registerBookAux n e s g j

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
splitBy sep = wordsWhen (== sep)

getAllBooks :: IO [Book]
getAllBooks = do
    let fileName = "books.csv"
    csvData <- readFile fileName
    let lines = wordsWhen (=='\n') csvData
    let temp = map (\s -> wordsWhen (== ';') s) lines
    let bookList = map strToBook temp
    return bookList

printAllBooks :: [Book] -> String
printAllBooks (x:xs)
    | null (x:xs) = ""
    | null xs = show (num x) ++ " - " ++ name x ++ " - " ++ author x ++ " (" ++ genre x ++ ")" ++ "\n"
    | otherwise = show (num x) ++ " - " ++ name x ++ " - " ++ author x ++ " (" ++ genre x ++ ")" ++ "\n" ++ printAllBooks xs