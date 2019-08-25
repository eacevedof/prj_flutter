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
    - En la siguiente lección se vera como gestionar información global según Flutter.
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
    - Hasta ahora lo haciamos con el patrón singleton
    - Flutter recomienda el uso de InheretedWidget
    - Es algo como Redux
    - El context sería como el DOM
    - El MaterialApp es el nodo principal (nivel superior) del "DOM"
    ```dart
    //provider.dart
    //Widget con gestor de streaming
    class Provider extends InheritedWidget {
      //instancia única del gestor de streaming
      final loginBloc = LoginBloc();

      //constructor
      Provider({Key key, Widget child}) : super(key: key, child:child);

      @override
      //en el 99% de los casos debe devolver true
      bool updateShouldNotify(InheritedWidget oldWidget) => true;

      //va a buscar en el DOM (context) y devolverá la instancia de este "LoginBloc"
      static LoginBloc of (BuildContext context){
        //va a buscar un Provider en el DOM, una vez que lo encuentre devuelve el loginBloc (que es el gestor de streaming)
        return (context.inheritFromWidgetOfExactType(Provider) as Provider).loginBloc;
      }
    }//class Provider

    //main.dart
    Widget build(BuildContext context) {
      //devuelve un widget gestor de streaming de tipo: InheritedWidget
      return Provider(

        child: MaterialApp(
          //deshabilitar franja de banner
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: "login",
          routes: {
            "login" : (BuildContext context) => LoginPage(),
            "home"  : (BuildContext context) => HomePage(),
          },
        ),

      );//Provider
    }//build    
    ```
- 11.9. Conectar los inputs con los Streams
    - Se conectará los LoginBloc atributos con los inputs
    - Con el provider se publica en lo más alto (es decir, a nivel global) los streams
    - vscode: strBuilder
    - Para escuchar los cambios ahora necesitamos el Widget Streambuilder en este widget, se configura el stream correspondiente
    - Con esta técnica podemos redibujar el widget sin la necesidad de setState
    - De momento estamos escuchando el stream y no el valor. Más adelante se verá.
    ```dart
    //provider.dart
    export "package:flutter_formvalidation/src/bloc/login_bloc.dart";   

    //login_page.dart
    Widget _get_loginform_wg(BuildContext context){
      final bloc = Provider.of(context);
    ...    
    Widget _get_email_wg(LoginBloc bloc){
      
      return StreamBuilder(
        stream: bloc.emailStream ,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email,color: Colors.deepPurple),
                hintText: "ejemplo@correo.com",
                labelText: "Un correo electronico",
                counterText: snapshot.data,
              ),
              onChanged: bloc.changeEmail, //el primer argumento se pasará al primer argumento de changeEmail
            ),

          );
        },
      );

    }//_get_email_wg

    Widget _get_password_wg(LoginBloc bloc){

      return StreamBuilder(
        stream: bloc.passStream ,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline,color: Colors.deepPurple),
                labelText: "Contraseña",
                counterText: snapshot.data,
              ),
              onChanged: bloc.changePass,
            ),
          );
        },
      );
    
    }//_get_password_wg    

    //main.dart
    theme: ThemeData(
      //el color de los label y las lineas limite de las cajas de texto
      primaryColor: Colors.purple,
    )    
    ```
