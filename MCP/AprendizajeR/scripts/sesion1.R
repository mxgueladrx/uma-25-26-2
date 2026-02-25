# La asignación a una variable se hace con <- 
variableNueva <- 10

# Para mostrar el valor de una variable escribimos su nombre
variableNueva
print(variableNueva)

# Podemos borrar variables individuales usando rm()
rm(variableNueva) # En ningún script debe haber ningún rm()
# O borrar todas las variables usando rm(list = ls())

## Tipos de datos atómicos:

# Numéricos
x <- pi
a <- 1L # long integer
b <- 1
class(x) # numeric
class(a) # integer
class(b) # numeric

# Carácter
cadena <- "hola 'mundo'"
class(cadena) # character

# Lógicos
FALSE
TRUE
true <- T # Mala práctica
false <- F # Mala práctica
class(true) # logical
class(false) # logical

# NA representa un valor faltante o desconocido (not available)
perdido <- NA
class(perdido) # logical
class(NA_character_) # character

## Vectores
# Se crean con la función c()
vectorNumerico <- c(1, 2, 3)
vectorCaracter <- c("a", "b", "c")
vectorFinal <- c(vectorNumerico, vectorCaracter) # "1" "2" "3" "a" "b" "c"
class(vectorFinal) # character

# is.vector me dice si es un vector, aunque solo tenga un elemento
is.vector(vectorNumerico)
is.vector(cadena)

# length me dice la longitud del vector, número de elementos que tiene
length(vectorFinal)
length(cadena)

# R es 1-based (el índice empieza en 1 no en 0)
vectorFinal[2] # segundo elemento
vectorFinal[c(1, 3, 6)] # elementos del índice 1, 3 y 6
vectorFinal[7] # elemento del índice 7 no existe, devuelve NA

# Otra forma de construir vectores numéricos es con la sintaxis inicio:fin
6:19
6:3

# Más generalmente con la función seq(). inicio, fin, paso
seq(1, 10, by=0.5) # numeric
seq.int(1, 10, 2) # integer

# Otra forma de seleccionar elementos de un vector es usando índices lógicos
vectorFinal[c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)] 
# equivalente a
vectorFinal[c(1, 3, 5)]

# La función which encuentra los TRUE dentro de un vector lógico
cualesVerdadero <- which(c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE))
vectorFinal[cualesVerdadero]

# Reciclaje
# Se repite TRUE, FALSE hasta el final del vector
vectorFinal[c(TRUE, FALSE)] # posiciones impares
vectorFinal[c(FALSE, TRUE)] # posiciones pares

# Se puede usar condiciones lógicas: <, >, <=, >=, ==, !=, &, |
vectorGrande <- runif(100, min=0, max=10) # 100 números aleatorios entre 0 y 10
# Seleccionamos los < 5
vectorGrande < 5
vectorGrande[vectorGrande < 5]
vectorGrande[vectorGrande >= 7]
vectorGrande[vectorGrande > 3 & vectorGrande < 5]
vectorGrande[vectorGrande <= 2 | vectorGrande >= 8]

## Listas. Permiten tener elementos de distinto tipo
lista <- list(1, "a", NA, TRUE, pi, "hola")

# Para seleccionar elementos de una lista, usamos dobles corchetes [[]]
# El índice es siempre numérico
lista[[2]]
lista[[4]]
lista[[5]]

# Para seleccionar varios elementos de la lista, uso el corchete simple [], 
# devuelve una nueva lista. Podemos usar todo como en los vectores
nuevaLista <- lista[c(1, 3, 5)]

# En las listas podemos poner nombres a los elementos
lista2 <- list(primero=TRUE, 
               segundo=5, 
               tercero=pi - 1, 
               cuarto="NA")

# Podemos seguir accediendo a elementos igual que antes. El hacer subconjuntos
# mantiene el nombre de las componentes
lista2[[1]]
lista2[[3]]
lista2[c(1, 3, 4)]
lista2$primero
lista2$tercero
lista3 <- list("nombre con espacios"=1) # Mala práctica
lista3$`nombre con espacios`
lista2[c("primero", "segundo")]
lista2[["tercero"]] # lista2$tercero

## Operaciones con vectores
# Operaciones componente a componente
1:10 + 7
1:10 / 2
1:10 / 0
1:5 + 2:6 # Tienen que tener la misma dimensión
1:10 / 1:2 # Recicla el vector mas pequeño hasta tener el tamaño del mayor. 
           # Solo si las dimensiones son divisibles
1:10 / 1:3 # No tienen dimensiones divisibles, da un warning
