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