{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}
module Main where

import           Data.ByteString.Lazy
import qualified Data.ByteString.Lazy as L
import           Data.Word
import           Foreign.Ptr
import           System.IO
import           System.IO.MMap

main :: IO ()
main = do
  lbs <- L.readFile "bobaadr.txt"
  print $ Prelude.length (scanner lbs)

carriageReturn :: Word8
carriageReturn = 34

newLine :: Word8
newLine = 10

comma :: Word8
comma = 44

doubleQuote :: Word8
doubleQuote = 42

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
startUnescaped bs = do
  let (ls,rs) = L.break pred bs
  (ls, rs)
    where
      pred p = p `L.elem` shouldBreak

shouldBreak = L.pack [ carriageReturn
                     , newLine
                     , comma
                     -- can't see double quotes
                     ]

startEscaped :: ByteString -> (ByteString, ByteString)
startEscaped bs = do
  let (ls,rs) = L.break (==doubleQuote) bs
  case L.uncons rs of
    Nothing -> (ls, L.empty)
    Just (h,ts) ->
      if h == doubleQuote
        -- Handle case where double quotes occur
        then undefined
        else (ls,ts)

beginEscape :: ByteString -> ByteString
beginEscape bs = bs


