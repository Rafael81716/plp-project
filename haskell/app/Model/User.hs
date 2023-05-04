module Model.User where
import Modules.UtilModule (parseStrToList, wordsWhen, parseStrToBook)
import Model.Book

data User = User
  { nameUser :: String,
    email :: String,
    password :: String,
    bookGenres :: [String],
    books::[Int]
  }
  deriving (Eq)

instance Read User where
  readsPrec _ str =
    case wordsWhen (== ';') str of
      [n, e, s, gs, b] -> [(strToUser [n, e, s, gs, b], "")]
      _ -> []

instance Show User where
    show (User nameUser email password bookGenres books) = nameUser ++ ";" ++ email ++ ";" ++ password ++ ";" ++ Prelude.show bookGenres ++ ";" ++ Prelude.show books

strToUser :: [String] -> User
strToUser x = do
  let n = head x
  let e = x !! 1
  let s = x !! 2
  let g = parseStrToList (x !! 3)
  let b = parseStrToBook (x !! 4)
  User n e s g b
  