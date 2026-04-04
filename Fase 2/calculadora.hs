-- ============================================================
-- Calculadora Decimal <-> Binario en Haskell
-- CC2016 - Algoritmos y Estructura de Datos
-- Universidad del Valle de Guatemala
-- Entrega 2 - Programa Opcional
-- ============================================================

module Main where

import Data.Char (digitToInt, intToDigit, isDigit)
import Data.List (intercalate)

-- ============================================================
-- TIPOS DE DATOS
-- ============================================================

-- Tipo algebraico para representar el resultado de una operación
data Resultado
  = ExitoInt    Int    -- conversión exitosa a entero
  | ExitoStr    String -- conversión exitosa a string binario
  | Error       String -- error con mensaje descriptivo
  deriving (Show)

-- Tipo algebraico para la base numérica
data Base = Decimal | Binario deriving (Show, Eq)

-- Record para representar un número con su base y valor
data Numero = Numero
  { valor :: String
  , base  :: Base
  } deriving (Show)


-- ============================================================
-- CONVERSIÓN DECIMAL -> BINARIO
-- ============================================================

-- Convierte un entero no negativo a su representación binaria (String)
decimalABinario :: Int -> String
decimalABinario 0 = "0"
decimalABinario n
  | n < 0     = '-' : decimalABinario (abs n)
  | otherwise = reverse (construirBits n)
  where
    construirBits :: Int -> String
    construirBits 0 = ""
    construirBits x = intToDigit (x `mod` 2) : construirBits (x `div` 2)


-- ============================================================
-- CONVERSIÓN BINARIO -> DECIMAL
-- ============================================================

-- Verifica si un String es un número binario válido (solo 0s y 1s)
esBinarioValido :: String -> Bool
esBinarioValido ""  = False
esBinarioValido str = all (`elem` "01") str

-- Convierte una representación binaria (String) a entero
binarioADecimal :: String -> Resultado
binarioADecimal str
  | not (esBinarioValido str) = Error ("\"" ++ str ++ "\" no es un numero binario valido.")
  | otherwise = ExitoInt (foldl (\acc b -> acc * 2 + digitToInt b) 0 str)


-- ============================================================
-- OPERACIONES ARITMÉTICAS EN BINARIO
-- ============================================================

-- Suma dos números binarios (como Strings) y devuelve el resultado binario
sumaBinaria :: String -> String -> Resultado
sumaBinaria a b =
  case (binarioADecimal a, binarioADecimal b) of
    (ExitoInt x, ExitoInt y) -> ExitoStr (decimalABinario (x + y))
    (Error msg, _)           -> Error msg
    (_, Error msg)           -> Error msg
    _                        -> Error "Error inesperado en suma binaria."

-- Resta dos números binarios
restaBinaria :: String -> String -> Resultado
restaBinaria a b =
  case (binarioADecimal a, binarioADecimal b) of
    (ExitoInt x, ExitoInt y)
      | x >= y    -> ExitoStr (decimalABinario (x - y))
      | otherwise -> Error "Resultado negativo: no soportado en binario sin signo."
    (Error msg, _) -> Error msg
    (_, Error msg) -> Error msg
    _              -> Error "Error inesperado en resta binaria."

-- Multiplica dos números binarios
multiplicacionBinaria :: String -> String -> Resultado
multiplicacionBinaria a b =
  case (binarioADecimal a, binarioADecimal b) of
    (ExitoInt x, ExitoInt y) -> ExitoStr (decimalABinario (x * y))
    (Error msg, _)           -> Error msg
    (_, Error msg)           -> Error msg
    _                        -> Error "Error inesperado en multiplicacion binaria."


-- ============================================================
-- TABLA DE CONVERSIÓN
-- ============================================================

-- Genera una tabla de conversiones decimal-binario para un rango dado
tablaConversion :: Int -> Int -> [(Int, String)]
tablaConversion desde hasta =
  [ (n, decimalABinario n) | n <- [desde..hasta] ]

