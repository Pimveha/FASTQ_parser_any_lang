import System.IO
import Data.Maybe (mapMaybe)

data FastqRecord = FastqRecord
    { header :: String
    , sequence :: String
    , quality :: String
    } deriving Show

parseFastqRecord :: [String] -> Maybe FastqRecord
parseFastqRecord (h : s : _ : q : _) = Just (FastqRecord h s q)
parseFastqRecord _ = Nothing

parseFastqFile :: FilePath -> IO [FastqRecord]
parseFastqFile filePath = do
    contents <- readFile filePath
    let linesList = lines contents
    let records = splitEvery 4 linesList
    let parsedRecords = map parseFastqRecord records
    return (mapMaybe id parsedRecords)

splitEvery :: Int -> [a] -> [[a]]
splitEvery _ [] = []
splitEvery n list = first : splitEvery n rest
    where (first, rest) = splitAt n list

getNthRecord :: [FastqRecord] -> Int -> Maybe FastqRecord
getNthRecord records n
    | n >= 1 && n <= length records = Just (records !! (n - 1))
    | otherwise = Nothing

main :: IO ()
main = do
    records <- parseFastqFile "./example.fastq"

    -- userNum <- readLn :: IO Int
    -- let nthRecord = getNthRecord records userNum
    let nthRecord = getNthRecord records 1
    case nthRecord of
        Just record -> print record
        Nothing     -> putStrLn "Record not found"
