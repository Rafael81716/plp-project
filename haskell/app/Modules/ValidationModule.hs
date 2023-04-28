module Modules.ValidationModule where
import Data.List (isInfixOf)
import Data.Char (isDigit)

isValidEmail :: String -> Bool
isValidEmail email
    | "@gmail.com" `isInfixOf` email || "@hotmail.com" `isInfixOf` email || "@ccc.ufcg.edu.br" `isInfixOf` email || "@estudante.ufcg.edu.br" `isInfixOf` email|| "@outlook.com" `isInfixOf` email || "@yahoo.com" `isInfixOf` email = True
    | otherwise = False

isValidPassword :: String -> Bool
isValidPassword password = if length password >= 6 then True
                            else False 

isValidName :: String -> IO()
isValidName name = if not (any isDigit name) then return () 
                    else print "Nome Invalido"