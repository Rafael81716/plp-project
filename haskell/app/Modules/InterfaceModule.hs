module Modules.InterfaceModule where
import Modules.UserModule as UserModule
import Modules.ValidInput.Getter (getNameWithContext, getEmailWithContext, getPasswordWithContext, getLoginRegisterOptionWithContext, getMainMenuOption, getTitleWithContext, getOptionsBookLoan)
import Modules.UtilModule (centeredText, clear, mapGenres)
import Model.User
import Modules.BookModule (getBookByName, Book, wordsWhenB, strToBook, num)
import qualified Text.CSV
import Modules.CsvModule as CSV
import Modules.ValidInput.Validation (isValidSize, isValidIndex)


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

removeFavorites :: User -> IO()
removeFavorites usuario = do
  putStrLn "Insira o nome do livro: "
  nomeLivro <- getLine
  book <- getBookByName nomeLivro
  if book == []
    then do
      putStrLn "Livro nao encontrado!"
      removeFavorites usuario
    else do
      let livroId = num (head book)
      let listaFavoritos = favoriteBooks usuario
      if (length listaFavoritos > 0) && (not (isValidIndex livroId listaFavoritos))
        then do
          let listaFavoritosAtt = removeElement livroId listaFavoritos
          let user = User (name usuario) (email usuario) (password usuario) (bookGenres usuario) listaFavoritosAtt (booksLoan usuario)
          userList <- getUserList
          let newList = user:filterUserList (email usuario) userList
          writeFile "users.csv" ""
          CSV.append newList "users.csv"
          putStrLn "Livro removido com sucesso!"
        else do
          if length listaFavoritos == 0
            then do
              putStrLn "Lista de favoritos vazia!"
            else do
              putStrLn "Livro não está na lista de favoritos!"


removeElement :: Eq a => a -> [a] -> [a]
removeElement x xs = filter (/= x) xs

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
      let livroId = num (head book)
      let listaFavoritos = favoriteBooks usuario
      if (isValidSize listaFavoritos) && (isValidIndex livroId listaFavoritos)
        then do
          let listaFavoritosAtt = listaFavoritos ++ [livroId]
          let user = User (name usuario) (email usuario) (password usuario) (bookGenres usuario) listaFavoritosAtt (booksLoan usuario)
          userList <- getUserList
          let newList = user:filterUserList (email usuario) userList
          writeFile "users.csv" ""
          CSV.append newList "users.csv"
          putStrLn "Livro adicionado com sucesso!"
        else do
          if not $ isValidSize listaFavoritos
            then do
              putStrLn "Lista De Favoritos Cheia!"
            else do
              putStrLn "Livro Já está nos Favoritos!"

filterUserList :: String -> [User] -> [User]
filterUserList _ [] = []
filterUserList em (x:xs) = if email x == em
  then filterUserList em xs
  else x : filterUserList em xs

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
        UserModule.registerUser name email password listGenrers [] []

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


mainMenu:: User -> IO()
mainMenu user = do
  option <- getMainMenuOption "Menu Principal"
  readMainMenu user option

readMainMenu:: User -> String -> IO()
readMainMenu user option | option == "1" = printMakeLoan user
                    | option == "2" = printReturnBook
                    | otherwise = print("todo other functionss")


printMakeLoan:: User ->IO()
printMakeLoan user  = do
  option <- getOptionsBookLoan "Empréstimo"
  if option == "1" then printMakeLoanByTitle user
  else if option == "2" then printMakeLoanByAuthor
  else printMakeLoanByGender
  

printMakeLoanByTitle:: User -> IO()
printMakeLoanByTitle user = do
  title <- getTitleWithContext "Empréstimo"
  UserModule.makeLoanByTitle user title

printMakeLoanByAuthor::IO()
printMakeLoanByAuthor = do
  putStrLn "autor"

printMakeLoanByGender::IO()
printMakeLoanByGender = do
  putStrLn "gender"

printReturnBook::IO()
printReturnBook = do
  print("foi")
