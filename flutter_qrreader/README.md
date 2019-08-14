## QR Reader Capitulo 9
- 9.4. Inicio de proyecto - QRScanner
- 9.5. BottomNavigationBar - QRScanner
    - No se puede hacer una navegación por páginas en un StatelessWidget
    - Tenemos que transformar a un StatefulWidget (con estado)
    - Se hace que la barra de navegación envie su posición y en base a esta se devuelva la pág correspondiente
    ```dart
    //home_page.cart
    class _HomePageState extends State<HomePage> {

        int iCurrPage = 0;  

        @override
        Widget build(BuildContext context) {
        
            return Scaffold(      
            body: _get_page_wg(iCurrPage),
            bottomNavigationBar: _get_bottom_navbar(),
            );

        }//build

        Widget _get_bottom_navbar(){

            return BottomNavigationBar(
            //que posicion de botón está activa (se colorea en azul)
            currentIndex: iCurrPage, 

            onTap: (index){
                setState(() {
                iCurrPage = index; 
                });
            },
            
            items: [
                BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text("Mapas"),
                ),

                BottomNavigationBarItem(
                icon: Icon(Icons.brightness_1),
                title: Text("Direcciones"),
                ),
            ],//los botones
                
            );

        }//_get_bottom_navbar

        Widget _get_page_wg(int iPagActual){
            switch(iPagActual){
                case 0: return MapasPage();
                case 1: return DireccionesPage();
                default: return MapasPage();
            }
        }//_get_page_wg
        
    }// HomePage
    ```
- 9.6. FloatingActionButton y tema de la aplicación
    ```dart
    //main.dart
    //tema centralizado
    theme: ThemeData(
        primaryColor: Colors.orange
    )    

    //home_page.dart
    return Scaffold(      
      appBar: AppBar(
        title: Text("QR Scanner"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){
              //borrara todos los regs
            },
          )
        ],
      ),

      body: _get_page_wg(iCurrPage),
      bottomNavigationBar: _get_bottom_navbar(),

      //boton naranja en el medio
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: (){

        },
        //esto se relaciona con main.dart y la propiedad theme
        backgroundColor: Theme.of(context).primaryColor,
      ),  
    )  
    ```
- 9.7. Leer un código QR
    - https://pub.dev/packages/qrcode_reader
    - Instalar paquete qrcode_reader 0.4.4
    - pubscpec.yaml
    - Me estaba dando error: Flutter MissingPluginException error
      - Para solucionarlo tuve que ejecutar: flutter upgrade 
      - Limpiar la maq virtual (wipe data)
      - Reiniciar vscode
      - Volver a ejecutar
    - Generador qr: https://www.qrcode.es/es/generador-qr-code/
    ```dart
    //home_page.dart
        //boton azul en el medio que ejecuta el scanner de QR
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.filter_center_focus),
          onPressed: scan_qr,
          //esto se relaciona con main.dart y la propiedad theme
          backgroundColor: Theme.of(context).primaryColor,
        ),

      );

    }//build

    void scan_qr() async {
      //lee el qr y lo transorma en el sitio web
      //theframework.es
      //geo:40.64717223609042,-73.96886244257814
      print("scan_qr");
      String futreString = "";
      try {
        //con el await esperamos un string de lo contrario esperariamos un Future
        futreString = await new QRCodeReader().scan();
      }catch(e){
        futreString = e.toString();
      }

      print("scan_qr.futurestring: $futreString");
      if(futreString!=null)
        print("Tenemos Información");

    }//scan_qr    
    ```
- 9.8. Modelo para manejar los Scans
  - https://app.quicktype.io/ generador de modelo
  - se genera modelo usando quicktype.io
  ```dart
  //scan_model.dart
  class ScanModel {
    int id;
    String tipo;
    String valor;

    ScanModel({
        this.id,
        this.tipo,
        this.valor,
    });

    factory ScanModel.fromJson(Map<String, dynamic> json) => new ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
    };
  }//class ScanModel  
  ```
