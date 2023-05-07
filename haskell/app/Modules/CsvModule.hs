module Modules.CsvModule where

import Modules.UtilModule (splitBy)

append :: (Show t) => [t] -> FilePath -> IO ()
append values pathToFile = do
  appendFile pathToFile csvContent
  where
    csvContent = unlines $ map show values

read :: (String -> t) -> String -> IO [t]
read parser filePath = do
  csvData <- readFile filePath
  seq (length csvData) (return ())
  let lines = splitBy '\n' csvData
  let dataList = map parser lines
  return dataList

write :: (Show t) => [t] -> FilePath -> IO ()
write values pathToFile = do
  writeFile pathToFile csvContent
  where
    csvContent = unlines $ map show values
