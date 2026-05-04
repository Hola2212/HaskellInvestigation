module Main where

import Control.Concurrent (threadDelay)

data Cell = Alive | Dead deriving (Eq)
type Grid = [[Cell]]

showCell Alive = 'O'
showCell Dead  = '.'

printGrid grid = do
  putStrLn ""
  mapM_ (putStrLn . map showCell) grid

height = length
width g = length (head g)

-- CHANGED: wrapping
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

glider =
  [ [Dead, Alive, Dead, Dead, Dead]
  , [Dead, Dead, Alive, Dead, Dead]
  , [Alive, Alive, Alive, Dead, Dead]
  , [Dead, Dead, Dead, Dead, Dead]
  , [Dead, Dead, Dead, Dead, Dead]
  ]

main :: IO ()
main =
  mapM_
    (\g -> printGrid g >> threadDelay 300000)
    (take 100 (iterate step glider))