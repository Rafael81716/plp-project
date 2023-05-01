module Modules.ValidInput.Getter where
import Modules.ValidInput.Validation (isValidEmail, isValidName, isValidPassword)
import Modules.UtilModule (clear, centeredText)
import Control.Monad.Trans.Cont (cont)

getNameWithContext :: String -> IO String
getNameWithContext context = baseGetWithContext context "Digite seu nome: " isValidName "Nome inválido!\nDigite seu nome novamente!"

getEmailWithContext :: String -> IO String
getEmailWithContext context = baseGetWithContext context "Digite seu email: " isValidEmail "Email inválido!\nDigite seu email novamente!"

getPasswordWithContext :: String -> IO String
getPasswordWithContext context = baseGetWithContext context "Digite sua senha: " isValidPassword "Senha inválida!\nDigite sua senha novamente!"

getLoginRegisterOptionWithContext :: String -> IO String
getLoginRegisterOptionWithContext context  = baseGetWithContext context ("1 - Entrar\n" ++ "2 - Cadastrar\n" ++ "Escolha uma opção: ") (\o -> o == "1" || o == "2") "Opção inválida!"


getName :: IO String
getName = baseGet "Digite seu nome: " isValidName "Nome inválido!\nDigite seu nome novamente!"

getEmail :: IO String
getEmail = baseGet "Digite seu email: " isValidEmail "Email inválido!\nDigite seu email novamente!"

getPassword :: IO String
getPassword = baseGet "Digite sua senha: " isValidPassword "Senha inválida!\nDigite sua senha novamente!"

getLoginRegisterOption :: IO String
getLoginRegisterOption = baseGet ("1 - Entrar\n" ++ "2 - Cadastrar\n" ++ "Escolha uma opção: ") (\o -> o == "1" || o == "2") "Opção inválida!"

getMainMenuOption:: String -> IO String
getMainMenuOption context = baseGetWithContext context   ( " 1 - Realizar empréstimo \n"
        ++ " 2 - Devolver livro \n"
        ++ " 3 - Ver todos os livros do sistema \n"
        ++ " 4 - Listar recomendações \n"
        ++ " 5 - Cadastra favoritos \n"
        ++ " 6 - Remover favoritos \n"
        ++ " 7 - Listar favoritos \n"
        ++ " 8 - Exibir histórico de leitura \n"
        ++ " 9 - Editar perfil \n"
        ++ " 10 - Logout \n" ++
       " Escolha uma opção: "
    )  (\o -> o == "1" || o == "2" || o == "3" || o == "4" || o == "5" || o == "6" || o == "7" || o == "8" || o == "9" || o == "10") "Opção inválida"

baseGetWithContext :: String -> String -> (String -> Bool) -> String -> IO String
baseGetWithContext context prompt predicate errMsg = customGet
    where
        customGet :: IO String
        customGet = do
            -- PRINTS CONTEXT
            putStrLn (centeredText context)
            putStrLn prompt
            input <- getLine
            
            let invalidInput = not (predicate input)
            if invalidInput then do
                clear
                putStrLn errMsg
                customGet
            else do
                clear
                return input

baseGet :: String -> (String -> Bool) -> String -> IO String
baseGet prompt predicate errMsg = customGet
    where
        customGet :: IO String
        customGet = do
            -- DOESN'T PRINT CONTEXT
            putStrLn prompt
            input <- getLine
            
            let invalidInput = not (predicate input)
            if invalidInput then do
                clear
                putStrLn errMsg
                customGet
            else do
                clear
                return input