- 9.9. Inicio de configuración de SQFLite
  - Instalación de: https://pub.dev/packages/sqflite
  - Instalación de pathprovider: https://pub.dev/packages/path_provider
    - Detecta donde está el archivo de sqlite
  - creacion de db_provider.dart
    - Clase singleton que devuelve una conexión a la bd en modo asincrono
  ```dart
  class DbProvider{
    static Database _objDb;
    static final DbProvider objDbProv = DbProvider._();
    DbProvider._();
    Future<Database> get database async {
      if(_objDb != null) return _objDb;
      _objDb = await initDB();
      return _objDb;
    }//database
    initDB() async {
      return;
    }
  }//DbProvider
  ```
- 9.10. SQFLite - CREATE Table y Database
  ```dart
  //db_provider.dart
  initDB() async {
    Directory pathDbFolder = await getApplicationDocumentsDirectory();
  
    final pathFile = join(pathDbFolder.path, "scandb.db");
  
    return await openDatabase(
      pathFile, version: 1, onOpen: (db){}, 
      onCreate:(Database db, int version) async {
        String sql = """
        CREATE TABLE scans (
          id INTEGER PRIMARY KEY,
          tipo TEXT, 
          valor TEXT
        )
        """;
        await db.execute(sql);
      }
    );

  }//initDB  
  ```
- 9.11 SQFLite - Crear registros
  ```dart
  //db_provider.dart
    //crear registros
  nuevoScanRaw(ScanModel oScanModel) async {
    final db = await database;
    String sql = """
    INSERT INTO scans (id, tipo, valor)
    VALUES (${oScanModel.id},'${oScanModel.tipo}','${oScanModel.valor}')
    """;
    final res = await db.rawInsert(sql);
    return res;
  }

  nuevoScan(ScanModel oScanModel) async {
    final db = await database;
    final res = db.insert("scans", oScanModel.toJson());
    return res;
  }
  ```
- 9.12. SQFLite - Obtener registros
  - metodos de lectura por id y por *
  ```dart
  //db_provider.dart
  //obtener datos
  Future<ScanModel> getScanId(int id) async {
    final db = await database;
    final res = await db.query("scans", where: "id=?",whereArgs: [id]);
    //devuelve una lista de mapas
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;   
  }

  Future<List<ScanModel>> getScanAll(int id) async {
    final db = await database;
    final res = await db.query("scans");
    //devuelve una lista de mapas
    List<ScanModel> list = res.isNotEmpty 
                              ? res.map((c) => ScanModel.fromJson(c)).toList()
                              : [];
    return list;
  }

  Future<List<ScanModel>> getScanTipo(String tipo) async {
    final db = await database;
    String sql = """
    SELECT * FROM scans WHERE tipo='$tipo'
    """;
    final res = await db.rawQuery(sql);
    List<ScanModel> list = res.isNotEmpty 
                              ? res.map((c) => ScanModel.fromJson(c)).toList()
                              : [];
    return list;
  }  
  ```
- 9.13. SQFLite - Actualizar registros
  ```dart
  //db_provider.dart
  //actualizar registros
  Future<int> updateScan(ScanModel oScanModel) async {
    final db = await database;
    //devuelve la cantidad de registros actualizados
    final res = await db.update("scans", oScanModel.toJson(),where: "id = ?",whereArgs: [oScanModel.id]);
    return res;
  }
  ```
- 9.14. SQFLite - Borrar registros
  - consulta delete
  ```dart
  //db_provider.dart
  Future<int> deleteScanAll() async {
    final db = await database;
    //devuelve la cantidad de registros actualizados
    final sql = """DELETE FROM scans""";
    final res = await db.rawDelete(sql);
    return res;
  }  
  ```