- 11.10. StreamTransformer y Validaciones
    - En el onchange del input se asigna el stream que gestionará los cambios sobre este.  El valor recibido se escribirá con .add en el stream.
    - Antes de retornar lo que hay en el stream (.stream) se validará el texto y se agregará esa validación al stream
    - En el builder de los inputs se recibirán los datos del stream en la variable **snapshot**
    ```dart
    //validators.dart
    //streamTransformer público
    final validarPass = StreamTransformer<String,String>.fromHandlers(
      handleData: (password, sink){
        if (password.length>= 6){
          //es válido y q continue el pass
          sink.add(password);
        }
        else{
          sink.addError("más de 6 caracteres por favor");
        }
      }
    );
    
    final validarEmail = StreamTransformer<String,String>.fromHandlers(
      handleData: (email, sink){
        Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = new RegExp(pattern);
        if(regExp.hasMatch(email)){
          sink.add(email);
        }
        else
        {
          sink.addError("email incorrecto");
        }
      }
    );  

    //login_bloc.dart
    Stream<String> get emailStream => _emailCtrl.stream.transform(validarEmail);
    Stream<String> get passStream => _passCtrl.stream.transform(validarPass);

    //login_page.dart
    Widget _get_email_wg(LoginBloc bloc){
      return StreamBuilder(
        stream: bloc.emailStream ,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email,color: Colors.deepPurple),
                hintText: "ejemplo@correo.com",
                labelText: "Un correo electronico",
                counterText: snapshot.data,
                errorText: snapshot.error,
              ),
              onChanged: bloc.changeEmail, //el primer argumento se pasará al primer argumento de changeEmail
            ),    
    
    Widget _get_password_wg(LoginBloc bloc){
      return StreamBuilder(
        stream: bloc.passStream ,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline,color: Colors.deepPurple),
                labelText: "Contraseña",
                counterText: snapshot.data,
                //errorText: "no es un dato válido"  //si hay texto se pone rojo si es null se queda en su color
                errorText: snapshot.error,    

    ```
- 11.11. Combinar Streams
    - rxdart
    - https://pub.dev/packages/rxdart#-installing-tab-
    - https://rxmarbles.com/#combineLatest  ^^
    - combineLatestStream<T,R> es como un concatenador de datos
    - Los combineLatest no trabajan con StreamControllers en su lugar
    usan BehaviorSubject
    ```dart
    //pubspec.yaml
    rxdart: ^0.22.1+1

    //login_bloc.dart
    //se cambia los controllers por behaviours y streams por observables
    final _emailCtrl = BehaviorSubject<String>();
    final _passCtrl = BehaviorSubject<String>();

    //(e,p) es el resultado del email y password. Si hay datos en ambos streams deseo retornar un true en caso contrario regresaria null
    Stream<bool> get formValidStream => Observable.combineLatest2(emailStream, passStream, (e,p)=>true);

    //insertar valores al stream
    //son funciones que reciben un string: Function(String)
    Function(String) get changeEmail => _emailCtrl.sink.add;
    Function(String) get changePass => _passCtrl.sink.add;

    //login_page.dart (boton)
    Widget _get_raisedbutton_wg(BuildContext context, LoginBloc bloc){
      //formValidStream
      //snapshot.hasData
      //true ? algo si true:
      return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
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
            //null desactiva el botón
            onPressed: snapshot.hasData ? () {} :null,
          );
        },
      );

    }//_get_raisedbutton_wg    
    ```
- 11.12. Obtener el último valor emitido por un stream
    - No interesa el valor propio de la caja de texto sino el último valor emitido por los streams
    - Si se hace un hot-reload se pierde el dato del stream
    ```dart
    //login_bloc.dart
    //obtener el último valor ingresado a los streams
    String get email => _emailCtrl.value;
    String get password => _passCtrl.value;    
    
    //login_page.dart
    ...
          //null desactiva el botón
          onPressed: snapshot.hasData ? () => _login(bloc, context) :null,
    ...
    _login(LoginBloc bloc, BuildContext context){
      
      print("============");
      print("Email: ${bloc.email}");
      print("Passwrod: ${bloc.password}");
      //Navigator.pushNamed(context,"home"); //mantinene la flecha de retorno
      Navigator.pushReplacementNamed(context,"home");
    }    

    //home_page.dart
    Widget build(BuildContext context) {
      final bloc = Provider.of(context);

      return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("email: ${bloc.email}"),
            Divider(),
            Text("password: ${bloc.password}"),
          ]
        ),
      );
    }//build    
    ```
