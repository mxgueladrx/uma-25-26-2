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
- **Método del codo**: realizar K.means para diferentes $K$, calcular $J$ y buscar un codo donde la mejora deja de ser significativa.
- **Método Silhouette**: mide cómo de bien encaja cada dato en su grupo en comparación con los demás grupos. Para cada ejemplo $i$, $s(i)=\frac{b(i)-a(i)}{\max (a(i),b(i))}$ donde $a(i)$ es la distancia media del punto $i$ a los puntos de su cluster y $b(i)$ la menos distancia media del punto $i$ a los puntos del otro cluster. 
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
