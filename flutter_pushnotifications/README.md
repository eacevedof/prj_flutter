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
  - Para escuchar la notificación push, que puede ocurrir en cualquier momento se debe trabajar con **streams**
  - **error** ^^ Ahora no me llegan las notificaciones ~~! vaya! sorpresa ... :s
    - He desinstalado la app y vuelto a instalar
    - me ha cambiado el token y con este ya funciona, me llegan las notif
  - Los datos desde fbase pueden variar entre **android** e **ios**
  - Recibe los argumentos escuchando el stream y teniendo la app en foreground
  ```dart
  //home_page.dart
  //mensaje_page.dart

  //main.dart
  rutas
  //pus_notifications.dart
  class PushNotificationsProvider{

    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    //listener, siempre es bueno usar broadcast
    final _mensajesStreamController = StreamController<String>.broadcast();
    Stream<String> get get_mensajes_stream => _mensajesStreamController.stream;
    ...
    onMessage: (info){
      print("======= On Message =============");
      print(info);
      //la info entre android e ios puede ser diferente cuando llega en push 
      String argumento = 'no-data';
      if(Platform.isAndroid ){
        argumento = info["data"]["comida"] ?? "no-data";
        //se agrega al stream
        _mensajesStreamController.sink.add(argumento);
      }      
      //_mensajesStreamController.sink.add(event);
    },//onMessage 
    ...   
  ```
- 16.9. Navegar a la segunda pantalla con los argumentos de la notificación
  - Se reciben los mensajes tanto en foreground como en background y al interactuar con este se navega a la página mensaje
  ```dart
  //main.dart
    final GlobalKey<NavigatorState> oGlobalNavkey = new GlobalKey<NavigatorState>();

  @override
  void initState(){
    print("========= _MyappState.initState() ============");
    super.initState();

    final pushProvider = new PushNotificationsProvider();
    pushProvider.initNotifications();
    pushProvider.get_mensajes_stream.listen( (strdata){
      //aqui no se puede llamar a pushNamed porque no tengo el objeto Navigator creado
      //tengo que relacionar el build.materialapp y el pusprovider.argumento
      //Navigator.pushNamed(context,"mensaje");
      print("Argumento del push:");
      print(strdata);

      oGlobalNavkey.currentState.pushNamed("mensaje",arguments:strdata);
    });

  }//initState

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //esta variable me permitirá controlar el estado de MaterialApp a lo largo de toda esta clase
      navigatorKey: oGlobalNavkey,
      ...
  //push_notifications_provider.dart
  onResume: (info){
    print("======= On Resume =============");
    print(info);

    String argumento = 'no-data';
    if(Platform.isAndroid ){
      argumento = info["data"]["comida"] ?? "no-data";
      //se agrega al stream, y esto desencadena en main.dart que se navegue a mensaje_page.dart
      _mensajesStreamController.sink.add(argumento);
    }      
    //print(noti);  
    ...

  //mensaje_page.dart
  Widget build(BuildContext context) {

    final String strarg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Text(strarg),
      ),
    );

  }
  ```
- 16.10. Inicio de configuraciones Push en IOS
  - [Video udemy](https://www.udemy.com/flutter-ios-android-fernando-herrera/learn/lecture/14951738#questions/8158031)
  - Se necesita una cuenta de developer de apple pagada
  - en el paquete firebase_messaging hay indicaciones de como montar el paquete en IOS
  - nos podemos saltar el provisional profile
  - configurar apns with fcm
    - Gestión en developer.apple.com/account/ios/authkey/create
    - la key generada solo la dejará descargar 1 vez (archivo.p8)
    - esta hay que guardarla bien, en dropbox por ejemplo
  - crear el app id
    - en identifiers
    - el bundle id: com.miweb.flutterpush
    - se selecciona push notifications
  - firebase console
    - el bundle id: com.miweb.flutterpush
    - nombre app: FlutterPush Ios
    - descarga de googleservice-info.plist
    - se coloca el fichero en ios/runner.xcworkspace
    - se abre en xcode
    - una vez abierto xcode se incluye dentro de runner el fichero .plist
    - en el bundle identifier debe ser igual al "bundle id"
  - En firebase/flutter push ios
    - subimos el fichero .p8
    - copiamos el id de la llave
    - copiamos el team id de la cuenta de ios
  - Las notificaciones no llegán, se corregirá en el prox video
- 16.11. Push Notification en segundo plano o terminada - IOS
  - [Video udemy](https://www.udemy.com/flutter-ios-android-fernando-herrera/learn/lecture/14952670#questions/8158031)
  - **/ios/Runner.xcworkspace**
  - se abre y se hace la comporobación del **bundle identifier** que no tenga espacios al principio ni fn
  - con esta comprobación se lanza la app de ios en el emulador dentro de **xcode**
  - se mostrará el token de firebase en xcode
  - a partir de aqui se puede usar con vscode
  - con el nuevo token ahora si la app en ios esta minimizada llegará el push
  - cerramos todo **xcode**
  ```dart
  //push_notifications_provider.dart
      onMessage: (info){
        print("======= On Message =============");
        print(info);
        //la info entre android e ios puede ser diferente cuando llega en push 
        String argumento = 'no-data';
        if(Platform.isAndroid ){
          argumento = info["data"]["comida"] ?? "no-data";      
        }
        //ios
        else{
          argumento = info["data"]["comida"] ?? "no-data-ios";
        }   
        //se agrega al stream
        _mensajesStreamController.sink.add(argumento);
        //_mensajesStreamController.sink.add(event);
      },//onMessage

  //lo mismo para onResume  
  ```
- 16.12. Enviar notificaciones mediante un servicio REST
  - La intención es enviar mensajes push sin necesidad de entrar al panel de control de Firebase
  - La app móvil llamará a un endpoint de nuestro backend y este se comunique con Fbase
  - ![get token](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/576x480/dc97708c81a06f29140681532e360fbb/image.png)
    - Obtengo la clave del servidor para la llamada
  ```js
  DATA='{"notification": {"body": "this is a body","title": "this is a title"}, "priority": "high", "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1", "status": "done"}, "to": "<FCM TOKEN>"}'
  curl https://fcm.googleapis.com/fcm/send -H "Content-Type:application/json" -X POST -d "$DATA" -H "Authorization: key=<FCM SERVER KEY>"
  ```
  - ![resultado](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/999x503/d498db8632df3cae73da422c57ff9327/image.png)
  
