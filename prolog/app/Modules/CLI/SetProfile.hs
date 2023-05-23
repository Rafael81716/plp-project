module Modules.CLI.SetProfile where

import Data.List (nub)
import Model.User
import Modules.UserModule (setUser, isUserRegistered)
import Modules.UtilModule (mapGenres)
import Modules.ValidInput.Getter (getBookGenresWithContext, getNewEmailWithContext, getNewPasswordWithContext)

printSetProfile :: User -> IO User
printSetProfile user = do
  let context = "Editar Perfil"
  newEmail <- getNewEmailWithContext context
  registered <- isUserRegistered newEmail
  if registered && email user /= newEmail
    then do
      putStrLn "Email já cadastrado!"
      printSetProfile user
    else do
      newPassword <- getNewPasswordWithContext context
      newGenres <- getBookGenresWithContext context
      let genresFormated = words newGenres
      let listGenrers = nub $ mapGenres genresFormated
      setUser user newEmail newPassword listGenrers
