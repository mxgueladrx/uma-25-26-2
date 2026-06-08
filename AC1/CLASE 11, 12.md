**Aprendizaje no supervisado**: datos no etiquetados
## Clustering
Divide el conjunto de datos en clusters con características similares.

**K-means**: optimiza la media del cuadrado de las distancias euclídeas entre cada ejemplo y el centroide que se le asigna. La función de coste sería $J=\frac{1}{m}\sum^{m}_{i=1}||x_i-\mu_{c_i}||^2$.

**Algoritmo**:
- Inicializar aleatoriamente los centroides $\mu_1, \mu_2,...\mu_k$.
- Para cada ejemplo $x_i, i=1...m$ y cada cluster $k=1...K$
	- Calculamos su distancia a cada centroide $||x_i-\mu_k||^2$.
	- Asignamos cada punto al cluster $c_i$ más cercano $c_i=\arg\min_k||x_i-\mu_k||^2$. Minimiza $J$ respecto a las asignaciones $c_i$.
	- Actualizamos cada centroide como la media de los puntos asignados al cluster $\mu_k=\frac{1}{|C_k|}\sum_{i\in C_k}x_i$, donde $C_k$ es el conjunto de puntos del clúster $k$. Minimiza $J$ respecto a $\mu_k$.
- Parar cuando $c_i$ no cambien respecto a la iteración anterior.

### Ejemplo
![[Pasted image 20260518204340.png]]![[Pasted image 20260518204354.png]]

**Sensibilidad a la inicialización**: el resultado puede cambiar dependiendo de la inicialización de los centroides
- **Estrategia de reinicio aleatorio**: realizar K-means $T$ veces y quedarse con la configuración que haya conseguido el $J$ más bajo.
**Grupos no suelen ser separables**: si no hay separación clara entre los datos, K-means no es el mejor algoritmo. Alternativas como DBSCAN o modelos de mezcla.
**Clusters vacíos**: no tiene puntos asignados. Solución: reducir $K$, reubicar centroides, colocar centroide en el punto más lejano (mayor error) $\arg\min_i||x_i-\mu_{c_i}||^2$.
**Elección de $K$**:
- **Método del codo**: realizar K-means para diferentes $K$, calcular $J$ y buscar un codo donde la mejora deja de ser significativa.
- **Método Silhouette**: mide cómo de bien encaja cada dato en su grupo en comparación con los demás grupos, la separación del cluster vecino. Para cada ejemplo $i$, $s(i)=\frac{b(i)-a(i)}{\max (a(i),b(i))}$ donde $a(i)$ es la distancia media del punto $i$ a los puntos de su cluster y $b(i)$ la menor distancia media del punto $i$ a los puntos del otro cluster. 
	- Si $s(i) \approx 1$: es un punto bien asignado.
	- Si $s(i)\approx 0$: es un punto cerca de la frontera.
	- Si $s(i) \lt 0$: es una posible mala asignación.
  Definimos $S_k=\frac{1}{m}\sum^{m}_{i=1}s(i)$. Elegimos el valor de $k$ que maximiza $S_k$.
**Sensible a outliers**: solución: preprocesamiento (eliminarlos), usar meloides (puntos del cluster cuya distancia total al resto es mínima), usar DBSCAN.
**Clusters no convexos**: se asume clusters compactos y esféricos (datos en forma de anillo y en medio no puede). Se usan kernels o DBSCAN.

**DBSCAN**: agrupa puntos en función de la densidad. Regiones de baja densidad separan los clusters. No asume formas esféricas. Detecta outliers. 

Se define una distancia $\epsilon$ para considerar puntos que están cerca. Serán vecinos de un punto si están dentro de su radio $\epsilon$. Definimos $minPts$ como el número mínimo de puntos que queremos en cada vecindario. Hay 3 tipos de puntos:
- **Núcleo**: tienen al menos $minPts$ en su vecindario (dentro del cluster).
- **Frontera**: no es núcleo pero estan en el vecindario de un núcleo (borde del cluster).
- **Noise**: otro caso (ruido, outliers).
Los clusters se forman conectando núcleos cercanos.

**Algoritmo**:
- Escalar variables. Fijar un $\epsilon$ y un $minPts$.
- Para cada punto calcular su vecindad.
- Identificar los núcleos.
- Para cada núcleo sin asignar.
	- Crear un cluster y añadir sus vecinos.
- Expandir el cluster.
	- Si un punto añadido es núcleo, se añade sus vecinos.
- Repetir hasta que no se puedan añadir más puntos.
- Los que no pertenecen a ningún cluster son ruido/outliers.

### Ejemplo
![[Pasted image 20260518213350.png]]

![[Pasted image 20260518213410.png]]

## Análisis de componentes principales
**Maldición de dimensionalidad**: en altas dimensiones, los datos se vuelven más dispersos. Si el dataset tiene $m$ rasgos y cada uno $n$ intervalos, hay $n^m$ regiones.

**PCA**: representa datos con menos dimensiones conservando la mayor variabilidad. Construye PC como combinaciones de las variables. La PC1 recoge la máxima variabilidad, las siguientes las restantes. Hay que escalar antes de PCA (z-score), así se centra en analizar la estructura de variabilidad y correlación.

