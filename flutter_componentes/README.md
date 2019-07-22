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
    - Clase chunga, no me entero... :S  Tengo que repetirla

