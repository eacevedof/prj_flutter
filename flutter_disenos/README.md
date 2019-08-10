## 8 Diseños en Flutter
- 8.1 (126) Introducción
    - Separar un diseño y convertirlo en Widgets 
    - Container, Rows, Columns
    - Fernando hará una versión del código que hay en la web de Flutter
    - Si se desea seguir practicando el diseño de las apps hay mucho material
        - Pinterest, Applabs etc
- 8.3. (128) Demostración de la aplicación - Diseños en Flutter
    - App 1: hacer scroll y regresar arriba
    - App 2: Diseño app de clima con pantalla de dashboard
    - Button Navigation Bar
- 8.4. (129) Explicación del diseño en Flutter
- 8.5. Inicio de proyecto - Diseños
    - vscode snippet meteapp
- 8.6. Diseño básico - parte 1
    ```dart
    //basico_page.dart
    div.padding  => Container( padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
    Column => tiene como hijos widgets que son filas => childs: <tr>
    Row => tiene como hijos widgets que son columnas => childs: <td>
    crossAxisAlignment: CrossAxisAlignment.start  => align-contet: left
    Expanded => div.widht = 100%
    SizedBox(height: 6.0,) => <span></span>
    TextStyle(fontSize: 20.0, fontWeight:FontWeight.bold) => font-size:20; font-weight:bold; 
    Image(image: NetworkImage("https://www.xtravelperu.com/wp-content/uploads/2016/12/machupicchu-santa-teresa.jpg"),), => <img href=>
    ```
- 8.7 Diseño básico - parte 2
    - basico_page.dart
    - vscode: Extensión Lorem Ipsum
    - Al Text no se le puede aplicar padding, para esto hay que envolverlo en un Container
    - Row: mainAxisAlignment: MainAxisAlignment.spaceEvenly, Distribuye de forma homogenea los iconos (los anchos de los <td>)
    - se deja con overflow vertical en el widget Column que se solucionará en el sig video (con un SingleChildScrollView)
- 8.8. Diseño básico - parte 3
    - SingleChildScrollView sirve para que permita hacer scroll
    - Ojo con las rotaciones y el nodge (de los iphone)
    - Recoloca imágen:
        - height: 180.0,
        - fit: BoxFit.cover  
    - SafeArea para evitar que el nodge se coma información
    - Fin diseño 1
- 8.9. Diseño con scroll - parte 1
    - Se define assets
    ```dart
    //scroll_page.dart
    return Scaffold(
      body: PageView(
        //esto permite hacer scroll de arriba hacia abajo, por defecto 
        //el desplazamiento es horizontal
        scrollDirection: Axis.vertical,
    ...
    ```
- 8.10. Diseño con scroll - parte 2
    - Componente Stack, permite solapar widgets
    ```dart
    Widget _get_color_fondo_wg() {
        return Container(
        width: double.infinity, //todo el ancho posible
        height: double.infinity, //todo el alto posible
        color: Color.fromRGBO(108,192,218,0.5),//0.5 semi-transparente
        );
    }  //_get_color_fondo_wg

    Widget _get_img_fondo_wg() {
        return Container(
        width: double.infinity, //todo el ancho posible
        height: double.infinity, //todo el alto posible
        child: Image(
            image: AssetImage("assets/img/scroll-1.png"),
            //image: AssetImage("assets/scroll-1.png"),
        ),
        );
    }  //_get_img_fondo_wg

    Widget _get_textos_wg() {
        final estiloTexto = TextStyle(color: Colors.white, fontSize:50.0);
        
        return SafeArea(
        child: Column( 
            children: <Widget>[
            SizedBox(height: 20.0,),
            Text("11º",style: estiloTexto,),
            Text("Miercoles",style: estiloTexto,),
            //expanded: estira el widget al ancho o alto posible
            Expanded(
                child: Container(),
            ),
            Icon(Icons.keyboard_arrow_down, size:70.0, color: Colors.white),
            ],
        ),
        );
    }  //_get_textos_wg      
    ```
- 8.11. Diseño con scroll - parte 3
    ```dart
    Widget _get_pagina2_wg() {
        return Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromRGBO(108,192,218,0.5),//0.5 semi-transparente
        child: Center(
            child: RaisedButton(
            shape: StadiumBorder(),
            color: Colors.blue,
            textColor: Colors.white,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Text("Bienvenidos", style: TextStyle(fontSize: 20.0),),
            ),
            onPressed: () {

            }
            )
        )
        );
    }// _get_pagina2_wg
    ```
