module Modules.CLI.LoginAndRegisterModule where

import Model.User
import Modules.UserModule as UserModule
import Modules.UtilModule (clear, mapGenres)
import Modules.ValidInput.Getter (getBookGenresWithContext, getEmailWithContext, getLoginRegisterOptionWithContext, getNameWithContext, getPasswordWithContext)

loginOrRegisterMenu :: IO User
loginOrRegisterMenu = do
  option <- getLoginRegisterOptionWithContext "Início"

  if option == "1"
    then loginMenu
    else registeringMenu

loginMenu :: IO User
loginMenu = do
  let context = "Login"
  email <- getEmailWithContext context
  password <- getPasswordWithContext context

  clear
  result <- UserModule.loginUser email password
  case result of
    Nothing -> do
      putStrLn "Credenciais inválidas, tente novamente"
      loginOrRegisterMenu
    Just user -> return user

registeringMenu :: IO User
registeringMenu = do
  let context = "Cadastre-se"

  name <- getNameWithContext context
  email <- getEmailWithContext context
  userIsNotRegistered email >>= \isNotRegistered ->
    if not isNotRegistered
      then do
        clear
        putStrLn "Email já cadastrado, insira outro!"
        registeringMenu
      else do
        password <- getPasswordWithContext context
        -- Maybe take this to ValidInput too? Not sure
        genres <- getBookGenresWithContext context
        let genresFormated = words genres
        let listGenrers = mapGenres genresFormated
        UserModule.registerUser name email password listGenrers [] [] []