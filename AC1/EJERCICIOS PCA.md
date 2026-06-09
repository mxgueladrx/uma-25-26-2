## Ejercicio 1
![[Pasted image 20260609140741.png]]

a) Representar datos en menos dimensiones conservando la mayor variabilidad. Lleva los datos a un nuevo sistema de coordenadas donde los ejes apuntan a direcciones de máxima varianza

b) Para analizar la estructura y variabilidad real de los datos. 

c) Centrar consiste en restar la media para que valga cero, manteniendo las unidades originales. Estandarizar, tras restar la media, divide entre la desviación típica para que todas las variables tengan varianza 1 y la misma escala.

d) Que son perpendiculares y no tiene correlación ninguna

e) Porque busca variables que estén correlacionadas para unir todas ellas y crear una PC

f) Perdemos las variables y solo vemos direcciones, solo vemos combinaciones lineales de variables

## Ejercicio 2
![[Pasted image 20260609141539.png]]

a) Como los datos están sin estadarizar, X1 es la variable que más varianza tiene ya que hablamos de miles, y como PC1 es la componente que más varianza acumula, X1 domina esa componente

b) No, por lo que dijimos antes

c) Pues por ejemplo la PC1 podría estar dominada, ahora si de forma justa, por otra variable o combinaciones de otras.

d) Cuando todas las variables tienen la misma unidad de medida

## Ejercicio 3
![[Pasted image 20260609142153.png]]![[Pasted image 20260609142202.png]]

a) En este caso no ya que lo que quiere es representarlo gráficamente y la mejor opción para ello sería en 2D, además de que un 72% de varianza con solo 2 PC es bastante.

b) Para visualización queremos ver las direcciones de máxima varianza de las variables y los datos. Para la entrada de algoritmo nos permite pasar de miles de variables a solo decenas que minimice la pérdida de información, mejorando el rendimiento

c) Perderíamos un 28% de información

d) Elegir solo las primeras 5 PC ya que con ellas ya explicamos el 91% de la varianza, pasando de 20 a 5 variables y perdiendo solo un 9% de información

## Ejercicio 4
![[Pasted image 20260609142837.png]]

a) Como los patrones de fraude son menos frecuentes y los que no lo son dominan el dataset, dominan también las PC, perdiendo información que de verdad nos interesa que es el fraude

b) En este caso no, ya que es una clase minoritaria y es la que más nos interesa. Por ejemplo cuando hay un desbalance de clases y nos interesa la clase minoritaria

c) Analizar si con esas componentes es suficiente para almacenar el tipo de información que necesitamos, evaluando la correlación de cada PC con la variable objetivo

d) La máxima varianza solo busca dónde se dispersan más los datos. La máxima utilidad predictiva consiste busca las variables que realmente separan las clases. Por ejemplo si una variable cambia muy poco y ese cambio es significante para decidir la clase, esa variable es de máxima utilidad predictiva

## Ejercicio 5
![[Pasted image 20260609143822.png]]

a) Si, como la renta, el nivel educativo y la esperanza de vida son variables correlacionadas y se mueven en la misma dirección positiva, el nombre resume perfectamente esa PC

b) Analizar el signo y que los datos hayan sido estandarizados

c) Según PCA, como esas variables tiene pesos positivos altos, a mayor renta mayor esperanza de vida, pero eso no implica que sea una causa real, correlación no implica causalidad.

d) Porque se debe interpretar primero los resultados para asignarle un nombre, ya que PCA solo da direcciones

## Ejercicio 6
![[Pasted image 20260609144755.png]]

a) Tenemos muchas variables y además ruido. PCA recoge las variables más "importantes", descartando variables que no aportan información y eliminando ruido

b) Al eliminar la redundancia de las variables correlacionadas y filtrar el ruido, PCA recalcula las distancias de forma que reflejen únicamente las diferencias reales y estructurales de los datos

c) No estaríamos recogiendo la suficiente varianza y estaríamos perdiendo gran % de información, complicando la separación de clases a k-means

d) Calcular la varianza acumulada para cada número de PC (scree plot), encontrando así el valor óptimo.

## Ejercicio 7
![[Pasted image 20260609145800.png]]

a) Porque PCA busca correlaciones entre variables, usando esas otras variables para "predecir" ese valor perdido

b) Al usar solo las primeras PC para reconstruir los datos, se elimina el ruido y estima el valor perdido basándose en cómo se comportan el resto de las variables correlacionadas

c) Si hay muchos valores perdidos, rellenar por la media sesgará las PC

d) Al principio se usa unos datos rellenados con la media. En la segunda iteración, como ya hemos sustituido las medias por los valores reconstruidos, las nuevas PC serán mucho más precisos. Repetir esto asegura que rellenar los valores perdidos sea lo más preciso posible

## Ejercicio 8
![[Pasted image 20260609150646.png]]

