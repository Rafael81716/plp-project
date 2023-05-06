module Model.User where
import Modules.BookModule
import Modules.UtilModule (parseStrToList, wordsWhen, parseStrToBook)
import Model.Book

data User = User
  { nameUser :: String,
    email :: String,
    password :: String,
    bookGenres :: [String],
    favoriteBooks :: [Int],
    booksLoan:: [Int],
    booksHistoric:: [Int]
  }
  deriving (Eq)

instance Read User where
  readsPrec _ str =
    case wordsWhen (== ';') str of
      [n, e, s, gs, fb, bk, bh] -> [(strToUser [n, e, s, gs, fb, bk, bh], "")]
      _ -> []

instance Show User where
    show (User name email password bookGenres favoriteBooks booksLoan booksHistoric) = name ++ ";" ++ email ++ ";" ++ password ++ ";" ++ Prelude.show bookGenres ++ ";" ++ Prelude.show favoriteBooks ++ ";" ++ Prelude.show booksLoan ++ ";" ++ Prelude.show booksHistoric

strToUser :: [String] -> User
strToUser x = do
  let n = head x
  let e = x !! 1
  let s = x !! 2
  let g = parseStrToList (x !! 3)
  let f = read (x !! 4)
  let b = read (x !! 5)
  let a = read (x !! 6)
  User n e s g f b a


