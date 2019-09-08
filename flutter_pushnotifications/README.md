# 16. Bonus - Push notifications
- 16.1. Introducción a la sección
  - Para Android no hace falta ninguna cuenta especial para notificaciones push
  - Para IOS se necesita una cuenta developer de Apple
- 16.2. Temas puntuales de la sección
  - FMC - Firebase cloud messaging
  - Push Notifications
  - Notificaciones cuando la aplicación está abierta
  - Notificaciones cuando la aplicación está en segundo plano o terminada
  - Usar el GlobalKey para manejar la navegación
  - Servicio REST de Firebase para envío de notificaciones push
  - Envío de argumentos en la notificación push
  - Uso de los argumentos de la push
  - Esta es una sección adicional que agregue al curso porque muchas personas me lo solicitaron, espero les guste y nos vemos en el siguiente video.
- 16.3. Demostración de la sección
  - Como mandar NP a nuestros dispositivos 
  - Como trataran estas NP los dispositivos
  - Se hará de dos maneras con: **cloud messagin de firebase** y con el **servicio REST de Firebase**
  - Para el segundo usarémos POSTMAN
  - Con Postman emularemos la configuración que se tiene que hacer en **nuestro backend** para llamar al servicio de **Fbase** y que este último se encargue de enviar la NP
  - **Ver screenshots**
- 16.4. Inicio de proyecto - Push Notifications
  - Requerimientos previos:
    - Android: Ninguno
    - IOS: Licencia de developer de apple vigente y activa
    - **Flutter new project: push_local**
    - se crea una app vacia y en main.dart: `debugShowCheckedModeBanner: false`
- 16.5. Configuración de FCM (Firebase Cloud Messaging)
  - 
  ```dart
  ```
- 16.6. Provider para controlar las notificaciones y FCM Token
  - 
  ```dart
  ```
- 16.7. Recibir notificación - onMessage, onLaunch y onResume
  - 
  ```dart
  ```
- 16.8. Reaccionar cuando recibimos una notificación y nuestra aplicación está abierta
  - 
  ```dart
  ```
- 16.9. Navegar a la segunda pantalla con los argumentos de la notificación
  - 
  ```dart
  ```
- 16.10. Inicio de configuraciones Push en IOS
  - 
  ```dart
  ```
- 16.11. Push Notification en segundo plano o terminada - IOS
  - 
  ```dart
  ```
- 16.12. Enviar notificaciones mediante un servicio REST
  - 
  ```dart
  ```
