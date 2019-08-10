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

