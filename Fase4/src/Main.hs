module Main where

import Tipos
import BST      (desdeLista, cantidadNodos)
import Catalogo
import Vista
import Datos


main :: IO ()
main = do

    -- ── Construcción del catálogo ─────────────────────────────
    let catalogo = desdeLista librosPrueba

    imprimirEncabezado
    imprimirEstadisticas catalogo

    -- ── Visualización del catálogo ───────────────────────────
    imprimirCatalogo catalogo
    imprimirTopN 5 catalogo
    imprimirPorGenero Ciencia catalogo
    imprimirClasificaciones catalogo
    imprimirGeneros catalogo
    imprimirCronologia catalogo

    -- ── Actualización de un libro ────────────────────────────
    imprimirSeccion "ACTUALIZACION: El codigo Da Vinci 61 -> 72"
    let catalogoActualizado = actualizarCalificacion "El codigo Da Vinci" 72 catalogo
    putStrLn "  Nuevo Top 3:"
    mapM_ (\l -> putStrLn $ "  -> \"" ++ titulo l ++
                            "\" (" ++ show (calificacion l) ++ "/100)")
        (topN 3 catalogoActualizado)

    -- ── Recomendaciones ──────────────────────────────────────
    imprimirSeccion "RECOMENDACIONES: Fantasia con cal >= 90"
    mapM_ (\l -> putStrLn $ "  ** \"" ++ titulo l ++ "\" - " ++ autor l)
                (recomendar Fantasia 90 catalogo)

    -- ── Recorridos del árbol ─────────────────────────────────
    imprimirRecorridos catalogo

    -- ── Fusión de catálogos ───────────────────────────────────
    let catalogoExtra  = desdeLista librosExtra
    let catalogoFinal  = fusionar catalogo catalogoExtra
    imprimirSeccion "CATALOGO FUSIONADO (+El principito, +Homo Deus)"
    putStrLn $ "  Total libros: " ++ show (cantidadNodos catalogoFinal)
    putStrLn "  Nuevo Top 5:"
    mapM_ (\(pos, l) ->
        putStrLn $ "  #" ++ show pos ++ " \"" ++ titulo l ++
                    "\" (" ++ show (calificacion l) ++ "/100)"
        ) (zip [1..] (topN 5 catalogoFinal))

    putStrLn "\nPractica completada.\n"
