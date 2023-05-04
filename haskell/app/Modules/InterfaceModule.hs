module Modules.InterfaceModule where
import Modules.UserModule as UserModule
import Modules.ValidInput.Getter (getNameWithContext, getEmailWithContext, getPasswordWithContext, getLoginRegisterOptionWithContext)
import Modules.UtilModule (centeredText, clear, mapGenres)
import Model.User
import Modules.BookModule (getBookByName, Book)
import qualified Text.CSV
import Modules.CsvModule as CSV

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
    Nothing -> do
      print "Senha invalida, tente novamente"
      loginMenu
    Just user -> do
      print (bookGenres user)
      print (favoriteBooks user)
      addFavorites user

addFavorites :: User -> IO()
addFavorites usuario = do
  putStrLn "Insira o nome do livro: "
  nomeLivro <- getLine
  book <- getBookByName nomeLivro
  if book == []
    then do
      putStrLn "Livro nao encontrado!"
      addFavorites usuario
    else do
      let listaFavoritos = favoriteBooks usuario
      let listaFavoritosAtt = listaFavoritos ++ book
      let user = User (name usuario) (email usuario) (password usuario) (bookGenres usuario) listaFavoritosAtt
      userList <- getUserList
      let newList = user:filterUserList (email usuario) userList
      writeFile "users.csv" ""
      recursiveAppend newList

recursiveAppend :: [User] -> IO()
recursiveAppend [] = return ()
recursiveAppend (x:xs) = do
  CSV.append [x] "users.csv"
  recursiveAppend xs

filterUserList :: String -> [User] -> [User]
filterUserList em [] = []
filterUserList em (x:xs) = if email x == em
  then filterUserList em xs
  else x:filterUserList em xs

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
        UserModule.registerUser name email password listGenrers []

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
