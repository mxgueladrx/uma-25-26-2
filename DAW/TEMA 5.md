## Tipos de computación en la nube
![[Pasted image 20260521203426.png]]

**IaaS (Infrastructure as a Service)**: oferta de infraestructura de computación (memoria, cómputo, red...). Orientado a instituciones que no quieren mantener equipos informáticos y se cobra por el uso de CPU, memoria..., permitiendo aumentar o reducir la infraestructura bajo demanda. Ejemplo: Amazon EC2. Microsoft Azure VM.

**CaaS (Container as a Service)**: oferta de plataformas de ejecución de contenedores. Orientado a desarrolladores. Ejemplo: OpenShift, Amazon Elastic Container Service.

**PaaS (Platform as a Service)**: oferta de plataformas de ejecución para las aplicaciones. Orientado a desarrolladores que quieren ofrecer aplicaciones web, y el proveedor cobra por almacenamiento, tiempo de CPU y datos transferidos. Ejemplo: Google App Engine, Microsoft Azure.

**FaaS (Function as a Service)**: desarrollador proporciona la funcionalidad pero no tiene que preocuparse del escalado de la aplicación ni del entorno de tiempo de ejecución. Se cobra por número de llamadas que se realicen a las funciones. Ejemplo: AWS Lambda, Google Cloud Functions.

**SaaS (Software as a Service):** oferta de aplicaciones finales a través de Internet. Orientado a usuarios que no requieren conocimientos informáticos y su gran ventaja es que las actualizaciones son inmediatas. Ejemplo: Gmail, Facebook, Twitter.

## Tecnologías de contenedores y máquinas virtuales
**Máquina virtual (VM)**: simula la máquina física y requiere instalar sistema operativo.

**Contenedores**: ofrecen aislamiento de procesos pero se ejecutan sobre el mismo sistema kernel del sistema operativo.

### Patrones de despliegue (como meter el código en estos contenedores o VM)
**Múltiples servicios en un anfitrión**: poner varios microservicios juntos en una misma máquina.

**Un servicio por anfitrión**: cada microservicio tiene su propio espacio exclusivo. El anfitrión puede ser una VM o un contenedor.

**Despliegue sin servidor (Serverless)**: los anfitriones son transparentes para el desarrollador, quien solo se centra en la funcionalidad. Despliegas tu código y la infraestructura se encarga de gestionar los contenedores o VM automáticamente. Ejemplos: AWS Lambda, Google Cloud Functions.

### Patrones de descubrimiento (como se hablan entre ellos)
Cada microservicio debe saber a qué IP debe conectarse para invocar otro microservicio. Hay que resolver dos problemas:
- **Registro de servicios**: los servicios disponibles deben registrarse en algún lado. Esto lo puede hacer el propio servicio o un tercero.
- **Descubrimiento de servicios**: los clientes tienen que saber dónde se encuentran los servidores. Búsqueda en el lado del cliente (Ejemplo: EWP) o del servidor (Ejemplo: Docker).

### Kubernetes
Framework de orquestación de contenedores docker. Muy flexible y con muchas opciones (calcular matemáticamente el autoescalado) pero es bastante complejo.