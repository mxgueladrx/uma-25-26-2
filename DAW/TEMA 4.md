## Arquitectura hexagonal
**Núcleo**: contiene la lógica de negocio del servicio. Ejemplo: una clase implementando la lógica de negocio.

**Adaptadores**: conexión de la lógica de negocio con el exterior.
- **De entrada**: para invocar la lógica de negocio. Ejemplo: controlador REST.
- **De salida**: usados por la lógica de negocio para realizar acciones. Ejemplo: una clase implementando un repositorio.

**Puertos**: es un conjunto de operaciones, una interfaz para que la lógica de negocio interactúe con los adaptadores. 

Desacopla la lógica de negocio del resto de componentes (permite probar dicha lógica de forma aislada), refleja mejor la estructura lógica de las aplicaciones, y es útil para describir la arquitectura de cada microservicio.

## Patrones de diseño para microservicios
### Patrones de descomposición (como dividir el trabajo)
**Descomposición por capacidad empresarial**: analiza lo que la aplicación hace para generar valor (<u>agrupar los servicios por lo que hacen</u>). Se puede subdividir en subcapacidades y se asigna un servicio a cada capacidad, subcapacidad o grupos de ambos.

**Descomposición subdominio**: se crea un modelo de dominio reflejando las entidades del problema completo, se identifican subdominios (entidades relacionadas) y se asigna un servicio a cada subdominio (<u>agrupar mirando cómo se relacionan los datos</u>).

### Patrones para consistencia de datos (como compartimos información)
**Agregado**: es un conjunto de entidades del modelo de dominio que se puede tratar como una unidad (<u>agrupar datos que siempre deben ir juntos</u>).
- Las entidades relacionadas se manipulan solo invocando métodos del agregado.
- Las referencias entre agregados se hacen mediante claves primarias. 
- Una transacción solo crea o actualiza un agregado.

**Evento de dominio**: eventos publicados por agregados cuando se crean o se actualizan.

**Saga**: permite mantener consistencia de datos en operaciones de negocio que requieren la actualización de varios servicios. Es la alternativa a las transacciones distribuidas y está formada por una secuencia de transacciones locales. Si falla una, es necesario tener una transacción de compensación por cada transacción local ya ejecutada. Pueden implementarse mediante Orquestación (alguien dirige todo) o Coreografía (cada servicio reacciona automáticamente).

### Patrones para el acceso externo (como habla el cliente con los servicios)
**API Gateway**: servicio que sirve como punto de entrada para aplicaciones externas (<u>recepcionista del servicio al que llama</u>).

**Composición de APIs**: combina los resultados de varios servicios para dar la respuesta.

**Command Query Responsability Seggregation (CQRS)**: mantiene una base de datos solo para consultas, construida con eventos de dominio. Lectura/Escritura.

### Patrones de apertura de circuitos (que pasa si un servicio se rompe)
Cuando se detecta que un servicio no está disponible, se rechazan las llamadas a dicho servicio de forma inmediata. No está disponible si en llamadas recientes el servicio no responde en un tiempo determinado o devuelve un error. Para la recuperación: si la respuesta es crítica, devolver error, pero si no lo es, se puede devolver un valor por defecto u obtenido en llamadas anteriores.

### Configuración externa
No se guardan las contraseñas o rutas de base de datos dentro del código, necesarios para que los servicios funcionen. La idea es que esta información se encuentra almacenada fuera de los servicios y se accede a ella al arrancar el servicio.
- **Modelo push**: el servidor aporta la configuración en el arranque.
- **Modelo pull**: el servicio accede a un servidor que contiene de configuración.

### Patrones de observabilidad
**API de comprobación de estado (health check API)**: en cada servicio se añade un endpoint para consultar el estado del servicio. La ausencia de respuesta o respuesta errónea indica indisponibilidad.

**Patrón de agregación de logs**: reunir los logs de todos los servicios en una base de datos central que permita búsquedas y avisos.

**Patrón de trazas distribuidas**: asignar un identificador único a cada petición entrante y registrar su movimiento por todos los servicios involucrados en la resolución de la petición usando un servidor centralizado.

### Patrones para pruebas
**Verificar expectativas del cliente:** cada consumidor de una API comprueba que la API responde como debe.