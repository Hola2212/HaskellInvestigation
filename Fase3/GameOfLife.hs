module Main where

import Control.Concurrent (threadDelay)
import System.Random (randomRIO)

data Cell = Alive | Dead deriving (Eq)
type Grid = [[Cell]]

showCell Alive = "\ESC[32m█\ESC[0m"
showCell Dead  = "\ESC[90m█\ESC[0m"

printGrid grid = do
  let w = length (head grid)
      horizontal = "+" ++ replicate w '-' ++ "+"
  putStrLn horizontal
  mapM_ (\row -> putStrLn ("|" ++ concatMap showCell row ++ "|")) grid
  putStrLn horizontal

-- Shifting

shiftLeft (x:xs) = xs ++ [x]
shiftLeft [] = []

shiftRight xs = last xs : init xs

shiftUp (r:rs) = rs ++ [r]
shiftUp [] = []

shiftDown g = last g : init g

neighborsGrids g =
  [ shiftUp g
  , shiftDown g
  , map shiftLeft g
  , map shiftRight g
  , map shiftLeft (shiftUp g)
  , map shiftRight (shiftUp g)
  , map shiftLeft (shiftDown g)
  , map shiftRight (shiftDown g)
  ]

-- Conversion

toInt Alive = 1
toInt Dead  = 0

addGrids = zipWith (zipWith (+))

zeroGrid :: Grid -> [[Int]]
zeroGrid g = map (map (const 0)) g

sumNeighbors :: Grid -> [[Int]]
sumNeighbors g =
  foldr addGrids (zeroGrid g)
    (map (map (map toInt)) (neighborsGrids g))

-- Rules

next Alive 2 = Alive
next Alive 3 = Alive
next Dead  3 = Alive
next _     _ = Dead

step g =
  zipWith (zipWith next) g (sumNeighbors g)

-- Random grid

randomCell = do
  n <- randomRIO (0,1 :: Int)
  return (if n == 0 then Dead else Alive)

randomGrid h w =
  sequence [ sequence [ randomCell | _ <- [1..w] ]
           | _ <- [1..h] ]

-- Simulation

clearScreen = putStr "\ESC[2J\ESC[H"

simulate grid = do
  clearScreen
  printGrid grid
  threadDelay 300000
  let nextGrid = step grid
  if nextGrid == grid
    then putStrLn "Stable pattern reached."
    else simulate nextGrid

main = do
  grid <- randomGrid 20 40
  simulate grid