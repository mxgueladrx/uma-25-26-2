## Ejercicio 1
![[Pasted image 20260610180917.png]]

Porque permite entender cómo se toma una decisión. Los nodos internos representan condiciones sobre variables, las ramas los posibles resultados de esas condiciones y las hojas la predicción final.

Si asistencia < 70% y nota media < 5, entonces predecir abandono académico. Las variables son asistencia y nota media, la decisión es predecir abandono, y la regla es interpretable porque se expresa como una serie de condiciones simples y comprensibles.

## Ejercicio 2
![[Pasted image 20260610181926.png]]

Un modelo con alta varianza se ajusta mucho a los datos de entrenamiento y generaliza peor a datos nuevos. Los árboles de decisión suelen tener alta varianza porque pequeños cambios en el conjunto de entrenamiento pueden hacer que se elijan divisiones diferentes, dando lugar a árboles y predicciones distintas.

## Ejercicio 3
![[Pasted image 20260610182528.png]]

Porque crean divisiones hasta adaptarse bien a los datos de entrenamiento, incluyendo ruido y casos particulares. Cuando el árbol crece demasiado, el error en entrenamiento disminuye, pero el error en datos nuevos aumenta porque el modelo pierde capacidad de generalización.

## Ejercicio 4
![[Pasted image 20260610182636.png]]

Se selecciona ejemplos del conjunto de entrenamiento con reemplazo. Al devolver cada ejemplo a la muestra después de seleccionarlo, un mismo ejemplo puede aparecer varias veces, mientras que otros pueden no ser elegidos ninguna vez

## Ejercicio 5
![[Pasted image 20260610182837.png]]

Mide la mezcla de las clases en un nodo. Cuanto más mezcladas estén las clases, mayor será la entropía, cuanto más puro sea el nodo, menor será. $H(p)=-p*\log_2 p$. Si el nodo es puro (p=1 o p=0), la entropía vale 0. Si las clases están equilibradas (p=0.5), la entropía vale 1.

## Ejercicio 6
![[Pasted image 20260610183415.png]]

La fórmula mide la impureza de un nodo en función de la proporción p de una clase. Es simétrica respecto a p=0.5 porque intercambiar las probabilidades de las dos clases (p y 1−p) produce la misma entropía. Esto implica que en un problema binario da igual qué clase sea mayoritaria, la impureza solo depende de lo equilibradas que estén ambas clases.

## Ejercicio 7
![[Pasted image 20260610183535.png]]

Mide cuánto se reduce la entropía al dividir los datos según un atributo. Se utiliza para seleccionar atributos que separa mejor las clases y genera nodos más puros.

## Ejercicio 8
![[Pasted image 20260610183739.png]]

Porque entrena varios árboles sobre distintas muestras bootstrap del mismo conjunto de datos. Cada árbol aprende patrones algo diferentes debido a estas variaciones, y al promediar sus predicciones no depende de una única respuesta. 

## Ejercicio 9
![[Pasted image 20260610184142.png]]

Como las muestras bootstrap son con reemplazo, algún ejemplo puede no ser seleccionado. Estos se llaman OOB. Como no se han usado para entrenar el árbol, puede ser útil para comprobar su generalización (test)

## Ejercicio 10
![[Pasted image 20260610184304.png]]

En cada nodo del árbol se selecciona aleatoriamente un subconjunto de atributos candidatos para hacer la división. Esto reduce la correlación entre árboles, porque evita que todos elijan siempre las mismas variables más dominantes. Esto promedia modelos más diversos y disminuye aún más la varianza, mejorando la generalización.

## Ejercicio 11
![[Pasted image 20260610184729.png]]

Se tratan mediante umbrales que dividen los datos en dos grupos. El algoritmo busca el mejor umbral que maximiza la pureza de los nodos.
La misma variable puede reutilizarse en distintos niveles del árbol porque pueden existir varios umbrales con particiones más finas y adaptadas a la estructura del problema.

## Ejercicio 12
![[Pasted image 20260610184949.png]]

Mide la impureza de un nodo como la probabilidad de error al clasificar un elemento según la distribución de clases del nodo. $G(p)=2p(1-p)$. Si el nodo es puro (p=1 o p=0), el índice vale 0, si está equilibrado (p=0.5), el índice vale 0.5.

## Ejercicio 13
![[Pasted image 20260610185302.png]]

Bagging entrena árboles con subconjuntos aleatorios y promedia sus resultados para reducir la varianza (evita overfitting). Boosting entrena árboles en secuencia, donde cada uno corrige los errores del anterior, para reducir el sesgo (evita underfitting).

## Ejercicio 14


## Ejercicio 15


## Ejercicio 16


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


## Ejercicio 40


## Ejercicio 41
