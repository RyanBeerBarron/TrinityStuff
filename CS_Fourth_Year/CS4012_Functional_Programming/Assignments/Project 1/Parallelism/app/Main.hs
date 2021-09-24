module Main where


import Lib
import System.CPUTime
import Text.Printf


main :: IO ()
main = do
    list <- randomList 10 (1, 100000)
    start1 <- getCPUTime
    let quickSorted = quickSort list
    end1 <- getCPUTime
    start2 <- getCPUTime
    let mergeSorted = mergeSort list
    end2 <- getCPUTime
    let diff1 = (fromIntegral (end1 - start1) / (10^12))
        diff2 = (fromIntegral (end2 - start2) / (10^12))
    print [list, quickSorted, mergeSorted]
    printf "Time for quicksort: %0.9f sec\n" (diff1 :: Double)  
    printf "Time for mergesort: %0.9f sec\n" (diff2 :: Double) 

