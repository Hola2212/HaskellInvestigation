module Datos
    ( librosPrueba
    , librosExtra
    ) where

import Tipos


-- Catálogo inicial de 12 libros
librosPrueba :: [Libro]
librosPrueba =
    [ Libro "Cien anos de soledad"           "Gabriel Garcia Marquez"  1967    Ficcion   95
    , Libro "Sapiens"                         "Yuval Noah Harari"       2011    Historia  88
    , Libro "El nombre de la rosa"            "Umberto Eco"             1980    Misterio  82
    , Libro "Cosmos"                          "Carl Sagan"              1980    Ciencia   91
    , Libro "El senor de los anillos"         "J.R.R. Tolkien"          1954    Fantasia  97
    , Libro "Breve historia del tiempo"       "Stephen Hawking"         1988    Ciencia   85
    , Libro "Don Quijote"                     "Miguel de Cervantes"     1605    Ficcion   93
    , Libro "El codigo Da Vinci"              "Dan Brown"               2003    Misterio  61
    , Libro "Dune"                            "Frank Herbert"           1965    Fantasia  90
    , Libro "Una breve historia de casi todo" "Bill Bryson"             2003    Ciencia   78
    , Libro "Crimen y castigo"                "Fiodor Dostoyevski"      1866    Ficcion   89
    , Libro "El arte de la guerra"            "Sun Tzu"                 (-500)  Historia  74
    ]

-- Libros adicionales para demostrar la fusión de catálogos
librosExtra :: [Libro]
librosExtra =
    [ Libro "El principito" "Antoine de Saint-Exupery" 1943 Ficcion  96
    , Libro "Homo Deus"     "Yuval Noah Harari"        2015 Historia 83
    ]
