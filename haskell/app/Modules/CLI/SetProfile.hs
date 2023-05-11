module Modules.CLI.SetProfile where

import Data.List (nub)
import Model.User (User)
import Modules.UserModule (setUser)
import Modules.UtilModule (mapGenres)
import Modules.ValidInput.Getter (getBookGenresWithContext, getNewEmailWithContext, getNewPasswordWithContext)

printSetProfile :: User -> IO User
printSetProfile user = do
  let context = "Editar Perfil"
  newEmail <- getNewEmailWithContext context
  newPassword <- getNewPasswordWithContext context
  newGenres <- getBookGenresWithContext context
  let genresFormated = words newGenres
  let listGenrers = nub $ mapGenres genresFormated
  setUser user newEmail newPassword listGenrers