- 9.15. Grabando el Scan en base de datos
  - Ya inserta pero no se refresca el listado automaticamente
  - El refersco automático se verá en la prox clase
  ```dart
  //db_provider.dart
  //exporta el modelo en los archivos que usan db_provider
  export 'package:flutter_qrreader/src/models/scan_model.dart';

  //home_page.dart
    String futureString = "http://theframework.es";

    if( futureString != null){
      final oScanModel = ScanModel(valor:futureString);
      DbProvider.oDb.nuevoScan(oScanModel);
    }
  
  //mapas_page.dart
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScanModel>>(
      future: DbProvider.oDb.getScanAll(),
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        final scans = snapshot.data;
        if(scans.length == 0){
          return Center(child: Text("No hay info"),);
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => ListTile(
            leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor),
            title: Text(scans[i].valor),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          ),
        );

      },
    );
  }//build 
  ```
- 9.16. Borrar registros de la base de datos
  - Dismissible
  - key: UniqueKey(),
  ```dart
  //mapas_page.dart
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScanModel>>(
      future: DbProvider.oDb.getScanAll(),
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        final scans = snapshot.data;
        if(scans.length == 0){
          return Center(child: Text("No hay info"),);
        }

        return ListView.builder(
          itemCount: scans.length,
          //permite deslizar hacia izq o derecha, en el listado cada item ahora tendrá
          //una flecha que indica q se puede deslizar y aparentemente desaparece de la lista
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(), //obligatorio, se necesita aportar un key
            background: Container(color: Colors.red), //al deslizar aparecerá el fondo en rojo
            //se le pasa la dirección: izq o derecha
            onDismissed: (direction) =>
              //esto devuelve un future y se podría poner el await 
              // no hace falta llamar a refresh ^^
              DbProvider.oDb.deleteScan(scans[i].id),
            //esto es el item en forma de "row" o mejor dicho, "tarjeta row"
            child: ListTile(
              leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor),
              title: Text(scans[i].valor),
              subtitle: Text("ID: ${scans[i].id}"),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }// build  
  ```
- 9.17. ScanBloc - Usando Streams
  - Refrescando el listado
  - Nuevo bloc/scans_bloc.dart
  ```dart
  //scans_bloc.dart clase singleton
  class ScansBloc {
    static final ScansBloc _singleton = new ScansBloc._internal();

    factory ScansBloc(){
      return _singleton;
    }//factory ScansBloc

    ScansBloc._internal(){   

    }//._internal

    final _oStrmController = StreamController<List<ScanModel>>.broadcast();

    Stream<List<ScanModel>> get scansStream => _oStrmController.stream;

    dispose(){
      _oStrmController?.close();
    }

  }//class ScansBloc
  ```
- 9.18. Métodos para controlar el flujo de información
  - Los eventos suelen ir en otro archivo, esta vez harémos una excepción ya que estos, en este ejemplo son muy sencillos
  ```dart
  //scans_bloc.dart
  //por norma general estos eventos deberían ir en otro archivo (events.dart por ejemplo)
  obtenerScans() async {
    _oStrmController.sink.add(await DbProvider.oDb.getScanAll());
  }

  //puede que agregar tarde un poco más, ya que es escritura por lo tanto 
  //para asegurarnos que obtenerscans se ejecute despues de nuevoScan hay que aplicar
  //async y await
  agregarScan(ScanModel oScanModel) async {
    await DbProvider.oDb.nuevoScan(oScanModel);
    //tengo que avisarle al stream que hay un nuevo registro
    obtenerScans();
  }

  borrarScan(int id) async {
    await DbProvider.oDb.deleteScan(id);
    obtenerScans();
  }

  borrarScanAll() async {
    await DbProvider.oDb.deleteScanAll();
    //_oStrmController.sink.add([]); este seria equivalnete
    obtenerScans();
  }  
  ```
