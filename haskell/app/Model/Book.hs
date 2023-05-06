module Model.Book where
data Book = Book{
    num::Int,
    name::String,
    author::String,
    genre::String,
    link::String
} deriving (Eq, Read)

instance Show Book where
    show(Book num name author genre link) = show num ++ ";" ++name ++ ";" ++ author ++ ";" ++ genre ++ ";" ++ link