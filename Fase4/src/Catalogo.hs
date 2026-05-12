module Catalogo
    ( catalogoDescendente
    , topN
    , porGenero
    , sobreCalificacion
    , promedio
    , clasificar
    , contarPorClasificacion
    , generosDisponibles
    , masAntiguo
    , masReciente
    , actualizarCalificacion
    , fusionar
    , recomendar
    ) where

import Data.List (nub)
import Tipos
import BST


-- Catálogo completo ordenado de mejor a peor calificación
catalogoDescendente :: BST Libro -> [Libro]
catalogoDescendente = reverse . inOrder

-- Top N libros mejor calificados
topN :: Int -> BST Libro -> [Libro]
topN n = take n . catalogoDescendente

-- Filtrar libros por género
porGenero :: Genero -> BST Libro -> [Libro]
porGenero g = filter (\l -> genero l == g) . inOrder

-- Filtrar libros con calificación mínima
sobreCalificacion :: Int -> BST Libro -> [Libro]
sobreCalificacion minCal = filter (\l -> calificacion l >= minCal) . inOrder

-- Calificación promedio del catálogo
promedio :: BST Libro -> Double
promedio Vacio = 0.0
promedio bst =
    let libros = inOrder bst
        total    = fromIntegral (sum (map calificacion libros)) :: Double
        cantidad = fromIntegral (length libros)                 :: Double
    in total / cantidad

-- Clasificar un libro según su calificación
clasificar :: Libro -> Clasificacion
clasificar l
    | calificacion l < 50 = Regular
    | calificacion l < 70 = Bueno
    | calificacion l < 85 = MuyBueno
    | otherwise = Excelente

-- Contar libros por clasificación
contarPorClasificacion :: BST Libro -> [(Clasificacion, Int)]
contarPorClasificacion bst =
    let clases = map clasificar (inOrder bst)
        todas    = [Regular, Bueno, MuyBueno, Excelente]
        contar c = (c, length (filter (== c) clases))
    in map contar todas

-- Géneros presentes en el catálogo (sin repetir)
generosDisponibles :: BST Libro -> [Genero]
generosDisponibles = nub . map genero . inOrder

-- Libro más antiguo del catálogo
masAntiguo :: BST Libro -> Maybe Libro
masAntiguo Vacio = Nothing
masAntiguo bst =
    Just $ foldr1 (\l acc -> if anio l < anio acc then l else acc) (inOrder bst)

-- Libro más reciente del catálogo
masReciente :: BST Libro -> Maybe Libro
masReciente Vacio = Nothing
masReciente bst =
    Just $ foldr1 (\l acc -> if anio l > anio acc then l else acc) (inOrder bst)

-- Actualizar la calificación de un libro por título
actualizarCalificacion :: String -> Int -> BST Libro -> BST Libro
actualizarCalificacion tit nuevaCal bst =
    let libros = inOrder bst
        sinLibro = filter (\l -> titulo l /= tit) libros
    in case filter (\l -> titulo l == tit) libros of
        [] -> bst
        (l:_) -> desdeLista (l { calificacion = nuevaCal } : sinLibro)

-- Fusionar dos catálogos en uno
fusionar :: BST Libro -> BST Libro -> BST Libro
fusionar bst1 bst2 = desdeLista (inOrder bst1 ++ inOrder bst2)

-- Recomendar libros de un género con calificación mínima
recomendar :: Genero -> Int -> BST Libro -> [Libro]
recomendar g minCal =
    filter (\l -> genero l == g && calificacion l >= minCal) . catalogoDescendente
