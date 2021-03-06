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
- 10.5. Drawers - Crear un menú lateral
    - Drawer para crear menú en home_page.dart
    - Pinta el icono de hamburguesa
    - #boton hamburguesa
    - child: listview, ya que permite hacer scroll
    - ListTile: Li
    ```dart
    //home_page.dart
    Drawer get_menu_wg(BuildContext context){

    //esto ya muestra el botón hamburguesa
    return Drawer(
      //listview permite hacer scroll
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/menu-img.jpg"),
                fit: BoxFit.cover
              )
            ),

          ), //DrawerHeader

          //opciones de menu
          ListTile(
            leading: Icon(Icons.pages, color: Colors.blue),
            title: Text("Home"),
            onTap: ()=>Navigator.pushReplacementNamed(context, HomePage.routeName),
          ),// listile:home

          ListTile(
            leading: Icon(Icons.party_mode, color: Colors.blue),
            title: Text("Party Mode"),
            onTap: (){},
          ),// listile:party mode

          ListTile(
            leading: Icon(Icons.people, color: Colors.blue),
            title: Text("People"),
            onTap: (){},
          ),// listile:people

          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue),
            title: Text("Settings"),
            onTap: (){
              //debe mover el navigator a la pantalla de settings
              //cuando sucede esto aparece la flecha de retorno en el appBar y si hacemos click
              //entonces se muestra el ListView y no debería ser así.
              //Habría que cerrar el menú
              //La idea es que la página de destino se vea como pag principal
              
              //Navigator.pop(context); //cierra el ListView
              //Navigator.pushNamed(context, SettingsPage.routeName);

              //con esta linea se consigue la nav como pag principal pero se pierde la "hamburguesa"
              Navigator.pushReplacementNamed(context, SettingsPage.routeName);
              
            },
          ),// listile:settings          

        ],

      ),
    );

    }// get_menu_wg  
    ```
- 10.6. Crear un widget independiente para el drawer
    - Se centraliza la funcion get_menu_wg en un widget
    - Se crea nuevo widget: menu_widget.dart
    - Este widget devuelve un Drawer
    - Se asigna a la propiedad drawer de cada "_page.dart" de modo que en la navegación dibuje la "hamburguesa"
    ```dart
    import 'package:flutter/material.dart';
    import 'package:flutter_preferencias_usuario/src/pages/home_page.dart';
    import 'package:flutter_preferencias_usuario/src/pages/settings_page.dart';

    class MenuWidget extends StatelessWidget {
    
    @override
    Widget build(BuildContext context) {
        return Drawer(
        //listview permite hacer scroll
        ...
    }//build
    ```
- 10.7. Diseño de la página de los ajustes
    - Si deseo cargar en el TextField un valor por defecto no lo puedo hacer directamente
    - Tengo que crear un controller TextEditingController
    - Esto no es posible `<input value="valor por defecto">` utilizando una variable string
    - En la propiedad controller: _oTextContrl, del TextField se asigna el controlador que gestionará el valor
    - Creo que para componentes complejos, como una caja de texto, se necesita un gestor (controlador) ya que tiene que tener en cuenta distiontos tipos de entrada
    ```dart
    //control "check horizontal"
    SwitchListTile(
      value: true,
      title: Text("color secundario"),
      onChanged: (isTrue){
        setState(() {
          _colorSecundario = isTrue;
        });
      },
    ),

    Divider(),

    RadioListTile(
      value: 1, 
      title: Text("Masculino"),
      groupValue: _genero, //variable que agrupa los radios
      onChanged: (iValue){
        setState(() {
          _genero = iValue; 
        });
      },
    ),

    RadioListTile(
      value: 2, 
      title: Text("Femenino"),
      groupValue: _genero, //variable que agrupa los radios
      onChanged: (iValue){
        setState(() {
          _genero = iValue; 
        });
      },
    ),

    Divider(),

    Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: _oTextContrl,
        decoration: InputDecoration(
          labelText: "Nombre",
          helperText: "Nombre de la persona usando el teléfono"
        ),
        onChanged: (sChanged){
          setState(() {
            _nombre = sChanged; 
          });
        },
      ),
    ),    
    ```
