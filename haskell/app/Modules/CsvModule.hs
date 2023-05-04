module Modules.CsvModule where
import Modules.UtilModule (wordsWhen)
import Model.User (User)
import System.IO

append :: (Show t) => [t] -> FilePath -> IO ()
append values pathToFile = do
    appendFile pathToFile csvContent
  where
    csvContent = unlines $ map show values

<<<<<<< HEAD
read :: String -> IO [User]
read filePath = do
  let parser s = Prelude.read s :: User
  csvData <- readFile filePath
  seq (length csvData) (return ())
  let lines = wordsWhen (== '\n') csvData
  let dataList = map parser lines
  return dataList
=======
read :: (Read t) => (String -> t) -> FilePath -> IO [t]
read parser pathToFile = do
    csvData <- readFile pathToFile
    let lines = wordsWhen (== '\n') csvData
    let dataList = map parser lines
    return dataList


>>>>>>> 58e506ba67210db64f5089fba639e86aa0016899
