## QR Reader Capitulo 10

#### flutter_preferencias_usuario

- 10.1. Introducción a la sección
    - Se grabarán las preferencias del usuario
    - Los datos deben ser minimos y de preferencia no estructurados
    - Token, aplicaciones seleccionadas por el usuario
    - Es equivalente a una cookie
    - El objetivo es como persistir los datos en el dispositivo
- 10.2. Temas puntuales de la sección (html)
    - Aprender cómo guardar en el storage
    - Aprender a leer del storage
    - Cómo leer información del storage antes de que la aplicación se ejecute
    - Implementar un singleton para aumentar la eficiencia del mismo.
    - Esta sección es corta, pero es vital para cualquier aplicación que necesite guardar información en el storage nativo sin usar SQLite.
- 10.3. Demostración de la aplicación - Preferencias de Usuario
    - Widget drawer
    - Cada vez que se modifica un valor se va guardando la información
    - Si termino a la app y regreso los datos se conservan
    - Se manejaran valores por defecto
    - Se verá como guardar los distintos tipos: Boolean, Entero, etc.
- 10.4. Inicio de proyecto - Preferencias de Usuario
    - Otra forma de trabajar con las rutas
    - home_page.dart
    - settings_page.dart
    ```dart
    //main.dart
    @override
    Widget build(BuildContext context) {

        return MaterialApp(
            title: 'Preferencias',
            //initialRoute: "home",
            //otra forma de enrutar
            initialRoute: HomePage.routeName,
            routes: {
                HomePage.routeName     : (BuildContext context) => HomePage(),
                SettingsPage.routeName : (BuildContext context) => SettingsPage(),
            },
        );

    }//build

    //home_page.dart
    //propiedad estática
    static final String routeName = "home";
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Preferencias de Usuario"),
            ),

            body: Column(
                children: <Widget>[
                Text("Color secundario:"),
                Divider(),
                Text("Género:"),
                Divider(),
                Text("Nombre de usuario:"),
                Divider(),
                ],
            ),
        );
    }//build

    //settings_page.dart
    //propiedad estática
    static final String routeName = "settings";

    @override
    Widget build(BuildContext context) {
        
        return Scaffold(
        appBar: AppBar(
            title: Text("Ajustes"),
        ),

        body: Center(
            child: Text("Ajustes Page"),
            )
        );

    }//build    
    ```