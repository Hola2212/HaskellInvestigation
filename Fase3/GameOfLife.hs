module Main where

import Control.Concurrent (threadDelay)

data Cell = Alive | Dead deriving (Eq)
type Grid = [[Cell]]

-- ----- Display -----

showCell :: Cell -> Char
showCell Alive = 'O'
showCell Dead  = '.'

printGrid :: Grid -> IO ()
printGrid grid = do
  putStrLn ""
  mapM_ (putStrLn . map showCell) grid

-- ----- Grid helpers -----

height :: Grid -> Int
height = length

width :: Grid -> Int
width g = length (head g)

getCell :: Grid -> (Int, Int) -> Cell
getCell grid (r,c)
  | r < 0 || r >= height grid = Dead
  | c < 0 || c >= width grid  = Dead
  | otherwise = (grid !! r) !! c

neighbors :: [(Int, Int)]
neighbors =
  [(-1,-1),(-1,0),(-1,1),
   (0,-1),        (0,1),
   (1,-1),(1,0),(1,1)]

aliveNeighbors :: Grid -> (Int, Int) -> Int
aliveNeighbors grid (r,c) =
  length [() | (dr,dc) <- neighbors,
               getCell grid (r+dr,c+dc) == Alive]

-- ----- Rules -----

nextCell :: Grid -> (Int, Int) -> Cell
nextCell grid pos =
  case (getCell grid pos, aliveNeighbors grid pos) of
    (Alive,2) -> Alive
    (Alive,3) -> Alive
    (Dead,3)  -> Alive
    _         -> Dead

step :: Grid -> Grid
step grid =
  [ [ nextCell grid (r,c)
    | c <- [0..width grid - 1] ]
  | r <- [0..height grid - 1] ]

-- ----- Initial grid -----

glider :: Grid
glider =
  [ [Dead, Alive, Dead, Dead, Dead]
  , [Dead, Dead, Alive, Dead, Dead]
  , [Alive, Alive, Alive, Dead, Dead]
  , [Dead, Dead, Dead, Dead, Dead]
  , [Dead, Dead, Dead, Dead, Dead]
  ]

-- ----- Loop -----

run :: Grid -> IO ()
run grid = do
  printGrid grid
  threadDelay 300000
  run (step grid)

main :: IO ()
main = run glider