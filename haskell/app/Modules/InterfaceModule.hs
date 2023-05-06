module Modules.InterfaceModule where
import Modules.UserModule as UserModule
import Modules.ValidInput.Getter (getNameWithContext, getEmailWithContext, getPasswordWithContext, getLoginRegisterOptionWithContext, getMainMenuOption, getTitleWithContext, getOptionsBookLoan, getAuthorWithContext, getGenreWithContext)
import Modules.UtilModule (centeredText, clear, mapGenres)
import Modules.BookModule (getBookByName,wordsWhenB, strToBook, getBookByName, contentLoanInUser, getBookByAuthor, printAllBooks, getBookByGenre)
import qualified Text.CSV
import Modules.CsvModule as CSV
import Modules.ValidInput.Validation (isValidSize, isValidIndex, filterUserList)
import Model.User
import Model.Book
import Control.Monad.Trans.RWS.Lazy (put)
import Data.Binary.Put (putWord64host)


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
      mainMenu user

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
          let user = User (nameUser usuario) (email usuario) (password usuario) (bookGenres usuario) listaFavoritosAtt (booksLoan usuario)
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
          let user = User (nameUser usuario) (email usuario) (password usuario) (bookGenres usuario) listaFavoritosAtt (booksLoan usuario)
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


registeringMenu :: IO ()
registeringMenu = do
  let context = "Cadastre-se"

  name <- getNameWithContext context
  email <- getEmailWithContext context
  userIsNotRegistered email >>= \isNotRegistered ->
    if not isNotRegistered then do
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
  else if option == "2" then printMakeLoanByAuthor user
  else printMakeLoanByGender user
  

printMakeLoanByTitle:: User -> IO()
printMakeLoanByTitle user = do
  title <- getTitleWithContext "Empréstimo"
  book <- getBookByName title
  let bookId = num(head book)
  if book == [] then do
    putStrLn("Livro nao consta na base de dados!")
    printMakeLoanByTitle user
  
  else
    if isValidSize (booksLoan user) == False then do
      putStrLn("O Usuario ja atingiu o numero maximo de emprestimos")
      mainMenu user

    else
      if contentLoanInUser (booksLoan user) bookId == True then do
        putStrLn("Este usuario ja tem esse livro emprestado, escolha outro!")
        printMakeLoanByTitle user
        
      else do
      UserModule.makeLoanByTitle user bookId

printMakeLoanByAuthor:: User -> IO()
printMakeLoanByAuthor user = do
  author <- getAuthorWithContext "Empréstimo"
  books <- getBookByAuthor author
  if isValidSize (booksLoan user) == False then  do
      putStrLn("O Usuario ja atingiu o numero maximo de emprestimos")
      mainMenu user
      else 
      if books == [] then do
        putStrLn("Este autor nao esta cadastrado no sistema!")
        printMakeLoanByAuthor user
      else do
        let booksAuthor = printAllBooks books
        putStrLn (booksAuthor)
        putStrLn "Escolha um livro pelo titulo: "
        printMakeLoanByTitle user
       
printMakeLoanByGender:: User -> IO()
printMakeLoanByGender user = do
  genre <- getGenreWithContext "Empréstimo"
  books <- getBookByGenre genre
  if isValidSize (booksLoan user) == False then  do
      putStrLn("O Usuario ja atingiu o numero maximo de emprestimos.")
      mainMenu user
  else if books == [] then do
        putStrLn("Nao ha livros desse genero cadastrados no sistema.")
        printMakeLoanByGender user
  else do 
        let booksGenre = printAllBooks books
        putStrLn (booksGenre)
        putStrLn "Escolha um livro pelo titulo: "
        printMakeLoanByTitle user



 
printReturnBook::IO()
printReturnBook = do
  print("foi")
