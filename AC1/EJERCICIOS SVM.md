## Ejercicio 1
![[Pasted image 20260609192336.png]]

Para ganar capacidad de generalización. Al centrar la frontera y dejar el máximo margen posible con los puntos más cercanos, creando un margen que evita que el modelo falle con datos nuevos o ruido

## Ejercicio 2
![[Pasted image 20260609192714.png]]

Son los puntos del conjunto de datos que se encuentran justo en el borde del margen. La frontera de decisión viene determinada por los vectores de soporte

## Ejercicio 3
![[Pasted image 20260609193017.png]]

Si es 0, estamos hablando de la frontera de decisión, si es mayor que 0 se encuentra a un lado de la frontera y si es menor que 0 al otro lado de la frontera. Cuanto más lejano de 0 está, más lejos de la frontera está el punto

## Ejercicio 4
![[Pasted image 20260609193548.png]]

Porque ante datos nuevos o ruido puede ser más sensible y generalizar peor

## Ejercicio 5
![[Pasted image 20260609193654.png]]

No cambia ya que la frontera depende de los vectores de soporte, y éstos se mueven si el punto más cercano a la frontera cambia

## Ejercicio 6
![[Pasted image 20260609193824.png]]

Porque el hard margin impide que un dato esté dentro del margen (prohibe errores de clasificación), por lo que un outlier puede impedir la creación de la frontera

## Ejercicio 7
![[Pasted image 20260609194037.png]]

Hard margin: al prohibir errores, se ajusta al entrenamiento y se deforma por el ruido o los outliers, generalizando peor con datos nuevos.
Soft margin: al permitir errores, ignora el ruido y los outliers, manteniendo una frontera recta y limpia que generaliza mejor ante datos nuevos.

## Ejercicio 8
![[Pasted image 20260609194333.png]]

Como C multiplica a la pérdida hinge, un C grande penaliza más el error, impidiendo que no hayan puntos en el margen, dejando un margen estrecho. Un C pequeño es más flexible y penaliza menos, dejando que hayan puntos en el margen a cambio de mejor generalización
## Ejercicio 9
![[Pasted image 20260609194721.png]]

En hard margin, al forzar una precisión alta en el entrenamiento, el margen se deforma memorizando el ruido y los outliers, por lo que falla ante nuevos datos en validación. En soft margin, al ser más flexible, permite errores en el entrenamiento y la frontera se mantiene mejor y generaliza mejor ante nuevos datos en validación

## Ejercicio 10
![[Pasted image 20260609195239.png]]

Si $\xi=0$, el punto está lejos del margen y clasificado correctamente, por lo que $yf(x)\ge 1$
Si $0 \lt \xi \lt 1$, el punto está en el margen y clasificado correctamente, por lo que $0\lt yf(x)\lt 1$
Si $\xi = 1$, el punto está encima de la frontera, $yf(x) = 0$
Si $\xi \gt 1$, el punto ha pasado la frontera y clasificado incorrectamente, por lo que $yf(x) \lt 0$

## Ejercicio 11
![[Pasted image 20260609200403.png]]

Queremos tener un buen margen para que ante nuevos datos sea más flexible y no cruzar tan fácil la frontera, por lo que cuánto más lejos estén los puntos de la frontera, más fácil será generalizar

## Ejercicio 12
![[Pasted image 20260609200602.png]]

Porque es un algoritmo basado en distancias, por lo que ante gran diferencia de escalas puede deformar la frontera ignorando las variables de escalas pequeñas

## Ejercicio 13
![[Pasted image 20260609201325.png]]

Porque la frontera depende de los vectores de soporte, formado por los puntos más cercanos a la frontera, por lo que los puntos más importantes son esos, y los que están mas alejados no influyen en nada. Esto se aplica con $\alpha$ (0 para los lejanos que no influyen)

## Ejercicio 14
![[Pasted image 20260609201640.png]]

Porque se puede sustituir el producto $x^T_ix$ por una función a optimizar, eliminando la linealidad de SVM

