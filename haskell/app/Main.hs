module Main where
import Models.User

main::IO ()
main = do
    inputName <- getLine
    inputEmail <- getLine
    inputPassword <- getLine


    let user = User inputName inputEmail inputPassword ["Terror"]
    putStrLn $ name user
    putStrLn $ password user
    putStrLn $ email user
    