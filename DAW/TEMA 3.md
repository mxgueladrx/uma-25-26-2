## Arquitectura interna de los servicios Web REST

![[Pasted image 20260413191221.png]]

Aplicaciones en 4 niveles:
- **Cliente**: se ejecuta fuera del servidor.
- **Presentación**: primera capa que se ejecuta enel servidor. Da el formato a los datos y traduce peticiones.
- **Negocio**: lógica de negocio, lo que la aplicación hace.
- **Sistema de información**: BD (puede estar en un servidor diferente).

Servidores de aplicaciones: programas que da herramientas de despliegue para la instalación y configuración de componentes. Implementan contenedores (servicios y APIs) para los componentes de la aplicación, gestionando los recursos y el ciclo de vida.

![[Pasted image 20260413191821.png]]

- **Controladores**: capa de presentación (@RestController).
- **DTOs (Data Transfer Objects)**: objetos que representan los datos que se intercambian con el exterior y son serializados (JSON).
- **Entidades**: objectos que persisten en la BD (@Entity).
- **Repositorios**: DAOs (Data Access Objects) que permiten acceder a la BD (@Repository). Heredan de interfaces que ofrecen métodos para el acceso.
- **Servicios**: capa de negocio (@Service).

![[Pasted image 20260413192247.png]]![[Pasted image 20260413192319.png]]![[Pasted image 20260413192349.png]]![[Pasted image 20260413192528.png]]
![[Pasted image 20260413192607.png]]

## Persistencia de datos mediante ORMs

**ORM (Object Relational Mapping)**: mapean filas de tablas en objetos (entidades) para que sean manipulables en la aplicación.

**JPA (Java Persistence API)**: especificación de ORM para java. Una entidad es un POJO (Plain Old Java Object) con anotaciones.

![[Pasted image 20260413193102.png]]

Una entidad debe tener un constructor sin argumento, ser una clase top-level, no ser ni tener "final" y conveniente que implemente "Serializable".

![[Pasted image 20260413193049.png]]![[Pasted image 20260413193134.png]]
![[Pasted image 20260413193226.png]]
![[Pasted image 20260413193419.png]]![[Pasted image 20260413193305.png]]
![[Pasted image 20260413193445.png]]![[Pasted image 20260413193942.png]]![[Pasted image 20260413193704.png]]![[Pasted image 20260413193720.png]]![[Pasted image 20260413193856.png]]![[Pasted image 20260413193908.png]]![[Pasted image 20260413193928.png]]

**Herencia (@Inheritance)**:
- **InheritanceType.SINGLE_TABLE**: por defecto. Todas las clases se mapean en una única tabla. La tabla contiene columnas para todos los atributos de la clase padre y todos los atributos específicos de cada subclase. 1 tabla.
- **InheritanceType.JOINED**: cada clase de la jerarquía tiene su propia tabla. Hay una tabla para la clase padre con sus atributos y tablas separadas para cada subclase con sus atributos específicos y una FK que apunta al ID de la clase padre. n + 1 tablas.
- **InheritanceType.TABLE_PER_CLASS**: cada subclase tiene sus atributos y los heredados de la clase padre. n tablas.

![[Pasted image 20260413195445.png]]![[Pasted image 20260413195507.png]]![[Pasted image 20260413195543.png]]

## Autenticación y autorización

**Autenticación**: verificar que el usuario es quien dice ser.
**Autorización**: verificar que el usuario puede hacer lo que pretende.

![[Pasted image 20260413195748.png]]
![[Pasted image 20260413195759.png]]

JWT (JSON Web Token): contiene información para la autorización (ID, roles, validez). Se usa tiempos cortos de validez.

![[Pasted image 20260413195952.png]]

**Firma**: cuando el usuario hace login, llama a un método que crea un JWT con roles, nombre y firmado con una contraseña.

**Validación**: en cada petición, el servicio valida el token (filtro). Sin cambia el token dará error.

**Extracción**: si es válido, se obtiene el usuario y rol desde el token para decirlo a los demás servicios.

**OAuth 2.0**: protocolo de delegación de autorización. Permite que una aplicación acceda a datos de otra sin que el usuario comparta contraseñas. La capa de presentación consulta los permisos del token. 

![[Pasted image 20260413200400.png]]

Los usuarios tienen roles y estos permisos. El acceso por roles se gestiona en la capa de presentación (Ejemplo: solo admis pueden acceder a /admin) o de negocio (permisos particulares de usuarios. Ejemplo: usuarios solo tienen acceso a sus facturas).

![[Pasted image 20260413200540.png]]![[Pasted image 20260413200603.png]]![[Pasted image 20260413200618.png]]![[Pasted image 20260413200701.png]]![[Pasted image 20260413200711.png]]