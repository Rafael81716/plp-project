module Modules.InterfaceModule where

listLength :: [String] -> Int
listLength list = length list
verticalSpace n = sequence_ (replicate n (putStrLn ""))

clear :: IO()
clear = putStrLn ("\ESC[2J")

centeredText :: String -> String
centeredText text =
  let width = 40
      padding = replicate ((width - length text) `div` 2) ' '
  in replicate width '-' ++ "\n" ++ padding ++ text ++ padding ++ "\n" ++ replicate width '-'

printLoginRegister:: IO()
printLoginRegister = do
    putStrLn(centeredText "Início")
    putStrLn("1 - Entrar \n"  ++
          "2 - Cadastrar")

    putStr "Escolha uma opção: "
    option <- getLine
    clear
    readLoginRegister (read option)


    
readLoginRegister:: Int -> IO()
readLoginRegister option
                  | option == 1 = printLogin
                  | option == 2 = printRegistering
                  | otherwise = do
                    invalidInput
                    printLoginRegister

printLogin::IO()
printLogin = do
    putStrLn (centeredText "Login")
    putStr "Digite o seu email: "
    email <- getLine
    putStr "Digite a sua senha: "
    password <- getLine
    clear
    readLogin (read email) (read password)

readLogin:: String -> String -> IO()
readLogin email password = print "todo readLogin"


printRegistering::IO()
printRegistering = do
    putStrLn( centeredText "Cadastre-se")
    putStr "Digite seu nome: "
    name <- getLine

    putStr "Digite seu email: "
    email <- getLine

    putStr "Digite sua senha: "
    password <- getLine

    putStr "\n"

    putStrLn "Escolha até 5 gêneros literários em ordem de preferência: "
    printGenres



printGenres:: IO()
printGenres = do
    putStrLn("1 - Ficção Científica \n"  ++
          "2 - Ação e Aventura \n" ++
          "3 - Biografia \n" ++ 
          "4 - Fantasia \n" ++
          "5 - Distopia \n" ++ 
          "6 - Suspense \n" ++
          "7 - Mistério \n" ++ 
          "8 - Infantil  \n" ++
          "9 - Comédia \n" ++
          "10 - Romance \n" ++
          "11 - Terror \n" ++ 
          "12 - HQ \n")

    putStr "Escolha até 5 gêneros, separando cada um por espaço: "
    genres <- getLine 
    let listGenrers = words genres
    let numberOfGenres = listLength listGenrers
    mapGenres listGenrers numberOfGenres
    print "Dados salvos com sucesso!"

readGenres:: [String] -> [String]
readGenres x = x

mapGenres::[String] -> Int -> IO()
mapGenres listGenres n = do
    if n > 5 
    then do
        let newListGenres = take (n - 5) listGenres
        print "todo mapGenres"
    else print "todo mapGenres"
        
        

registro::IO()
registro = print "todo register"

invalidInput::IO()
invalidInput = putStrLn ("\n" ++ "Opção inválida!")


    


