module Model.User where
import Modules.UtilModule (parseStrToList, wordsWhen)
import Model.Book

data User = User
  { nameUser :: String,
    email :: String,
    password :: String,
    bookGenres :: [String],
    books::[Book]
  }
  deriving (Eq)

instance Read User where
  readsPrec _ str =
    case wordsWhen (== ';') str of
      [n, e, s, gs] -> [(strToUser [n, e, s, gs], "")]
      _ -> []

instance Show User where
    show (User name email password bookGenres books) = name ++ ";" ++ email ++ ";" ++ password ++ ";" ++ Prelude.show bookGenres ++ ";" ++ Prelude.show books

strToUser :: [String] -> User
strToUser x = do
  let n = head x
  let e = x !! 1
  let s = x !! 2
  let g = parseStrToList (x !! 3)
  let b = []
  User n e s g b
  