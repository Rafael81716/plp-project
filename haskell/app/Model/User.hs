module Model.User where
import Util (parseStrToList, wordsWhen)

data User = User
  { name :: String,
    email :: String,
    password :: String,
    bookGenres :: [String]
  }
  deriving (Eq)

instance Read User where
  readsPrec _ str =
    case wordsWhen (== ';') str of
      [n, e, s, gs] -> [(strToUser [n, e, s, gs], "")]
      _ -> []

instance Show User where
    show (User name email password bookGenres) = name ++ ";" ++ email ++ ";" ++ password ++ ";" ++ Prelude.show bookGenres

strToUser :: [String] -> User
strToUser x = do
  let n = head x
  let e = x !! 1
  let s = x !! 2
  let g = parseStrToList (x !! 3)
  User n e s g
  