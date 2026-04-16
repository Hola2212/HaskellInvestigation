**Juan Pablo Flores**

## Instrucciones:
1) Ejecutar el programa con:
runghc calculadora.hs

---

## ¿Qué realiza?

El programa implementa una calculadora en Haskell que trabaja con números en base decimal y binaria.

---

### 1) Conversión de decimal a binario  
Permite transformar un número entero en su representación binaria.

---

### 2) Conversión de binario a decimal  
Recibe un número en binario, valida que sea correcto y lo convierte a decimal.

---

### 3) Operaciones aritméticas  
Permite realizar operaciones entre números binarios:

- Suma  
- Resta  
- Multiplicación  

Internamente, los números se convierten a decimal, se realiza la operación y luego se regresan a binario.

---

### 4) Tabla de conversión  
Genera una tabla que muestra equivalencias entre números decimales y binarios en un rango definido.

---

### 5) Manejo de errores  
El programa valida:

- Que los números binarios sean correctos  
- Entradas inválidas  
- Casos donde la operación no es posible  

Los errores se muestran como mensajes en consola.

---

## Estructura del programa

1) Uso de `data`  
   Se definen tipos personalizados para representar resultados y números.

2) Pattern Matching  
   Se utiliza para manejar distintos casos en las funciones.

3) Funciones puras  
   La lógica de conversión y operaciones se implementa con funciones puras.

4) Entrada/Salida  
   Se maneja desde `main` para interactuar con el usuario.
