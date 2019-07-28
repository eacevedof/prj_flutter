# CAP 6 - flutter_componentes

- 6.3 Demostración de la aplicación (que realizaremos)
    - Listado de opciones
    - La opción de alerta (popup)
    - Fade In Image en el avatar
    - Efectos de tarjetas
    - Animated container (como hacer un clip con un vectorial)
    - Formulario con distintos inputs
    - Slider, check y switch
    - Loading en scroll de imágenes
    - Pull to refresh
- 6.4 Inicio de proyecto - Componentes
    - snippet **mateapp**
    - se creo home_temp.dart
- 6.5 Listview
    - ListViewBuilder para muchos registros
    - ListTile son como las tarjetas contenedoras
    - Divider() son las lineas de division entre los ListTile
- 6.6 Crear ListTiles a partir de una lista estática
    ```dart
    // llenar lista
    List<Widget> _crear_items(){
    List<Widget> Lista = new List<Widget>();
    for (String opt in this.opciones) {
      final oWidget = ListTile(
        title: Text(opt),
      );
      Lista..add(oWidget)..add(Divider()); 
    }
    return Lista;
    }// _crear_items
    ```
- 6.7 Método map de las listas y ListTile
    ```dart
    //crea lista con iconos que permiten hacer "click" (onTap)
    List<Widget> _crearItemsCorta() {
        return this.opciones.map((opt) {
        return Column(
            children: <Widget>[
            ListTile(
                title: Text( opt + "!"),
                subtitle: Text("Cualquier cosa"),
                leading: Icon(Icons.account_balance_wallet),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){},
            )
            ],
        ); 
        }).toList();
    }    
    ```
- 6.8 Página - HomePage
    - Se define la homepage final
    - Se crean dos metodos de lista
    - ctrl + . sugiere la creacion del método
    - st less sugiere el snippet de nueva página stateless
- 6.9 Leer un archivo JSON Local
    - Para configurar recursos externos (data/menu_opts.json)
    - fichero: pubspec.yaml
        ```yaml
        assets:
            - data/menu_opts.json
        ```
    - Presionamos F5 para que cargue el nuevo archivo
- 6.10 Convertir el JSONString en un Map
    - import y show
    - json.decode(): convierte a un objeto Map
    - Trabajando con futuros (promesas)
    - Uso de async y await
- 6.11 Future Builder 
    - Widget que permite dibujarese a si mismo basado en el último estado
    - Ejemplo future builder:
    ```dart
    Future<List<dynamic>> cargarData() async {
    final resp = await rootBundle.loadString("data/menu_opts.json");
        Map dataMap = json.decode(resp);
        //print(dataMap["rutas"]);
        opciones = dataMap["rutas"];
        return opciones;
    }

    Widget _lista() {
        //print(oMenuProvider.opciones);
        oMenuProvider.cargarData().then((opt){
            //aqui no se puede poner ListView pq si tarda mucho la respuesta pareceria que la app esta colgada
            print("_lista");
            print(opt);
        });

        return FutureBuilder(
            //future es lo que vamos a esperar
            future: oMenuProvider.cargarData(),
            //la info por defecto mientras se resuelve el future
            initialData: [],
            //el renderizador
            //tiene etapas
            builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
                //aqui se puede hacer loaders
                print("builder");
                print(snapshot.data);

                return ListView(
                    children: _listaItems(snapshot.data),
                );
            }, // builder
        ); // FutureBuilder
    } // _lista

    List<Widget> _listaItems(List<dynamic> data) {
        final List<Widget> opciones = [];

        data.forEach( (opt) {
            final oWidget = ListTile(
                title: Text(opt["texto"]),
                leading: Icon(Icons.account_circle, color: Colors.blue),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
                onTap: () {

                },
            ); // ListTile
            opciones..add(oWidget)
                    ..add(Divider());
        }); // data.foreach

        return opciones;
    } //_listaItems
    ```
- 6.12 Utilidades - Obtener ícono por strings
    - No existe un método que nos permita obtener un icono en base al string
    - icons_helper 0.0.8 es una opción pero no la recomienda Fernando
    - Realizarémos nuestro propio generador de íconos en base al string que le pasemos
    - carpeta src/utils
    - archivo: src/utils/icono_string_util.dart
    ```dart
    final _icons = <String, IconData>{
        "add_alert"       : Icons.add_alert,
        "accessibility"   : Icons.accessibility,
        "folder_open"     : Icons.folder_open,
    };

    Icon getIcon( String nombreIcono) {
        return Icon( _icons[nombreIcono], color:Colors.blue);
    }    
    ```
