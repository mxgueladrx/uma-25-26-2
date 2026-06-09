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


## Ejercicio 18


## Ejercicio 19


## Ejercicio 20


## Ejercicio 21


## Ejercicio 22


## Ejercicio 23


## Ejercicio 24


## Ejercicio 25


## Ejercicio 26


## Ejercicio 27


## Ejercicio 28


## Ejercicio 29


## Ejercicio 30


## Ejercicio 31


## Ejercicio 32


## Ejercicio 33


## Ejercicio 34


## Ejercicio 35


## Ejercicio 36


## Ejercicio 37


## Ejercicio 38


## Ejercicio 39


