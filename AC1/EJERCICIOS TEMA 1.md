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
a)