- 6.13 Navegar a una nueva pantalla en Flutter
    - En el onTap vamos a realizar la nevegación
    - definimos navegación
    ```dart
    class AlertPage extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
            return Scaffold(
                appBar: AppBar(
                    title: Text("Alert Page"),
                ),
                //botón de retorno
                floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add_location),
                    onPressed: (){
                        Navigator.pop(context);
                    },
                ),
            ); //Scaffold
        } // build
    } // AlertPage

    onTap: () {
        final route = MaterialPageRoute(
            builder: (context) => AlertPage()
        );

        //context: es el build context, es el que tiene la información de la navegación
        //información global de la app
        Navigator.push(context, route);
    },    
    ```
- 6.14 Navegar con rutas con nombre
    - en main.dart hay que definir las rutas
    ```dart
    // home_page.dart
    //pushNamed busca la ruta en MyApp.routes y en base a esta carga la pantalla que es un widget Scaffold
    onTap: Navigator.pushNamed(context, opt["ruta"]);

    //main.dart
    return MaterialApp(
      title: 'Componentes App',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/"     : ( BuildContext context) => HomePage(),
        "alert" : ( BuildContext context) => AlertPage(),
        "avatar": ( BuildContext context) => AvatarPage(),
      }// routes
    ); // MaterialApp
    ```
- 6.15 Rutas generadas dinámicamente y archivo de rutas independiente
    - Que hacer con una ruta que no existe
    - onGenerateRoute: Define una ruta dinámica
    - externalizando las rutas a un archivo independiente
    ```dart
    //routes.dart
    Map<String, WidgetBuilder> getApplicationRoutes() {
        return <String, WidgetBuilder>{
            "/"     : ( BuildContext context) => HomePage(),
            "alert" : ( BuildContext context) => AlertPage(),
            "avatar": ( BuildContext context) => AvatarPage(),
        };
    }// getApplicationRoutes    

    main.dart
    routes: getApplicationRoutes(),

    onGenerateRoute: ( RouteSettings settings) {
        print("Ruta llamada: ${ settings.name }");
        //página por defecto para rutas
        return MaterialPageRoute(
            builder: ( BuildContext context ) => AlertPage()
        );
    },
    ```
- 6.16 Card Widget
    - Se crea un listado de tarjetas con texto y botones
    - Se aplica icono a la tarjeta y padding
    - EdgeInsets
    ```dart
    Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_album, color: Colors.blue),
            title: Text("Soy el titulo de esta tarjeta"),
            subtitle: Text("Aqui estamos con la descripción de la tarjeta que quiero que ustedes vean para tener una idea de lo que quiero"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: (){},
              ),
              FlatButton(
                child: Text("Ok"),
                onPressed: (){},
              ),              
            ],
          )
        ],
      ),
    );    
    ```
- 6.17 Image y FadeIn Image
    - Cargar imagen con loader
    ```dart
    body: ListView(
        padding: EdgeInsets.all(10.0), //..symetric(horizontal:50.0),
        children: <Widget>[
            _cardTipo1(),
            SizedBox(height: 30.0,),
            _cardTipo2()
        ],
    ),

    Widget _cardTipo2() {
        return Card(
            child: Column(
                children: <Widget>[
                    FadeInImage(
                        image: NetworkImage("https://static.photocdn.pt/images/articles/2017_1/iStock-545347988.jpg"),
                        placeholder: AssetImage("assets/jar-loading.gif"),
                        fadeInDuration: Duration( milliseconds: 200),
                        height: 250.0,
                        fit: BoxFit.cover,
                    ),

                    //Image(
                        //image: NetworkImage("https://static.photocdn.pt/images/articles/2017_1/iStock-545347988.jpg"),
                    //),
                    Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text("No tengo idea de que poner")
                    )
                ], // <Widget> []
            )// column
        ); // Card
    }// _cardTipo2        
    ```
- 6.18 Resolviendo - The method 'forEach' was called on null
    ```dart
    //la info por defecto mientras se resuelve el future, esto se le envia al snapshot.data
    initialData: [],    
    ```
- 6.19 Personalizando el estilo de las cards
    - emulando un card de imágen
    ```dart
    return Container(
      child: ClipRRect(
        child: oContainerCard,
        borderRadius: BorderRadius.circular(30.0),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0,-10.0)
          ),
        ]
        //color: Colors.red
      ),
    );    
    ```