- 10.8. Shared Preferences
  - [share_preferences 0.5.2](https://pub.dev/packages/shared_preferences#-installing-tab-)
  - Donde se guardará:
    - En ios NSUserDefaults
    - En Android: SharedPreferences
  - Queda pendiente la gestion de escritura en preferencias sin tener que crear un método para cada "control" de entrada ni utilizar un streambuilder o un futurebuilder
  - En principio la app ya cumple su cometido. Guardar en prefs.
  ```dart
  //no podemos hacer initState como async
  void initState() {
    super.initState();
    _get_selected_radio();
    _oTextContrl = new TextEditingController(text: _nombre);

  }//initState

  _get_selected_radio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _genero = prefs.getInt("genero");
    setState(() {
      
    });
  }

  _set_selected_radio(int iValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("genero", iValue);
    _genero = iValue;
    setState(() {});       
  }  
  ```
- 10.9. Clase para manejar las preferencias del usuario
  - Se crea clase singleton para leer las preferencias de modo global
  - La intención es guardar la última pagina que el usuario visitó
  - Con el patrón singleton tendremos solo una instancia de prefs 
  ```dart
  //preferencias_usuario.dart
  class PreferenciasUsuario {
    
    static final PreferenciasUsuario _oSelf = new PreferenciasUsuario._internal();

    factory PreferenciasUsuario(){
      return _oSelf;
    }//PreferenciasUsuario

    PreferenciasUsuario._internal(){;}

    SharedPreferences _prefs;

    initPrefs() async {
      this._prefs = await SharedPreferences.getInstance();
    }

    bool _colorSecundario;
    int _genero;
    String _nombre;

    get genero {return _prefs.getInt("genero")??1;}
    set genero (int iValue) {_prefs.setInt("genero",iValue);}

  }//class PreferenciasUsuario

  //main.dart
  void main() async {
    //cargo las preferencias
    final prefs = new PreferenciasUsuario();
    //devuelve un future
    await prefs.initPrefs();
    runApp(MyApp());
  }

  //home.dart
  Widget build(BuildContext context) {  
    final prefs = new PreferenciasUsuario();
    ...
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Color secundario:"),
          Divider(),
          Text("Género: ${prefs.genero}"),    
  ```
- 10.10. Clase para manejar las preferencias del usuario
  - Se configuran los otros atributos de preferencias y se pintan los valores en home_page
  ```dart
  //settings_page.dart
  //se quita "cargarPef()" (_get_selected_radio()) ya no es necesario
  //control "check horizontal"
  SwitchListTile(
    value: _colorSecundario,
    title: Text("color secundario"),
    onChanged: (isTrue){
      setState(() {
        //si comento todo esto no se actualiza la pantalla
        _colorSecundario = isTrue;//modif en pantalla
        prefs.colorsecundario = isTrue;//modif en el storate
      });
    },
  ),

  Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: TextField(
      controller: _oTextContrl,
      decoration: InputDecoration(
        labelText: "Nombre",
        helperText: "Nombre de la persona usando el teléfono"
      ),
      //cada tecla se presiona dispara este evento
      onChanged: (sChanged){
        prefs.nombre = sChanged;
      },
    ),
  ),

  //home_page.dart
  body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text("Color secundario: ${prefs.colorsecundario}"),
      Divider(),
      Text("Género: ${prefs.genero}"),
      Divider(),
      Text("Nombre de usuario: ${prefs.nombre}"),
      Divider(),
    ],  

  ```
- 10.11. Última página abierta
  - Se crea un atributo ultima_pagina en PrefenciasUsuario
  - Ya guarda la última pantalla, para esto se asigna a prefs la última ruta
  ```dart
  //preferencias_usuario.dart
  get ultima_pagina {return _prefs.getString("ultima_pagina") ?? "home";}
  set ultima_pagina (String sValue) {_prefs.setString("ultima_pagina",sValue);}

  //settings_page.dart
  @override
  //no podemos hacer initState como async
  void initState() {
    super.initState();
    prefs.ultima_pagina = SettingsPage.routeName;
  //home_page.dart
  Widget build(BuildContext context) {
    
    final prefs = new PreferenciasUsuario();
    prefs.ultima_pagina = HomePage.routeName;  
  ```