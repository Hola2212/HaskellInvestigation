# 🧬 Game of Life en Haskell

**Juan Pablo Flores**  
Universidad del Valle de Guatemala  
Algoritmos y Estructuras de Datos  

## Descripción
Este proyecto implementa el **Juego de la Vida de Conway (Game of Life)** en Haskell. El programa simula la evolución de una cuadrícula de células aplicando reglas simples que generan comportamientos complejos a lo largo del tiempo.

## Funcionalidad
- Genera una cuadrícula inicial (aleatoria o definida)
- Representa células vivas y muertas
- Aplica las reglas del Game of Life:
  - Viva con 2 o 3 vecinas → sobrevive  
  - Muerta con exactamente 3 vecinas → revive  
  - En otro caso → muere  
- Muestra la evolución en la terminal
- Detecta estados estables

## Conceptos utilizados
- Funciones puras (`step :: Grid -> Grid`)
- Inmutabilidad
- Funciones de orden superior (`map`, `zipWith`, `foldr`)
- Tipos algebraicos (`data Cell = Alive | Dead`)
- Separación entre lógica pura e IO

## ▶️ Ejecución
Opción rápida:
```bash
runhaskell Fase3/GameOfLife.hs
```

O compilado:
```bash
ghc Fase3/GameOfLife.hs -o GameOfLife
./GameOfLife
```

## ⚠️ Requisitos
- GHC
- Cabal
- Librería `random`

Instalar:
```bash
cabal update
cabal install --lib random
```

## ⚙️ Configuración
Tamaño de la cuadrícula:
```haskell
grid <- randomGrid 20 40
```

Velocidad:
```haskell
threadDelay 1000000
```

## Notas
- En terminales online la animación puede fallar  
- Se recomienda usar terminal local  
- Ajustar tamaño según la pantalla  

## Estructura
- Modelado: `Cell`, `Grid`
- Lógica: `step`
- Simulación: `simulate`
- Visualización: `printGrid`

## Mejoras futuras
- Detectar ciclos  
- Control interactivo  
- Mejor interfaz  
- Optimización  

## Conclusión
El proyecto demuestra cómo Haskell permite modelar sistemas complejos de forma declarativa, separando lógica pura y ejecución.