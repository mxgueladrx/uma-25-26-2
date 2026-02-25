**Servicio**: unidad funcional, sin estado, con una entrada y salida bien definida. Implementan operaciones de la **capa de negocio** (Ejemplo: transacciones entre bancos). La arquitectura basada en servicios es un modelo donde la lógica de negocio se descompone en unidades lógicas (servicios).

Los servicios encapsulan operaciones de diversa granularidad. Un servicio puede a su vez utilizar otros servicios. Para poder invocar un servicio es necesario su **descriptor** (documento que especifica la interfaz del servicio. Ejemplo: WSDL (Web Services Description Language)).

La comunicación entre dos servicios se realiza mediante mensajes síncronos (Ejemplo: HTTP) o asíncronos (Ejemplo: ActiveMQ). Ejemplo: SOAP (Simple Object Access Protocol) es un protocolo de intercambio de mensajes.

**SOA (Service Oriented Architecture)**: tiene que cumplir **bajo acoplamiento** (minimizar dependencias, cualquier cambio no rompa el servicio y sea transparente al usuario final), **contrato** (cumplen la interfaz definida), **autonomía** (control total sobre su función, un servicio solo conoce su comportamiento), **abstracción** (ocultan detalles de funcionamiento, caja negra, no se como es su implementación, solo su interfaz), **reutilización** (descomposición para reutilizar, descomponer un sistema en servicios. Ejemplo: pasarela de pago, login), **composición** (se pueden combinar diferentes servicios), **sin estado** (no guardan estado, historial) y **descubrimiento** (se publicitan ellos mismos, saber que servicio esta disponible, que hace).

La web es la principal tecnología usada para implementar arquitecturas SOA (servicios web). OA es una arquitectura independiente de la tecnología subyacente.

SOA debe tener bajo acoplamiento y autonomía para su reutilización. 

**Transacciones distribuidas**: WS AtomicTransaction
![[Pasted image 20260225112446.png]]

**Actividades de negocio**: WS BusinessActivity
![[Pasted image 20260225112533.png]]

**Orquestación**: reglas que los servicios deben seguir para completar una tarea. WS BPEL (Web Services Business Process Execution Language) sirve para especificar osquestaciones. Un jefe, misma empresa.![[Pasted image 20260225113055.png]]

**Coreografía**: reglas para que las entidades interesadas deben seguir para poder colaborar. WS CDL (Web Services Choreography Description Language) define el intercambio de información entre las entidades. Documento global que todos saben.![[Pasted image 20260225113329.png]]

## Servicios Web REST
