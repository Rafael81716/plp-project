
printAllBooks :: [Book] -> String
printAllBooks (x:xs)
    | null (x:xs) = ""
    | null xs = show (num x) ++ " - " ++ name x ++ " - " ++ author x ++ " (" ++ genre x ++ ")" ++ "\n"
    | otherwise = show (num x) ++ " - " ++ name x ++ " - " ++ author x ++ " (" ++ genre x ++ ")" ++ "\n" ++ printAllBooks xs
splitBy :: Char -> String -> [String]
splitBy sep = wordsWhen (== sep)