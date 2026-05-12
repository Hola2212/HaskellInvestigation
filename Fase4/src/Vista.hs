module Vista
    ( imprimirEncabezado
    , imprimirEstadisticas
    , imprimirCatalogo
    , imprimirTopN
    , imprimirPorGenero
    , imprimirClasificaciones
    , imprimirGeneros
    , imprimirCronologia
    , imprimirRecorridos
    , imprimirSeccion
    ) where

import Data.List (intercalate)
import Tipos
import BST
import Catalogo


-- Separador de sección reutilizable
imprimirSeccion :: String -> IO ()
imprimirSeccion titulo =
    putStrLn $ "\n[" ++ titulo ++ "]"

-- Encabezado principal
imprimirEncabezado :: IO ()
imprimirEncabezado = do
    putStrLn "=================================================="
    putStrLn "   CATALOGO DE BIBLIOTECA - BST + Listas         "
    putStrLn "=================================================="

-- Estadísticas generales del BST
imprimirEstadisticas :: BST Libro -> IO ()
imprimirEstadisticas catalogo = do
    imprimirSeccion "ESTADISTICAS DEL ARBOL"
    putStrLn $ "  Libros en catalogo : " ++ show (cantidadNodos catalogo)
    putStrLn $ "  Altura del BST     : " ++ show (altura catalogo)
    putStrLn $ "  Calificacion media : " ++ show (promedio catalogo)
    case minimo catalogo of
        Just l  -> putStrLn $ "  Peor calificado  : \"" ++ titulo l ++
                            "\" (" ++ show (calificacion l) ++ "/100)"
        Nothing -> pure ()
    case maximo catalogo of
        Just l  -> putStrLn $ "  Mejor calificado : \"" ++ titulo l ++
                            "\" (" ++ show (calificacion l) ++ "/100)"
        Nothing -> pure ()

-- Formato de una línea de libro en el catálogo
formatLibro :: (Int, Libro) -> String
formatLibro (pos, l) =
    "  #" ++ show pos ++ "  [" ++ show (calificacion l) ++ "] " ++
    titulo l ++ " - " ++ autor l ++
    " (" ++ show (anio l) ++ ")  {" ++ show (genero l) ++ "}"

-- Catálogo completo descendente
imprimirCatalogo :: BST Libro -> IO ()
imprimirCatalogo catalogo = do
    imprimirSeccion "CATALOGO COMPLETO - mayor a menor calificacion"
    mapM_ (putStrLn . formatLibro) (zip [1..] (catalogoDescendente catalogo))

-- Top N libros
imprimirTopN :: Int -> BST Libro -> IO ()
imprimirTopN n catalogo = do
    imprimirSeccion $ "TOP " ++ show n ++ " LIBROS"
    mapM_ (\l -> putStrLn $ "  -> \"" ++ titulo l ++
                            "\" - " ++ show (calificacion l) ++ "/100")
                (topN n catalogo)

-- Libros filtrados por género
imprimirPorGenero :: Genero -> BST Libro -> IO ()
imprimirPorGenero g catalogo = do
    imprimirSeccion $ "LIBROS DE " ++ show g
    let libros = porGenero g catalogo
    if null libros
        then putStrLn "  (ninguno)"
        else mapM_ (\l -> putStrLn $ "  * \"" ++ titulo l ++
                            "\" (" ++ show (calificacion l) ++ "/100)")
                    libros

-- Distribución por clasificación
imprimirClasificaciones :: BST Libro -> IO ()
imprimirClasificaciones catalogo = do
    imprimirSeccion "DISTRIBUCION POR CLASIFICACION"
    mapM_ (\(cls, cnt) ->
        putStrLn $ "  " ++ show cls ++ ": " ++ show cnt ++ " libro(s)"
        ) (contarPorClasificacion catalogo)

-- Géneros disponibles
imprimirGeneros :: BST Libro -> IO ()
imprimirGeneros catalogo = do
    imprimirSeccion "GENEROS EN EL CATALOGO"
    putStrLn $ "  " ++ intercalate ", " (map show (generosDisponibles catalogo))

-- Cronología (más antiguo y más reciente)
imprimirCronologia :: BST Libro -> IO ()
imprimirCronologia catalogo = do
    imprimirSeccion "CRONOLOGIA"
    case masAntiguo catalogo of
        Just l  -> putStrLn $ "  Mas antiguo : \"" ++ titulo l ++
                            "\" (" ++ show (anio l) ++ ")"
        Nothing -> pure ()
    case masReciente catalogo of
        Just l  -> putStrLn $ "  Mas reciente: \"" ++ titulo l ++
                            "\" (" ++ show (anio l) ++ ")"
        Nothing -> pure ()

-- Recorridos del árbol
imprimirRecorridos :: BST Libro -> IO ()
imprimirRecorridos catalogo = do
    imprimirSeccion "RECORRIDOS DEL ARBOL (calificaciones)"
    putStrLn $ "  In-Order  (asc): " ++
        intercalate ", " (map (show . calificacion) (inOrder catalogo))
    putStrLn $ "  Pre-Order      : " ++
        intercalate ", " (map (show . calificacion) (preOrder catalogo))
    putStrLn $ "  Post-Order     : " ++
        intercalate ", " (map (show . calificacion) (postOrder catalogo))