a) PCA busca maximizar la varianza. Un punto que esté lejos tendrá una distancia alta. Para PCA, ese punto representa mucha varianza, por lo que el algoritmo priorizará coger ese punto antes que al resto

b) Solo guarda información de los valores atípicos, alineándose esa PC al outlier

c) Al hacer z-score, comprobar que sea menor que 3 ya que si es más se considera outlier. Analizar el IQR. O sino mediante gráficos, como el Boxplot, scatter plot o histogramas.

d) Para ver si hay puntos (datos) mal posicionados sesgados por los outliers

## Ejercicio 9
![[Pasted image 20260609171557.png]]

a) Calculamos su módulo y tiene que dar 1: $||u_1||=\sqrt{(\frac{2}{\sqrt{5}})^2 + (\frac{1}{\sqrt{5}})^2}=1$. Si es un vector unitario

b) $z_1 = (5) * (\frac{2}{\sqrt{5}}) + (1) * (\frac{1}{\sqrt{5}}) = \frac{11}{\sqrt{5}}$

c) $\hat{x} = \frac{11}{\sqrt{5}} * ( \frac{2}{\sqrt{5}}, \frac{1}{\sqrt{5}}) = ( \frac{22}{5}, \frac{11}{5}) = (4.4, 2.2)$

d) $e = (5, 1) - (4.4, 2.2) = (0.6, -1.2)$

e) Para que sea ortogonal el producto escalar debe dar 0: $e * u_1 = (0.6) * (\frac{2}{\sqrt{5}}) + (-1.2) * (\frac{1}{\sqrt{5}})= 0$

## Ejercicio 10
![[Pasted image 20260609170702.png]]

a) Suma de todos los autovalores: $\sum^{6}_{i=1} \lambda_i=10$

b) 
Proporción de $\lambda_1$: $5.5/10=55\%$
Proporción de $\lambda_2$: $2.1/10=21\%$
Proporción de $\lambda_3$: $1/10=10\%$
Proporción de $\lambda_4$: $0.8/10=8\%$
Proporción de $\lambda_5$: $0.4/10=4\%$
Proporción de $\lambda_6$: $0.2/10=2\%$

c)
Acumulada de $\lambda_1$: 55%
Acumulada de $\lambda_2$: 76%
Acumulada de $\lambda_3$: 86%
Acumulada de $\lambda_4$: 94%
Acumulada de $\lambda_5$: 98%
Acumulada de $\lambda_6$: 100%

d) 3 PC, conseguimos 86%

e) 4 PC, conseguimos 94%

f) 5 PC, conseguimos 98%

## Ejercicio 11
![[Pasted image 20260609171532.png]]
![[Pasted image 20260609171611.png]]

a)
$||u_1||=\sqrt{(\frac{1}{\sqrt{5}})^2 + (\frac{2}{\sqrt{5}})^2}=1$
$||u_2||=\sqrt{(\frac{-2}{\sqrt{5}})^2 + (\frac{2}{\sqrt{5}})^2}=1$
$u_1 * u_2=(\frac{1}{\sqrt{5}}) * (\frac{-2}{\sqrt{5}}) + (\frac{2}{\sqrt{5}})*(\frac{2}{\sqrt{5}})=0$

b) 
$x_1$: 
	$z_{1_1}=(3)*(\frac{1}{\sqrt{5}})+(1)*(\frac{2}{\sqrt{5}})=\sqrt{5}$
	$z_{1_2}=(3)*(\frac{-2}{\sqrt{5}})+(1)*(\frac{1}{\sqrt{5}})=-\sqrt{5}$
$x_2$: 
	$z_{2_1}=(1)*(\frac{1}{\sqrt{5}})+(3)*(\frac{2}{\sqrt{5}})=\frac{7}{\sqrt{5}}$
	$z_{2_2}=(1)*(\frac{-2}{\sqrt{5}})+(3)*(\frac{1}{\sqrt{5}})=\frac{1}{\sqrt{5}}$
$x_3$:
	$z_{3_1}=(-2)*(\frac{1}{\sqrt{5}})+(-1)*(\frac{2}{\sqrt{5}})=\frac{-4}{\sqrt{5}}$
	$z_{3_2}=(-2)*(\frac{-2}{\sqrt{5}})+(-1)*(\frac{1}{\sqrt{5}})=\frac{3}{\sqrt{5}}$
$x_4$: 
	$z_{4_1}=(-1)*(\frac{1}{\sqrt{5}})+(-3)*(\frac{2}{\sqrt{5}})=\frac{-7}{\sqrt{5}}$
	$z_{4_2}=(-1)*(\frac{-2}{\sqrt{5}})+(-3)*(\frac{1}{\sqrt{5}})=\frac{-1}{\sqrt{5}}$