- 11.13. Mantener la data de los streams después de un hot reload
    - La información se pierde cuando se refresca la pantalla porque cada vez que se recarga, se devuelve el **Provider** (que es un **InheritedWidget**) que al no ser un singleton se carga con los valores por defecto. Es decir la propiedad loginBloc se limpia.
    - La solución no pasa por hacer del 
    ```dart
    //provider.dart
    class Provider extends InheritedWidget {

      static Provider _instancia;

      factory Provider({Key key, Widget child}){
        if(_instancia == null){
          _instancia = new Provider._internal(key: key, child: child);
        }
        return _instancia;
      }

      //constructor interno que evita que se cree una instancia desde afuera
      Provider._internal({Key key, Widget child})
          : super(key:key, child:child);
      
      //instancia única
      final loginBloc = LoginBloc();

      //constructor, no procede, ahora es singleton
      //Provider({Key key, Widget child}) : super(key: key, child:child); 
    ```

## 12. CRUD hacia servicios REST, uso de cámara y galería de imágenes
- 12.1. Introducción a la sección
  - Se trabajara con Firebase
  - Se usará el REST API para hacer el CRUD
  - Trabajaremos con la cámara 
  - Usaremos la galería de fotos del teléfono
  - Subiremos ficheros
  - Leeremos el mimetype
  - Adjuntaremos desde la galería de imágenes
- 12.3. Demostración de la aplicación - CRUD
  - Ejemplo de una ejecución de subida a firebase
  - Se llenará un formulario
  - Las imágenes se subirán a [cloudinary.com](https://cloudinary.com/)
  - creo cuenta en cloudinary.com
- 12.4. Inicio de proyecto - CRUD
  - Es la continuación del proyecto de login (sección 11)
- 12.5. Diseño de la pantalla de detalle de producto
  - Se crea formulario con campos Producto y precio
  - Botón guardar
  - No hace nada de momento. Solo es diseño
  ```dart
  //main.dart
  //nueva ruta producto

  //producto_page.dart
  //botones galeria y foto
  Form()
  TextFormField()
  keyboardType: TextInputType.numberWithOptions(decimal: true), //teclado numerico decimal

  //home_page.dart
  //floating button que navega a la pantalla producto
  onPressed: () => Navigator.pushNamed(context, "producto"),
  ```
- 12.6. Validación de formularios - FormWidget
  - atributo validator de TextFormField
  - para trabajar con el form se debe usar un statefulwidget
  ```dart
  //producto_page.dart
  //definiendo así la variable se informa a Flutter que 
  //esta representa a la config del formulario
  final formkey = GlobalKey<FormState>();

  ...
        child: Form(
        key: formkey,//el id del formulario

  //aqui necesito tomar una referencia al formulario
  //en otros casos hemos usado un controlador pero Form no tiene esa posibilidad
  void _submit(){
    bool isValid = formkey.currentState.validate();
    if(!isValid) return;
    print("todo ok");
  }//_submit
  ```
- 12.7. Modelo para manejar los productos
  - 
  ```dart
  ```
- 12.8. Conectar nuestro formulario con el modelo de producto
  - 
  ```dart
  ```
- 12.9. Preparar nuestra base de datos - Firebase
  - 
  ```dart
  ```
- 12.10. Provider de productos
  - 
  ```dart
  ```
- 12.11. Cargar productos de Firebase
  - 
  ```dart
  ```
- 12.12. Mostrar el listado de los productos
  - 
  ```dart
  ```
- 12.13. Eliminar registros de Firebase
  - 
  ```dart
  ```
- 12.14. Editar un producto
  - 
  ```dart
  ```
- 12.15. Bloquear botón y mostrar Snackbar
  - 
  ```dart
  ```
- 12.16. Seleccionar y mostrar una fotografía
  - 
  ```dart
  ```
- 12.17. Tomar una fotografía y mostrarla en pantalla
  - 
  ```dart
  ```
- 12.18. Backend - Subir fotografías
  - 
  ```dart
  ```
- 12.19. Subir fotografía desde Flutter
  - 
  ```dart
  ```
- 12.20. Pruebas de carga de fotografías y actualizar registros en Firebase
  - 
  ```dart
  ```
- 12.21. Mostrar imágenes cargadas
  - 
  ```dart
  ```