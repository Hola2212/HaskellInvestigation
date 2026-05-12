# 📚 Catalogo de Biblioteca en Haskell

**Juan Pablo Flores**  
Universidad del Valle de Guatemala  
Algoritmos y Estructuras de Datos  

## Descripcion

Este proyecto implementa un **sistema de catalogo de biblioteca** en Haskell. Utiliza un Arbol Binario de Busqueda (BST) para almacenar y organizar libros por calificacion, combinado con operaciones sobre listas para filtrado, estadisticas y recomendaciones.

## Funcionalidad

- Almacena libros en un BST ordenado por calificacion
- Muestra el catalogo completo de mayor a menor calificacion
- Genera un Top N de los mejores libros
- Filtra libros por genero literario
- Calcula la calificacion promedio del catalogo
- Clasifica libros en: Regular, Bueno, MuyBueno, Excelente
- Detecta el libro mas antiguo y mas reciente
- Actualiza la calificacion de un libro
- Fusiona dos catalogos en uno
- Genera recomendaciones por genero y calificacion minima
- Muestra los tres recorridos del arbol: In-Order, Pre-Order, Post-Order

## Conceptos utilizados

- Arbol Binario de Busqueda (BST) generico con tipo `data BST a`
- Tipos algebraicos (`data Libro`, `data Genero`, `data Clasificacion`)
- Pattern matching en todas las operaciones del arbol
- Funciones de orden superior (`map`, `filter`, `foldr`, `foldr1`)
- Composicion de funciones (`.`) y estilo punto-libre
- Funciones puras separadas de la entrada/salida
- Diseno modular con multiples archivos `.hs`

## Estructura del proyecto

```
Biblioteca/
├── Main.hs        — Punto de entrada, orquesta los modulos
├── Tipos.hs       — Definicion de tipos: Libro, BST, Genero, Clasificacion
├── BST.hs         — Operaciones genericas del arbol (insertar, buscar, recorridos...)
├── Catalogo.hs    — Logica de dominio (filtrar, recomendar, estadisticas...)
├── Vista.hs       — Funciones de presentacion e impresion en pantalla
└── Datos.hs       — Datos de prueba centralizados
```

## Instrucciones de ejecucion

Todos los archivos deben estar en la misma carpeta.

### Sin compilar (rapido):
```bash
runghc Main.hs
```

### Compilando (recomendado para correr varias veces):
```bash
ghc -o biblioteca Main.hs
```
```bash
./biblioteca
```
> El comando `ghc` solo se necesita correr una vez. Luego se puede ejecutar `./biblioteca` todas las veces que se quiera sin recompilar.

### Nota sobre archivos generados al compilar
Al usar `ghc` se generan archivos `.hi` y `.o` por cada modulo. Son archivos intermedios de compilacion y se pueden eliminar con seguridad si ya no se necesitan.

## Requisitos

- GHC (Glasgow Haskell Compiler)

Sin dependencias externas — solo usa modulos de la libreria estandar de Haskell (`Data.List`).

## Generos disponibles

`Ficcion` | `NoFiccion` | `Ciencia` | `Historia` | `Fantasia` | `Misterio`

## Mejoras futuras

- Agregar busqueda por titulo o autor
- Persistencia de datos en archivo
- Interfaz interactiva con menu
- Soporte para mas campos: ISBN, editorial, numero de paginas
- Exportar el catalogo a CSV
