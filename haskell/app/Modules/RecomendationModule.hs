module Modules.RecomendationModule where
import Model.Book
import Model.User
import Modules.BookModule(getBookById,getBookByGenre, getBookByIdSorted, printBooks)
import System.Random
import Modules.UtilModule (waitOnScreen, centeredText, clear)
import System.Console.ANSI
import Data.List (nub)


recomendation:: User -> IO User
recomendation user = do
    let genres = bookGenres user
    setSGR [SetColor Foreground Vivid Green]
    putStrLn (centeredText "Recomendações")
    setSGR [Reset]
    if length genres == 0 then do
         gen <- newStdGen
         let randomBooksId =  take 10 $ nub $ randomRs (1, 21) gen :: [Int]
         books <- getBookByIdSorted randomBooksId
         mapM_ (putStrLn . formatBook) books
         waitOnScreen 
         clear
         return user

    else do
        book <- getBookByGenre (genres !!0)
        print(author (book !! 0))
        return user 