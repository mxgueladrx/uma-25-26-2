### 1. Conceptos Básicos

- **Objetivo de la Lógica:** Detectar esquemas válidos de razonamiento mediante la idea de demostración en un sistema formal.
	
- **Enunciados declarativos:** Expresiones afirmativas sobre las que se puede asegurar de forma unívoca si son verdaderas o falsas.
    
- **Enunciados libres de contexto:** Enunciados cuyo valor de verdad se puede determinar sin necesidad de recurrir a información adicional.
    
- **Funcionalidad de los valores de verdad:** Propiedad que establece que el valor de verdad de una fórmula compuesta depende única y exclusivamente de los valores de verdad de sus componentes primitivos.
    
- **Corrección:** Propiedad de un sistema deductivo que asegura que todo teorema obtenido de forma sintáctica es también una fórmula lógicamente válida en la semántica.
    
- **Completitud:** Propiedad que garantiza que toda fórmula semánticamente válida puede ser demostrada como un teorema dentro del sistema.
    
- **Decidibilidad:** Una lógica es decidible si cuenta con un procedimiento capaz de determinar de manera matemática y en un número finito de pasos si una fórmula es válida o no.

### 2. Lógica Clásica Proposicional (LP)

#### A) Sintaxis y Estructura

- **Alfabeto:** Conjunto numerable de símbolos proposicionales o átomos ($\Pi = \{p, q, r, \dots\}$) , un conjunto de conectivas u operadores lógicos ($\neg, \land, \lor, \rightarrow, \leftrightarrow$) y delimitadores convencionales.
    
- **Fórmulas Bien Formadas (fbfs):** El lenguaje proposicional se define como la clausura inductiva del conjunto $\Pi$ bajo las conectivas. Esto significa que todo átomo es una fbf , la negación de una fbf es una fbf , y la unión de dos fbfs mediante un conectivo binario genera una nueva fbf. Es una construcción libremente generada porque cada fórmula tiene un único árbol sintáctico.

#### B) Semántica y Propiedades de las Fórmulas

- **Interpretación:** Es una aplicación $I$ que asigna un valor de verdad (0 o 1) a cada fórmula del lenguaje, extendiéndose de forma única a partir de los valores otorgados a los átomos mediante las condiciones de verdad de cada conectiva.
    
- **Modelo:** Una interpretación $I$ es un modelo de una fórmula $A$ si al evaluar la fórmula bajo esa asignación se obtiene el valor destacado 1 ($I(A)=1$).
    
- **Clasificación semántica de fórmulas:**
    
    - **Válida (Tautología):** Una fbf es válida si es verdadera ($1$) en todas las interpretaciones posibles.
        
    - **Satisfacible:** Una fbf es satisfacible si cuenta con, al menos, una interpretación que sea modelo para ella.
        
    - **Contingente:** Fbf que es satisfacible (tiene algún modelo) pero que no llega a ser una tautología (tiene también alguna interpretación falsa).
        
    - **Insatisfacible (Contradicción):** Fbf que arroja el valor falso ($0$) bajo todas y cada una de las interpretaciones posibles.
        
- **Consistencia de conjuntos:** Un conjunto de fórmulas $\Omega$ es satisfacible o consistente si comparte de forma común al menos una interpretación que actúe como modelo simultáneo para todas las fbfs del conjunto.
    
- **Teorema de Compacidad:** Un conjunto infinito de fórmulas es satisfacible si y solo si todos y cada uno de sus subconjuntos finitos lo son.

#### C) Consecuencia, Equivalencia y Formas Normales

- **Consecuencia Lógica ($\Omega \models A$):** Una fórmula $A$ se infiere o es consecuencia lógica de un conjunto $\Omega$ si cualquier interpretación que sea modelo de $\Omega$ se convierte obligatoriamente en modelo de $A$.
	
- **Propiedad de monotonía**: Si un subconjunto de hipótesis deduce una conclusión, el conjunto global también la deduce (si $\Omega_0 \models A$ y $\Omega_0 \subseteq \Omega$, entonces obligatoriamente $\Omega \models A$).
    
- **Principio de Refutación:** Teorema metallógico que dicta que un razonamiento con premisas $A_1, \dots, A_n$ y conclusión $A$ es válido si y solo si el conjunto formado por las premisas y la conclusión negada ($\{A_1, \dots, A_n, \neg A\}$) es insatisfacible.
    
- **Equivalencia Lógica ($A \equiv B$):** Dos fbfs son equivalentes si coinciden en su valor de verdad ante cualquier interpretación ($A \leftrightarrow B$ es una tautología).
    
- **Estructura Clausular:**
    
    - **Literal:** Es un símbolo proposicional (literal positivo) o su negación (literal negativo).
        
    - **Cubo:** Un literal único o una conjunción de literales.
        
    - **Cláusula:** Un literal único o una disyunción de literales.
        