- 9.19. Actualizando los widgets mediante streams
  - Actualiza el listado y borra todos los elementos
  - Queda pendiente el loader del principio
  ```dart
  //home_page.dart
  class _HomePageState extends State<HomePage> {

  //como el provider se usa en el bloc, se quita esa importación ya que no
  //deberiamos usarlo aqui
  final scansBloc = new ScansBloc();
  ...
    appBar: AppBar(
    title: Text("QR Scanner"),
    actions: <Widget>[
      IconButton(
        //icono papelera
        icon: Icon(Icons.delete_forever),
        onPressed: scansBloc.borrarScanAll,
      )
  ...
    if( futureString != null){
      final oScanModel = ScanModel(valor:futureString);
      //esto funciona pero no notifica al stream que ha habido cambios y por ende
      //que se refresquen las pantallas que estan escuchando
      //DbProvider.oDb.nuevoScan(oScanModel);
      scansBloc.agregarScan(oScanModel);
    }
  
  //mapas_page.dart
  class MapasPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    //ya no necesito un futurebuilder sino un streambuilder
    //return FutureBuilder<List<ScanModel>>(
    return StreamBuilder<List<ScanModel>>(
      //no debemos usar el dbprovider ya que ahora se gestiona por el stream
      //future: DbProvider.oDb.getScanAll(),
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        ...
        return ListView.builder(
          ...    
          //ya no necesito un futurebuilder sino un streambuilder
          //return FutureBuilder<List<ScanModel>>(
          return StreamBuilder<List<ScanModel>>(
            //no debemos usar el dbprovider ya que ahora se gestiona por el stream
            //future: DbProvider.oDb.getScanAll(),
            stream: scansBloc.scansStream,
  ...
  ```
- 9.20. Package url_launcher
  - Instalar url_launcher 5.0.2
  - https://pub.dev/packages/url_launcher
  ```dart
  //utils.dart
  import 'package:flutter_qrreader/src/models/scan_model.dart';
  import 'package:url_launcher/url_launcher.dart';

  abrir_scan(ScanModel oScanModel) async {

    if(oScanModel.tipo == "http")
    {
      if (await canLaunch(oScanModel.valor)){
        await launch(oScanModel.valor);
      }
      else{
        throw "could not launch ${ oScanModel.valor }";
      }
    }
    else
    {
      print("geo");
    }
  }

  //home_page.dart
  //solo para IOS:
  if (Platform.isIOS){
    Future.delayed(Duration(microseconds: 750),(){
      u.abrir_scan(oScanModel);
    });
  }
  else 
    u.abrir_scan(oScanModel);

  //mapas_page.dart
  //on tap tarjeta go scan.valor (url)
  onTap: (){
    u.abrir_scan(scans[i]);
  },
  ```
- 9.21. Página para desplegar un mapa
  - Navegacion a otra pantalla
  - Creacion de mapa_page.dart
  ```dart 
  //utils.dart
  //se cambia la función y ahora recibe el context de modo que se pueda navegar
  {
    Navigator.pushNamed(context, "mapa", arguments: oScanModel);
  }

  //home_page.dart
  onPressed: () => scan_qr(context),

  //mapa_page.dart
  final ScanModel oScan = ModalRoute.of(context).settings.arguments;

  body: Center(
    child: Text(oScan.valor),
  )
  ```
- 9.22. Mapbox - Generar Token para crear un mapa
  - https://account.mapbox.com/
  - https://pub.dev/packages/flutter_map (flutter_map 0.7.0+2)
  - temp token: pk.eyJ1IjoiaW9lZHUiLCJhIjoiY2p6YTdwMWdnMDBubTNnbzVvcHBpNHpocSJ9.RG-89XIV8LGViG-XaB5Jdg
