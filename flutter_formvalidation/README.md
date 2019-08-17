## 11. Validación de formularios - Patrón Bloc

#### flutter_formvalidation

- 11.1. Introducción a la sección
    - Crearemos un form login
    - campo usuario, contraseña
    - transformacion de streams
    - validacion de contraseña incorrecta
    - Login atractivo
    - Más adelante usarémos el widget form para validar el form que es más sencilla
- 11.3. Demostración de la aplicación que haremos en esta sección
    - No es una sección sencilla
    - Se recomienda haber visto los otros videos anteriores sobre BLoC
- 11.3.1 01-Demostracion de la aplicacion que haremos en esta seccion.mp4
    - Mientras escribimos se va validando
    - Si la contraseña cumple con 6 chars ya habilita el botón
- 11.4. Inicio de proyecto - FormulariosBloc
    - vscode: mateapp
    ```dart
    //home_page.dart
    //login_page.dart
    ```
- 11.5. Diseño del fondo de pantalla del login
    - Se define parte del diseño, concretamente el de la chincheta y el nombre
    ```dart
    //login_page.dart
    Widget _get_fondo_wg(BuildContext context){
      final size = MediaQuery.of(context).size;

      final fondomorado = Container(
        height: size.height * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color> [
              Color.fromRGBO(63, 63, 15, 1.0),
              Color.fromRGBO(90, 70, 178, 1.0),
            ]
          )
        ),
      );
    
      final circulo = Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)
        ),
      );

      return Stack(
        children: <Widget>[
          fondomorado,
          //permite aplicar una coordenada de posicion
          Positioned(top:90.0,left: 30.0,child:circulo),
          Positioned(top:-40.0,right: -30.0,child:circulo),
          Positioned(bottom:-50.0,right: -10.0,child:circulo),
          Positioned(bottom:120.0,right: -20.0,child:circulo),
          Positioned(bottom:-50.0,left: -20.0,child:circulo),
          
          Container(
            padding: EdgeInsets.only(top: 80.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.person_pin_circle, color:Colors.white, size:100.0),
                SizedBox(height: 10.0, width: double.infinity,),
                Text("Fernando Herrera", style: TextStyle(color: Colors.white, fontSize: 25.0),)
              ],
            ),
          ),
        ],
      );

    }//_get_fondo_wg     
    ```
- 11.6. Diseño de la caja del login y los campos
    - 
    ```dart
    ```
- 11.7. LoginBloc - Controlar los campos del formulario
    - 
    ```dart
    ```
- 11.8. InheritedWidget
    - 
    ```dart
    ```
- 11.9. Conectar los inputs con los Streams
    - 
    ```dart
    ```
- 11.10. StreamTransformer y Validaciones
    - 
    ```dart
    ```
- 11.11. Combinar Streams
    - 
    ```dart
    ```
- 11.12. Obtener el último valor emitido por un stream
    - 
    ```dart
    ```
- 11.13. Mantener la data de los streams después de un hot reload
    - 
    ```dart
    ```
