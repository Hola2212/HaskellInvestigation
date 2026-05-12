module BST
    ( insertar
    , buscar
    , eliminar
    , inOrder
    , preOrder
    , postOrder
    , altura
    , cantidadNodos
    , minimo
    , maximo
    , desdeLista
    ) where

import Tipos (BST(..))


-- Insertar un elemento (empates van a la derecha)
insertar :: (Ord a) => a -> BST a -> BST a
insertar x Vacio = Nodo Vacio x Vacio
insertar x (Nodo izq val der)
    | x < val   = Nodo (insertar x izq) val der
    | otherwise  = Nodo izq val (insertar x der)

-- Buscar un elemento exacto
buscar :: (Ord a) => a -> BST a -> Bool
buscar _ Vacio = False
buscar x (Nodo izq val der)
    | x == val  = True
    | x < val   = buscar x izq
    | otherwise  = buscar x der

-- Recorrido In-Order: lista ordenada ascendente
inOrder :: BST a -> [a]
inOrder Vacio              = []
inOrder (Nodo izq val der) = inOrder izq ++ [val] ++ inOrder der

-- Recorrido Pre-Order
preOrder :: BST a -> [a]
preOrder Vacio              = []
preOrder (Nodo izq val der) = [val] ++ preOrder izq ++ preOrder der

-- Recorrido Post-Order
postOrder :: BST a -> [a]
postOrder Vacio              = []
postOrder (Nodo izq val der) = postOrder izq ++ postOrder der ++ [val]

-- Altura del árbol
altura :: BST a -> Int
altura Vacio            = 0
altura (Nodo izq _ der) = 1 + max (altura izq) (altura der)

-- Número de nodos
cantidadNodos :: BST a -> Int
cantidadNodos Vacio            = 0
cantidadNodos (Nodo izq _ der) = 1 + cantidadNodos izq + cantidadNodos der

-- Elemento mínimo
minimo :: BST a -> Maybe a
minimo Vacio              = Nothing
minimo (Nodo Vacio val _) = Just val
minimo (Nodo izq _ _)     = minimo izq

-- Elemento máximo
maximo :: BST a -> Maybe a
maximo Vacio              = Nothing
maximo (Nodo _ val Vacio) = Just val
maximo (Nodo _ _ der)     = maximo der

-- Auxiliar: eliminar el nodo mínimo
eliminarMin :: BST a -> BST a
eliminarMin Vacio              = Vacio
eliminarMin (Nodo Vacio _ der) = der
eliminarMin (Nodo izq val der) = Nodo (eliminarMin izq) val der

-- Eliminar un elemento del BST
eliminar :: (Ord a) => a -> BST a -> BST a
eliminar _ Vacio = Vacio
eliminar x (Nodo izq val der)
    | x < val   = Nodo (eliminar x izq) val der
    | x > val   = Nodo izq val (eliminar x der)
    | otherwise  =
        case minimo der of
            Nothing  -> izq
            Just suc -> Nodo izq suc (eliminarMin der)

-- Construir un BST desde una lista
desdeLista :: (Ord a) => [a] -> BST a
desdeLista = foldr insertar Vacio
