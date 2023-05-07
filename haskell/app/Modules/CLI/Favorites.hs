module Modules.CLI.Favorites where

import Model.Book
import Model.User as User
import Modules.BookModule
import Modules.CsvModule as CSV
import Modules.UserModule as UserModule
import Modules.UtilModule (removeFromList)
import Modules.ValidInput.Validation (filterUserList, isValidIndex, isValidSize)

removeFavorites :: User -> IO ()
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
          let listaFavoritosAtt = removeFromList livroId listaFavoritos
          let user = User (User.name usuario) (email usuario) (password usuario) (bookGenres usuario) listaFavoritosAtt (booksLoan usuario) (recentBooks usuario)
          userList <- getUserList
          let newList = user : filterUserList (email usuario) userList
          writeFile "users.csv" ""
          CSV.append newList "users.csv"
          putStrLn "Livro removido com sucesso!"
        else do
          if length listaFavoritos == 0
            then do
              putStrLn "Lista de favoritos vazia!"
            else do
              putStrLn "Livro não está na lista de favoritos!"

addFavorites :: User -> IO ()
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
          let user = User (User.name usuario) (email usuario) (password usuario) (bookGenres usuario) listaFavoritosAtt (booksLoan usuario) (recentBooks usuario)
          userList <- getUserList
          let newList = user : filterUserList (email usuario) userList
          writeFile "users.csv" ""
          CSV.append newList "users.csv"
          putStrLn "Livro adicionado com sucesso!"
        else do
          if not $ isValidSize listaFavoritos
            then do
              putStrLn "Lista De Favoritos Cheia!"
            else do
              putStrLn "Livro Já está nos Favoritos!"
