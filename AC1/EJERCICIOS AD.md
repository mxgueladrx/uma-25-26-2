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
![[Pasted image 20260611103530.png]]

En los métodos de ensemble no se puede ver el camino de la decisión. Podemos calcular la importancia de las variables, barajando aleatoriamente sus valores en el conjunto de validación. Permite interpretar modelos complejos porque evalúa el impacto real de la variable y sus interacciones sobre la predicción final

## Ejercicio 15
![[Pasted image 20260611104444.png]]

En cada nodo del árbol se calcula la entropía para medir la impureza de los datos. Para cada atributo se evalúa cuánto reduce esa impureza al dividir los ejemplos, su IG. Se selecciona el atributo con mayor IG para realizar la partición y el proceso se repite recursivamente en los nodos hijos

## Ejercicio 16
![[Pasted image 20260611104830.png]]

Porque el árbol ha extendido muchas ramas para que cada dato de entrenamiento acierte, por lo que al meter un nuevo dato falle, no generaliza.

## Ejercicio 17
![[Pasted image 20260611105031.png]]

Bagging reduce la varianza al combinar varios modelos entrenados con muestras bootstrap distintas. Es útil en árboles profundos porque tienen alta varianza y son muy sensibles a cambios en los datos, por lo que el promedio de varios árboles mejora la generalización.

## Ejercicio 18
![[Pasted image 20260611105433.png]]

Porque en cada nodo elige la variable de un subconjunto, por lo que el árbol no elige siempre la que menos separa las clases, aumentando la generalización y disminuyendo la correlación entre árboles

## Ejercicio 19
![[Pasted image 20260611105705.png]]

Porque construye árboles de forma secuencial, cada nuevo árbol se centre en los ejemplos que los anteriores clasificaron mal, corrigiendo progresivamente los errores acumulados

## Ejercicio 20
![[Pasted image 20260611110120.png]]

Aumenta el peso de los ejemplos mal clasificados y disminuye el de los correctamente clasificados después de cada iteración. Así prestan más atención a los casos difíciles, corrigiendo progresivamente los errores de los árboles anteriores.

## Ejercicio 21
![[Pasted image 20260611110353.png]]

Ambos miden la impureza de un nodo. La entropía mide la incertidumbre y el Gini la probabilidad de error al clasificar según la distribución de clases. Producir árboles parecidos porque ambas favorecen divisiones que generan nodos más puros.

## Ejercicio 22
![[Pasted image 20260611111103.png]]

En cada nodo se elige la mejor división posible en ese momento, sin considerar cómo afectará a las divisiones futuras. El árbol se construye de forma eficiente, pero no garantiza encontrar el árbol óptimo.

## Ejercicio 23
![[Pasted image 20260611111221.png]]

Porque ya no existe un único árbol para seguir. La decisión final es una agregación de muchos árboles, lo que dificulta explicar la predicción. Parte de la interpretabilidad puede recuperarse como con la importancia de variables.

## Ejercicio 24
![[Pasted image 20260611111849.png]]

Cada ejemplo tiene probabilidad $1-\frac{1}{m}$​ de no ser elegido en una extracción bootstrap, por lo que tras m extracciones la probabilidad es $(1-\frac{1}{m})^m \approx e^{-1} \approx 0.368$. 36,8% de los ejemplos quedan fuera (OOB), lo que permite usarlos como datos de validación.

## Ejercicio 25
![[Pasted image 20260611112601.png]]

ID3 construye un árbol de decisión de forma voraz, empezando por la raíz y dividiendo los datos en cada nodo según el atributo que mejor separa las clases. Para elegirlo utiliza la ganancia de información, seleccionando el atributo que más reduce la entropía en ese nodo. El proceso se repite recursivamente hasta obtener nodos puros o cumplir un criterio de parada.

## Ejercicio 26
![[Pasted image 20260611112718.png]]

Se asigna a la rama la clase mayoritaria del nodo padre, porque no hay datos para aprender esa rama, y así se evita dejar el modelo sin capacidad de predicción para ese valor.

## Ejercicio 27
![[Pasted image 20260611112917.png]]

Porque crea ramas según los valores de cada variable. Las variables numéricas no tienen categorías. La solución es crear umbrales que permiten convertirlas en divisiones binarias.

## Ejercicio 28
![[Pasted image 20260611113120.png]]

