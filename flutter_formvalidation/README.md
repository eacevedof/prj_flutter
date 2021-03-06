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
  //se crea utils.dart

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
  - Generador de modelos: [https://app.quicktype.io/](https://app.quicktype.io/)
  ```dart
  //file: product_model.dart
  //generador: https://app.quicktype.io/
  import 'dart:convert';

  //recibe un json en string y devuelve una instancia del modelo
  ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

  //recibe un modelo y devuelve un json
  String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

  class ProductoModel {

      String id;
      ...

      ProductoModel({
          this.id,
          ...
      });

      factory ProductoModel.fromJson(Map<String, dynamic> json) => new ProductoModel(
          id         : json["id"],
          ...
      );

      Map<String, dynamic> toJson() => {
          "id"         : id,
          ...
      };

  }//class ProductoModel
  ```
- 12.8. Conectar nuestro formulario con el modelo de producto
  - `onSaved: (value) => producto.titulo = value,`
  ```dart
  //producto_page.dart
      children: <Widget>[
      _get_field_nombre_wg(),
      _get_field_precio_wg(),
      _get_is_disponible_wg(),
      _get_button_wg(),
    ],

    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "Producto",
      ),
      //se ejecuta despues de haber validado el campo
      onSaved: (value) => producto.titulo = value,
      validator: (strvalue){    

  //aqui necesito tomar una referencia al formulario
  //en otros casos hemos usado un controlador pero Form no tiene esa posibilidad
  void _submit(){
    bool isValid = formkey.currentState.validate();
    if(!isValid) return;

    //guarda el estado de lo que hay en los inputs de modo que
    //el modelo se actualiza con estos datos
    formkey.currentState.save();
    print("todo ok");
    print("titulo:"+producto.titulo);
    print("valor:"+producto.valor.toString());
    print("disponible:"+producto.disponible.toString());

  }//_submit

  Widget _get_is_disponible_wg(){
    //check horizontal
    return SwitchListTile(
      value: producto.disponible,
      title: Text("Disponible"),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState((){
        producto.disponible = value;
      }),
    );
  }//_get_is_disponible_wg   
  ```
- 12.9. Preparar nuestra base de datos - Firebase
  - url de la bd realtime: [https://console.firebase.google.com/project/fir-flutter-db876/database/fir-flutter-db876/data](https://console.firebase.google.com/project/fir-flutter-db876/database/fir-flutter-db876/data)
  - configurar reglas: [https://console.firebase.google.com/project/fir-flutter-db876/database/fir-flutter-db876/rules](https://console.firebase.google.com/project/fir-flutter-db876/database/fir-flutter-db876/rules)
  - nodo de productos: [https://fir-flutter-db876.firebaseio.com/productos.json](https://fir-flutter-db876.firebaseio.com/productos.json)
  - documentacion fbase: [https://firebase.google.com/docs/reference/rest/database](https://firebase.google.com/docs/reference/rest/database)
- 12.10. Provider de productos
  - Ya hace insert en Firebase
  ```dart
  //pubspec.yaml
    cupertino_icons: ^0.1.2
    rxdart: ^0.22.1+1
    http: //instala la última version 
    //nos permite hacer peticiones http

  //productos_provider.dart
  class ProductosProvider{
    final String _url = "https://fir-flutter-db876.firebaseio.com";

    Future<bool> getasync_producto( ProductoModel producto) async {
      final url = "$_url/productos.json";
      final resp = await http.post(url,body:productoModelToJson(producto));
      final decodedData = json.decode(resp.body);
      print(decodedData);
    }//getasync_producto

  }//class ProductosProvider  

  //product_page.dart
  ...
    formkey.currentState.save();
    productoprov.getasync_producto(producto);
  ...
  ```
- 12.11. Cargar productos de Firebase
  - Mostrar el listado
  ```dart
  //productos_provider
  Future<List<ProductoModel>> getasync_list() async {
    final url = "$_url/productos.json";
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if(decodedData == null ) return [];
    
    decodedData.forEach((id,prod){
      final oProd = ProductoModel.fromJson(prod);
      oProd.id = id;
      productos.add(oProd);
    });

    print(productos);
    return productos;
    
  }//getasync_list  

  //home_page.dart
  final prodProv = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);    

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: _get_listado_wg(),
  ...
  Widget _get_listado_wg(){
    return FutureBuilder(
      future: prodProv.getasync_list(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if(snapshot.hasData){
          return Container();
        }
        else{
          return Center(
            child:CircularProgressIndicator(),
          );
        }
      },
    );
  }//_get_listado_wg
  ```
- 12.12. Mostrar el listado de los productos
  - Para trabajar con el borrado desde el listado hay que usar **Dismissible**
  ```dart
  //home_producto.dart
  Widget _get_item_wg(BuildContext context, ProductoModel oProd){
    //dismissible (descartable) permite el borrado
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      //cuando se ejecuta el dismissible (desaparece de pantalla) lanza este evento
      onDismissed: (direccion){
        //todo borrar producto
      },
      //Tile=teja
      child: ListTile(
        title: Text("${oProd.titulo} - ${oProd.valor}"),
        subtitle: Text(oProd.id),
        onTap: () => Navigator.pushNamed(context,"producto"),
      ),
    );
  }//_get_item_wg

  Widget _get_listado_wg(BuildContext context){
    return FutureBuilder(
      future: prodProv.getasync_list(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if(snapshot.hasData){
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context,i) => _get_item_wg(context,productos[i]),
          );
        }
        else{
          return Center(
            child:CircularProgressIndicator(),
          );
        }
      },
    );
  }//_get_listado_wg  
  ```
- 12.13. Eliminar registros de Firebase
  - prodProv.getasync_deleted(oProd.id)
  ```dart
  //home_page.dart
  Widget _get_item_wg(BuildContext context, ProductoModel oProd){
    //dismissible permite el borrado
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      //cuando se ejecuta el dismissible (desaparece de pantalla) lanza este evento
      onDismissed: (direccion){
        prodProv.getasync_deleted(oProd.id);
      },
      child: ListTile(
        title: Text("${oProd.titulo} - ${oProd.valor}"),
        subtitle: Text(oProd.id),
        onTap: () => Navigator.pushNamed(context,"producto"),
      ),
    );
  }//_get_item_wg
  ```
- 12.14. Editar un producto
  - Habria que hacer refactor de los metodos
  ```dart
  //home_page.dart
  onTap: () => Navigator.pushNamed(context,"producto", arguments:oProd),

  //producto_page.dart
    //aqui viene el dato de la otra pantalla
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if(prodData!=null){
      producto = prodData;
    }
  ...
    if(producto.id == null){
      productoprov.getasync_producto(producto);
    }
    else{
      productoprov.getasync_productoup(producto);
    }
  }//_submit

  //productos_provider.dart
  Future<bool> getasync_productoup( ProductoModel producto) async {
    final url = "$_url/productos/${producto.id}.json";
    final resp = await http.put(url,body:productoModelToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }//getasync_productoup  

  //producto_model
  Map<String, dynamic> toJson() => {
        //"id"         : id, lo excluyo para que no se duplique la información
        //es decir, se crearía un nodo: id
        "titulo"     : titulo,
        "valor"      : valor,
        "disponible" : disponible,
        "fotoUri"    : fotoUri,
  };  
  ```
- 12.15. Bloquear botón y mostrar Snackbar
  - El scaffold y el snackbar se comunican por la key del scaffold
  - la key es `final scaffoldkey = GlobalKey<ScaffoldState>();`
  - bloquear el botón: `onPressed: (_guardando) ? null:_submit,`
  ```dart
  //producto_page.dart
  return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(

  //aqui necesito tomar una referencia al formulario
  //en otros casos hemos usado un controlador pero Form no tiene esa posibilidad
  void _submit(){
    bool isValid = formkey.currentState.validate();
    if(!isValid) return;

    //guarda el estado de lo que hay en los inputs de modo que
    //el modelo se actualiza con estos datos
    formkey.currentState.save();

    setState(() {
      _guardando = true;
    });
    
    if(producto.id == null){
      productoprov.getasync_producto(producto);
    }
    else{
      productoprov.getasync_productoup(producto);
    }

    //setState(() { _guardando = false; });
    _get_snackbar_wg("registro guardado");
    //hace un redirect al listado
    Navigator.pop(context);
  }//_submit

  //el snackbar es como un alert pero en el pie
  void _get_snackbar_wg(String message){
    //se necesita la referencia al scaffoldstate
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(microseconds: 1500),
    );

    //esto muestra el snackbar en la pantalla del formulario
    scaffoldkey.currentState.showSnackBar(snackbar);

  }//_get_snackbar_wg

  ```
- 12.16. Seleccionar y mostrar una fotografía
  - [image_picker: ^0.6.1+4](https://pub.dev/packages/image_picker)
  - carpeta **assets**
  - `flutter_formvalidation\android\app\build.gradle`
  - Por norma general la versión minima para usar camara es la 21
  - `/android/app/build.gradle minSdkVersion=21`
  - Ios: `flutter_formvalidation\ios\Runner\Info.plist`
  ```dart
  //flutter_formvalidation\ios\Runner\Info.plist
	<key>NSPhotoLibraryUsageDescription</key>
	<string>Necesito acceso al carrete</string>

	<key>NSCameraUsageDescription</key>
	<string>Necesito acceso a la camara</string>

	<key>NSMicrophoneUsageDescription</key>
	<string>Quiero escucharte</string>

  //producto_page.dart
  ...
  File foto;
  ...
      return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text("Producto"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: seleccionar_foto_async,
            //onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomar_foto,
            //onPressed: (){},
          ),          
        ],
      ),
  ...

  //espacio para mostrar la fotografia
  Widget _get_foto_wg(){
    print(producto.fotoUri);
    if(producto.fotoUri != null){
      //tengo q arreglar esto
      return Container();
    }
    else{
      print("no existe imagen");
      return Image(
        //si no existe la 
        image: AssetImage(foto?.path ?? "assets/no-image.png"),
        height: 300.0,
        fit: BoxFit.cover
      );
    }

  }//_get_foto_wg

  seleccionar_foto_async() async {
    foto = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    //cancela o no selecciona
    if(foto != null){
      //limpieza
    }

    setState(() {
      
    });
  }

  _tomar_foto(){
    
  }
  ```
- 12.17. Tomar una fotografía y mostrarla en pantalla
  - Los métodos: seleccionar_foto_async y _tomar_foto_async originalmente son async pero si quito ese operador sigue funcionando. Por que??
  ```dart
  //producto_page.dart
  seleccionar_foto_async()  {
    _procesar_imagen_async(ImageSource.gallery);
  }

  _tomar_foto_async()  {
    _procesar_imagen_async(ImageSource.camera);
  }

  _procesar_imagen_async(ImageSource origen) async{
    foto = await ImagePicker.pickImage(
      source: origen,
    );
    //cancela o no selecciona
    if(foto != null){
      //limpieza
    }

    setState(() {});   
  }//_procesar_imagen_async  
  ```
- 12.18. Backend - Subir fotografías config cloudinary.com
  - Firebase cuenta con **Storage** para guardar imágenes pero no cuentan con un endpoint.  Para esto fbs usa funtions que están en node por lo tanto
  usarémos otro recurso.
  - [https://cloudinary.com/console](https://cloudinary.com/console)
  ```js
  //plan gratuito
  25 Monthly Credits
  1 Credit =
  1,000 Transformations OR
  1 GB Storage OR
  1 GB Bandwidth
  Change to:
  Plus Plan ($99 / Month)             225 Monthly Credits
  Advanced Plan ($249 / Month)        600 Monthly Credits
  Advanced Extra Plan ($549 / Month)  1,350 Monthly Credits  
  ```
  - [https://cloudinary.com/documentation/image_upload_api_reference](https://cloudinary.com/documentation/image_upload_api_reference)
  - [https://api.cloudinary.com/v1_1/<cloud_name>/<resource_type>/upload
](https://api.cloudinary.com/v1_1/<cloud_name>/<resource_type>/upload
)
  - **cloudname** ioedu
  - **resource_type** image
  - [https://cloudinary.com/console/settings/upload](https://cloudinary.com/console/settings/upload)
    - Para habilitar unsigned uploading
    - Una vez habilitado hay que configurar el endpoint así:
      - Post: [https://api.cloudinary.com/v1_1/ioedu/image/upload?upload_preset=yhzktxo0](https://api.cloudinary.com/v1_1/ioedu/image/upload?upload_preset=yhzktxo0)
      - ![https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/600x507/efe9d4fe0ee6db20fb20201cfe27abb1/image.png](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/600x507/efe9d4fe0ee6db20fb20201cfe27abb1/image.png)
- 12.19. Subir fotografía desde Flutter
  - [mime_type: ^0.2.4](https://pub.dev/packages/mime_type#-installing-tab-)
  ```dart
  //products_provider.dart
  Future<String> subir_imagen_async(File oImagen) async {

    final oUri = Uri.parse("https://api.cloudinary.com/v1_1/ioedu/image/upload?upload_preset=yhzktxo0");
    final arMimeType = mime(oImagen.path).split("/");
    print(arMimeType.toString());
    final oImageUploadReq = http.MultipartRequest("POST",oUri);
    final oFile = await http.MultipartFile.fromPath(
      "file",
      oImagen.path,
      contentType: MediaType(arMimeType[0], arMimeType[1])
    );
    
    oImageUploadReq.files.add(oFile);
    final oStreamResp = await oImageUploadReq.send();
    final oResponse = await http.Response.fromStream(oStreamResp);

    if(oResponse.statusCode != 200 && oResponse.statusCode != 201){
      print("Algo salio mal");
      print(oResponse.body);
      return null;
    }

    final respData = json.decode(oResponse.body);
    print(respData);
    return respData["secure_url"];//devuelve la url https://imagen..

  }//subir_imagen_async
  ```
- 12.20. Pruebas de carga de fotografías y actualizar registros en Firebase
  - _submit pasa a ser asincrono
  ```dart
  //producto_provider
  void _submit() async {
    bool isValid = formkey.currentState.validate();
    if(!isValid) return;

    //guarda el estado de lo que hay en los inputs de modo que
    //el modelo se actualiza con estos datos
    formkey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if(foto != null){
      producto.fotoUrl = await productoprov.subir_imagen_async(foto);
  }
  ```
- 12.21. Mostrar imágenes cargadas
  ```dart
  //home_page.dart
  Widget _get_item_wg(BuildContext context, ProductoModel oProd){
    //dismissible permite el borrado
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),

      //cuando se ejecuta el dismissible (desaparece de pantalla) lanza este evento
      onDismissed: (direccion){
        prodProv.getasync_deleted(oProd.id);
      },

      child: Card(
        child: Column(
          children: <Widget>[
            (oProd.fotoUrl == null) 
            ? Image(image: AssetImage("assets/no-image.png"))
            : FadeInImage(
                image: NetworkImage(oProd.fotoUrl),
                placeholder: AssetImage("assets/jar-loading.gif"),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover
            ),
            
            ListTile(
              title: Text("${oProd.titulo} - ${oProd.valor}"),
              subtitle: Text(oProd.id),
              onTap: () => Navigator.pushNamed(context,"producto", arguments:oProd),
            ),    
          ],
        ),
      ),
    );

  }//_get_item_wg

  //producto_page.dart
  //espacio para mostrar la fotografia
  Widget _get_foto_wg(){
    print("_get_foto_wg producto.fotoUrl:"+producto.fotoUrl.toString());
    if(producto.fotoUrl != null){
      print("producto_page._get_foto_wg: existe la imagen??");
      //tengo q arreglar esto
      return FadeInImage(
        image: NetworkImage(producto.fotoUrl),
        placeholder: AssetImage("assets/jar-loading.gif"),
        height: 300.0,
        fit: BoxFit.contain,
      );
    }
  ....
  _procesar_imagen_async(ImageSource origen) async{
    foto = await ImagePicker.pickImage(
      source: origen,
    );
    //cancela o no selecciona
    if(foto != null){
      producto.fotoUrl = null;
    }
  ```
## 13. Login y manejo de Tokens
- 13.1. Introducción a la sección
  - Continuación del login de la app anterior
  - Haremos una petición a Fbase para que nos devuelva un json webtoken
  - Con este token podremos hacer peticiones
- 13.2. Temas puntuales de la sección
  - Funcionamiento completo del login
  - Registro de nuevos usuarios
  - Firebase Auth Rest API
  - Manejo de Tokens
  - Alertas
  - Habilitar autenticación en Firebase
  - Aquí vamos a trabajar en hacer funcional nuestro login y que nuestros servicios utilicen el token que Firebase nos regresará 
- 13.3. Inicio de proyecto - Login y manejo de tokens
  - Se necesita tener una bd en Fbase
  - Se necesita al menos dos productos en la Bd
  - Explica que lineas hay que reconfigurar en caso de usar el .zip dejado por Fernando
- 13.4. Pantalla para registrar usuarios
  - Ya se puede navegar entre las pantallas de login y registro
  ```dart
  //login_page.dart
  FlatButton(
    child: Text("Crear una nueva cuenta"),
    onPressed: () => Navigator.pushReplacementNamed(context, "registro"),
  ),  
  //register_page.dart
  //copia de login_page.dart

  //main.dart
  "registro"  : (BuildContext context) => RegisterPage(),
  ```
- 13.5. Usuario Provider - Petición para crear cuentas
  - En firebase:
    - Database > Reglas >
    - se ven las reglas de acceso
    - Authentication > Método de acceso > habilitar acceso por email
    ![Firebase conf](https://trello-attachments.s3.amazonaws.com/5d658aa359dad4174c7cc48e/599x188/b47e3bcb5c979091523a65d9e4fc9643/image.png)
  - [firebase.google.com/docs/reference/rest/auth#section-create-email-password](https://firebase.google.com/docs/reference/rest/auth#section-create-email-password)
  - [firebase.google.com/docs/reference/rest/auth#section-sign-in-email-password](https://firebase.google.com/docs/reference/rest/auth#section-sign-in-email-password)
  - https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]
  - Usuario de pruebas:
    - test@test.com
    - 123456
  ```dart
  //usuario_provider.dart
  import 'dart:convert';
  import 'package:http/http.dart' as http;

  class UsuarioProvider {
    //se obtiene de: https://console.firebase.google.com/project/fir-flutter-db876/settings/general/
    final String _firebaseToken = "AIzaSyBs5xvUOzSE5aIInVBhG_DgFDRuG8Piq-4";

    Future get_nuevo_usuario_async(String email, String password) async {
      final authData = {
        "email"             : email,
        "password"          : password,
        "returnSecureToken" : true,
      };

      final url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken";
      final resp = await http.post(
          url,
          body: json.encode(authData)
        );
      
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      print(decodedResp);

    }//get_nuevo_usuario_async

  }//class UsuarioProvider
  ```
  - Dió este error: `{error: {code: 400, message: OPERATION_NOT_ALLOWED, errors: [{message: OPERATION_NOT_ALLOWED, domain: global, reason: invalid}]}}`
    - Solución: Habilitar permisos de acceso en: `https://console.firebase.google.com/project/fir-flutter-db876/authentication/providers`
    - `Correo electrónico/contraseña`
- 13.6. Usuario Provider - Login - Verificar usuario y contraseña
  - Ya se trata el login en el provider
  ```dart
  //login_page.dart
  final oUsuarioProv = new UsuarioProvider();

  //usuario_provider.dart
  Future<Map<String, dynamic>> get_login_async(String email, String password) async{
    final authData = {
      "email"             : email,
      "password"          : password,
      "returnSecureToken" : true,
    };

    final url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken";
    //print("get_nuevo_usuario_async url: "+url);
    final resp = await http.post(
        url,
        body: json.encode(authData)
    );
    
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if(decodedResp.containsKey("idToken")){
      return {"ok":true, "token":decodedResp["idToken"]};
    }
    return {"ok":false, "token":decodedResp["error"]["message"]};
  }  
  ```
- 13.7. Grabar Token en el storage del dispositivo
  - https://gist.github.com/Klerith/8f6c75db4fb0696f6cdd5852b377b1e1
  - **siempre que hay preferencias de usuario el main tiene que ser async**
  ```dart
  ///pubspec.yaml
  //preferencias_usuario (desde el link)

  //usuario_provider.dart
    if(decodedResp.containsKey("idToken")){
      _prefs.token = decodedResp["idToken"];
      return {"ok":true, "token":decodedResp["idToken"]};
    }
    return {"ok":false, "token":decodedResp["error"]["message"]};  

  //main.dart
  //paso main a async
  void main() async {
    final prefs = new PreferenciasUsuario();
    //crea una instancia de shared_preferences en prefs._prefs
    await prefs.initPrefs(); 
    runApp(MyApp());
  }
  ```
- 13.8. Mostrar alerta cuando el usuario es incorrecto
  - Crear **alert** en utils.dart
  - En caso de error muestra un alert y si todo es ok se va a la home
  ```dart
  //login_page.dart
  _login(LoginBloc bloc, BuildContext context) async {
    Map info = await oUsuarioProv.get_login_async(bloc.email, bloc.password);

    if(info["ok"]){
      Navigator.pushReplacementNamed(context,"home");
    }
    else{
      alert(context,info["mensaje"]);
    }
  }
  //register_page.dart
  _register(LoginBloc bloc, BuildContext context) async {
    Map info = await oUsuarioProvider.get_nuevo_usuario_async(bloc.email, bloc.password);

    if(info["ok"]){
      Navigator.pushReplacementNamed(context,"home");
    }
    else{
      alert(context,info["mensaje"]);
    }
  }
  //utils.dart
  void alert(BuildContext context, String msg){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Warning !!"),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              //cerramos la alerta
              onPressed: () => Navigator.of(context).pop()
            )
          ],
        );
      }
    );
  }//void alert(      
  ```
- 13.9. Usar token para validar peticiones en Firebase
  - En firebase:
    - https://console.firebase.google.com/project/fir-flutter-db876/database/fir-flutter-db876/rules
    - En reglas, publicar
  - como tarea estaria bien agregar una comprobacion en main.dart para saber si ya estoy autorizado o no e ir directamente a la pantalla home
  - En la sección de preferencias de usuario esta el ejercicio resuelto.
  ```dart
  //productos_provider.dart
    final _oUserPrefs = new PreferenciasUsuario();
  ...
  //crearProducto
  Future<bool> getasync_producto( ProductoModel producto) async {
    final url = "$_url/productos.json?auth=${_oUserPrefs.token}";
  
  //editarProducto
  Future<bool> getasync_productoup( ProductoModel producto) async {
    final url = "$_url/productos/${producto.id}.json?auth=${_oUserPrefs.token}";    

  //eliminarProductos
  Future<int> getasync_deleted(String id) async {
    final url = "$_url/productos/$id.json?auth=${_oUserPrefs.token}";
  ...  
  ```       
## 14. Detalles finales de la aplicación de productos
- 14.1. Introducción a la sección
  - Es una continuación del 13
  - Se trabajará con el patron BloC
- 14.2. Temas puntuales de la sección
  - El objetivo central de la aplicación, es utilizar un Bloc para el manejo de los productos en lugar de hacer los llamadas directamente del Provider mediante FutureBuilders.
- 14.3. Inicio del proyecto - Detalles finales productos
  - Probamos el acceso despues de adaptar el repo de Fernando
- 14.4. ProductosBloc
  - Se crea los metodos crud apoyados en streams
  ```dart
  //productos_bloc
  ```
- 14.5. Añadir un segundo Bloc a mi inheritedWidget
  - El provider es de tipo inheritedwidget que es como una caja de resonancia que permite a sus hijos escuchar los cambios por eso es el widget padre del resto
  - Está dentro de **MyApp.build**
  ```dart
  //bloc/provider.dart
  static ProductosBloc get_prod_bloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._productosBloc;
  }
  ```    
- 14.6. Utilizando nuestro ProductosBloc
  - Ya se carga el home usando los streams
  ```dart
  //productos_provider.dart
  //tratando caducidad del token, se devuelve un array vacio pero se podria devolver un 
  //mensaje de error
  if(decodedData["error"] != null) return [];

  //home_page.dart
  final prodBloc = Provider.get_prod_bloc(context);
  prodBloc.cargar_productos_async();

  //esto pasa de un future builder a un streambuilder
  Widget _get_listado_wg(ProductosBloc oProdBloc){
    return StreamBuilder(
      stream: oProdBloc.get_productos_stream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if(snapshot.hasData){
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _get_item_wg(context, oProdBloc, productos[i]),
          );
        }
        else{
          return Center(
            child:CircularProgressIndicator(),
          );
        }
      },
    );
  }//_get_listado_wg

  //productos_bloc.dart
  cambio los nombres de los metodos añadiendo sufijo async

  //me está dando este error:
  Launching lib\main.dart on Android SDK built for x86 64 in debug mode...
  Built build\app\outputs\apk\debug\app-debug.apk.
  Package install error: Failure [INSTALL_FAILED_DEXOPT]
  Error launching application on Android SDK built for x86 64.
  Exited (sigterm)
  //solución
  He tenido que cerrar todo vscode, android y he actualizado los plugins
  de android studio
  ```    
- 14.7. ProductosBloc para actualizar y crear productos
  - Detalle del producto
  - Pruebas de que todo funciona, pero ahora con Bloc
  ```dart
  //producto_page
  ProductosBloc productosBloc;
  ...
  productosBloc = Provider.get_prod_bloc(context);
  ...

  if(foto != null){
    producto.fotoUrl = await productosBloc.subir_foto_async(foto);
  }
  
  if(producto.id == null){
    productosBloc.agregar_producto_async(producto);
  }
  else{
    productosBloc.editar_producto_async(producto);
  }
  ``` 
        