- **Formas Normales Restringidas:** Toda fórmula posee una _Forma Normal Disyuntiva Restringida (fndr)_ (disyunción de cubos) y una _Forma Normal Conjuntiva Restringida (fncr)_ (conjunción de cláusulas) equivalentes, caracterizadas por no contener literales repetidos, literales opuestos en el mismo bloque ni bloques contenidos unos en otros.

### 3. Lógica Clásica de Predicados de Primer Orden (LP1)

#### A) Sintaxis: Signatura, Términos y Fórmulas

- **Signatura ($\Sigma = (C, F, P)$):** Terna que define el vocabulario específico de una aplicación lógica:
    
    - **Constantes ($C$):** Símbolos que denotan un individuo fijo del universo.
        
    - **Símbolos de Función ($F$):** Símbolos dotados de una aridad concreta que reciben objetos y devuelven otro objeto.
        
    - **Símbolos de Predicado ($P$):** Símbolos con aridad asignada que representan propiedades (aridad 1) o relaciones entre los objetos (aridad mayor que 1).
        
- **Términos:** Expresiones lógicas que representan exclusivamente a los objetos del universo. Las variables y las constantes son términos y un símbolo de función aplicado a una secuencia de términos según su aridad genera un nuevo término.
    
- **Fórmulas Atómicas:** Son las cadenas con estructura $P(t_1, \dots, t_n)$, formadas por la aplicación de un predicado a una colección de términos. Las fbfs de primer orden se construyen combinando estos átomos mediante conectivas lógicas y la aplicación de cuantificadores.

#### B) Variables, Cierres y Sustituciones

- **Ocurrencia libre o ligada:** Una variable en una fbf está ligada si se localiza dentro de un cuantificador asociado a ella misma o forma parte de él. En caso contrario, se dice que su ocurrencia es libre.
    
- **Fórmulas básicas (o cerradas):** Expresiones lógicas que carecen de variables libres.
    
- **Cierres:** El _cierre universal_ de una fbf añade cuantificadores $\forall$ delante de todas sus variables libres ; el _cierre existencial_ realiza la misma operación anteponiendo cuantificadores $\exists$.
    
- **Sustitución ($[x/t]$):** Aplicación matemática que reemplaza de forma simultánea las apariciones de una variable libre por un término determinado. Una variable se considera _sustituible_ por un término en una fórmula la variable es libre.

#### C) Semántica de Primer Orden

- **Estructura (o Dominio de Interpretación):** Par $(M, I)$ donde $M$ representa el _universo_ (conjunto no vacío de individuos reales). La función de interpretación $I$ mapea la sintaxis con el mundo real asignando: un elemento de $M$ a cada constante, una función matemática pura $M^n \rightarrow M$ a cada símbolo de función, y una relación o subconjunto $M^m$ a cada símbolo de predicado.
    
- **Valuación de variables:** Es una función $\sigma$ encargada de adjudicar temporalmente un elemento del universo $M$ a cada variable libre del lenguaje.
    
- **Condiciones de Verdad para Cuantificadores:** La función de verdad $I_\sigma$ evalúa las fórmulas basándose en la estructura y la valuación. Para las fórmulas cuantificadas dicta que:
    
    - $I_\sigma(\forall x A) = 1$ si y solo si la fórmula es verdadera para **todas** las valuaciones alternativas que se puedan formar variando únicamente el valor asignado a la variable $x$.
        
    - $I_\sigma(\exists x A) = 1$ si y solo si la fórmula es verdadera para al menos **alguna** de esas valuaciones alternativas.
        
- **Validez en Primer Orden:** Una fórmula es válida si resulta verdadera bajo cualquier estructura semántica y ante cualquier valuación posible. Una fórmula es válida si y solo si lo es su cierre universal.

#### D) Formas Normales Avanzadas y Propiedades Metalógicas

- **Forma Normal Prenexa:** Estructura en la que la fbf queda nítidamente dividida en dos bloques: un _prefijo_ compuesto por solo cuantificadores, seguido de una _matriz_ que carece por completo de ellos.
    
- **Forma Normal de Skolem:** Variante de la forma prenexa cuya característica es que en su prefijo solo se permiten cuantificadores universales ($\forall$).
    
- **Equisatisfacibilidad:** La fórmula original es satisfacible si y solo si su correspondiente forma de Skolem es satisfacible en alguna estructura.
    
- **Teorema de Church-Turing (No decidibilidad):** Demostración que concluye que la LP1 **no es decidible**, es matemáticamente imposible diseñar un algoritmo universal capaz de decidir la validez de cualquier fórmula de primer orden en un tiempo finito.
    
- **Semidecidibilidad de LP1:** LP1 es semidecidible. Si un conjunto de fórmulas es insatisfacible, existe un algoritmo adecuado capaz de certificar dicha insatisfacibilidad en un número finito de etapas. En cambio, si el conjunto es satisfacible, el procedimiento matemático podría entrar en un bucle infinito.