## Ejercicio 15
![[Pasted image 20260609201845.png]]

Porque no hace falta calcular las coordenadas de cada punto nuevo, se aplica una función y ya estamos en un espacio transformado

## Ejercicio 16
![[Pasted image 20260609202045.png]]

Porque se aplica una función que lleva los puntos a una dimensión más alta donde la SVM traza un hiperplano recto y lineal. Al aplicar la inversa para volver al espacio original, esa frontera recta se deforma, convirtiéndose en una frontera curva y no lineal

## Ejercicio 17
![[Pasted image 20260610111955.png]]

El lineal hace fronteras rectas. El polinómico hace fronteras dobladas y curvas. El RBF o gaussiano hace fronteras super complejas, capaz de formar islas independientes a ciertos datos

## Ejercicio 18
![[Pasted image 20260610112255.png]]

Como ese kernel crea fronteras super complejas y se adapta mucho a los datos de entrenamiento, falla ante nuevos datos

## Ejercicio 19
![[Pasted image 20260610112409.png]]

Porque puede provocar overfitting al al crear fronteras para todos los datos y no de forma general

## Ejercicio 20
![[Pasted image 20260610112440.png]]

Los vectores de soporte definen la posición de la frontera y la distancia entre ellos y la frontera es el margen. Maximizar este margen aleja la frontera lo máximo posible de ambas clases, lo que reduce el riesgo de cometer errores con datos nuevos y una mejor generalización

## Ejercicio 21
![[Pasted image 20260610112557.png]]

El que tiene mayor separación ya que el objetivo de SVM es maximizar el margen. Ante nuevos datos podemos dejar más margen en la frontera y evitar fallos

## Ejercicio 22
![[Pasted image 20260610112903.png]]

Porque la de margen duro prohíbe errores de clasificación, por lo que deformaría la frontera al haber esos errores. El margen suave permite ciertos errores, por lo que la frontera no se deformaría y seguiría igual para una mejor generalización

## Ejercicio 23
![[Pasted image 20260610113131.png]]

Hay muchos puntos en el margen. Esto ocurre porque las clases están mezcladas, o porque el modelo ha sido definido con un margen muy ancho

## Ejercicio 24
![[Pasted image 20260610113633.png]]

No. Los vectores de soporte son todos los puntos que cruzan el margen. Incluye tanto a puntos bien clasificados como a los puntos mal clasificados

## Ejercicio 25
![[Pasted image 20260610114007.png]]

Al ser un algoritmo basado en distancias, la nueva variable de gran escala domina la distancia, obligando a la SVM a crear una frontera que solo hace caso a esa variable grande. La solucion es escalar la variable 

## Ejercicio 26
![[Pasted image 20260610114402.png]]

Al ser un circulo, una SVM lineal no puede hacer curvas. La solución es usar un kernel gaussiano ya que puede hacer fronteras muy complejas

## Ejercicio 27
![[Pasted image 20260610114551.png]]

Mide cuánto se parece el nuevo punto a los vectores de soporte en el espacio transformado para decidir su clase

## Ejercicio 28
![[Pasted image 20260610114919.png]]

El modelo está sufriendo overfitting. Un C alto penaliza mucho cada error, forzando a la frontera a ajustarse a los datos de entrenamiento, provocando que el modelo falle al generalizar con los datos nuevos de validación

## Ejercicio 29
![[Pasted image 20260610115345.png]]

La frontera depende de los vectores de soporte (pocos puntos), sin importar cuántas variables tengan los datos. Depende del kernel y el peso que le demos al error (C), podemos estar haciendo overfitting

## Ejercicio 30
![[Pasted image 20260610115552.png]]

Lineal: a lo mejor el problema no es linealmente separable, por eso los bajos resultados
Polinómico: con curvas suaves es capaz de dividir la frontera y además con un margen suave, mejorando ambos resultados
Gaussiano: se ha ajustado demasiado a los datos de entrenamiento ya que hace fronteras muy complejas y muy ajustadas a los datos, por lo que ante nuevos datos falla.

