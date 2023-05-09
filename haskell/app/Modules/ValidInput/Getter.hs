module Modules.ValidInput.Getter where

import Modules.UtilModule (centeredText, clear, getAllGenresString)
import Modules.ValidInput.Validation (isValidEmail, isValidGenre, isValidName, isValidPassword)

getNameWithContext :: String -> IO String
getNameWithContext context = baseGetWithContext context "Digite seu nome: " isValidName "Nome inválido!\nDigite seu nome novamente!"

getEmailWithContext :: String -> IO String
getEmailWithContext context = baseGetWithContext context "Digite seu email: " isValidEmail "Email inválido!\nDigite seu email novamente!"

getPasswordWithContext :: String -> IO String
getPasswordWithContext context = baseGetWithContext context "Digite sua senha: " isValidPassword "Senha inválida!\nDigite sua senha novamente!"

getLoginRegisterOptionWithContext :: String -> IO String
getLoginRegisterOptionWithContext context = baseGetWithContext context ("1 - Entrar\n" ++ "2 - Cadastrar\n" ++ "Escolha uma opção: ") (\o -> o == "1" || o == "2") "Opção inválida!"

getName :: IO String
getName = baseGet "Digite seu nome: " isValidName "Nome inválido!\nDigite seu nome novamente!"

getEmail :: IO String
getEmail = baseGet "Digite seu email: " isValidEmail "Email inválido!\nDigite seu email novamente!"

getPassword :: IO String
getPassword = baseGet "Digite sua senha: " isValidPassword "Senha inválida!\nDigite sua senha novamente!"

getTitleWithContext :: String -> IO String
getTitleWithContext context = baseGetWithContext context "Informe o título do livro: " (/= "") "Título inválido! Digite o título novamente: "

getAuthorWithContext :: String -> IO String
getAuthorWithContext context = baseGetWithContext context "Informe um autor para pesquisa: " isValidName "Nome inválido! Digite o nome novamente: "

getGenreWithContext :: String -> IO String
getGenreWithContext context = baseGetWithContext context "Informe um gênero para pesquisa: " isValidName "Gênero inválido! Digite o gênero novamente: "

getLoginRegisterOption :: IO String
getLoginRegisterOption = baseGet ("1 - Entrar\n" ++ "2 - Cadastrar\n" ++ "Escolha uma opção: ") (\o -> o == "1" || o == "2") "Opção inválida!"

getIsRead:: IO String
getIsRead = baseGet ("\nVocê leu esse livro?\nDigite <1> para Sim ou <2> para Não: ") (\o -> o == "1" || o == "2" ) "Opção inválida, digite novamente!"

getMainMenuOption :: String -> IO String
getMainMenuOption context =
  baseGetWithContext
    context
    ( " 1 - Realizar empréstimo \n"
        ++ " 2 - Ver livros emprestados \n"
        ++ " 3 - Devolver livro \n"
        ++ " 4 - Ver todos os livros do sistema \n"
        ++ " 5 - Listar recomendações \n"
        ++ " 6 - Cadastra favoritos \n"
        ++ " 7 - Remover favoritos \n"
        ++ " 8 - Listar favoritos \n"
        ++ " 9 - Exibir histórico de leitura \n"
        ++ " 10 - Editar perfil \n"
        ++ " 11 - Logout \n"
        ++ " Escolha uma opção: "
    )
    (\o -> (read o :: Int) `elem` [1 .. 11])
    "Opção inválida"

getOptionsBookLoan :: String -> IO String
getOptionsBookLoan context = baseGetWithContext context ("Escolha uma forma de consulta:\n" ++ "1 - Título\n" ++ "2 - Autor\n" ++ "3 - Gênero\n" ++ "Escolha uma opção: ") (\o -> o == "1" || o == "2" || o == "3") "Opção inválida"

getBookGenresWithContext :: String -> IO String
getBookGenresWithContext context = baseGetWithContext context ("Escolha até 5 gêneros literários pelos seus respectivos números em ordem de preferência e separados por espaço: " ++ getAllGenresString) isValidGenre "Gêneros inválidos! Digite os gêneros novamente: "

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
      if invalidInput
        then do
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
      if invalidInput
        then do
          clear
          putStrLn errMsg
          customGet
        else do
          clear
          return input