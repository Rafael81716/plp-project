module Modules.CsvModule where
import Modules.UtilModule (wordsWhen)

append :: (Show t) => [t] -> FilePath -> IO ()
append values pathToFile = do
    appendFile pathToFile csvContent
  where
    csvContent = unlines $ map show values

read :: (Read t) => (String -> t) -> FilePath -> IO [t]
read parser pathToFile = do
    csvData <- readFile pathToFile
    let lines = wordsWhen (== '\n') csvData
    let dataList = map parser lines
    return dataList