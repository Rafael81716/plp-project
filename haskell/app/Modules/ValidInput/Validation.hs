module Modules.ValidInput.Validation where

import Data.Char (isDigit)
import Data.List (isInfixOf)
import Model.User

isValidEmail :: String -> Bool
isValidEmail email
  | "@gmail.com" `isInfixOf` email || "@hotmail.com" `isInfixOf` email || "@ccc.ufcg.edu.br" `isInfixOf` email || "@estudante.ufcg.edu.br" `isInfixOf` email || "@outlook.com" `isInfixOf` email || "@yahoo.com" `isInfixOf` email = True
  | otherwise = False

isValidPassword :: String -> Bool
isValidPassword password = length password >= 6

isValidName :: String -> Bool
isValidName name = not (any isDigit name)

isValidIndex :: Int -> [Int] -> Bool
isValidIndex n [] = True
isValidIndex n (x : xs) = (n /= x) && isValidIndex n xs

isValidSize :: [Int] -> Bool
isValidSize [] = True
isValidSize l1 = length l1 < 10

isValidGenre :: String -> Bool
isValidGenre genre = do
  let genreList = words genre
  let validSize = length genreList <= 5
  let validChoices = all (\num -> num >= 1 && num <= 7) (map read genreList :: [Int])
  validSize && validChoices

filterUserList :: String -> [User] -> [User]
filterUserList _ [] = []
filterUserList em (x : xs) =
  if email x == em
    then filterUserList em xs
    else x : filterUserList em xs