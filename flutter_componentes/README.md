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
    





