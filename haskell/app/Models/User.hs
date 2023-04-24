module Models.User where
    data User = User{
        name::String,
        email::String,
        password::String,
        bookGenres:: [String]
    } deriving(Show,Eq,Read)
   
    
