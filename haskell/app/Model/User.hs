module Model.User where
<<<<<<< HEAD
import Modules.BookModule
import Modules.UtilModule (parseStrToList, wordsWhen)
=======
<<<<<<< HEAD
import Modules.UtilModule (parseStrToList, wordsWhen, parseStrToBook)
=======
import Modules.UtilModule (parseStrToList, wordsWhen, parseStrToBooks)
>>>>>>> d31bff4afd6a8689076c072e7b60d2815daa6118
import Model.Book
>>>>>>> 58e506ba67210db64f5089fba639e86aa0016899

data User = User
  { nameUser :: String,
    email :: String,
    password :: String,
    bookGenres :: [String],
<<<<<<< HEAD
    favoriteBooks :: [Int],
    booksLoan:: [Int]
=======
    books::[Int]
>>>>>>> 58e506ba67210db64f5089fba639e86aa0016899
  }
  deriving (Eq)

instance Read User where
  readsPrec _ str =
    case wordsWhen (== ';') str of
<<<<<<< HEAD
      [n, e, s, gs, fb, bk] -> [(strToUser [n, e, s, gs, fb, bk], "")]
      _ -> []

instance Show User where
    show (User name email password bookGenres favoriteBooks booksLoan) = name ++ ";" ++ email ++ ";" ++ password ++ ";" ++ Prelude.show bookGenres ++ ";" ++ Prelude.show favoriteBooks ++ ";" ++ Prelude.show booksLoan
=======
      [n, e, s, gs, b] -> [(strToUser [n, e, s, gs, b], "")]
      _ -> []

instance Show User where
    show (User nameUser email password bookGenres books) = nameUser ++ ";" ++ email ++ ";" ++ password ++ ";" ++ Prelude.show bookGenres ++ ";" ++ Prelude.show books
>>>>>>> 58e506ba67210db64f5089fba639e86aa0016899

strToUser :: [String] -> User
strToUser x = do
  let n = head x
  let e = x !! 1
  let s = x !! 2
  let g = parseStrToList (x !! 3)
<<<<<<< HEAD
  let f = read (x !! 4)
  let b = read (x !! 5)
  User n e s g f b
=======
<<<<<<< HEAD
  let b = parseStrToBook (x !! 4)
=======
  let b = parseStrToBooks (x !! 4)
>>>>>>> d31bff4afd6a8689076c072e7b60d2815daa6118
  User n e s g b
  
>>>>>>> 58e506ba67210db64f5089fba639e86aa0016899