- 6.20 Widget - Alert
    - Personalizando un modal de alert
    ```dart
    //alert_page.dart
    body: Center(
        child: RaisedButton(
            child: Text("Mostrar Alerta"),
            color: Colors.blue,
            textColor: Colors.white,
            shape: StadiumBorder(),
            onPressed: ()=>_mostrarAlerta(context),
        ),
    ),

    ... 

    void _mostrarAlerta(BuildContext context){
        showDialog(
            context: context,
            barrierDismissible: true,//se cierra la alerta haciendo click afuera
            builder: (context){
                return AlertDialog(
                    title: Text("Titulo"),
                    content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                            Text("Contenido de la caja de la alerta"),
                            FlutterLogo(size: 100.0,)
                        ],
                    ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text("Cancelar"),
                            onPressed: ()=>Navigator.of(context).pop(),
                        ),
                        FlatButton(
                            child: Text("Ok"),
                            onPressed: ()=>Navigator.of(context).pop(),
                        )            
                    ],
                ); // AlertDialog
            } // builder
        ); //showDialog
    }// _mostrarAlerta    
    ```
- 6.21 Widget - Circle Avatar 
    - avatar_page.dart
    ```dart
    return Scaffold(
      appBar: AppBar(
        title: Text("Avatar Page"),
        actions: <Widget>[
          //icono de imágen de stanlee
          Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://americanlibrariesmagazine.org/wp-content/uploads/2015/01/StanLee.png"),
              radius: 20.0,
            ),
          ),

          //icono con SL arriba a la derecha
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text("SL"),
              backgroundColor: Colors.brown,
            ),
          ),
        ],
      ),

      body:Center(
        //Carga imágen grande de stanlee
        child: FadeInImage(
          image: NetworkImage("https://americanlibrariesmagazine.org/wp-content/uploads/2015/01/StanLee.png"),
          placeholder: AssetImage("assets/jar-loading.gif"),
          fadeInDuration: Duration(milliseconds: 200),
        ),
      )
    ); //Scaffold
    ```