- 8.12. Diseño compuesto - Fondo, Rotación y Gradientes
    - botones_page.dart
    ```dart
    Widget _get_fondo_wg(){
        final gradiente = Container(
            width: double.infinity,
            height: double.infinity,

            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset(0.0,0.6),
                    end: FractionalOffset(0.0,1.0),
                    colors: [
                        Color.fromRGBO(52,54, 101, 1.0),
                        Color.fromRGBO(35,37, 57, 1.0),
                    ]
                )
            ),
        );

        //permite rotación
        final cajaRosa = Transform.rotate(
            angle: -pi / 4.0,
            child:Container(
                height: 300.0,
                width: 300.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: LinearGradient(
                        colors: [
                            Color.fromRGBO(230, 98, 188, 1.0),
                            Color.fromRGBO(241, 142, 172, 1.0),
                        ],
                    ),
                ),
            ),
        );

        return Stack(
            children: <Widget>[
                gradiente,
                //es como la posicion absoluta en css
                Positioned(
                    top: -100.0,
                    child: cajaRosa,
                ),
            ],
        );
    }// _get_fondo_wg
    ```
- 8.13. Diseño compuesto - Statusbar y títulos
    ```dart
    //main.dart
    //colores del statusbar: Barra con el reloj, bateria, señal wifi etc
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white
    ));

    //botones_page
    //build(..)
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _get_fondo_wg(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _get_titulos_wg()
              ],
            ),
          ),
        ],
      )
    ); 

    Widget _get_titulos_wg(){
    //salva el nodge
    return SafeArea(
        child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
                //alinea el texto desde la izquierda
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Text("Classify transaction", style: TextStyle(color: Colors.white,fontSize: 30.0, fontWeight:FontWeight.bold)),
                    SizedBox(height: 10.0,),
                    Text("Classify this transaction into a particular category", style: TextStyle(color:Colors.white,fontSize: 18.0,)),
                ],
                ),
            ),
        );
    }// _get_titulos_wg   
    ```
- 8.14. Diseño compuesto - BottomNavigationBar
    - Para personalizar la barra de navegación se necesita tocar el "theme"
    - Se crea un Theme donde se importa los datos del Theme actual y es ahi donde se personaliza
    ```dart
    //botones_page.dart
    bottomNavigationBar: _get_bottom_navbar(context),
    ... 
    Widget _get_bottom_navbar(BuildContext context){
        //la única forma de customizar el BottomNavigationBar implica
        //cambiar el tema global de la app
        return Theme(
            data: Theme.of(context).copyWith(
                //fondo de la barra
                canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
                primaryColor: Colors.pink,
                textTheme: Theme.of(context).textTheme.copyWith(
                //color del icono en gris por defecto
                caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0))
                ),
            ),//data
            child: BottomNavigationBar(     
                items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.calendar_today, size: 30.0,),
                        title: Container(),
                    ),

                    BottomNavigationBarItem(
                        icon: Icon(Icons.bubble_chart, size: 30.0),
                        title: Container(),
                    ),

                    BottomNavigationBarItem(
                        icon: Icon(Icons.supervised_user_circle, size: 30.0),
                        title: Container(),
                    ),     
                ],
            ),//child
        );//Theme
    }// _get_bottom_navbar
    ```
- 8.15. Diseño compuesto - Table y TableRow
    - Barra con botones (dash de botones)
    ```dart
    //botones_page.dart
    Widget build(BuildContext context) {
    
        return Scaffold(
        body: Stack(
            children: <Widget>[
            _get_fondo_wg(),
            SingleChildScrollView(
                child: Column(
                children: <Widget>[
                    _get_titulos_wg(),
                    _get_botones_redondeados(),
                ],

    Widget _get_botones_redondeados(){
        //se podría hacer con rows de 2 columnas pero tambien con un Table
        //Los TableRow deben de tener la misma cant de elementos
        return Table(
            children: [
                TableRow(
                    children: [
                        _get_boton_redondeado_wg(),
                        _get_boton_redondeado_wg(),
                    ],
                ),
                TableRow(
                    children: [
                        _get_boton_redondeado_wg(),
                        _get_boton_redondeado_wg(),
                    ],
                ),
                TableRow(
                    children: [
                        _get_boton_redondeado_wg(),
                        _get_boton_redondeado_wg(),
                    ],
                ),   
                TableRow(
                    children: [
                        _get_boton_redondeado_wg(),
                        _get_boton_redondeado_wg(),
                    ],
                ),               
            ],
        );
    }// _get_botones_redondeados

    Widget _get_boton_redondeado_wg(){
        return Container(
            height: 180.0,
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(62, 66, 107, 0.7),
                borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                SizedBox(height: 5.0,),
                CircleAvatar(
                    backgroundColor: Colors.pinkAccent,
                    radius: 35.0,
                    child: Icon(Icons.swap_calls,color:Colors.white,size: 30,)
                ),
                Text("cosas", style: TextStyle(color: Colors.pinkAccent),),
                SizedBox(height: 5.0,)
                ],
            ),
        );
    }//_get_boton_redondeado_wg
    ```

