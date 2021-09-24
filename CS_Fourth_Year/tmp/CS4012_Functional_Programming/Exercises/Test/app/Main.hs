module Main where

import System.Random

main = do
    g <- getStdGen
    print $ take 10 ( randoms g :: [Int])
