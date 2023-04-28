module Modules.InterfaceModule where
import Modules.UserModule 
import Modules.ValidationModule


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
    let isValidEmail = Modules.ValidationModule.isValidEmail email
    if isValidEmail == False then do
        clear
        putStrLn "Email invalido!\nDigite seus dados novamente!"
        printRegistering

        else do
            putStr "Digite sua senha: "
            password <- getLine
            let isValidPassword = Modules.ValidationModule.isValidPassword password

            if isValidPassword == False then do
                clear
                putStrLn "A senha tem que conter no minimo 6 caracteres! \nDigite seus dados novamente!"
                printRegistering
                
            else do
                putStr "\n"
                putStrLn "Escolha até 5 gêneros literários em ordem de preferência: " 
                printGenres

                genres <- getLine
                let genresFormated = words genres
                let listGenrers = mapGenres genresFormated
                Modules.UserModule.registerUser name email password listGenrers


   

   

printGenres:: IO()
printGenres = do
    putStrLn("\n 1 - Ficção Cientifica \n" ++
            " 2 - Fantasia \n" ++
            " 3 - Infantil \n" ++
            " 4 - Misterio \n" ++
            " 5 - Historia \n" ++
            " 6 - Aventura \n" ++
            " 7 - Romance \n")

    putStr "Escolha os gêneros, separando cada um por espaço: "

mapGenres:: [String] -> [String]
mapGenres [] = []
mapGenres (h:t) |h == "1" = ["Ficcao Cientifica"] ++ mapGenres(t)
                |h == "2" = ["Fantasia"] ++ mapGenres(t)
                |h == "3" = ["Infantil"] ++ mapGenres(t)
                |h == "4" = ["Misterio"] ++ mapGenres(t)
                |h == "5" = ["Historia"] ++ mapGenres(t)
                |h == "6" = ["Aventura"] ++ mapGenres(t)
                |h == "7" = ["Romance"] ++ mapGenres(t)


registro::IO()
registro = print "todo register"

invalidInput::IO()
invalidInput = putStrLn ("\n" ++ "Opção inválida!")


    


