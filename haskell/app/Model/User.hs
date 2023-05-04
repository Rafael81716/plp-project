module Model.User where
<<<<<<< HEAD
import Modules.UtilModule (parseStrToList, wordsWhen, parseStrToBook)
=======
import Modules.UtilModule (parseStrToList, wordsWhen, parseStrToBooks)
>>>>>>> d31bff4afd6a8689076c072e7b60d2815daa6118
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
<<<<<<< HEAD
  let b = parseStrToBook (x !! 4)
=======
  let b = parseStrToBooks (x !! 4)
>>>>>>> d31bff4afd6a8689076c072e7b60d2815daa6118
  User n e s g b
  