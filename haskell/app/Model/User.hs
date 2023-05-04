module Model.User where
import Modules.BookModule
import Modules.UtilModule (parseStrToList, wordsWhen)

data User = User
  { name :: String,
    email :: String,
    password :: String,
    bookGenres :: [String],
    favoriteBooks :: [Int]
  }
  deriving (Eq)

instance Read User where
  readsPrec _ str =
    case wordsWhen (== ';') str of
      [n, e, s, gs, fb] -> [(strToUser [n, e, s, gs, fb], "")]
      _ -> []

instance Show User where
    show (User name email password bookGenres favoriteBooks) = name ++ ";" ++ email ++ ";" ++ password ++ ";" ++ Prelude.show bookGenres ++ ";" ++ Prelude.show favoriteBooks

strToUser :: [String] -> User
strToUser x = do
  let n = head x
  let e = x !! 1
  let s = x !! 2
  let g = parseStrToList (x !! 3)
  let f = read (x !! 4)
  User n e s g f