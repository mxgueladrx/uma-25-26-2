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
			- **Expectation**: valor esperado para el dato perdido. $x_{miss}=\mu_{miss}+\Upsigma_{12}\Upsigma^{-1}_{22}(x_{obs}-\mu_{obs})$
			- **Maximization**: maximizar la función de verosimilitud, que representa la probabilidad de tener las observaciones que tenemos en el dataset.
			Hay que encontrar $\theta$ (media $\mu$ y varianza $\sigma$) que mejor expliquen los datos faltantes. 
- **Datos anómalos**: 
	- **Detección**:
		- **Métodos estadísticos**:
			- **Normalización o reescalado Min-Max**: transformar valores a un rango específico. Normalmente se reescala a \[0,1]. Los valores extremos quedan cerca del 0 o 1. $$x'=\frac{x-min}{max-min}$$
			- **Z-score**: mide cuantas desviaciones estándar se encuentra un punto de la media. Un valor normalizado superior a 3 es anómalo (regla 68,27; 95; 99,73)$$x'=\frac{x-\mu}{\sigma}$$
			- **IQR (Rango Intercuartílico)**: dispersión de los datos. Se usan $Q_{1}$ y $Q_{3}$ y el rango intercuartílico $[Q_{1}-1.5*IQR, Q_{3}+1.5*IQR]$. Los puntos fuera del rango son anomalías.
			![[Pasted image 20260225093427.png]]
			![[Pasted image 20260225094611.png]]
		- **Técnicas de visualización**: 
			- **Boxplots**: visualiza cuartiles y puntos aislados que superan los límites del IQR.
			- **Scatter plots**: ver la relación entre dos variables e identificar puntos que se escapan del cluster principal.
			- **Histogramas**: frecuencia de los datos. Barras pequeñas o alejadas en los extremos son posibles anomalías.
			![[Pasted image 20260225093530.png]]
	- **Acciones**:
		- **Eliminación crítica**: se elimina si es error, el impacto es aceptable (menos del 5% de los datos) y no provoca sesgos.
		- **Imputación**: sustituir valores (apartado anterior).
		- **Transformar datos**: 
			- Transformaciones no lineales: funciones logarítmicas o raíz cuadrada para reducir el peso de los extremos.
			- Segmentación o clustering: identificar si las anomalías forman un grupo con patrón propio para tratarlos de forma aislada en lugar de eliminarlos.
			- Suavizado de datos: aplicar filtros de variabilidad para minimizar el impacto del ruido aleatorio en el análisis global.
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
## Integración de datos
Combinar información de múltiples fuentes para crear una vista única, coherente y valiosa.
- **Detección de instancias duplicadas**: cómo identificar registros repetidos.
	- **Métricas de caracteres**: Ejemplo: "Helena" y "Elena", "Calle Mayor 5" y "5, Mayor St.", "2345678X" y "2345678-X". Se cuenta el número de transformaciones necesarias para hacerlos coincidir.
	- **Métricas fonéticas**: Ejemplo: "Helena" y "Elena". Generan el mismo código fonético, por lo que podemos ignorar la diferencia ortográfica.
	- **Métrica de tokens**: Ejemplo: "Calle Mayor 5" y "5, Mayor St.". Se descompone la dirección en palabras sueltas y se ignora el orden.
	- **Modelo probabilístico (Fellegi-Sunter)**: definimos 
		- $m$: probabilidad de que el campo coincida si los registros son el mismo.
		- $u$: probabilidad de que el campo coincida en dos registros distintos.
		Calculamos el peso de cada valor:
		- **Peso de concordancia (hay coincidencia)**: $w^{+}=\log_{2}(\frac{m}{u})$
		- **Peso de desacuerdo (no hay coincidencia)**: $w^{-}=\log_{2}(\frac{1-m}{1-u})$
		Se define un score como la suma de los pesos de todas las variables y se establece un umbral $T_{superior}$ y $T_{inferior}$:
		- score $\ge T_{superior}$: mismo registro.
		- score $\lt T_{inferior}$: registros diferentes.
		- Otro caso: revisión manual.
- **Localización de datos redundantes**: qué información sobra. Atributo derivado de otro.
	- **Atributos nominales**:
		- **Test Chi-cuadrado de independencia**: 
			- p-valor $\gt a$: no hay evidencia suficiente para afirmar dependencia, hay redundancia.
			- p-valor $\le a$: hay dependencia. Solapamiento informativo. Evaluar eliminación.
	- **Atributos numéricos**:
		- **Coeficiente de correlación de Pearson**: si se sospecha relación lineal.
			- $|r| \approx 0$: no relación lineal. Mantener ambas variables.
			- $|r|$ alto (Ejemplo: $\gt$ 0.8): fuerte dependencia lineal. Redundancia.
		- **Correlación de Spearman**: explorar relaciones no lineales.
			- $|\rho| \approx 0$: no relación monotónica. Mantener ambas variables.
			- $|\rho|$ alto (Ejemplo: $\gt$ 0.8): fuerte dependencia monotónica. Redundancia.
