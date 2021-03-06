# prj_flutter

> Este repo contiene pruebas generales de concepto de Flutter <br/>
> También incluyo ejercicios del curso realizado en Udemy

- Hay que configurar las variables de entorno y los plugins de Android Studio

## [Tutorial: Flutter: Tu guía completa de desarrollo para IOS y Android](https://www.udemy.com/flutter-ios-android-fernando-herrera/learn/lecture/14532352?start=15#overview)

## Indice
- [1. Introducción]()
    - Falta readme.md
    - No hay prácticas
- [2. Introducción a Dart]()
    - Falta readme.md
    - Son nociones báscias del lenguaje. No realicé ningún ejercicio.
- [3. Instalación de Flutter, equipos virtuales y equipos físicos]()
    - Pendiente de hacer un readme.md, es muy extenso el contenido
- [4. Introducción a Flutter]()
    - Falta readme.md
    - Caracteristicas del lenguaje. Imports, Widgets, etc
- [5. Hola Mundo y Aplicación contador *](https://github.com/eacevedof/prj_flutter/tree/master/flutter_vscode)
- [6. Componentes de Flutter *](https://github.com/eacevedof/prj_flutter/tree/master/flutter_componentes#cap-6---flutter_componentes)
- [7. Aplicación de películas *](https://github.com/eacevedof/prj_flutter/tree/master/flutter_peliculas#cap-7---flutter_peliculas)
- [8. Diseños en Flutter *](https://github.com/eacevedof/prj_flutter/tree/master/flutter_disenos#8-dise%C3%B1os-en-flutter)
- [9. QRScanner - SQLite *](https://github.com/eacevedof/prj_flutter/tree/master/flutter_qrreader#qr-reader-capitulo-9)
- [10. Preferencias de usuario *](https://github.com/eacevedof/prj_flutter/tree/master/flutter_preferencias_usuario#qr-reader-capitulo-10)
- [11. Validación de formularios - Patrón Bloc *](https://github.com/eacevedof/prj_flutter/tree/master/flutter_formvalidation#11-validaci%C3%B3n-de-formularios---patr%C3%B3n-bloc)
- [12. CRUD hacia servicios REST, uso de cámara y galería de imágenes *](https://github.com/eacevedof/prj_flutter/tree/master/flutter_formvalidation#12-crud-hacia-servicios-rest-uso-de-c%C3%A1mara-y-galer%C3%ADa-de-im%C3%A1genes) 
- [13. Login y manejo de Tokens *](https://github.com/eacevedof/prj_flutter/tree/master/flutter_formvalidation#13-login-y-manejo-de-tokens)
- [14. Detalles finales de la aplicación de productos *](https://github.com/eacevedof/prj_flutter/tree/master/flutter_formvalidation#14-detalles-finales-de-la-aplicaci%C3%B3n-de-productos)
- [15. Despliegue en Google PlayStore y Apple AppStore *](https://github.com/eacevedof/prj_flutter/tree/master/flutter_deploy_googleapple#15-despliegue-en-google-playstore-y-apple-appstore)
- [16. Bonus - Push notifications *](https://github.com/eacevedof/prj_flutter/tree/master/flutter_pushnotifications#16-bonus---push-notifications)
- [17. Despedida del curso]()

## Errores:
- He tenido este error:
    - the selected avd is currently running in the emulator
    - Solución: eliminar **C:\Users\<usuario>\.android\avd\nexus-5x-api22-lollipop-motog2.avd\hardware-qemu.ini.lock**
- Excepción en esta linea:
    - image: AssetImage("assets/no-image.png")
    - Solución: comprobar que la imágen con ese nombre existe
    - Hay que hacer un hot restart para que se copien nuevamente los ficheros, eso a veces provoca que se cuelgue la maquina virtual