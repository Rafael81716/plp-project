module Modules.CLI.Favorites where

import Model.Book
import Model.User as User
import Modules.BookModule
import Modules.BookModule (getBookByName)
import Modules.CsvModule as CSV
import Modules.UserModule as UserModule
import Modules.UtilModule (centeredText, clear, removeFromList, waitOnScreen)
import Modules.ValidInput.Getter (getTitleWithContext)
import Modules.ValidInput.Validation (filterUserList, isValidIndex, isValidSize)
import System.Console.ANSI

printAddFavorites :: User -> IO User
printAddFavorites user = do
  title <- getTitleWithContext "Adicionar Favoritos"
  book <- getBookByName title
  if book == []
    then do
      putStrLn "Livro nao encontrado!"
      return user
    else do
      let idBook = num (head book)
      let favoriteList = favoriteBooks user

      if (isValidSize favoriteList) && (isValidIndex idBook favoriteList)
        then do
          UserModule.addFavorites user favoriteList idBook
        else do
          if not $ isValidSize favoriteList
            then do
              putStrLn ("Lista de favoritos cheia!")
              return user
            else do
              putStrLn ("Você ja tem esse livro favoritado!")
              return user

printRemoveFavorites :: User -> IO User
printRemoveFavorites user = do
  title <- getTitleWithContext "Remover Favoritos"
  book <- getBookByName title
  if book == []
    then do
      putStrLn "Livro nao encontrado!"
      return user
    else do
      let idBook = num (head book)
      let favoriteList = favoriteBooks user

      if (length favoriteList > 0) && (not (isValidIndex idBook favoriteList))
        then do
          UserModule.removeFavorites user favoriteList idBook
        else do
          if length favoriteList == 0
            then do
              putStrLn "Lista de favoritos vazia!"
              return user
            else do
              return user

printListFavorites :: User -> IO ()
printListFavorites user = do
  setSGR [SetColor Foreground Vivid Green]
  putStrLn (centeredText "Livros Favoritos")
  setSGR [Reset]
  listaFav <- UserModule.listFavorites user
  putStrLn listaFav
  waitOnScreen
  clear
