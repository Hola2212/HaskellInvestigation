module Tipos where

-- Géneros literarios disponibles
data Genero
    = Ficcion
    | NoFiccion
    | Ciencia
    | Historia
    | Fantasia
    | Misterio
    deriving (Show, Eq, Ord)

-- Clasificacion según calificación
data Clasificacion = Regular | Bueno | MuyBueno | Excelente
    deriving (Show, Eq, Ord)

-- Un libro tiene título, autor, año, género y calificación (1-100)
    data Libro = Libro
    { titulo       :: String
    , autor        :: String
    , anio         :: Int
    , genero       :: Genero
    , calificacion :: Int
    } deriving (Show, Eq)

-- Orden: comparamos libros por calificación
instance Ord Libro where
    compare l1 l2 = compare (calificacion l1) (calificacion l2)

-- Árbol Binario de Búsqueda genérico
data BST a
    = Vacio
    | Nodo (BST a) a (BST a)
    deriving (Show)
