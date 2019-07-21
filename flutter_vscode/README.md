# flutter_vscode

- Página: Layout que ocupa todo el espacio del móvil
- En dart es costumbre usar el _ para nombre de ficheros: home_page.dart
- Un widget **scaffold** es una plantilla de página completa (como una activity pero con su boton cabecera y menú lateral)
- 5.8 Organizando dentro del layout
    - Alineando con columnas 
    - Aplicando el estilo al texto
- 5.9 Botón flotante - FloatingActionButton
    - Usando la clase Icon en el botón
    - Aplico evento onPressed
- 5.10 Tarea - Cambiar la ubicación del FloatingActionButton
    - `floatingActionButtonLocation: FloatingActionButtonLocation.startTop,`
- 5.11 Contador problema del StatelessWidget
    - Se define un atributo final conteo
    - No se puede modificar al hacer click en el botón + ya que da un error porque se asume que es una constante
- 5.12 StatefulWidget
    - Se crea contador_page que es un statefulwidget
    - Sus atributos son ahora privados "_"
    - Se crea clase privada con "_"
        - `class _ContadorPageState extends State<ContadorPage>`
    - Uso de setState para refrescar la pantalla
    - Nota: `$'this._conteo'` no va. Hay que cambiarlo por `_conteo` sin `this`
    ```dart
    setState(() {
        this._conteo++;
        });
    ```
- 5.13 Creando más acciones en nuestro contador 
    - Se desacopla la creación de botones en floatingActionButton
    - Función privada _crearBotones
    - Se define un array de acciones. (botones 0, -, +)
    - Alineando en el eje X con Row(...)
    ```dart
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 30),
        FloatingActionButton(child: Icon(Icons.exposure_zero), onPressed: null,),
        Expanded(child: SizedBox(width: 5.0)),
        FloatingActionButton(child: Icon(Icons.remove), onPressed: null,),
        SizedBox(width: 5.0,),
        FloatingActionButton(child: Icon(Icons.add), onPressed: null,),
      ],
    );
    ```
- 5.14 Implementar funcionalidad de los botones
    - Se desacoplan las acciones en metodos privados
    - Las acciones solo actualizan el atributo `_conteo`
    - Estos métodos se asignan en **onPressed** de cada FloatingActionButton correspondiente
- 5.15 Resumen
    - Lo más complicado es el refactor del Stateless al Stateful
    - El stateful solo publica la clase tipo State
    - Parece que Flutter es una mezcla de objetos del DOM llevados a clases que solo se puede interactuar con estos usando programación
    
