module Lib
    ( someFunc,
    mergeSort,
    quickSort,
    randomList
    ) where

import Data.List
import System.Random


someFunc :: IO ()
someFunc = putStrLn "someFunc"

randomList :: Int -> (Int, Int) -> IO [Int]
randomList 0 _ = return []
randomList n bounds
        | n > 0 =  do 
            r <- randomRIO bounds
            rs <- randomList (n-1) bounds
            return (r:rs)
        | otherwise = return []    


mergeSort :: (Ord a) => [a] -> [a]
mergeSort [] = []
mergeSort [a] = [a]
mergeSort a =   let firstHalf = take (length a `div` 2) a
                    secondHalf = drop (length a `div` 2) a
                in  merge (mergeSort firstHalf) (mergeSort secondHalf)
                
merge :: (Ord a) => [a] -> [a] -> [a]
merge a [] = a
merge [] b = b
merge (x:xs) (y:ys)
    | x < y = x : (merge  xs (y:ys))
    | otherwise = y : (merge (x:xs) ys)  


quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs) = quickSort [ lowerThanXs | lowerThanXs <- xs, lowerThanXs <= x ] ++ [x] ++ ( quickSort [ higherThanXs | higherThanXs <- xs, higherThanXs > x ] )