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
    - Cuando se crean campos es importante ponerlos dentro de alguna caja que haga scroll
    - si esto no es así, puede que se oculte el teclado
    - Login form ok
    ```dart
    //login_page.dart
    Widget _get_email_wg(BuildContext context){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(Icons.alternate_email,color: Colors.deepPurple),
            hintText: "ejemplo@correo.com",
            labelText: "Un correo electronico",
          ),
        ),
      );
    }//_get_email_wg

    Widget _get_password_wg(BuildContext context){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock_outline,color: Colors.deepPurple),
            labelText: "Contraseña",
          ),
        ),
      );
    }//_get_password_wg

    Widget _get_raisedbutton_wg(BuildContext context){
      return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text("Ingresar"),

        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        elevation: 0.0,
        color: Colors.deepPurple,
        textColor: Colors.white,
        onPressed: (){

        },
      );
    }//_get_raisedbutton_wg


    Widget _get_loginform_wg(BuildContext context){
      final size = MediaQuery.of(context).size;

      //ojo! no se usa un ListView
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[

            SafeArea(
              child: Container(
                height: 180.0,
              ),
            ),

            Container(
              width: size.width * 0.85,
              margin: EdgeInsets.symmetric(vertical: 30.0),
              padding: EdgeInsets.symmetric(vertical: 50.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0
                  )
                ]
              ),
              child: Column(
                children: <Widget>[
                  Text("Ingreso", style: TextStyle(fontSize: 20.0),),
                  SizedBox(height: 60.0,),
                  _get_email_wg(context),
                  SizedBox(height: 30.0,),
                  _get_password_wg(context),
                  SizedBox(height: 30.0,),
                  _get_raisedbutton_wg(context),
                ],
              )
            ),

            Text("¿Olvidó la contraseña?"),
            
            SizedBox(height: 100.0,),
          ],
        )
      );
    }//_get_loginform_wg    
    ```
- 11.7. LoginBloc - Controlar los campos del formulario
    - Implementando el patrón BLoC
    - Se crea clase gestora de streams de email y password
    ```dart
    //login_bloc.dart
    class LoginBloc {

      //broadcast(): permite que varios objetos escuchen e interactuen con el stream
      final _emailCtrl = StreamController<String>.broadcast();
      final _passCtrl = StreamController<String>.broadcast();

      //escuchadores
      //recuperar los datos del stream
      //hay que definir lo que saldrá del stream: Stream<String> 
      Stream<String> get emailStream => _emailCtrl.stream;
      Stream<String> get passStream => _passCtrl.stream;

      //insertar valores al stream
      //son funciones que reciben un string: Function(String)
      Function(String) get changeEmail => _emailCtrl.sink.add;
      Function(String) get changePass => _passCtrl.sink.add;  

      dispose(){
        _emailCtrl?.close();
        _passCtrl?.close();
      }

    }//class LoginBloc    
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
