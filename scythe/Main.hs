{-# LANGUAGE BangPatterns      #-}
{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import           Control.Monad
import qualified Data.ByteString.Lazy as L
import           Data.CSV
import           Data.CSV.Lexer

main :: IO ()
main = do
  bs <- L.readFile "bobaadr.txt"
  print =<< foldM go 0 (getCSV bs)
    where
      go !n Newline = pure n
      go !n _ = pure (n + 1)
