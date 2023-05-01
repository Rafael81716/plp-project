module Modules.InterfaceModule where
import Modules.UserModule as UserModule
import Modules.ValidInput.Getter (getNameWithContext, getEmailWithContext, getPasswordWithContext, getLoginRegisterOptionWithContext)
import Modules.UtilModule (centeredText, clear, mapGenres)
import Model.User

loginOrRegisterMenu :: IO ()
loginOrRegisterMenu = do
  option <- getLoginRegisterOptionWithContext "Início"
  
  if option == "1" then loginMenu
  else registeringMenu

loginMenu :: IO ()
loginMenu = do
  let context = "Login"
  email <- getEmailWithContext "Login"
  password <- getPasswordWithContext "Login"

  clear
  result <- UserModule.loginUser email password
  case result of
    Nothing -> return ()
    Just user -> print (bookGenres user)


registeringMenu :: IO ()
registeringMenu = do
  let context = "Cadastre-se"

  name <- getNameWithContext context
  email <- getEmailWithContext context
  userIsNotRegistered email >>= \isNotRegistered ->
    if isNotRegistered == False then do
       clear
       putStrLn "Email já cadastrado, insira outro!"
       registeringMenu
      else do 
        password <- getPasswordWithContext context
      -- Maybe take this to ValidInput too? Not sure
        putStrLn "Escolha até 5 gêneros literários em ordem de preferência: "
        printGenres

        genres <- getLine
        let genresFormated = words genres
        let listGenrers = mapGenres genresFormated
        UserModule.registerUser name email password listGenrers

printGenres :: IO ()
printGenres = do
  putStrLn
    ( "\n 1 - Ficção Cientifica \n"
        ++ " 2 - Fantasia \n"
        ++ " 3 - Infantil \n"
        ++ " 4 - Misterio \n"
        ++ " 5 - Historia \n"
        ++ " 6 - Aventura \n"
        ++ " 7 - Romance \n"
    )

  putStrLn "Escolha os gêneros, separando cada um por espaço: "
