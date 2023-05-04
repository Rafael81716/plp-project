module Modules.UserModule where

import Modules.CsvModule as CSV
import Model.User
import Modules.UtilModule (wordsWhen)
import Data.Maybe
import Modules.BookModule

registerUser :: String -> String -> String -> [String] -> [Book] -> IO ()
registerUser readName readEmail readPassword readGenres readFavorites = do
  let user = User readName readEmail readPassword readGenres readFavorites
  CSV.append [user] "users.csv"
  
userIsNotRegistered :: String -> IO Bool
userIsNotRegistered email = do
  maybeUser <- getUser email
  return $ isNothing maybeUser

getUser :: String -> IO (Maybe User)
getUser em = do
  userList <- CSV.read "users.csv"
  let user = filter (\u -> email u == em) userList

  case user of
    [] -> return Nothing
    (u:_) -> return (Just u)

getUserList :: IO [User]
getUserList = CSV.read "users.csv"

loginUser :: String -> String -> IO (Maybe User)
loginUser em pass = do
  result <- getUser em

  case result of
    Nothing -> return Nothing
    Just user -> if password user == pass then return (Just user) else return Nothing
