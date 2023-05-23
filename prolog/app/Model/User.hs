module Model.User where

import Modules.UtilModule (parseStrToList, splitBy)

data User = User
  { name :: String,
    email :: String,
    password :: String,
    bookGenres :: [String],
    favoriteBooks :: [Int],
    booksLoan :: [Int],
    recentBooks :: [Int]
  }
  deriving (Eq)

instance Read User where
  readsPrec _ str = [(strToUser str, "")]

instance Show User where
  show (User n e p bG fB bL rB) = n ++ ";" ++ e ++ ";" ++ p ++ ";" ++ Prelude.show bG ++ ";" ++ Prelude.show fB ++ ";" ++ Prelude.show bL ++ ";" ++ Prelude.show rB

strToUser :: String -> User
strToUser userStr = do
  let attList = splitBy ';' userStr

  let n = head attList
  let e = attList !! 1
  let s = attList !! 2
  let g = parseStrToList (attList !! 3)
  let f = read (attList !! 4)
  let b = read (attList !! 5)
  let a = read (attList !! 6)
  User n e s g f b a
