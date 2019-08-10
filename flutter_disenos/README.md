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

