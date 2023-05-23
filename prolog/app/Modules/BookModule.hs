module Modules.BookModule where

import Control.Category (Category (id))
import Data.Char (toUpper)
import Data.List (intercalate)
import Model.Book
import Modules.CsvModule as CSV
import Modules.UtilModule (centeredText, clear, waitOnScreen)
import Modules.ValidInput.Getter (getIdLibrary, getLibraryOption)
import System.Console.ANSI
import Text.Read (readMaybe)

getBook :: String -> String -> IO [Book]
getBook em att = do
  bookList <- CSV.read strToBook "books.csv"
  let field = fieldSelectorFor att
  let emUpper = map toUpper em
  return $ filter (\u -> map toUpper (field u) == emUpper) bookList

fieldSelectorFor :: String -> (Book -> String)
fieldSelectorFor f = case f of
  "name" -> name
  "author" -> author
  _ -> genre

getBookByName :: String -> IO [Book]
getBookByName em = getBook em "name"

getBookByAuthor :: String -> IO [Book]
getBookByAuthor em = getBook em "author"

getBookByGenre :: String -> IO [Book]
getBookByGenre em = getBook em "genre"

getBookById :: [Int] -> IO [Book]
getBookById targets = do
  bookList <- CSV.read strToBook "books.csv"
  let result = filter (\u -> num u `elem` targets) bookList
  return result

getBookByIdSorted :: [Int] -> IO [Book]
getBookByIdSorted targets = do
  result <- getBookById targets
  let orderedResult = [book | target <- targets, book <- result, num book == target]
  return orderedResult

getAllBooks :: IO [Book]
getAllBooks = CSV.read (\s -> Prelude.read s :: Book) "books.csv"

printBooks :: [Book] -> IO ()
printBooks books = do
  let strBooks = map formatBook books
  mapM_ putStrLn strBooks

stringBooks :: [Book] -> String
stringBooks books = do
  let strBooks = map formatBook books
  intercalate "\n" strBooks

printLibrary :: IO ()
printLibrary = do
  contextBooks <- printAllBooks
  option <- getLibraryOption contextBooks
  if option == "1"
    then return ()
    else do
      printSinopse

printSinopse :: IO ()
printSinopse = do
  contextBooks <- printAllBooks
  bookidt <- getIdLibrary contextBooks
  let bookid = Prelude.read bookidt :: Int
  book <- getBookById [bookid]
  setSGR [SetColor Foreground Vivid Yellow]
  putStrLn (centeredText (name (book !! 0)))
  setSGR [Reset]
  putStrLn (sinopse (book !! 0))
  putStrLn ""
  waitOnScreen
  clear

printAllBooks :: IO String
printAllBooks = do
  allBooks <- getAllBooks
  return (stringBooks allBooks)

contentLoanInUser :: [Int] -> Int -> Bool
contentLoanInUser userBooks idBook = elem idBook userBooks
