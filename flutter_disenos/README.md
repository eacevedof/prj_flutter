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
    - se deja con overflow vertical en el Scaffold que se solucionará en el sig video
    
