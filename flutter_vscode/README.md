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


