## Ejercicio 1
![[Pasted image 20260608162349.png]]
![[Pasted image 20260608162357.png]]

Podemos ver un claro codo en K = 4, ya que a partir de ese punto el valor de WCSS decrece de forma mucho más suave que al principio (curva casi plana), la reducción no es significativa.

## Ejercicio 2
![[Pasted image 20260608162654.png]]

1)
$\mu_{1_{\{a, b, d\}}}=(\frac{0+8+0}{3},\frac{0+0+6}{3})=(2.67, 2)$
$\mu_{2_{\{c, e\}}}=(\frac{16+8}{2},\frac{0+6}{2})=(12, 3)$
$\mu_{3_{\{f\}}}=(\frac{16}{1},\frac{6}{1})=(16, 6)$

Paso de calcular 18 distancias, lo hago en el grafico. Hay que calcular para cada punto la distancia a cada cluster y asignarle el que está más cerca

Cluster 1: {a, d}
Cluster 2: {b, c, e}
Cluster 3: {f}

No es estable

2)
$\mu_{1_{\{a, b\}}} = (\frac{0+8}{2}, \frac{0+0}{2}) = (4, 0)$
$\mu_{2_{\{d, e\}}} = (\frac{0+8}{2}, \frac{6+6}{2}) = (4, 6)$
$\mu_{3_{\{c, f\}}}= (\frac{16+16}{2}, \frac{0+6}{2}) = (16, 3)$

Cluster 1: {a, b}
Cluster 2: {d, e}
Cluster 3: {c, f}

Si es estable

3)
$\mu_{1_{\{a, d\}}} = (\frac{0+0}{2}, \frac{0+6}{2}) = (0, 3)$
$\mu_{2_{\{b, e\}}} = (\frac{8+8}{2}, \frac{0+6}{2}) = (8, 3)$
$\mu_{3_{\{c, f\}}}= (\frac{16+16}{2}, \frac{0+6}{2}) = (16, 3)$

Cluster 1: {a, d}
Cluster 2: {b, e}
Cluster 3: {c, f}

Si es estable

4)
$\mu_{1_{\{a\}}} = (\frac{0}{1}, \frac{0}{1}) = (0, 0)$
$\mu_{2_{\{d\}}} = (\frac{0}{1}, \frac{6}{1}) = (0, 6)$
$\mu_{3_{\{b, c, e, f\}}}= (\frac{8+16+8+16}{4}, \frac{0+0+6+6}{4}) = (12, 3)$

Cluster 1: {a}
Cluster 2: {d}
Cluster 3: {b, c, e, f}

Si es estable

5)
$\mu_{1_{\{a, b\}}} = (\frac{0+8}{2}, \frac{0+0}{2}) = (4, 0)$
$\mu_{2_{\{d\}}} = (\frac{0}{1}, \frac{6}{1}) = (0, 6)$
$\mu_{3_{\{c, e, f\}}}= (\frac{16+8+16}{3}, \frac{0+6+6}{3}) = (13.33, 4)$

Cluster 1: {a, b}
Cluster 2: {d}
Cluster 3: {c, e, f}

Si es estable

6)
$\mu_{1_{\{a, b, d\}}} = (\frac{0+8+0}{3}, \frac{0+0+6}{3}) = (2.67,2)$
$\mu_{2_{\{c\}}} = (\frac{16}{1}, \frac{0}{1}) = (16, 0)$
$\mu_{3_{\{e, f\}}}= (\frac{8+16}{2}, \frac{6+6}{2}) = (12, 6)$

Cluster 1: {a, b, d}
Cluster 2: {c}
Cluster 3: {e, f}

Si es estable

## Ejercicio 3
![[Pasted image 20260608170206.png]]

Paso de calcular distancias, se ve a simple vista en el gráfico. En todo caso es calcular distancias y comprobar que sea $\le \epsilon$

1)
P1: borde
P2: núcleo
P3: borde
P4: borde
P5: núcleo
P6: borde
P7: borde
P8: borde
P9: ruido
P10: borde
P11: núcleo
P12: borde

2)
Cluster 1: {1, 2, 3, 10, 11, 12}
Cluster 2: {4, 5, 6, 7, 8}

## Ejercicio 4
![[Pasted image 20260608175518.png]]

1)
Consiste en dividir los datos en regiones con características similares. La diferencia es que aquí los datos no están etiquetados

2)
Inicializamos K centroides aleatorios en el grafico. Calculamos la distancia de cada punto a cada centroide. Asignamos a cada punto su centroide más cercano. Calculamos el nuevo centroide a partir de la media de los puntos asignados a ese centroide. Repetir estos pasos hasta que los centroides no se muevan más o, lo que es equivalente, la función de coste J converge