- 6.22 Container y AnimatedContainer
    - Animated container
    ```dart
    // cambiar el estado
    // detecta cambios en las variables privadas y refresca la pantalla
    onPressed: (){
          setState(() { 
            _width = 80.0;
            _height = 75.0; 
            _color = Colors.lightGreen;
          });
        },    
    ```
    - darth.math
    - objeto Random()
    ```dart
    body: Center(
        child: AnimatedContainer(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
                borderRadius: _borderRadius,
                color: _color
            ),
            duration: Duration(seconds: 1), //animación (curves=animación predefinida)
            curve: Curves.fastOutSlowIn, // tipo de transición
        ),
    ),  

    void _cambiarForma(){
        final rnd = Random();

        // detecta cambios en las variables privadas y refresca la pantalla
        setState(() {
        _width = rnd.nextInt(300).toDouble();
        _height = rnd.nextInt(300).toDouble();
        _color = Color.fromRGBO(rnd.nextInt(300),rnd.nextInt(300),rnd.nextInt(300), 1);

        _borderRadius = BorderRadius.circular(rnd.nextInt(100).toDouble());
        });
    }// _cambiarForma      
    ```
    - [Curvas animadas](https://docs.flutter.io/flutter/animation/Curves-class.html)
    - https://flutter.dev/docs/cookbook/animation/animated-container
- 6.23 inputFields
    ```dart
    body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        children: <Widget>[
            _crearInput(),//devuelve TextField()
            Divider(),
            _crearPersona(),//devuelve ListTile()
        ],
    ),

    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        counter: Text("Letras ${_nombre.length}"),//texto debajo derecho
        hintText: "Nombre de la persona", //placeholder
        labelText: "Nombre",//label
        helperText: "Solo es el nombre",//texto debajo
        suffixIcon: Icon(Icons.accessibility),//icono derecho
        icon: Icon(Icons.account_circle)//icono izquierdo
      ),

      onChanged: (valor){
        setState(() {
          _nombre = valor;
          print(_nombre);          
        });
      },
    );
    ```
- 6.24 Email y Password fields
    - parecido a inputtext
    - obscureText: true, para password
    - keyboardType: TextInputType.emailAddress, para email
- 6.25 Datepicker
    ```dart
    //se necesita definir un controlador para poder mostrar el valor seleccionado
    //en el input
    _selectDate(BuildContext context) async {
        DateTime picked = await showDatePicker(
            context: context,
            initialDate: new DateTime.now(),
            firstDate: new DateTime(2018),
            lastDate: new DateTime(2025),
        );

        if (picked != null){
            setState(() {
                _fecha = picked.toString();
                _oFieldDateController.text = _fecha;
            });
        }
    }// _selectDate

    Widget _crearFecha(BuildContext context){
        return TextField(
            enableInteractiveSelection: false,
            controller: _oFieldDateController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
                ),
                hintText: "Fecha de nacimiento", //placeholder
                labelText: "Fecha de nacimiento",//label
                suffixIcon: Icon(Icons.perm_contact_calendar),//icono derecho
                icon: Icon(Icons.calendar_today)//icono izquierdo
            ),

            onTap: (){
                FocusScope.of(context).requestFocus(new FocusNode());
                _selectDate(context);
            },
        );
    }// _crearFecha    
    ```
- 6.26. Cambiar el idioma del Datepicker
    - https://flutter.dev/docs/development/accessibility-and-localization/internationalization#specifying-supportedlocales
    - https://docs.flutter.io/flutter/flutter_localizations/GlobalMaterialLocalizations-class.html
    ```dart
    //pubspec.yaml
    flutter_localizations:
        sdk: flutter
    // main.dart
    localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
    ],

    supportedLocales: [
        const Locale("en","US"),
        const Locale("es","ES"),
    ],

    //input_page.dart
    locale: Locale("es","ES"),
    ```
- 6.27 Dropdown y DropdownMenuItem
    ```dart
    List<DropdownMenuItem<String>> getOpcionesDropdown() {
        List<DropdownMenuItem<String>> lista = new List();
        _poderes.forEach((poder){
            lista.add(DropdownMenuItem(
                child: Text(poder),
                value: poder,
                //key:
            ));
        });    
        return lista;
    } // getOpcionesDropdown

    Widget _crearDropdown(){
        return Row(
        children: <Widget>[
            Icon(Icons.select_all),
            SizedBox(width: 30.0), //espacio entre icono e input
            Expanded( //expanded: hace que se ocupe todo el ancho de la pantalla
                child: DropdownButton(
                    value: _opcionSeleccionada, //valor seleccionado
                    items: getOpcionesDropdown(),//devuelve: List<DropdownMenuItem<String>>
                    onChanged: (optselected){
                        setState(() {
                            _opcionSeleccionada = optselected;
                        });
                    },
                )
            ),
        ],
        );
    }// _crearDropdown    
    ```
- 6.28 Slider
    ```dart
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: Text("Slider"),
        ),

        body: Container(
            padding: EdgeInsets.only(top:50.0),
            child: Column(
            children: <Widget>[
                _crearSlider(),
                //_crearImagen(),
                Expanded(child: _crearImagen()),
            ],
            )
        ),
        );
    }// build

    Widget _crearSlider(){
        return Slider(
        activeColor: Colors.indigoAccent,
        label: "Tamaño de la imagen",
        divisions: 10,
        value: _valorSlider,
        min:10.0,
        max:400.0,
        onChanged: (valor){
            print(valor);
            setState(() {
            _valorSlider = valor;
            });
        },
        );
    }// _crearSlider

    Widget _crearImagen(){
        return Image(
        image: NetworkImage("https://www.cinepremiere.com.mx/wp-content/uploads/2019/03/batman-logo.jpg"),
        width: _valorSlider,
        fit: BoxFit.contain,//se ajusta
        );
    }// _crearImagen    
    ```
- 6.29 Checkbox y Swiches
    ```dart
    //slider_page.dart
    //es como un radio horizontal
    Widget _crearSwitch(){
        //listtile a diferencia de checkbox a secas, permite que se haga click en toda la linea
        return SwitchListTile( 
            title: Text("Bloquear slider"),
            value: _bloquearCheck,      
            onChanged: (valor){
                setState(() {
                _bloquearCheck = valor;
                });
            },
        );
    }// _crearSwitch  

    Widget _crearCheckbox(){
        //listtile a diferencia de checkbox a secas, permite que se haga click en toda la linea
        return CheckboxListTile( 
            value: _bloquearCheck,
            title: Text("Bloquear slider"),
            onChanged: (valor){
                setState(() {
                _bloquearCheck = valor;
                });
            },
        );  
    }

    //el null bloquea el slider
    onChanged:(_bloquearCheck) ? null: (valor){
    ```
- 6.30 Listview Builder
    ```dart
    //file: listview_page.dart
    List<int> _listaNumeros = [10,20,30,40,50,60];

    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Listview Page"),
            ),
            body: _crearLista()
        );
    }// build

    Widget _crearLista(){
        return ListView.builder(
            itemCount: _listaNumeros.length,
            itemBuilder: (BuildContext context,int index){
                final imagen = _listaNumeros[index];
                return FadeInImage(
                    image: NetworkImage("https://picsum.photos/500/300/?image=${imagen}"),
                    placeholder: AssetImage("assets/jar-loading.gif"),
                );
            },
        );
    }// _crearLista
    ```
       
