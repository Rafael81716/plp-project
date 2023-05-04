module Modules.ValidInput.Validation where
import Data.List (isInfixOf)
import Data.Char (isDigit)

isValidEmail :: String -> Bool
isValidEmail email
    | "@gmail.com" `isInfixOf` email || "@hotmail.com" `isInfixOf` email || "@ccc.ufcg.edu.br" `isInfixOf` email || "@estudante.ufcg.edu.br" `isInfixOf` email|| "@outlook.com" `isInfixOf` email || "@yahoo.com" `isInfixOf` email = True
    | otherwise = False

isValidPassword :: String -> Bool
isValidPassword password = length password >= 6

isValidName :: String -> Bool
isValidName name = not (any isDigit name)

isValidIndex :: Int -> [Int] -> Bool
isValidIndex n [] = True
isValidIndex n (x:xs) = if n == x then False else isValidIndex n xs

isValidSize :: [Int] -> Bool
isValidSize [] = True
isValidSize l1 = if length l1 < 10 then True else False