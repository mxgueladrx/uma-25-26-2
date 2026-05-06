**Aprendizaje supervisado**: sea $\tau$ datos de entrenamiento y cada $x_{i}$ consta de $p$ componentes (numéricas o categóricas). Cada $p$ tiene una variable objetivo $y_{i}$. La salida $Y$ es numérica (regresión) o categórica (clasificación binaria o multiclase).

## Métodos basados en instancias: KNN
**KNN**: se usa para clasificación y regresión. Si el dato de prueba $x^{*}$ esta cerca del punto de entrenamiento $x_{i}$, entonces $\hat{y}$ en clasificación será la clase que más se repite entre esos $y_{i}$ vecinos (votación mayoritaria), y en regresión será el promedio de los valores $y_{i}$ de esos vecinos.

**Métricas**: las variables deben estar en la misma escala (normalizar o escalar).
- **Euclídea (L2)**: atributos numéricos. Funciona bien. $d(x_{i}, x_{j})=\sqrt{\sum^{p}_{k=1} (x_{ik}-x_{jk})^2}$
- **Manhattan (L1)**: atributos numéricos. Más robusta en presencia de ruido/outliers. $d(x_{i}, x_{j})=\sum^{p}_{k=1} |x_{ik}-x_{jk}|$ 
- **Gower**: atributos numéricos o categóricos. Es Manhattan normalizada y promediada. $d(x_{i}, x_{j})=\frac{1}{p}\sum^{p}_{k=1}d^{k}_{i,j}$. Si el atributo es numérico, $d^{k}_{i,j}=\frac{|x_{ik}-x_{jk}|}{R_{k}}$ donde $R_{k}$ es el rango de $k$. Si el atributo es categórico, $d^{k}_{i,j}=0$ si los valores coinciden, 1 si no.

**Elección de K**: controla el suavizado del modelo.
- **K pequeño**: modelo se ajusta mucho a los datos, puede ser sensible al ruido (overfitting).
- **K grande**: modelo más suave, pero puede perder detalles importantes (underfitting).
- Valor óptimo de K depende del problema, se prueban con validación.

No construye un modelo explícito, usa los datos de entrenamiento para predecir (lazy learning). Se puede usar ponderaciones por distancia. Se asigna un peso a cada vecino $x_{i}$ en función de su distancia a $x^*$: $w_{i}=\frac{1}{d(x^*,x_{i})+\epsilon}$. En clasificación se hace una votación ponderada, en regresión un promedio ponderado. Es útil con K grandes o presencia de ruido/outliers.

### Ejercicio
![[Pasted image 20260421095414.png]]

$d(x^*,1)=\sqrt{(65-50)^2+(2-1)^2}=15$
$d(x^*,2)=\sqrt{(65-60)^2+(2-2)^2}=5$
$d(x^*,3)=\sqrt{(65-70)^2+(2-2)^2}=5$
$d(x^*,4)=\sqrt{(65-90)^2+(2-3)^2}=25$
$d(x^*,5)=\sqrt{(65-100)^2+(2-3)^2}=35$

$w_{1}=\frac{1}{15}$
$w_{1}=\frac{1}{5}$
$w_{1}=\frac{1}{5}$
$w_{1}=\frac{1}{25}$
$w_{1}=\frac{1}{35}$

Usando KNN con K = 3 es $\frac{180+210+150}{3}=180$€
Usando KNN ponderado con K = 3 es $\frac{180/5 + 210/5 + 150/15}{1/15 + 1/5 + 1/5}=188.7$€

![[Pasted image 20260421095111.png]]

**Annoy**: reduce el tiempo de búsqueda y obtiene resultados precisos. Busca vecinos aproximadamente cercanos construyendo estructuras de tipo árbol que dividen el espacio en regiones.

![[Pasted image 20260423091402.png]]

![[Pasted image 20260423091439.png]]

![[Pasted image 20260423091713.png]]

Un problema es que los vecinos pueden quedar fuera de la región seleccionada.

![[Pasted image 20260423091656.png]]

La k debe ser menor que el número máximo de puntos que fijo en cada región.

![[Pasted image 20260423095641.png]]

## Árboles de decisión y ensembles

### Ejercicio 
![[Pasted image 20260428090409.png]]

**Árbol 3**: cat (4/7), not cat (2/3). Acierta 6/10

**Entropía cruzada**: sea $p$ el porcentaje de ejemplos que son gatos, hay que minimizar$H(p)=-p\log_{2}(p)-(1-p)\log_{2}(1-p)$, y maximizar la ganancia de información

## Máquinas de Vectores de Soporte (SVM)

**Ecuación de la recta**: $\frac{x-x_{1}}{x_{2}-x_{1}}=\frac{y-y_{1}}{y_{2}-y_{1}}$
Pasos:
1. Vectores Soporte
2. Segmento y punto medio
3. Perpendicular
4. Rectas paralelas
5. Conseguir +1 y -1

### Ejercicio
![[Pasted image 20260430091022.png]]
![[Pasted image 20260430091235.png]]
![[Pasted image 20260430091247.png]]![[Pasted image 20260430091301.png]]
![[Pasted image 20260430091332.png]]

### Ejercicio
![[Pasted image 20260430091616.png]]

1. Candidatos N3 y P2
2. $\frac{x-5}{8-5}=\frac{y-3}{6-3}; 3x-15=3y-9; y=x-2$
3. Punto medio: $(\frac{5+8}{2}, \frac{3+6}{2})=(6.5, 4.5)$
4. ...

## Medidas de rendimiento y validación de modelos
