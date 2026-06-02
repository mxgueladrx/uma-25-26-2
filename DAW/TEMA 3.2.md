## Middleware orientado a mensajes
**MOM (Message Orientes Middleware)**: buffer de software que conecta sistemas distribuidos de forma asíncrona, permitiendo que productores y consumidores trabajen sin comunicarse directamente y garantizando la entrega de los mensajes.

### Modelo Punto a Punto
Los mensajes van dirigidos a un único receptor. El destino se llama cola (queue), donde se almacena el mensaje hasta que el receptor lo recoja. SI hubiesen varios receptores, no obtendrían todos los mensajes, una vez que se recoja el mensaje, desaparece de la cola.

### Modelo de Publicación/Subscripción
Formado por productores o consumidores de dicha información. El destino se llama tema (topic).
- Los productores envían mensajes al MOM y éste a los consumidores correspondientes.
- Varios consumidores pueden recoger el mensaje. Se suscriben a un determinado tipo de mensajes.
Si es una suscripción duradera, los mensajes se guardan mientras que esté desconectado el consumidor. Si es no duradera, el consumidor debe permanecer activo para recibir los mensajes.

### Java Messaging Service (JMS)
JMS es la API que usa Java para comunicarse con un MOM.
- **Proveedor JMS**: necesita un proveedor que la implemente. Ejemplos: ActiveMQ (Artemis).
- **Cliente JMS**: aplicación que genera y/o recibe mensajes (puede ser productor o consumidor).
- **Cola JMS**: mensajes que se envían y están a la espera de ser leídos, FIFO. 
- **Tema JMS**: mecanismo de distribución para publicar mensajes que se entregan a suscriptores.
- **El Mensaje JMS**: contiene los datos que se transfieren. Está dividido en tres partes:
    1. **Cabecera**: información para identificar y enrutar el mensaje.
    2. **Propiedades**: pares clave-valor que se usa para filtrar mensajes en el consumidor.
    3. **Cuerpo**: contenido en diferentes formatos.