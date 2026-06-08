## Ejercicio 1
![[Pasted image 20260608115149.png]]
$d(x^*, A)=\sqrt{(2.5-1)^2 + (2-2)^2}=1.8$
$d(x^*, B)=\sqrt{(2.5-2)^2 + (2-1)^2}=1.12$
$d(x^*, C)=\sqrt{(2.5-2)^2 + (2-3)^2}=1.12$
$d(x^*, D)=\sqrt{(2.5-3)^2 + (2-2)^2}=0.5$
$d(x^*, E)=\sqrt{(2.5-3)^2 + (2-3)^2}=1.12$

a) K = 1: más cercano es D. Clase 1
b) K = 3: más cercanos son D, B, C o D, B, E. En ambos casos es clase 1
c) K = 5: más cercanos son A, B, C, D, E. Clase 1

## Ejercicio 2
![[Pasted image 20260608115949.png]]

a)
$d(x^*, A)=\sqrt{(65000-30000)^2 + (44-45)^2 + (18-18)^2}=35000$
$d(x^*, B)=\sqrt{(65000-70000)^2 + (44-25)^2 + (18-12)^2}=5000$
$d(x^*, C)=\sqrt{(65000-90000)^2 + (44-50)^2 + (18-16)^2}=25000$

K = 1: más cercano es B. Clase 1

b) Hay que aplicar $\frac{x - min}{max - min}$ a cada variable.
$A=(0, 0.8, 1)$
$B=(0.67, 0, 0)$
$C=(1, 1, 0.67)$
$x^*=(0.58, 0.76, 1)$

$d(x^*, A)=\sqrt{(0.58-0)^2 + (0.76-0.8)^2 + (1-1)^2}=0.58$
$d(x^*, B)=\sqrt{(0.58-0.67)^2 + (0.76-0)^2 + (1-0)^2}=1.26$
$d(x^*, C)=\sqrt{(0.58-1)^2 + (0.76-1)^2 + (1-0.67)^2}=0.59$

K = 1: más cercano es A. Clase 0

c) Como el salario tiene un rango mucho más grande, domina la distancia, sin tener en cuenta las demás variables. Al normalizar, todas las variables tienen el mismo peso, siendo más justo.

## Ejercicio 3
![[Pasted image 20260608121257.png]]

$d(x^*, A)=\sqrt{(2.5-1)^2 + (2-2)^2}=1.5$
$d(x^*, B)=\sqrt{(2.5-2)^2 + (2-3)^2}=1.12$
$d(x^*, C)=\sqrt{(2.5-3)^2 + (2-1)^2}=1.12$
$d(x^*, D)=\sqrt{(2.5-4)^2 + (2-3)^2}=1.8$
$d(x^*, E)=\sqrt{(2.5-2)^2 + (2-1)^2}=1.12$
$d(x^*, F)=\sqrt{(2.5-3)^2 + (2-3)^2}=1.12$
$d(x^*, G)=\sqrt{(2.5-1)^2 + (2-3)^2}=1.8$
$d(x^*, H)=\sqrt{(2.5-4)^2 + (2-1)^2}=1.8$

K = 5: más cercanos son A, B, C, E, F. Clase Rojo

Suaviza las fronteras de decisión reduciendo el impacto del ruido. Si K es grande, provoca underfitting y el modelo se sesga votando siempre por la clase mayoritaria, siendo un modelo muy genérico

## Ejercicio 4
![[Pasted image 20260608121943.png]]
![[Pasted image 20260608121953.png]]

a)
$d(x^*, S1)=\sqrt{(3.4-1.5)^2 + (6.3-5)^2}=2.3$
$d(x^*, S2)=\sqrt{(3.4-2)^2 + (6.3-6.5)^2}=1.41$
$d(x^*, S3)=\sqrt{(3.4-2.5)^2 + (6.3-7)^2}=1.14$
$d(x^*, S4)=\sqrt{(3.4-3)^2 + (6.3-6)^2}=0.5$
$d(x^*, S5)=\sqrt{(3.4-3.5)^2 + (6.3-5.5)^2}=0.81$
$d(x^*, S6)=\sqrt{(3.4-4)^2 + (6.3-8)^2}=1.8$
$d(x^*, S7)=\sqrt{(3.4-4.5)^2 + (6.3-7.5)^2}=1.63$
$d(x^*, S8)=\sqrt{(3.4-5)^2 + (6.3-6)^2}=1.63$

K = 3: más cercanos son S4, S5, S3. Clase Aprobado

b) $rango_{estudio} = 5-1.5=3.5$, $rango_{sueño}=8-5=3$
$d(x^*, S1)=\frac{(|3.4-1.5|/3.5) + (|6.3-5|/3) + 0}{3}=0.36$
$d(x^*, S2)=\frac{(|3.4-2|/3.5) + (|6.3-6.5|/3) + 0}{3}=0.16$
$d(x^*, S3)=\frac{(|3.4-2.5|/3.5) + (|6.3-7|/3) + 1}{3}=0.5$
$d(x^*, S4)=\frac{(|3.4-3|/3.5) + (|6.3-6|/3) + 1}{3}=0.41$
$d(x^*, S5)=\frac{(|3.4-3.5|/3.5) + (|6.3-5.5|/3) + 0}{3}=0.1$
$d(x^*, S6)=\frac{(|3.4-4|/3.5) + (|6.3-8|/3) + 1}{3}=0.58$
$d(x^*, S7)=\frac{(|3.4-4.5|/3.5) + (|6.3-7.5|/3) + 1}{3}=0.57$
$d(x^*, S8)=\frac{(|3.4-5|/3.5) + (|6.3-6|/3) + 0}{3}=0.19$

K = 3: más cercanos son S2, S5, S8. Clase Suspenso

c) Usar un atributo extra cambia por completo el resultado

## Ejercicio 5
![[Pasted image 20260608124036.png]]

d)
Árbol A
![[Pasted image 20260608130553.png]]

(11, 8):
	(10, 1): 
		1, 2, 3, 12
		9, 10, 11
	(6, 16):
		4, 5, 8, 15, 16
		6, 7, 13, 14

Árbol B
![[Pasted image 20260608130605.png]]

(9, 1):
	(10, 16):
		6, 7, 9, 10, 14
		5, 8, 13, 16
	(12, 15):
		1, 3, 12
		2, 4, 15

Árbol C
![[Pasted image 20260608130619.png]]

(12, 8):
	(11, 2):
		3, 10, 11, 12
		1, 2
	(9, 8):
		6, 7, 9, 14
		4, 5, 8, 13, 15, 16

e)
Árbol A: 6, 7, 13, 14
Árbol B: 5, 8, 13, 16
Árbol C: 4, 5, 8, 13, 15, 16

f)
Árbol A: spam
Árbol B: spam
Árbol C: spam

g) $puntos = \{4, 5, 6, 7, 8, 13, 14, 15, 16\}$
Paso de hacer todas las distancias, viendo el grafico los K = 3 más cercanos son 5, 6, 8, 13. Clase spam

h)
Los tres árboles por separado y el modelo combinado coinciden en clasificar el correo como spam

## Ejercicio 6
![[Pasted image 20260423095832.png]]![[Pasted image 20260423095902.png]]

![[Pasted image 20260608191608.png]]

(13, 10):
	(3, 4):
		1, 2, 3, 15
		4, 5, 6, 13, 14, 16
	 (9, 10)
		 7, 9
		 8, 10, 11, 12

K = 5: más cercanos son 5, 6, 7, 8 y 9. La media es $\frac{205+225+245+230+270}{5}=235$€