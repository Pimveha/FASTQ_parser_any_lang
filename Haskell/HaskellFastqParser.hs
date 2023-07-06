import System.IO

readFile :: FilePath -> IO
readFile path = do
    contents <- readFile filePath
    let linesList = lines contents
    return linesList

readNthLineIndex :: FilePath -> Int -> IO (Maybe String)
readNthLineIndex filePath n = do
    contents <- readFile filePath
    let linesList = lines contents
    if n >= 1 && n <= length linesList
        then return (Just (linesList !! (n - 1)))
        else return Nothing



main :: IO ()
main = do
    contents <- readFile "./example.fastq"

    -- putStrLn contents

    let linesList = lines contents
    putStrLn $ show linesList
    -- putStrLn linesList
