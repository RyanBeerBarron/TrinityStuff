{-# LANGUAGE OverloadedStrings #-}
import Control.Exception
import Control.Parallel
import Control.DeepSeq
import Data.List
import System.Random
import System.Clock
import Formatting
import Formatting.Clock

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


main = do
    let low = 1
    let high = 100000
    let length = 1000000
    list <- randomList length (low, high)

    print "Starting quicksort..."
    start <- getTime Monotonic
    let quickSorted = quickSort list
    return $! force quickSorted
    end <- getTime Monotonic
    print "Finished."
    fprint (timeSpecs % "\n") start end
    assert (quickSorted == sort list) return 1
    
    print "Starting merge sort..."
    start <- getTime Monotonic
    let mergeSorted = mergeSort list
    return $! force mergeSorted
    end <- getTime Monotonic
    print "Finished."
    fprint (timeSpecs % "\n") start end
    assert (mergeSorted == sort list) return 1
    