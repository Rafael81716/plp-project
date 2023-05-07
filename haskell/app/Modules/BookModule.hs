module Modules.BookModule where

import Model.Book
import Modules.CsvModule as CSV
import Modules.UtilModule (waitOnScreen)

getBook :: String -> String -> IO [Book]
getBook em att = do
  bookList <- CSV.read strToBook "books.csv"
  let field = fieldSelectorFor att
  return $ filter (\u -> field u == em) bookList

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

getAllBooks :: IO [Book]
getAllBooks = CSV.read (\s -> Prelude.read s :: Book) "books.csv"

printBooks :: [Book] -> IO ()
printBooks books = do
  let strBooks = map formatBook books
  mapM_ putStrLn strBooks
  waitOnScreen

printAllBooks :: IO ()
printAllBooks = do
  allBooks <- getAllBooks
  printBooks allBooks

contentLoanInUser :: [Int] -> Int -> Bool
contentLoanInUser userBooks idBook = elem idBook userBooks