3)
Escalar o normalizar (z-score o min-max)

4)
Usando el método del codo: realizar K-means para diferentes K, calcular J y buscar un codo donde la mejora deja de ser significativa.
Método Silhouette: mide cómo de bien encaja cada dato en su grupo en comparación con los demás grupos. Para cada ejemplo $i$, $s(i)=\frac{b(i)-a(i)}{\max (a(i),b(i))}$ donde $a(i)$ es la distancia media del punto $i$ a los puntos de su cluster y $b(i)$ la menor distancia media del punto $i$ a los puntos del otro cluster. 
	- Si $s(i) \approx 1$: es un punto bien asignado.
	- Si $s(i)\approx 0$: es un punto cerca de la frontera.
	- Si $s(i) \lt 0$: es una posible mala asignación.
  Definimos $S_k=\frac{1}{m}\sum^{m}_{i=1}s(i)$. Elegimos el valor de $k$ que maximiza $S_k$.

5)
Viendo el gráfico, un cluster puede ser pingüinos con picos y aletas más cortos que el segundo, que tiene dimensiones mayores (dos especies de pingüinos)

## Ejercicio 5
![[Pasted image 20260608182402.png]]
![[Pasted image 20260608182413.png]]

1)
Escalar o normalizar (z-score o min-max)

2)
Usar el gasto del cliente y la fidelidad o satisfacción a la empresa

3 y 4)
K = 2:
	Cluster 1: fidelidad positiva y alta satisfacción
	Cluster 2: fidelidad negativa y baja satisfacción
K = 3:
	Cluster 1: muchos gastos, satisfechos y fieles
	Cluster 2: muchos gastos, insatisfechos y no fieles
	Cluster 3: bajos gastos
K = 4:
	Cluster 1: muchos gastos y alta fidelidad
	Cluster 2: muchos gastos y baja fidelidad
	Cluster 3: pocos gastos y alta fidelidad
	Cluster 4: pocos gastos y baja fidelidad

5)
Con K = 4 ya que es el que mejor divide a los grupos de clientes, teniendo en cuenta todas las posibilidades de la fidelidad y los gastos (atributos más "importantes")

## Ejercicio 6
![[Pasted image 20260608183923.png]]

1)
K = 4, es el máximo

2)
Puede dar una puntuación alta, por ejemplo, donde un clúster tiene el la mayor parte de los datos y los demás clusters están casi vacíos (pocos datos).

3)
El método del codo solo mide la distancia de los puntos a su centroide correspondiente, Silhouette mide además que ese punto esté lejos de otro cluster vecino.

## Ejercicio 7
![[Pasted image 20260608184655.png]]
![[Pasted image 20260608184709.png]]

1)
$s(x_2)=\frac{6-2.5}{max(6, 2.5)}=0.583$

2)
Como el valor es mayor que 0, significa que ese punto está bien asignado a ese cluster

3)
Si fuese mayor, el numerador sería negativo, por lo que el coeficiente sería negativo y el punto no está bien asignado, está más cerca del otro cluster que el suyo propio.

## Ejercicio 8
![[Pasted image 20260608185423.png]]

1)
K = 4, es el máximo

2)
Porque se dice que los puntos están uniformemente distribuidos, por lo que todo es aleatorio y no se puede interpretar grupos. A pesar de eso, K-means siempre agrupa los puntos de alguna forma, aunque luego el resultado no tenga explicación.

3)
Crea los clusters en regiones donde hay más densidad de puntos, definiendo un radio y mínimo de puntos para que se cree el cluster

## Ejercicio 9
![[Pasted image 20260608185814.png]]

1)
En supervisado los datos están etiquetados, predicen una clase o valor, en no supervisado están sin etiquetar, buscando patrones o grupos

2)
La media de los puntos asignados a ese cluster

3)
Porque es un algoritmo basado en distancias, por lo que variables con altos valores dominan la distancia. La solución es escalar o normalizar las variables

4)
La distancia entre los puntos de un mismo cluster tiene que ser mínima

5)
Como la inicialización se hace en puntos aleatorios, pueden converger varios cluster distintos según esa inicialización

6)
Mide que tan bien encaja un punto en su cluster asignado y la separación del cluster vecino

7)
Que esta bien asignado a su cluster

8)
Que esta mal asignado a su cluster, esta más cerca de un cluster vecino que el suyo propio

9)
K-means depende de distancias entre puntos e inicializar un valor para K, DBSCAN en la densidad de los puntos y no hace falta inicializar nada, el mismo algoritmo detecta el número de clusters que hacen falta

10)
DBSCAN no es sensible a los datos con ruido ya que en esa zona no hay la suficiente densidad de puntos para que se cree un cluster, asignando esos puntos aislados como ruido