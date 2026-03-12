## Ejercicio 1
![[Pasted image 20260304184704.png]]

| Etapa          | Problema detectado                                                                                 | Acción recomendada                                                                                                                                |
| -------------- | -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| Limpieza       | - Valor nulo en 303-Edad<br>- Valor atípico en 307-Peso y 305-Edad<br>- Fila 301 se repite 2 veces | - Cambiar el valor nulo por otro (media por ejemplo)<br>- Cambiar el valor atípico por otro (media por ejemplo)<br>- Eliminar las filas repetidas |
| Integración    | - Conflicto de nombres en: BCN, Barcelona y Bcn son la misma ciudad; Mujer y Femenino son lo mismo | - Cambiar esos valores por uno genérico (Barcelona y Femenino)                                                                                    |
| Transformación | - Columnas Ciudad y Género discretas<br>- Nueva columna IMC a partir de edad, altura y peso        | - One hot encoding a Género y Label encoding a Ciudad<br>- Crear columna IMC                                                                      |
| Reducción      | - Columna Nombre no aporta información, tenemos ya el ID                                           | - Borrar columna                                                                                                                                  |
| Discretización | - Discretizar IMC                                                                                  | - Discretizar IMC                                                                                                                                 |

## Ejercicio 2
![[Pasted image 20260304202743.png]]

| Etapa          | Problema detectado                                                                                                                                 | Acción recomendada                                                                                              |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| Limpieza       | - Valor nulo en 402-Altura<br>- Valor atípico en 406-Edad y 405-Altura                                                                             | - Cambiar el valor nulo por otro (media por ejemplo)<br>- Cambiar el valor atípico por otro (media por ejemplo) |
| Integración    | - Conflicto de nombres en: BCN y Barcelona son la misma ciudad; Mujer y Femenino son lo mismo; Hombre y Masculino también; Madrid y madrid también | - Cambiar esos valores por uno genérico (Barcelona, Femenino, Masculino y Madrid)                               |
| Transformación | - Columnas Ciudad y Género discretas<br>- Nueva columna IMC a partir de edad, altura y peso                                                        | - One hot encoding a Género y Label encoding a Ciudad<br>- Crear columna IMC                                    |
| Reducción      | - Columna Nombre no aporta información, tenemos ya el ID                                                                                           | - Borrar columna                                                                                                |
| Discretización | - Discretizar IMC                                                                                                                                  | - Discretizar IMC                                                                                               |

## Ejercicio 3
![[Pasted image 20260304190213.png]]![[Pasted image 20260304190224.png]]
a) 
$media_{sueño}=\frac{7+6+8+5}{4}=6.5$
$media_{café/día}=\frac{1+2+3+2}{4}=2$
$media_{estrés}=\frac{4+6+7+3}{4}=5$

b) Como la varianza mide la dispersión respecto de la media, al añadir valores que son justo la media, reduce la varianza, dando lugar a errores.

c) Por ejemplo, horas de sueño y estrés están inversamente relacionados, a menos horas de sueño, más estrés. Al aplicar por ejemplo al ID 5 el estrés 5 con 5 horas de sueño sería lo más probable un error.

## Ejercicio 4
![[Pasted image 20260304191654.png]]
a) 2

b)
$media_{horasEstudio}=\frac{10+6+12+8}{4}=9$
$media_{asistencia}=\frac{90+80+70+85}{4}=81.25$
$media_{nota}=\frac{8.5+6+5.5+9}{4}=7.25$

c) Si tenemos un dataset pequeño como el del ejercicio, eliminar filas con valores nulos nos podrá dejar con muchos menos datos de los que ya tenemos, teniendo un modelo mucho más débil. En este caso si eliminamos los registros nulos, eliminamos el 60% de nuestro dataset, nada conveniente. Lo razonable sería no eliminar más del 5% de los datos.

## Ejercicio 5
![[Pasted image 20260304192451.png]]
a) $consumo_{4}=3.275+0.0275*150=7.4$

b) Si fuera cuadrática, logarítmica o cualquiera que no sea lineal, estaríamos introduciendo un sesgo al modelo y que aprenda un patrón que realmente no es.

## Ejercicio 6
![[Pasted image 20260304193431.png]]![[Pasted image 20260304193439.png]]
a) Introduce un orden numérico a las categorías se podría interpretar que 1 es el "doble" que 0, que puede confundir al modelo.

b)
$media_{alquiler}=\frac{950+900+850+1100}{4}=950$
$alquiler_{3}=130+16*65-70*3+160*1=1120$

c) En este caso por regresión ya que el alquiler depende fuertemente de su tamaño, si esta reformado o no y la distancia al centro, variables muy relacionadas con él.

## Ejercicio 7
![[Pasted image 20260304195707.png]]
$rango_{edad}=40-25=15$
$rango_{ingresos}=2600-1500=1100$

$D(3,1) = \frac{10/15+500/1100}{2} =0.56$
$D(3,2) = \frac{5/15+200/1100}{2} =0.257$
$D(3,4) = \frac{5/15+600/1100}{2} =0.439$
$D(3,5) = \frac{7/15+400/1100}{2}=0.415$