-- Formatea la tabla como texto
mostrarTabla :: [(Int, String)] -> String
mostrarTabla tabla =
  let encabezado = "+----------+------------------+"
      titulo     = "| Decimal  | Binario          |"
      filas      = map formatFila tabla
  in unlines (encabezado : titulo : encabezado : filas ++ [encabezado])
  where
    formatFila (d, b) =
      "| " ++ padRight 8 (show d) ++ " | " ++ padRight 16 b ++ " |"
    padRight n s = s ++ replicate (n - length s) ' '


-- ============================================================
-- UTILIDADES DE PRESENTACIÓN
-- ============================================================

separador :: String
separador = replicate 52 '='

mostrarResultado :: Resultado -> String
mostrarResultado (ExitoInt n)  = show n
mostrarResultado (ExitoStr s)  = s
mostrarResultado (Error msg)   = "ERROR: " ++ msg


-- ============================================================
-- PROGRAMA PRINCIPAL
-- ============================================================

main :: IO ()
main = do
  putStrLn separador
  putStrLn "  CALCULADORA DECIMAL <-> BINARIO en Haskell"
  putStrLn "  CC2016 - Universidad del Valle de Guatemala"
  putStrLn separador

  -- 1. Conversiones Decimal -> Binario
  putStrLn "\n[1] DECIMAL -> BINARIO"
  putStrLn $ "  42        ->  " ++ decimalABinario 42
  putStrLn $ "  255       ->  " ++ decimalABinario 255
  putStrLn $ "  1024      ->  " ++ decimalABinario 1024
  putStrLn $ "  0         ->  " ++ decimalABinario 0
  putStrLn $ "  7         ->  " ++ decimalABinario 7

  -- 2. Conversiones Binario -> Decimal
  putStrLn "\n[2] BINARIO -> DECIMAL"
  putStrLn $ "  101010    ->  " ++ mostrarResultado (binarioADecimal "101010")
  putStrLn $ "  11111111  ->  " ++ mostrarResultado (binarioADecimal "11111111")
  putStrLn $ "  1111      ->  " ++ mostrarResultado (binarioADecimal "1111")
  putStrLn $ "  1         ->  " ++ mostrarResultado (binarioADecimal "1")
  putStrLn $ "  10203     ->  " ++ mostrarResultado (binarioADecimal "10203") -- inválido

  -- 3. Operaciones aritméticas en binario
  putStrLn "\n[3] OPERACIONES EN BINARIO"
  putStrLn $ "  1010 + 0110      =  " ++ mostrarResultado (sumaBinaria "1010" "0110")
  putStrLn $ "  1111 + 0001      =  " ++ mostrarResultado (sumaBinaria "1111" "0001")
  putStrLn $ "  1100 - 0100      =  " ++ mostrarResultado (restaBinaria "1100" "0100")
  putStrLn $ "  1010 * 0011      =  " ++ mostrarResultado (multiplicacionBinaria "1010" "0011")
  putStrLn $ "  0001 - 1000      =  " ++ mostrarResultado (restaBinaria "0001" "1000") -- error

  -- 4. Tabla de conversión del 0 al 15
  putStrLn "\n[4] TABLA DE CONVERSION (0 al 15)"
  putStr (mostrarTabla (tablaConversion 0 15))

  -- 5. Verificar usando el tipo Numero (record)
  putStrLn "[5] USO DEL RECORD 'Numero'"
  let num1 = Numero { valor = "42",     base = Decimal }
  let num2 = Numero { valor = "101010", base = Binario  }
  putStrLn $ "  Numero 1: " ++ valor num1 ++ " (base: " ++ show (base num1) ++ ")"
              ++ "  ->  binario: " ++ decimalABinario (read (valor num1) :: Int)
  putStrLn $ "  Numero 2: " ++ valor num2 ++ " (base: " ++ show (base num2) ++ ")"
              ++ "  ->  decimal: " ++ mostrarResultado (binarioADecimal (valor num2))

  putStrLn $ "\n" ++ separador
  putStrLn "  Programa finalizado."
  putStrLn separador
