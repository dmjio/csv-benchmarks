{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE BangPatterns      #-}
{-# LANGUAGE MultiWayIf        #-}
module Main where

import           Control.Monad
import           Data.ByteString.Lazy       (ByteString)
import qualified Data.ByteString.Lazy       as L
import qualified Data.ByteString.Lazy.Char8 as L8
import           Data.Word
import           System.IO

-- bobaadr.txt: ASCII text, with CRLF line terminators

main :: IO ()
main = do
  lbs <- L.readFile "bobaadr.txt"
  -- let len = length $ scanner $ head $ take 1 (L8.lines lbs)
  print $ length (scanner lbs)

-- chunksOf :: Int -> [a] -> [[a]]
-- chunksOf _ [] = []
-- chunksOf len xs = do
--   let (chunk, rest) = splitAt len xs
--   chunk : chunksOf len rest

carriageReturn, newLine, comma, doubleQuote :: Word8
carriageReturn = 13
doubleQuote = 34
newLine = 10
comma = 44

scanner :: ByteString -> [ByteString]
scanner bs
  | L.null bs = []
  | otherwise =
     case L.uncons bs of
       Nothing -> []
       Just (h, t) ->
         if | h == carriageReturn ->
            case L.uncons t of
              Nothing -> []
              Just (h2, t2) ->
                if h2 == newLine
                  then scanner t2
                  else [] -- impossible here
            | h == doubleQuote ->
              case startEscaped t of
                (x,xs) -> x : scanner xs
            | h == comma -> scanner t
            | otherwise -> do
                case startUnescaped bs of
                  (x, xs) -> x : scanner xs

startUnescaped
  :: ByteString
  -> (ByteString, ByteString)
startUnescaped bs | otherwise = L.break pred bs
  where
    pred = (`L.elem` shouldBreak)

shouldBreak :: ByteString
shouldBreak = L.pack [ carriageReturn
                     , comma
                     ]

startEscaped :: ByteString -> (ByteString, ByteString)
startEscaped bs = L.drop 1 <$> L.break (==doubleQuote) bs
