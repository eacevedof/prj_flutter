## Madrid 2019/09/07 18:00

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
    - 
    ```dart
    ```
 - 15.7. Cambiar el nombre de la aplicación en el HomeScreen
    - 
    ```dart
    ```
- 15.8. Generación y subida del APK de Android
    - 
    ```dart
    ```       
- 15.9. Generación y subida de la aplicación de IOS
    - 
    ```dart
    ```       