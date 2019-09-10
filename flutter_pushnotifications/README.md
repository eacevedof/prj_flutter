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
  - install [**firebase_messaging 5.1.5**](https://pub.dev/packages/firebase_messaging)
  ```dart
  //pubspeck.yaml
    firebase_messaging: ^5.1.5
  //android/app/build.gradle
  defaultConfig {
      // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
      //esto hay que cambiarlo por el nombre final de la app
      applicationId "com.example.push_local"
      minSdkVersion 16
      targetSdkVersion 28
      versionCode flutterVersionCode.toInteger()
      versionName flutterVersionName
      testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
  }  
  ```
  - ![flutter install push](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/514x434/eee266c6d32a2106841305511d16a6c4/image.png)
  - ![gradle](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/446x86/652c27ed3498f9febaa29c36c6c6b76f/image.png)
  - ![hash](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/655x163/a7fb758694db6e6eb31e1d7cb4b5dc68/image.png)
  - Para el hash hay que ejecutar el siguiente [comando](https://developers.google.com/android/guides/client-auth):
    - **windows** `keytool -list -v \ -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore`
    - Abrir la terminal (bash) como administrador
    - `/<path-to-jdk>/bin/keytool -list -v -alias androiddebugkey -keystore /c/users/<mi-usuario>/.android/debug.keystore` [**más en trello**](https://trello.com/c/W7Esvfng/1-generar-claves)
    - ![terminal](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/652x270/ac84b28fe9ab89326daecdb64f61c318/image.png)
    - ![json](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/630x287/86ccac29b8b6ca475e2448c6d09fd414/image.png)
    - Hay que copiar el json aqui: `\flutter_pushnotifications\push_local\android\app\`
  - Añadir el SDK de Firebase:
    - En el fichero: `\flutter_pushnotifications\push_local\android\build.gradle`
    - hay que aplicar las configuraciones que indica google en el asistente
  - **error:**
    ```js
    Note: C:\src\flutter\.pub-cache\hosted\pub.dartlang.org\firebase_messaging-5.1.5\android\src\main\java\io\flutter\plugins\firebasemessaging\FlutterFirebaseMessagingService.java uses or overrides a deprecated API.
    Note: Recompile with -Xlint:deprecation for details.
    Note: C:\src\flutter\.pub-cache\hosted\pub.dartlang.org\firebase_messaging-5.1.5\android\src\main\java\io\flutter\plugins\firebasemessaging\FirebaseMessagingPlugin.java uses unchecked or unsafe operations.
    Note: Recompile with -Xlint:unchecked for details.
    ```
    - Despues de hacer un **flutter upgrade** y reiniciar el apk (f5) ya no aparece este mensaje
    ```js
    Built build\app\outputs\apk\debug\app-debug.apk.
    D/EGL_emulation( 3131): eglMakeCurrent: 0x7fd5d7846ec0: ver 2 0 (tinfo 0x7fd5d7811c20)
    ```
  - **AndroidManifest.xml**
  - `\flutter_pushnotifications\push_local\android\app\src\main\AndroidManifest.xml`
    ```xml
    <intent-filter>
      <action android:name="FLUTTER_NOTIFICATION_CLICK" />
      <category android:name="android.intent.category.DEFAULT" />
    </intent-filter>
    ```
- 16.6. Provider para controlar las notificaciones y FCM Token
  - **error**
    ```
    Se produjo una excepción.
    PlatformException (PlatformException(error, Default FirebaseApp is not initialized in 
    this process com.example.push_local. Make sure to call 
    FirebaseApp.initializeApp(Context) first., null))
    ```
    - [En la docu de firebase_messaging:](https://pub.dev/packages/firebase_messaging)
    ```
    Note: If this section is not completed you will get an error like this:
    java.lang.IllegalStateException:
    Default FirebaseApp is not initialized in this process [package name].
    Make sure to call FirebaseApp.initializeApp(Context) first.
    ```
    - **solución:**
      - He tenido que agregar `apply plugin: 'com.google.gms.google-services` en el archivo: `\flutter_pushnotifications\push_local\android\app\build.gradle`
  - Ya tengo el token
    - > `drAaitFuUwI:APA91bGFP337MuMbPJkiJEJRd8h8ZYQe2RSUwqzyW_IyeoGsV_76j7gs5bW3zJlVBWcwBHrIcocXllUc2TL5Juyp3ZtIFVTeb8GnAnn-faxHXe5SD2evvInSt6QvpIG7PUp0Ij3Tty4F`
    - El token solo cambia al reinstalar la app.
- 16.7. Recibir notificación - onMessage, onLaunch y onResume
  - Hay notificaciones que llegarán cuando el usuario está usando la app, esta no es una notificación push.
  - Recibimos esta notif y la manejariamos como una local notification porque la app está abierta
  - Solo si la app está en el background se llama notificación push NP
  - **configuración del mensaje en fbase**
    - [config message en fbase](https://console.firebase.google.com/project/flutter-push-a5f21/notification/compose)
    - ![config msg](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/783x312/1f5d70af1b4fffe2e89090db07b9c5a5/image.png)
    - El texto máximo: 1000 caracteres
    - El título máximo: parece que no tiene limites
      - **error:** Presiono testar y no me llega nada :S
      - **solución** He eliminado el mensaje en cuestion puesto un titulo mas pequeño y ya ha funcionado
    - ![flutter push](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/255x187/aa9fb1def5a0ead595c414261ef48ad7/image.png)
  ```dart
    //tratando los estados para la recepcion de la notificacion
      _firebaseMessaging.configure(

        //cuando la app está abierta
        onMessage: (info){
          print("======= On Message =============");
          print(info);
        },//onMessage

        //en background
        onLaunch: (info){
          print("======= On Launch =============");
          print(info);

          final noti = info["data"]["comida"];
          print(noti);
        },//onLaunch

        //al hacer click en el "botón" push y con la app en segundo plano entra aqui
        onResume: (info){
          print("======= On Resume =============");
          print(info);
          //final noti = info["data"]["comida"];
          //print(noti);        
        }//onResume

      );//_firebaseMessaging.configure

    }//initNotifications

  }//class PushNotificationsProvider
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
