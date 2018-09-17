{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE BangPatterns        #-}
module Main where

import           Control.Monad                     (foldM)
import qualified Data.ByteString.Lazy              as LBS
import           Data.Char
import qualified Data.Vector                       as DV
import qualified HaskellWorks.Data.Dsv.Lazy.Cursor as SVL

main :: IO ()
main = do
  bs <- LBS.readFile "bobaadr.txt"
  let c = SVL.makeCursor 44 {- 44 is ascii for comma -} bs
  let rows :: [DV.Vector LBS.ByteString] = SVL.toListVector c
  print =<< foldM go 0 rows
    where
      go !n rows = pure (n + length rows)
