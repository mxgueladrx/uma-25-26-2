## Arquitectura basadas en servicios

**Servicio**: unidad funcional sin estado con entrada y salida bien definida. Implementan operaciones de la capa de negocio. SOA es un modelo donde la lógica de negocio se descompone en unidades lógicas (servicios).

Un servicio puede a su vez utilizar otros servicios, siendo necesario su descriptor (documento que especifica la interfaz del servicio. Ejemplo: WSDL (Web Services Description Language)).

La comunicación entre dos servicios se realiza mediante mensajes síncronos o asíncronos. SOAP (Simple Object Access Protocol) es un protocolo de intercambio de mensajes.

**SOA (Service Oriented Architecture)**: 
- **Bajo acoplamiento**: minimizar dependencias. Cualquier cambio no rompa el servicio y sea transparente al usuario final.
- **Contrato**: cumplen la interfaz definida.
- **Autonomía**: control total sobre su función. Un servicio solo conoce su comportamiento.
- **Abstracción**: ocultan detalles de funcionamiento, caja negra, no se como es su implementación, solo su interfaz.
- **Reutilización**: descomposición (en servicios) para reutilizar.
- **Composición**: combinar diferentes servicios.
- **Sin estado**: no guardan estado/historial.
- **Descubrimiento**: se publicitan ellos mismos. Saber que servicio esta disponible, que hace.

La web es la principal tecnología usada para implementar arquitecturas SOA (servicios web). SOA debe tener bajo acoplamiento y autonomía para su reutilización. 

![[Pasted image 20260413183554.png|357]]![[Pasted image 20260413183607.png|335]]

**Orquestación**: reglas que los servicios deben seguir para completar una tarea. WS-BPEL (Web Services Business Process Execution Language) sirve para especificar osquestaciones. Un jefe, misma empresa.

![[Pasted image 20260413183725.png|402]]

**Coreografía**: reglas que las entidades interesadas deben seguir para poder colaborar. WS-CDL (Web Services Choreography Description Language) sirve para intercambiar información entre las entidades. Documento global que todos saben.

![[Pasted image 20260413183934.png|396]]

## Servicios Web REST

![[Pasted image 20260413184302.png|366]]

**URI (Uniform Resource Identifier)**: identifica un recurso. Ejemplo: myserver.es/api/v1/usuarios.

**Servicio Web**: componente software que ofrece un servicio usando HTTP. Se relaciona con SOA. 

**REST (Representational State Transfer)**: arquitectura para entornos hipermedia distribuidos. Formado por principios para el desarrollo de arquitecturas distribuidas. Un servicio web REST sigue estos principios (HTTP se adhiere bien a estos):
- Dar a todos los recursos un ID (URI) y vincularlos (hiperenlaces).
- Usar métodos estándar (GET, POST, DELETE, PUT).
- Recursos con múltiples representaciones (JSON, XML).
- Sin estado (HTTP).

**Recurso**: objeto sobre el que hacemos operaciones. Cada uno tiene un ID (URI). Cuando hay referencias a otros, se usan enlaces. No salen del servidor, podemos obtener una representación (varias para un mismo objeto). Para decidir la representación:

![[Pasted image 20260413185310.png|400]]
![[Pasted image 20260413185329.png|575]]

Una de las ventajas de REST frente a otros servicios web  (como SOAP) es que usa una interfaz uniforme, usamos métodos estándares de HTTP para operar con recursos (CRUD).

Un servicio web no debe guardar el estado de la sesión (del recurso si). No existe concepto de sesión.

## Lenguajes de intercambio

**XML (eXtensible Mark-up Language)**: creación de modelos de documentos con el fin de estandarizar el intercambio de datos.

![[Pasted image 20260413185912.png|494]]

Los ficheros XML se pueden validar y transformar. Se pueden leer: DOM (Document Object Model) y SAX (Simple API for XML):

![[Pasted image 20260413190014.png|275]]

En Java se trabaja con JAXP (mapea objetos en XML), JAXB, STAX.

![[Pasted image 20260419132641.png]]

**JSON (JavaScript Object Notation)**: formato ligero de intercambio de datos procedente de JavaScript. Contiene un objeto (colección de pares clave/valor separados por ":"). Los valores pueden ser simples (números, cadenas, booleano, null) o compuestos (array entre "\[ ]", objeto entre  { }").

![[Pasted image 20260413190514.png|310]]

En Java se trabaja con JSON-B (equivalente a JAXP), Jackson.