module Modules.UtilModule where

import Data.Map as Map
import Data.Maybe as Maybe
import Model.Book
import System.Directory (listDirectory)

genreMap :: Map.Map String String
genreMap =
  Map.fromList
    [ ("1", "Ficcao Cientifica"),
      ("2", "Fantasia"),
      ("3", "Infantil"),
      ("4", "Misterio"),
      ("5", "Historia"),
      ("6", "Aventura"),
      ("7", "Romance")
    ]

parseStrToList :: String -> [String]
parseStrToList str = do
  let temp = Prelude.filter (/= '\\') str
  let lst = read temp :: [String]
  lst

parseStrToBook :: String -> [Book]
parseStrToBook str = do
  let temp = Prelude.filter (/= '\\') str
  let lst = read temp :: [Book]
  lst

mapGenres :: [String] -> [String]
mapGenres = Prelude.map (\k -> Maybe.fromMaybe "Non Existent Genre" (Map.lookup k genreMap))

getAllGenresString :: String
getAllGenresString = do
  "\n 1 - Ficção Cientifica \n"
    ++ " 2 - Fantasia \n"
    ++ " 3 - Infantil \n"
    ++ " 4 - Misterio \n"
    ++ " 5 - Historia \n"
    ++ " 6 - Aventura \n"
    ++ " 7 - Romance \n"

wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s = case dropWhile p s of
  "" -> []
  s' -> w : wordsWhen p s''
    where
      (w, s'') = break p s'

splitBy :: Char -> String -> [String]
splitBy sep = wordsWhen (== sep)

clear :: IO ()
clear = putStrLn "\ESC[2J"

centeredText :: String -> String
centeredText text =
  let width = 40
      padding = replicate ((width - length text) `div` 2) ' '
   in replicate width '-' ++ "\n" ++ padding ++ text ++ padding ++ "\n" ++ replicate width '-'

ensureUserFilesExists :: IO ()
ensureUserFilesExists = do
  foundUsers <- findFile "users.csv"

  case foundUsers of
    Nothing -> writeFile "users.csv" ""
    _ -> return ()

findFile :: String -> IO (Maybe FilePath)
findFile filename = do
  files <- listDirectory "."
  let matchingFiles = Prelude.filter (== filename) files
  case matchingFiles of
    [match] -> return (Just match)
    _ -> return Nothing