Limitar la profundidad del árbol, exigir un número mínimo de muestras por nodo o parar cuando la impureza es baja o los nodos son puros. Evita que el árbol siga dividiendo hasta ajustarse al ruido de los datos, reduciendo así el sobreajuste.

## Ejercicio 29
![[Pasted image 20260611113332.png]]

Porque seguirá creando ramas hasta que cada ejemplo acierte, por lo que estudia el ruido de los datos, aumentando el overfitting

## Ejercicio 30
![[Pasted image 20260611113445.png]]

a) $(1-1/200)^{200}=0.367$, un 36.7%

b) $200*(1-0.367)=126$ ejemplos

c) Cada árbol ve distintos datos, reduciendo la correlación entre ellos, mejorando la generalización.

## Ejercicio 31
![[Pasted image 20260611113918.png]]

a) Clase 1

b) Se equivoca si hay 3 o menos 1.

c) Porque permite que los errores se “compensen” al votar, si los árboles fueran correlacionados, fallarían a la vez y el ensemble no reduciría el error.

## Ejercicio 32
![[Pasted image 20260611122239.png]]

a) $2*0.75*(1-0.75)=0.375$

b) Gini igual que arriba. $40/80 * 0.375 + 40/80 * 0.375=0.375$

c) No mejora la impureza porque el Gini antes y después es el mismo

## Ejercicio 33
![[Pasted image 20260611122907.png]]

a) 1.097

b) 2.197

c) Cuanto menor es el error, mayor es $\alpha$, por lo que el clasificador tiene más peso en la decisión final.

## Ejercicio 34
![[Pasted image 20260611132106.png]]

a) $0.28-0.12=0.16$

b) La variable es importante porque al permutarla el error aumenta bastante, lo que indica que el modelo depende de ella para predecir correctamente.

c) Es mucho menos importante ya que el error el muy bajo, por lo que es redundante

## Ejercicio 35
![[Pasted image 20260611132402.png]]

a) Acierta Bin(9, 0.65) si se aciertan al menos 5

b) Acierta Bin(9, 0.65) si fallan al menos 5

c) Sus errores dejan de compensarse, por lo que la mejora del voting se reduce y se comporta más como un solo árbol.

## Ejercicio 36
![[Pasted image 20260611133339.png]]

a) $1-1/50=0.98$

b) $(1-1/50)^{50}=0.364$

c) 0.368

d) $50*(0.364)=18$

e) Como no han salido en las muestras, se pueden usar para validar los árboles

## Ejercicio 37
![[Pasted image 20260611133907.png]]

a) $2*0.5(1-0.5)=0.5$

b) $2*0.8(1-0.8)=0.32$, $50/100*0.32+50/100*0.32=0.32$

c) $2*0.6(1-0.6)=0.48$, $50/100*0.48+50/100*0.48=0.48$

d) La A porque es el que tiene menor índice de Gini, es más puro

## Ejercicio 38
![[Pasted image 20260611135140.png]]

a) X ~ Bin(11, 0.6) donde X es el número de árboles que acierta

b) 6 árboles

c) X ~ Bin(11, 0.6) donde X tiene que ser al menos 6

d) Porque permite que los errores de los árboles se compensen, si están correlacionados fallan y la mejora del ensemble se reduce mucho.

## Ejercicio 39
![[Pasted image 20260611135433.png]]

a) $\epsilon = 1/5*2=0.4$

b) $\alpha = 0.41$

c) Los que fallan aumentarán su importancia

d) El siguiente árbol se centrará más en los ejemplos con mayor peso (mal clasificados), reduciendo el sesgo

## Ejercicio 40
![[Pasted image 20260611141116.png]]

a) Asistencia: 0.13, Nota: 0.01, Apoyo: 0.24

b) Apoyo, Asistencia y Nota

c) La nota ya que al permutar las variables el error apenas cambia, por lo que no es una variable importante para el modelo

d) Si hay variables correlacionadas, al permutar una otra puede compensar su efecto y subestimar su importancia

## Ejercicio 41
![[Pasted image 20260611141454.png]]

a) A: bagging, B: random forest, C: boosting

b) A: reducir varianza, B: reducir varianza (más que bagging), C: reducir sesgo

c) El B porque reduce más la correlación por selección aleatoria de variables 

d) C porque reduce el error de los árboles anteriores