## Madrid 2019/09/07 18:00

- [Playstore Console](https://play.google.com/apps/publish/?account=8700821796458106202#AppListPlace)

# 15. Despliegue en Google PlayStore y Apple AppStore
- 15.1. Introducción a la sección
    - Despliegues en la nube
    - Falta crear icono de app
    - Hay que ponerle un splash screen
    - La google playstore obliga **a partir del 19 agosto de 2019** a que todas sus apps desplegadas tengan su **version en 64 bits**
    - Aprenderemos como generar la version en 64 desde una de 32
    - También lo harémos en IOS que el proceso es más sencillo
    - A partir del Iphone 5S ya vienen con procesadores de arq de 64 bits
    - [Pdf de soporte de Fernando]()
- 15.2. Temas puntuales de la sección
    - **Temas de la sección:**
        - Google PlayStore
        - Apple AppStore
        - Generación del APK de Android de 32 y 64bits
        - Cambiar ícono de la aplicación
        - SplashScreen
        - Carga a la PlayStore
        - Carga a la AppStore
        - Configuraciones de AppStore Connect
        - Configuraciones en el portal de developer de Apple
        - Esta sección tiene por objetivo ayudarlos con los despliegues de sus aplicaciones en las tiendas, junto a una guía paso a paso detallada para un despliegue exitoso.
 - 15.3. Inicio de proyecto - Despliegues
    - Descargar material de despligues
        - Icono de 2014*1024 que lo usaremos para generar todo lo demas
        - Y otro par de imágenes que son propiamente para IOS
        - Guía que no reemplaza a las oficiales
        - Hay que pagar algo adicional para los despliegues
        - Google: 30 $ de por vida
        - Apple: 100 $ al año
        - La app de películas
        - Se abre en vscode, hacemos un **`flutter packages get`**
        - Fernando trabajará con la app de películas dentro del proyecto (que es lo mismo)
        - No tiene que ser una app terminada, tiene que ser una app que funcione.
- 15.4. Configuración del ícono de la aplicación
  - Cambiar el ícono para que cuando se abra no se vea la F de flutter
  - La carpeta de android e ios ya son aplicaciones generadas
  - Dicho esto se podria configurar dentro de cada una de ellas las opciones propias de cada sistema como si fueran apps nativas
  - Se puede cambiar el ícono de varias formas, usaremos [**flutter_launcher_icons**](https://pub.dev/packages/flutter_launcher_icons#-readme-tab-) (ver pdf)
  - Usaremos dependencias de desarrollo **dev_dependencies:**
  ```dart
  //flutter_peliculas\pubspec.yaml
  dependencies:
    flutter:
        sdk: flutter
    flutter_launcher_icons: ^0.7.3
  ```
  - Creamos carpeta `assets\icon`
  - copiamos el icono de **1024 x 1024**. Tiene que ser de este tamaño porque cuando generemos para IOS si la imágen se estirará la appstore no lo aceptaría
  ```dart
  //flutter_peliculas\pubspec.yaml
  flutter_icons:
    android: "launcher_icon" 
    ios: true
    image_path: "assets/icon/movie-icon.png"    
  ```
  - ejecutar: `flutter pub run flutter_launcher_icons:main -f <your config file name here>`
    - **en pdf**: `flutter packages pub run flutter_launcher_icons:main`
    ```js
    Android minSdkVersion = 16
    Creating default icons Android
    Adding a new Android launcher icon
    Overwriting default iOS launcher icon with new icon
    ```
    - **resultados del comando:**
    - ![Modificaciones en Android](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/313x407/64679ab562f4bad28cdee635f31085ed/image.png)
    - ![Modificaciones en IOS](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/323x410/487422c2d7bd418c4911d7b5ff89dd2a/image.png)
  - Lanzamos la app en el dispositivo o emulador
    - **comprobamos el icono**
    - ![Icono 1](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/294x428/fa75faf29a36ff142b24352493d7c2c5/image.png)
    - ![Icono 2](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/298x447/6e8065a63aacabc1a5bc3b68a11f943d/image.png)
- 15.5. Configurar el splashscreen
    - El splashscreen es esa pantalla en blanco que aparece cuando se carga la app (cuando se abre y no está en memoria)
    - Abrimos: `<project-path>\flutter_peliculas\android\app\src\main\res\drawable\launch_background.xml`
    ```xml
    //launch_background.xml
    <?xml version="1.0" encoding="utf-8"?>
    <!-- Modify this file to customize your launch splash screen -->
    <layer-list xmlns:android="http://schemas.android.com/apk/res/android">
      <item android:drawable="@android:color/white" />
      <!-- You can insert your own image assets here -->
      <!-- <item>
          <bitmap
              android:gravity="center"
              android:src="@mipmap/launch_image" />
      </item> -->
    </layer-list>
    ```
    - El fichero es de configuración de una app nativa de android, que es la app generada con lo cual se puede customizar en ese sentido
    - Aqui se puede configurar:
      - Animación
      - Estilos del fondo
      - etc
    ```xml
    //en pdf
    <?xml version="1.0" encoding="utf-8"?>
    <!-- Modify this file to customize your launch splash screen --> 
    <layer-list xmlns:android="http://schemas.android.com/apk/res/android"> 
      <item android:drawable="@android:color/black" /> 
      <!-- You can insert your own image assets here --> 
      <item> 
        <bitmap 
          android:gravity="center" 
          android:src="@mipmap/ic_launcher" />  
          //esto apunta flutter_peliculas\android\app\src\main\res\*\ic_launcher.png
      </item> 
    </layer-list>
    ```
    - Despues de los cambios ya se ve el splash screen negro con el icono de flutter en el medio
    - Ahora vamos con IOS:
      - Se reemplazan las imagenes en la ruta: `\flutter_peliculas\ios\Runner\Assets.xcassets\LaunchImage.imageset\`
      - Desde esa ruta se recuperan los png
      - En el emulador de Fernando se ve que funciona
- 15.6. Corrección de tamaño de las películas (opcional)
    ```dart
    //flutter_peliculas\lib\src\widgets\movie_horizontal.dart
    return Container(
      height: _screenSize.height * 0.25, //cambia de 0.2
      //slider del footer. El pageview va a renderizar todos los items que se hayan cargado al mismo tiempo
      //Pageview.builder los va creando bajo demanda
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        //children: _tarjetas(context), //no va para pv.builder
        itemBuilder: (context, i) => _tarjeta(context, peliculas[i]),
      ),
    );
    ```
 - 15.7. Cambiar el nombre de la aplicación en el HomeScreen
    - archivo manifest: `\flutter_peliculas\android\app\src\main\AndroidManifest.xml`
    - Aqui se encuentra el id único de la app. **android:name**
    ```dart
        android:name="io.flutter.app.FlutterApplication"
        android:label="Películas"
    ```
    - Ios:
      - `\flutter_peliculas\ios\Runner\Info.plist`
      ```xml
      	<key>CFBundleName</key>
	      <string>flutter_peliculas</string>
        ...
        <key>CFBundleName</key>
	      <string>Películas</string>
      ```
    - ![app](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/177x180/5a924f0f2b5c1ae6f33e13ebb32a1bc6/image.png)
    - ![icon](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/75x76/4e8d369742babb190e10e7516ea95a2c/image.png)    
- 15.8. Generación y subida del APK de Android
  - Abrimos la guía oficial de despliegue [flutter.dev/docs/deployment/android](https://flutter.dev/docs/deployment/android)
  - `\flutter_peliculas\android\app\build.gradle`
    - cambiamos el id de la app
    ```js
    defaultConfig {
      applicationId "com.eduardoaf.flutterpeliculas"
    
    //tambien en el manifest: 
    //flutter_peliculas\android\app\src\main\AndroidManifest.xml
    <manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.eduardoaf.flutterpeliculas">
    ```
  - Podemos manejar manualmente la versión (build.gradle)
  ```js
      versionCode flutterVersionCode.toInteger() //tenemos que incrementar cada vez que hagamos un despliegue
      versionName flutterVersionName //es lo que los usuarios ven

      versionCode 1 //debe ser siempre un entero incremental
      versionName "1.0.0"
  ```
  - Especificar la versión mínima para usar tu app (Android)
    - [min version](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/488x508/3dff617b9c91128d3c44971463074e07/image.png) 
    - Flutter corre perfectamente en la version 16 pero puede haber otras librerias que no y obligue a usar una version superior
    - 
    ```js
    minSdkVersion 16 //ver tabla
    16 = Jelly Bean android 4.1
    ```
  - Firmar la app
    - Esto va a evitar que otras personas se hagan pasar por mi
    - [create a keystore](https://flutter.dev/docs/deployment/android#create-a-keystore)
      - En windows:
      - para ejecutar el comando hay que estar en la raíz del proyecto, es decir en **flutter_peliculas/**
      - `<path-java-jdk>/keytool -genkey -v -keystore E:/private_keys/flutter/google/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key`
      - **error**:`bash: keytool: command not found`
        - keytool esta dentro del bin del jdk instalado
      - [Con esto ha funcionado](https://trello.com/c/W7Esvfng/1-generar-claves)
      - Se ha generado el fichero **key.jks**
  - El fichero [**key.properties**](https://flutter.dev/docs/deployment/android#reference-the-keystore-from-the-app)
    - `\flutter_peliculas\android\key.properties`
    ```js
    storePassword=<password from previous step>
    keyPassword=<password from previous step>
    keyAlias=key
    //la ruta debe ser con / y no con \ sino dará error
    storeFile=<location of the key store file, such as /Users/<user name>/key.jks> 
    ```
    - En gitignore: `**/android/key.properties`
  - [Configurar la firma en gradle](https://flutter.dev/docs/deployment/android#configure-signing-in-gradle)
    - En build.gradle hay que incluir:
    ```js
    def keystoreProperties = new Properties()
    def keystorePropertiesFile = rootProject.file('key.properties')
    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
    }   
    ...
    signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile file(keystoreProperties['storeFile'])
           storePassword keystoreProperties['storePassword']
       }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    } 
    ```
  - Generar la versión de producción de nuestra app
    - `flutter build apk --release`
    - Genera un fichero en: **flutter_peliculas\build\app\outputs\apk\release\app-release.apk**
    - este es el **apk firmado** 
    - Me lo ha generado de unos 12 MB
  - Pagar la suscripción a Google play
    - ![mi googleplay](https://play.google.com/apps/publish/?account=8700821796458106202#AppListPlace)
    - Comprobar si se ha generado el apk para 64 bits
    - cambiar la extensión de apk a zip (en una copia)
    - Abrimos el .zip
    - ![apk en zip](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/377x135/fbfa7bf6b8ad8a26b5c38e18bf22c0ea/image.png)
    - Se debe mostrar la carpeta: **arm64-v8a**
    - **estos pasos no son necesarios si se ha creado la carpeta arm64-v8a**
    - En build.gradle
      - [copiar este contenido](https://gist.github.com/Klerith/53147980b8f6dc3ef5bbf3ef6b7472f6)
      ```js
      afterEvaluate {
        mergeReleaseJniLibFolders.doLast {
            def archTypes = ["arm-release", "arm64-release"] //en que arquitecturas lo debe generar
            archTypes.forEach { item ->
                copy {
                    from zipTree("$flutterRoot/bin/cache/artifacts/engine/android-$item/flutter.jar")
                    include 'lib/*/libflutter.so'
                    into "$buildDir/intermediates/jniLibs/release/"
                    eachFile {
                        it.path = it.path.replaceFirst("lib/", "")
                    }
                }
            }
        }
      }
      ```
      - ![lo que hay que pegar](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/600x378/d4ff42c91272f34b14b027c271e5f746/image.png)
      - Problemas al subir
        - > Debes cambiar el tamaño de la captura de pantalla. Longitud mínima para los laterales: 320 píxeles. 
        - > Longitud máxima para los laterales: 3840 píxeles. Relación de aspecto máxima: 2:1.
        - con 320 de ancho y 640 de alto ya coge la imágen
      - ![error optimización](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/918x381/5cbd6b66d5d46d892b41e9cd084af53b/image.png)
        - > Este APK tiene códigos y recursos que no se utilizan y que se están enviando a los usuarios. Reduce el tamaño de tu aplicación con el Android App Bundle...
        - Me comentan que use este comando: [`flutter build appbundle`](https://flutter.dev/docs/deployment/android#building-the-app-for-release)
        - [uso de bundletool](https://developer.android.com/studio/command-line/bundletool)
        - Con este comando se genera el fichero en: `\flutter_peliculas\build\app\outputs\bundle\release\app.aab`
        - con esta sentencia no hace falta de comprimir el .apk, es mejor subir directamente el bundle ya que google lo optimiza
    - Despues de subir la versión he tenido que contestar todos los cuestionarios y finalmente me ha dejado publicar la versión
- 15.9. Generación y subida de la aplicación de IOS
    - Me la salto de momento
    ```dart
    ```       