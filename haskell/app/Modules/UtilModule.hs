module Modules.UtilModule where
import Data.Map as Map
import Data.Maybe as Maybe
import qualified Data.Maybe as Maybe
import Model.Book

genreMap :: Map.Map String String
genreMap = Map.fromList [
    ("1", "Ficcao Cientifica"),
    ("2", "Fantasia"),
    ("3", "Infantil"),
    ("4", "Misterio"),
    ("5", "Historia"),
    ("6", "Aventura"),
    ("7", "Romance")]

parseStrToList :: String -> [String]
parseStrToList str = do
  let temp = Prelude.filter (/= '\\') str
  let lst = read temp :: [String]
  lst

<<<<<<< HEAD
parseStrToBook :: String -> [Book]
parseStrToBook str = do
=======
parseStrToBooks :: String -> [Book]
parseStrToBooks str = do
>>>>>>> d31bff4afd6a8689076c072e7b60d2815daa6118
  let temp = Prelude.filter (/= '\\') str
  let lst = read temp :: [Book]
  lst

<<<<<<< HEAD
=======

>>>>>>> d31bff4afd6a8689076c072e7b60d2815daa6118
mapGenres :: [String] -> [String]
mapGenres = Prelude.map (\ k -> Maybe.fromMaybe "Non Existent Genre" (Map.lookup k genreMap))

wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s = case dropWhile p s of
  "" -> []
  s' -> w : wordsWhen p s''
    where
      (w, s'') = break p s'

splitBy :: Char -> String -> [String]
splitBy sep str = wordsWhen (== sep) str

clear :: IO ()
clear = putStrLn "\ESC[2J"

centeredText :: String -> String
centeredText text =
  let width = 40
      padding = replicate ((width - length text) `div` 2) ' '
   in replicate width '-' ++ "\n" ++ padding ++ text ++ padding ++ "\n" ++ replicate width '-'