## ==Hacer EM==

## Transformación de datos
Transformar y refinar información bruta para que sirva de entrada adecuada a un algoritmo de aprendizaje.

- **Normalización/Escalado**: se transforman los valores de las variables para que sus magnitudes sean comparables.
	- **Escalado Min-Max**: valores a un rango entre \[a, b]. $$x'=a+\frac{(x-x_{min})(b-a)}{x_{max}-x_{min}}$$
	- **Normalización Z-score**: datos con media $\mu=0$ y desviación estándar $\sigma = 1$. $$z=\frac{x-\mu}{\sigma}$$
	- **Escalado decimal**: se divide por una potencia de 10 para que los valores queden entre (-1, 1). $j$ es el menor entero tal que $max(|x'|)\lt 1$. $$x'=\frac{x}{10^{j}}$$
- **Transformaciones funcionales**: aplicamos funciones matemáticas para moldear los datos según la necesidad.
	- **Transformaciones univariantes**: aplicadas a cada variable por separado. Definen nuevas variables $Y_{i}=f(X_{i})$
		- **Logarítmica**: $Y_{i}=\ln(X_{i})$. Reduce asimetría positiva fuerte y estabiliza la varianza. Requiere $X_{i} \gt 0$.
		- **Potencia**: $Y_{i}=X^{\lambda}_{i}$. Modifica la asimetría según $\lambda$.
			- Si $0\lt \lambda \lt 1$: comprime valores grandes (reduce cola derecha). Requiere $X_{i}\ge 0$.
			- Si $\lambda \gt 1$: expande los valores grandes.
	- **Transformaciones multivariantes**: se crea un nuevo atributo $Y =f(X_{1},..., X_{m})$ mediante transformaciones funcionales:
		- **Lineales**: suma ponderada de variables. $$Y=w_{1}X_{1}+...+w_{m}X_{m}$$
		- **Cuadráticas**: genera una nueva variable con los términos al cuadrado y productos entre variables, modelando relaciones no lineales que una lineal no podría capturar. $$Y=\sum^{m}_{i=1}w_{i}X^{2}_{i}+\sum^{}_{1\le i \lt j \le m}w_{ij}X_{i}X_{j}$$
		- **Box-Cox**: aproximar la normalidad y estabilizar la varianza en variables continuas. Requiere $X \gt 0$: $$z = g_{\lambda}(x) = \begin{cases} \frac{x^{\lambda} - 1}{\lambda}, & \text{si } \lambda \neq 0 \\ \ln(x), & \text{si } \lambda = 0 \end{cases}$$ Si el atributo tiene valore negativos, antes desplazamos $x'=x+c$, con $c \gt -\min(x)$ En la versión **Box-Draper**, hace que sea invariante a cambios de escala dividiendo por la media geométrica $g=(x_{1}x_{2}...x_{n})^{1/n}$, quedando: $$z = g_{\lambda}(x) = \begin{cases} \frac{(x+c)^{\lambda} - 1}{\lambda g}, & \text{si } \lambda \neq 0 \\ \frac{\ln(x+c)}{g}, & \text{si } \lambda = 0 \end{cases}$$ Para $\lambda = 1$ es lineal, $\lambda=2$ cuadrática, $\lambda = 1/2$ raíz y $\lambda = -1$ inversa (aprox $1/x$). Hay que estimar $\lambda$ que mejor normaliza el atributo (distribución gaussiana). ![[Pasted image 20260226100455.png]]
- **Codificación**: variables cualitativas se codifican de forma que puedan ser procesadas por los algoritmos.
	- **One hot encoding**: categorías en k columnas binarias (0 o 1).
	- **Label encoding**: cada categoría a un número entero único.
	- **Ordinal encoding**: cada categoría a un número entero único reflejando el orden natural. 

## Ejercicio
![[Pasted image 20260226091339.png]]
a) \[0, 1]: $0+\frac{(30-20)(1-0)}{50-20} = 1/3$
a) \[-1, 1]: $-1 + \frac{(30-20)(1+1)}{50-20} = -1/3$
a) \[5, 10]:  $5 + \frac{(30-20)(10-5)}{50-20} = 10/3$
b) $\frac{30-35}{10}= -1/2$
c) $\frac{30}{10^{2}}=0.3$ con $j=2$

## Ejercicio
![[Pasted image 20260226100947.png]]
a) Label encoding
b) Label encoding
c) Ordinal encoding