- 9.23. Crear un mapa en Flutter
  - https://docs.mapbox.com/api/search/#forward-geocoding
  - import "package:latlong/latlong.dart";

  ```dart
  //scan_model.dart
  LatLng getLatLng(){
    final lalo = valor.substring(4).split(",");
    final lat = double.parse(lalo[0]);
    final lng = double.parse(lalo[1]);

    return LatLng(lat, lng);
  }

  //mapa_page.dart
  ...
     body:_crear_fluttermap(oScan),
    );//scaffold

  }//build

  Widget _crear_fluttermap(ScanModel oScan){
    return FlutterMap(
      options: MapOptions(
          center: oScan.getLatLng(),
          zoom: 10,
      ),
      //capas de información que se quiere poner
      layers: [
        _get_mapbox_map() //primer layer mapa 
        //segundo layer marcadores
      ],
    );
  }//_crear_fluttermap

  _get_mapbox_map(){
    return TileLayerOptions(
      urlTemplate: "https://api.tiles.mapbox.com/v4/"
                    //2x: doble de resolucion
                    //z: zoom
                    "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
      additionalOptions: {
        "accessToken":"pk.eyJ1IjoiaW9lZHUiLCJhIjoiY2p6YTdwMWdnMDBubTNnbzVvcHBpNHpocSJ9.RG-89XIV8LGViG-XaB5Jdg",
        "id": "mapbox.streets"
      }
    );
  }//_get_mapbox_map
  ```
- 9.24. Bonus Tipos de mapas
  - Otras vistas que admite el mapa
  ```dart
        "id": "mapbox.streets"
        //streets, dark, light, outdoors, satellite  
  ```
- 9.25. Crear marcadores
  - MarkerLayerOptions
  ```dart
  //mapa_page.dart
  _get_marked_layer_options(ScanModel oScan){
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: oScan.getLatLng(),
          builder: (context) => Container(
            //color: Colors.red, fondo del marcador
            child: Icon(
              Icons.location_on,
              size: 70.0,
              color:Theme.of(context).primaryColor
            ),
          ),//builder
        ),
      ],
    );
  }//_get_marked_layer_options  
  ```
- 9.26. Mover a un punto el mapa
  ```dart
  //mapa_page.dart
  final MapController map = new MapController();
  ...
  IconButton(
    icon: Icon(Icons.my_location),
    onPressed: (){
      map.move(oScan.getLatLng(),15);
    },
  )
  ...
  Widget _crear_fluttermap(ScanModel oScan){
    return FlutterMap(
      mapController: map,
      options: MapOptions(
          center: oScan.getLatLng(),
  ```
- 9.27. Cambiar tipo de mapa de forma dinámica
  ```dart
  //por esta variable necesito un statefulwidget
  String strtipomapa = "streets";
    
  //mapa_page.dart
  Widget _get_float_button(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        if(strtipomapa == "streets")
          strtipomapa = "dark";
        else if (strtipomapa == "dark")
          strtipomapa = "light";
        else if (strtipomapa == "light")
          strtipomapa = "outdoors";
        else if (strtipomapa == "outdoors")
          strtipomapa = "satellite";
        else 
          strtipomapa = "streets";

        setState(() {
          
        });
      },
    );
  }//_get_float_button
  ```
- 9.28. Uso de mixins para los streams
  - corrección del loading infinito al principio
  - refrescar mixins
  ```dart
  //mapas_page.dart
  //ejecuta el stream controller y corrige el loader infinito
  scansBloc.obtenerScans();

  //nuevo archivo:
  //validators_bloc
  class Validators {
    //StreamTransformer<lista de entrada (scans), lista de salida transformada (sink)>
    final validarGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
      
      handleData: (scans, sink){
        final geoScans = scans.where((s)=>s.tipo == "geo").toList();
        sink.add(geoScans);
      }//handleData

    );//fromHandlers

    final validarHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
        
        handleData: (scans, sink){
          final geoScans = scans.where((s)=>s.tipo == "http").toList();
          sink.add(geoScans);
        }//handleData

      );//fromHandlers
  }//class Validators

  //scans_bloc.dart
  //mixins
  class ScansBloc with Validators {
    ...
    Stream<List<ScanModel>> get scansStream => _oStrmController.stream.transform(validarGeo); //validarGeo:StreamTransformer
    Stream<List<ScanModel>> get scansStreamHttp => _oStrmController.stream.transform(validarHttp);
  ```