Lleva los datos a un nuevo sistema de coordenadas donde los nuevos ejes apuntan en direcciones de máxima varianza. Los datos se proyectan en el subespacio que determinan las PC.

Reduce dimensionalidad, más simple de visualizar datos, extracción de rasgos a partir de las PC y elimina redundancia.

**Calcular proyecciones sobre las PC**:

![[Pasted image 20260519170010.png]]

Busca una dirección unitaria $u$ tal que las proyecciones de los puntos sobre esa dirección tengan máxima varianza. $\max_{||u|=1}\sum_i (x_i * u)^2$ donde la longitud de la proyección $y_i=x_i*u$.

No es regresión lineal, ésta predice y minimiza errores en el eje $y$. PCA busca una dirección que resuma los datos maximizando la varianza proyectada y minimizando distancias ortogonales.

Algoritmo:
- Escalar con z-score.
- Calcular la matriz de covarianzas $\Sigma = \frac{1}{m}\sum_{i=1}^{m} x_i x_i^T = \begin{pmatrix} \text{Var}(X_1) & \text{Cov}(X_1, X_2) \\ \text{Cov}(X_1, X_2) & \text{Var}(X_2) \end{pmatrix}$.
- Calcular los $k$ mayores autovalores $det(\Sigma - \lambda I) = 0$ y autovectores $\Sigma u = \lambda u$, $(\Sigma - \lambda_k I)u_k = 0$.
- Calcular la matriz de autovectores $U_k=[u_1,...,u_k]$
- Las proyecciones se calculan como $y_i=U_k^T x_i = \begin{pmatrix} u_1^T x_i \\ \vdots \\ u_k^T x_i \end{pmatrix}$ Siendo cada $u_k^T x_i$ la coordenada del punto sobre la PC$k$.

**Varianza y número óptimo de PC**: sea $m$ muestras y $p$ variables:
- **Varianza explicada por la componente $r$**: $Var(y_r)=\lambda_r$
- **Porcentaje de varianza explicada por la componente $r$**: $\frac{\lambda_r}{\sum^{p}_{j=1}\lambda_j}$
- **Porcentaje de varianza acumulada hasta la componente $r$**: $\frac{\sum^{r}_{j=1}\lambda_j}{\sum^{p}_{j=1}\lambda_j}$. Se elige un número de componentes tal que el porcentaje de varianza acumulada sea $\ge \alpha$. El menor a partir del cual añadir más PC apenas aumenta la varianza (criterio del codo).

### Ejercicio
![[Pasted image 20260519173019.png]]

$\Sigma = \begin{pmatrix} 5.549 & 0.5539 \\ 0.5539 & 0.6449 \end{pmatrix}$
$det(\Sigma - \lambda I)=0; det\begin{pmatrix} 0.5549-\lambda & 0.5539 \\ 0.5539 & 0.6449-\lambda \end{pmatrix}=0; (0.5549-\lambda)(0.6449-\lambda)-0.3068; \lambda^2 - 1.1998\lambda + 0.051 = 0; \lambda_1 = 1.1557, \lambda_2 = 0.0441$
**Autovector de $\lambda_1$**:
$\begin{pmatrix} 0.5549-1.1557 & 0.5539 \\ 0.5539 & 0.6449-1.1557 \end{pmatrix}u_k = 0; \begin{pmatrix} -0.6007 & 0.5539 \\ 0.5539 & -0.5107 \end{pmatrix} u_k = 0; -0.6007 * u_1 + 0.5539 * u_2 = 0; u_2= 1.08453 * u_1$
Para $u_1=1 \implies v_1=\begin{pmatrix} 1 \\ 1.0845 \end{pmatrix}$. Normalizamos dividiendo por $\sqrt{1^2+1.0845^2}; v_1= \begin{pmatrix} 0.6779 \\ 0.7352 \end{pmatrix}$
**Autovector de $\lambda_2$**:
$\begin{pmatrix} 0.5549-0.0441 & 0.5539 \\ 0.5539 & 0.6449-0.0441 \end{pmatrix}u_k = 0; \begin{pmatrix} 0.5107 & 0.5539 \\ 0.5539 & 0.6007 \end{pmatrix} u_k = 0; 0.5107 * u_1 + 0.5539 * u_2 = 0; u_2= -0.9221 * u_1$
Para $u_1=1 \implies v_1=\begin{pmatrix} 1 \\ -0.9221 \end{pmatrix}$. Normalizamos dividiendo por $\sqrt{1^2+(-0.9221)^2}; v_1= \begin{pmatrix} 0.7352 \\ -0.6779 \end{pmatrix}$

Proyectamos los puntos, por ejemplo para $x_1$:
$PC1=v_1^Tx_1=0.6779*0.69+0.7352*0.49= 0.828$
$PC2=v_2^Tx_1=0.7352*0.69-0.6779*0.49= 0.1751$

![[Pasted image 20260519172933.png]]![[Pasted image 20260519172943.png]]