Como k=2, cogemos los dos menores, el 2 y 5: $\frac{450+420}{2}=435$ €

## Ejercicio 8
![[Pasted image 20260304201607.png]]
a)
$rango_{edad}=50-25=25$
$rango_{imc}=30-22=8$

$D(4,1) = \frac{5/25+2/8+0}{3} =0.15$
$D(4,2) = \frac{20/25+6/8+1}{3} =0.85$
$D(4,3) = \frac{10/25+4/8+0}{3} =0.3$
$D(4,5) = \frac{5/25+1/8+1}{3}=0.44$

b) Los vecinos más cercanos son 1, 3 y 5.

c) Como k=3, cogemos los tres menores, el 1, 3 y 5: en este caso son dos Bajo y uno Alto, por lo que por mayoría queda bajo.

d) Porque nos permite combinar en una métrica valores discretos y continuos sin tener que hacer una conversión previa.

## Ejercicio 9
![[Pasted image 20260304203200.png]]
a) $\Upsigma = \begin{pmatrix}144 & -36\\-36 & 9\end{pmatrix}$ 

b) $edad_{3}=32+\frac{-36}{9}*(3-6)=44$ 

c)
$\mu_{edad}=\frac{20+44+44}{3}=36$
$\mu_{horas}=\frac{9+3+3}{3}=5$
$Var(edad)=\frac{(20-36)^2+(44-36)^2+(44-36)^2}{3}=128$
$Var(horas)=\frac{(9-5)^2+(3-5)^2+(3-5)^2}{3}=8$ 
$Cov(edad, horas)=\frac{(20-36)(9-5)+(44-36)(3-5)+(44-36)(3-5)}{3}=-32$
$\Upsigma = \begin{pmatrix}128 & -32\\-32 & 8\end{pmatrix}$

d) Cuando el algoritmo alcanza la convergencia, el resultado no varía un umbral $\epsilon$.

## Ejercicio 10
![[Pasted image 20260312164937.png]]
a) Sea $x'=\frac{x-min}{max-min}=\frac{x-12}{33}$, los valores son: $[0,0.03,0.06,0.09,0.12,0.18,0.21,1]$. Podemos ver que los valores se agrupan entre 0 y 0.2 y un valor atípico que sería el 45, que se encuentra en el extremo.

b) Sea $x'=\frac{x-\mu}{\sigma}=\frac{x-19}{10}$, los valores son: $[-0.7,-0.6,-0.5,-0.4,-0.3,-0.1,0,2.6]$. Aunque ningún valor supere el umbral de 3, el valor 45 da un z-score de 2.6, por lo que podríamos estudiar ese valor.

c) $Q1=13.5, Q3=18.5, IQR = Q3-Q1=5$. Rango: $[13.5-1.5*5, 18.5+1.5*5]=[6,26]$. Como antes, el valor 45 está fuera del rango.

d) El primero mide la distancia entre los extremos, por lo que podemos ver donde se agrupan los valores e identificar las anomalías. El segundo mide cuantas desviaciones típicas se aleja un valor de la media, detectando una anomalía a partir de un umbral. El último mide donde se concentra el 50% central de los datos, por lo que si vemos valores fueras del rango y además alejados, podrían ser anomalías.

## Ejercicio 11
![[Pasted image 20260312172252.png]]
a) 
Sea $x'=\frac{x-\mu}{\sigma}=\frac{x-8.1}{7.9}$, los valores son: $[-0.77,-0.64,-0.64,-0.52,-0.52,-0.39,-0.14,1.5,2.13]$
$Q1=3, Q3=13.5, IQR=13.5-3=10.5$. Rango: $[3-1.5*10.5, 13.5+1.5*10.5]=[-12.75,29.25]$

b) El IQR ya que el z-score puede variar y hacer que los valores atípicos no lo parezcan tanto, ya que si un conjunto de datos está mal distribuido, mueve la media a donde está el valor atípico.

c) Que eliminaríamos información muy útil ya que podrían ser datos más escasos y tienen la misma o incluso más importancia que los demás.

## Ejercicio 12
![[Pasted image 20260312174004.png]]
a) Un posible error sería que, teniendo en cuenta los demás datos, en vez de ser 55 era 15 y en caso de que sea un evento real, pues la vivienda en ese día sucedió algún evento que hiciera que el consumo creciera de esa forma.

b) En caso de que sea un error, imputaríamos el dato ya que si lo eliminamos no tenemos dato para el quinto día. En caso de que sea un evento real tratarlo como un dato especial.

c) Comprobar que no se elimine más del 5% de los datos y que su eliminación no provoque sesgos.

## Ejercicio 13
![[Pasted image 20260312175129.png]]
a) Una anomalía colectiva ya que si fuese un outlier puntual, no ocurriría siempre. En este caso sucede siempre en el mismo instante.

b) Teniendo en cuenta que no es algo puntual, este tipo de patrones podrían dar información bastante útil al modelo ya que podría ser actividad anómala en esa plataforma y estudiarla puede ser dar a conocer a qué se debe eso.

