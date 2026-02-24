## Problemas
- **Ruido**: edad aparece -5 o animal pesa 500kg.
- **Valores faltantes**: registros vacíos.
- **Inconsistencias**: un mismo producto aparece como Champú, Champu y Shampoo.
- **Datos superfluos**: columnas que no aportan valor estadístico.
- **Tamaño enorme**: millones de filas y columnas.

## Etapas
- **Limpieza de datos**:
	- **Manejo de valores nulos**: eliminar filas/columnas o imputación (rellenar con la moda, media o mediana).
	- **Tratamiento de valores atípicos (outliers)**: datos que se alejan del promedio y decidir si son errores o casos especiales.
	- Eliminar duplicados.
- **Integración de datos**: combinar datos de diferentes fuentes.
- **Transformación de datos**:
	- Crear nuevos atributos usando fórmulas o modelos matemáticos.
	- **Codificación de variables categóricas**: One-Hot Encoding (1 o 0) o Label Encoding (1 - n).
- **Reducción de datos**: 
	- Selección de características o ejemplos.
	- **Reducción de dimensionalidad**: algoritmos como PCA para comprimir información sin perder la esencia.
- **Discretización**: convertir variables continuas en discretas.
## ==Preguntas del examen como los ejercicios de los apuntes==

## Ejercicio
Una clínica de nutrición ha unido información de tres fuentes y obtenido la siguiente tabla. Detecta los problemas de este dataset y propón una solución.

| **ID** | **Nombre**   | **Edad** | **Altura (cm)** | **Peso (kg)** | **Ciudad** | **Género** |
| ------ | ------------ | -------- | --------------- | ------------- | ---------- | ---------- |
| 201    | Carlos Ruiz  | 34       | 172             | 82            | Madrid     | Masculino  |
| 202    | Elena Torres | 29       | 165             | NULL          | BCN        | Femenino   |
| 203    | Marta López  | 41       | 168             | 75            | Barcelona  | Mujer      |
| 204    | David Martín | NULL     | 180             | 95            | Madrid     | Masculino  |
| 205    | Ana Pérez    | 250      | 158             | 52            | Valencia   | Femenino   |
| 206    | Luis García  | 37       | 1.75            | 78            | madrid     | Hombre     |
| 207    | Laura Díaz   | 22       | 169             | 0             | Bcn        | Femenino   |
| 208    | Pablo Gómez  | 45       | 182             | 110           | Valencia   | M          |
- **Limpieza**:
	- **Resolver NULL**: 204/edad, 202/peso.
	- **Valor atípico**: edad 250 en 205/edad, altura 1.75 en 206/altura, peso 0 en 207/peso.
- **Integración**:
	- **Conflicto de nombres**: BCN, Barcelona y Bcn en ciudad. Madrid y madrid en ciudad. Masculino, Hombre y M en género. Femenino y Mujer en género.
- **Transformación**: 
	- One-Hot Encoding en género.
	- Label Encoding en ciudad.
	- Nueva columna IMC unificada por edad, altura y peso.
- **Reducción**: eliminar columna nombre.
- **Discretización**: IMC.

## Limpieza de datos
Detecta y corrige errores, inconsistencias y datos faltantes en el conjunto de información original para evitar resultados sesgados o erróneos. Problemas de duplicados, consistencia, nulos y outliers.

- **Tratamiento de valores perdidos:**
	- **Eliminación (discarding)**: borrar registros o variables incompletas.
		- **Eliminación de instancias (filas)**: no se recomienda eliminar más del 5%.
			- **Pérdida del poder estadístico**: si tengo 100 datos y elimino 20, el modelo será más débil.
			- **Sesgo de elección**: si los huecos no son aleatorios, al borrar esas filas se está eliminando a un grupo específico, con lo que es probable que se esté sesgando el modelo hacia un subgrupo de la población.
		- **Eliminación de atributos (columnas)**: si hay muchos valores faltantes en una columna, intentar rellenar implica que la mayor parte de los datos serían inventados por un algoritmo, lo que introduce más ruido y sesgos que información real.
	- **Imputación simple**: rellenar el hueco con la moda (categóricas), media (numérica) o mediana (numérica, más robusta que la media).
	- **Imputación basada en modelos**: basándose en información disponible, predecir que valor va en el hueco.
		- **Regresión**: si falta el Peso, el modelo mira la Altura y la Edad de esa persona para calcular qué peso es el más probable.
		- **KNN**: buscamos a los registros más parecidos y copiamos el valor que ellos tienen. Supongamos que al i-simo registro le falta el valor del rasgo j (no se conoce el valor $x_{ij}$). Definimos la función de distancia de Gower entre dos registros $x_{i}$ y $x_{j}$ como: $$d(x_{i}, x_{j}) = \frac{\sum^{m}_{k=1} w_{k} \delta^{k}_{i,j} d^{k}_{i,j}}{\sum^{m}_{k=1} w_{k} \delta^{k}_{i,j}}$$ donde $w_{k}$ es el peso del atributo $k$, $\delta^{k}_{i,j}$ es 1 si la variable esta observada en ambos individuos y 0 si en uno de ellos tiene un valor perdido, $d^{k}_{i,j}$ es la disimilitud parcial del atributo $k$:
			- Si el atributo es numérico: $d^{k}_{i,j} = \frac{|x_{i,k}-x_{j,k}|}{R_{k}}$ donde $R_{k}$ es el rango de a variable K.
			- Si el atributo es categórico: $d^{k}_{i,j} = 0$ si los valores coinciden, 1 si no coinciden.
		- **Máxima verosimilitud (EM)**: probabilístico. Encuentra valores que mejor encajarían para que la distribución total de los datos sea lo más coherente posible.

## Ejercicio
Calcula el valor para imputar a la edad del socio 6 usando KNN.

| Nº socio | Edad (N) | Horas Gym (N) | Nivel (C)    | Deporte (C) |
| -------- | -------- | ------------- | ------------ | ----------- |
| 1        | 20       | 10            | Experto      | Natación    |
| 2        | 45       | 2             | Principiante | Golf        |
| 3        | 22       | 9             | Experto      | Natación    |
| 4        | 40       | 3             | Principiante | Golf        |
| 5        | 21       | 9             | Experto      | -           |
| 6        | -        | 2             | Principiante | Golf        |
| Rango    | 25       | 8             |              |             |

$D(6,1) = \frac{8/8 + 1 + 1}{3} =1$
$D(6,2) = \frac{0/8 + 0 + 0}{3} =0$
$D(6,3) = \frac{7/8 + 1 + 1}{3} =0.9583$
$D(6,4) = \frac{1/8 + 0 + 0}{3} =0.0416$
$D(6,5) = \frac{7/8 + 1}{2}=0.9375$