## Ejercicio 31
![[Pasted image 20260610115825.png]]

A: al ser mayor que 0, está en la clase positiva
B: al ser mayor que 0 y cercano a 0 (menor que 1), está en la clase positiva y además cerca de la frontera (dentro del margen)
C: al ser menor que 0, está en la clase negativa

## Ejercicio 32
![[Pasted image 20260610120341.png]]

A: $\max(0, 1-1.8) = 0$, como es 0, está en su clase correcta ya demás lejos de la frontera
B: $\max(0, 1-0.6) = 0.4$, como $0 \lt 0.4 \lt 1$, está en su clase correcta pero dentro del margen
C: $\max(0, 1-(-0.4)) = 1.4$, como $1.4 \gt 1$, está en la otra clase, ha pasado la frontera

## Ejercicio 33
![[Pasted image 20260610120839.png]]

Según el valor de C, penaliza más o menos la pérdida de hinge. Si C = 100, penaliza más, haciendo que la frontera se ajuste más a ese dato que falló. Si C = 0.1, penaliza mucho menos y se ajusta muy poco la frontera. Al final con un C grande obtenemos overfitting, y con un C menor mayor generalización

## Ejercicio 34
![[Pasted image 20260610121115.png]]

Si se elimina un punto con $\alpha_i = 0$, no ocurriría nada. La frontera y el margen se mantendrían iguales, ya que estos puntos no participan en la definición del hiperplano (están lejos del margen o bien clasificados). Si se elimina P5 (con $\alpha_5 > 0$), al ser un vector de soporte, la frontera cambiará. Al quitar uno de esos, el margen se reajustará buscando nuevos puntos

## Ejercicio 35
![[Pasted image 20260610121526.png]]

Se espera un signo positivo para f(x) y se predecirá la clase positiva. Como lo que se hace es el producto escalar (distancia entre los puntos) en una nueva dimensión, y se dice que son similares (y = 1), la suma daría positiva, por lo que la clase es positiva.

## Ejercicio 36
![[Pasted image 20260610123043.png]]

Al no escalar los datos, la variable de ingresos domina el cálculo de distancias y productos escalares. Como la SVM utiliza estas magnitudes para construir la frontera de decisión, el modelo dará mucho más peso a esa variable y apenas considerará la otra

## Ejercicio 37
![[Pasted image 20260610124659.png]]

Al introducir una nueva dimensión con polinomios, ya estamos quitando linealidad e incluyendo curvas, por lo que podría ayudar a separar las clases que con una recta no se podía separar

## Ejercicio 38
![[Pasted image 20260610124839.png]]

El lineal por ser más simple, más interpretable y menos propenso al sobreajuste. Cambiaría de decisión si los datos no fueran linealmente separables o si con el kernel mostrara una mejor mejora

## Ejercicio 39
![[Pasted image 20260610125030.png]]
![[Pasted image 20260610125037.png]]

a) El punto P2 y N3 ya que son los puntos de cada clase que están mas cerca

b) $(\frac{8+5}{2},\frac{6+3}{2})=(6.5, 4.5)$

c) $\frac{x-x_1}{x_2-x_1}=\frac{y-y_1}{y_2-y_1}$, $\frac{x-5}{8-5}=\frac{y-3}{6-3}$, $3(x-5)=3(y-3)$, $y=x-2$

d) $y-4.5=-(x-6.5)$, $y=-x+11$

e) $-x-y+11=0$

f) $-5-3+11=3$, $f(x,y)=\frac{1}{3}(-x-y+11)$

g) $w=\frac{1}{9}*(8,6)+\frac{1}{9}*(-1)*(5,3)=(\frac{1}{3}, \frac{1}{3})$
Usamos el vector de soporte $1/3*5+1/3*3+b=-1$, $b=-3.67$, $f(x,y)=\frac{1}{3}x+\frac{1}{3}y-3.67$