## Ejercicio 14
![[Pasted image 20260312175749.png]]
a) En el nombre la tilde y el DNI el "-".

b) "Sol" y "10".

c) Con solo fijarnos en el DNI, que es la identidad de la persona, con ello bastaría confirmar que son la misma persona.

## Ejercicio 15
![[Pasted image 20260312180114.png]]
a) La "b" y "v" fonéticamente se parecen y "s" y "z" también. Además si vemos la estructura de los nombres son casi idénticos, diferenciando las letras anteriores.

b) El nombre y la dirección de la persona.

c) En este caso habría que hacer una revisión manual ya que aunque el nombre y dirección son similares, el email es distinto y puede causar confusión.

## Ejercicio 16
![[Pasted image 20260312180714.png]]
a)
$nombre=\log_{2}(\frac{0.9}{0.05})=4.16$
$dni = \log_{2}(\frac{0.99}{0.000001})=19.91$

b)
$dirección=\log_{2}(\frac{1-0.95}{1-0.01})=-4.32$

c) $suma = 4.16+19.91-4.32=19.75$. Como es mayor que el umbral superior, el registro corresponde a la misma persona.

## Ejercicio 17
![[Pasted image 20260312181757.png]]
a) 
$nombre=\log_{2}(\frac{0.8}{0.2})=2$
$dirección=\log_{2}(\frac{0.85}{0.1})=3.09$
$teléfono=\log_{2}(\frac{1-0.9}{1-0.05})=-3.25$
$suma=2+3.09-3.25=1.84$

b) Como el total es menor que el umbral inferior, no corresponden a la misma persona.

## Ejercicio 18
![[Pasted image 20260312182300.png]]
a) como el p-valor es menor que $\alpha$, hay dependencia entre las variables.

b) Aunque las variables sean dependientes, cada una aporta una información determinada que la otra no puede. Además, el modelo será más simple pero más complejo de explicar con menos variables.

c) Dependiendo del objetivo del equipo de marketing, elegir una variable u otra puede ser mejor. Otra forma es evaluar cada modelo independientemente con cada una de las dos variables y ver cual da mejor resultados.

## Ejercicio 19
![[Pasted image 20260312183218.png]]
a) 
Caso A: Pearson porque se usa cuando hay una relación lineal.
Caso B: Spearman porque no es lineal.
Caso C: usar ambas ya que no podemos decidir su linealidad.

b) Si tenemos claro que es lineal, usar Pearson, en cualquier otro caso Spearman.

## Ejercicio 20
![[Pasted image 20260312183743.png]]![[Pasted image 20260312183754.png]]
a) Imputar por la media puede ser peor si existen valores atípicos y además no se toma en cuenta las demás variables, reduce la varianza. EM toma en cuenta las covarianzas y las medias de todas las variables.

b) Cuando ese outlier es realmente un dato normal del dataset, solo es un dato más relevante que puede aportar la misma o incluso más información que los demás datos. Eliminarlo haría que el modelo falle en esos casos especiales.

c) Porque restringe los datos a un rango determinado y no tenemos ningún criterio para decidir si es un valor anómalo o no, solo vemos donde se concentran los valores.

d) Casi seguro: datos que superan el umbral superior y se afirma que son el mismo registro. Zona gris: datos que se encuentran entre el umbral superior e inferior y no se puede decidir si es o no el mismo registro, hay que verlo manualmente.

## Ejercicio 21
![[Pasted image 20260312184937.png]]
a) 
1. Eliminar la variable edad ya que se puede deducir de la fecha de nacimiento.
2. Usar métricas para decidir si los duplicados con variaciones en nombre y dirección son el mismo registro o no.
3. Usar métricas para comprobar eso valores altos de gasto mensual y confirmar si son datos anómalos o casos especiales.
4. Si la variable teléfono no es útil y existe algún otro campo como email, se puede eliminar. En otro caso mantenerlo y rellenar el campo vacío con algún dato que determine si tiene o no número de teléfono.

b) Seria peligroso modificar los datos altos de gasto mensual ya que tiene pinta de ser algo normal tener un mes que se gaste más dinero que otro (por ejemplo comprarse un coche).

c) Valores perdidos: eliminar variables, imputar (media, moda, mediana, EM...), Outliers: verificar si son datos anómalos o no (max-min, z-score, IQR), Duplicados: comprobar la fonética, uso de tokens, Fellegi-Sunter..., Redundancia de variables: X^2, Pearson, Spearman.

## Ejercicio 22
![[Pasted image 20260312190355.png]]
a) $[0.69,1.39,1.61,1.95,2.08,2.3,2.48,4.38]$

b) Hace que los valores que sean muy grandes pasen a un rango con valores más prácticos de manejar. Comprime la escala de los datos. 

c) Evita que el modelo tenga que hacer operaciones con valores muy grandes y hacer que sea más eficiente. Además al reducir la simetría de los nuevos datos, se acerca mejor a una distribución normal.