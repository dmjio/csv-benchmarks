{-# LANGUAGE BangPatterns #-}
module Main where

import           Data.ByteString      (ByteString)
import qualified Data.ByteString      as B
import           Data.Csv.Incremental
import           Data.Either          (rights)
import           Data.Vector          (Vector)
import qualified Data.Vector          as V
import           System.Exit
import           System.IO

main :: IO ()
main = withFile "bobaadr.txt" ReadMode $ \ csvFile -> do
    let loop :: Int -> Parser (Vector ByteString) -> IO ()
        loop !_ (Fail _ errMsg) = putStrLn errMsg >> exitFailure
        loop acc (Many rs k)    = loop (acc + sum (map V.length (rights rs))) =<< feed k
        loop acc (Done rs)      = print (sum (map V.length (rights rs)) + acc)
        feed k = do
            isEof <- hIsEOF csvFile
            if isEof
                then return $ k B.empty
                else k `fmap` B.hGetSome csvFile 4096
    loop 0 (decode NoHeader)
