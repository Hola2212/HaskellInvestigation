module Main where

import Control.Concurrent (threadDelay)
import System.Random (randomRIO)

data Cell = Alive | Dead deriving (Eq)
type Grid = [[Cell]]

showCell Alive = 'O'
showCell Dead  = '.'

printGrid grid = do
  putStrLn ""
  mapM_ (putStrLn . map showCell) grid

height = length
width g = length (head g)

getCell grid (r,c) =
  let h = height grid
      w = width grid
  in (grid !! ((r+h) `mod` h)) !! ((c+w) `mod` w)

neighbors =
  [(-1,-1),(-1,0),(-1,1),
   (0,-1),        (0,1),
   (1,-1),(1,0),(1,1)]

aliveNeighbors grid (r,c) =
  length [() | (dr,dc) <- neighbors,
               getCell grid (r+dr,c+dc) == Alive]

nextCell grid pos =
  case (getCell grid pos, aliveNeighbors grid pos) of
    (Alive,2) -> Alive
    (Alive,3) -> Alive
    (Dead,3)  -> Alive
    _         -> Dead

step grid =
  [ [ nextCell grid (r,c)
    | c <- [0..width grid - 1] ]
  | r <- [0..height grid - 1] ]

-- NEW
randomCell = do
  n <- randomRIO (0,1 :: Int)
  return (if n == 0 then Dead else Alive)

randomGrid h w =
  sequence [ sequence [randomCell | _ <- [1..w]]
           | _ <- [1..h] ]

main :: IO ()
main = do
  grid <- randomGrid 20 40
  mapM_
    (\g -> printGrid g >> threadDelay 300000)
    (take 100 (iterate step grid))