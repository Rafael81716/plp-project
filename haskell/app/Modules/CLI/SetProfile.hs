module Modules.CLI.SetProfile where
import Modules.ValidInput.Getter(getNewEmailWithContext, getNewPasswordWithContext, getBookGenresWithContext)
import Modules.UserModule(setUser)
import Modules.UtilModule (clear, mapGenres)
import Model.User (User)

printSetProfile:: User -> IO User
printSetProfile user = do
    let context = "Editar Perfil"
    newEmail <- getNewEmailWithContext context
    newPassword <- getNewPasswordWithContext context
    newGenres <- getBookGenresWithContext context
    let genresFormated = words newGenres
    let listGenrers = mapGenres genresFormated
    setUser user newEmail newPassword listGenrers




