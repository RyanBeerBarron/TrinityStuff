module Main where

import Lib

data Tree a = Leaf a
            | Node a (Tree a) (Tree a)
            deriving Show

count :: Tree a -> Int
count (Leaf _) = 1
count (Node a left right) = 1 + count left + count right


main :: IO ()
main =  someFunc