c)
$Z =\begin{pmatrix} \sqrt{5} & -\sqrt{5} \\ 1.565 & 0.447 \\ -1.789 & 1.342 \\ -3.130 & -0.447 \end{pmatrix}$

d)
$\hat{x}_1=\sqrt{5}*(\frac{1}{\sqrt{5}}, \frac{2}{\sqrt{5}})=(1, 2)$

## Ejercicio 12
![[Pasted image 20260609173254.png]]

a) X1 y X2

b) Personas que tienen muchas horas de redes sociales y videojuegos tienen pocas horas de lectura y deporte

c) X3 y X4

d) Personas que tienen muchas horas de lectura y Deporte

e) Es una persona con muchas horas en todo. Muchas horas de contenido digital y también en deporte y lectura

## Ejercicio 13
![[Pasted image 20260609174012.png]]
![[Pasted image 20260609174024.png]]
![[Pasted image 20260609174033.png]]

a) Cada uno de los datos del dataset (una flor)

b) Las variables (dirección y peso de cada variable que contribuye a PC1 y PC2)

c) Petal length, petal width y sepal length

d) Sepal width

e) Cuanto más largo el pétalo, más ancho es 

f) Setosa

g) Flores con pétalos grandes y sépalos largos

## Ejercicio 14
![[Pasted image 20260609174526.png]]

a) Predecir y minimizar errores en el eje y. Busca la relación entre variables independientes para predecir el valor de una variable dependiente

b) Buscar la dirección de máxima variabilidad minimizando distancias ortogonales

c) En regresión minimizar la distancia en el eje y con la recta de regresión. En PCA minimizar la distancia ortogonal con la PC.

d) No, ya que solo reduce la dimensión de las variables y es no supervisado

## Ejercicio 15
![[Pasted image 20260609175012.png]]

a)
$||u_1||=\sqrt{(2/3)^2+(1/3)^2+(2/3)^2}=1$
$||u_2||=\sqrt{(-1/\sqrt{5})^2+(2/\sqrt{5})^2+(0)^2}=1$
$u_1*u_2=(2/3)*(-1/\sqrt{5})+(1/3)*(2/\sqrt{5})+(2/3)*(0)=0$

b) 
$z_1=(3)*(2/3)+(0)*(1/3)+(6)*(2/3)=6$
$z_2=(3)*(-1/\sqrt{5})+(0)*(2/\sqrt{5})+(6)*(0)=-3/\sqrt{5}$

c)
$\hat{x}_1=6*(2/3,1/3,2/3)=(4,2,4)$

d)
$\hat{x}_2=\hat{x}_1 + 6 * (-1/\sqrt{5},2/\sqrt{5},0)=(4.6,0.8,4)$

e)
$e_1 = x - \hat{x}_1 = (-1 , -2 , 2)$
$e_2 = x - \hat{x}_2 = (-1.6, -0.8 , 2)$
$||e_1||=3$
$||e_2||=2.68$
Como el módulo de $e_2$ es menor, al usar más PC, el error disminuye más.

## Ejercicio 16
![[Pasted image 20260609180804.png]]

a) Si ya que PCA se encarga de reducir dimensiones uniendo esas variables correlacionadas

b) Al tener altas dimensiones, PCA recoge las variables más "importantes", descartando variables que no aportan información y eliminando ruido, facilitando el trabajo a k-means

c) No es útil ya que las PC son combinaciones lineales de todas las variables originales, quitando la interpretabilidad de las variables

d) Si pero usando z-score antes de PCA

e) No importa ya que PCA busca direcciones de alta varianza, dejando el ruido en las últimas componentes (baja varianza)

## Ejercicio 17
![[Pasted image 20260609181457.png]]
![[Pasted image 20260609181505.png]]

a) $\Sigma u_2 = \lambda_2 u_2; \begin{pmatrix}4&0&0\\0&2&1\\0&1&2\end{pmatrix} *\begin{pmatrix}0\\1/\sqrt{2}\\1/\sqrt{2}\end{pmatrix}=3*\begin{pmatrix}0\\1/\sqrt{2}\\1/\sqrt{2}\end{pmatrix};(0, 3/\sqrt{2}, 3/\sqrt{2})=(0, 3/\sqrt{2}, 3/\sqrt{2})$ 

b)
PC1: 4/8 = 50%
PC2: 3/8 = 37.5%
PC3: 1/8 = 12.5%

c)
Acumulada de PC1: 50%
Acumulada de PC2: 87.5%
Acumulada de PC3: 100%

d) Con solo las dos primeras componentes ya explicamos el 87.5%

e) 
PC1 = 2
PC2 = $2\sqrt{2}$

f) 
$\hat{x}_1=3*(1, 0,0)=(2, 0, 0)$
$\hat{x}_2=\hat{x}_1 + 2\sqrt{2}*(0, 1/\sqrt{2}, 1/\sqrt{2})=(2, 2, 2)$ 