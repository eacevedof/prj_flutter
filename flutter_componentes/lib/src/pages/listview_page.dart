import 'dart:async';

import 'package:flutter/material.dart';

class ListviewPage extends StatefulWidget {
  @override
  _ListviewPageState createState() => _ListviewPageState();
}// ListviewPage

class _ListviewPageState extends State<ListviewPage> {
  
  //observador del scroll al que le podemos preguntar la posicion 
  ScrollController _oScrollController = new ScrollController();
  List<int> _listaNumeros = new List();
  int _ultimoItem = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _agregar10();
    //se disparará cada vez que se haga el scroll
    _oScrollController.addListener((){
      //si la pos actual es de x pixeles y lo máximo permitido por el scroll es x se agregan 10
      if(_oScrollController.position.pixels == _oScrollController.position.maxScrollExtent){
        //_isLoading=true, refresca, despues de 2 segundos llama a respuestaHTTP
        //respuestaHTTP: _isLoading=false, reposiciona el scroll para ver siguiente imagen
        //llama a:_agregar10() que actualiza la variable _listaNumeros y fuerza un refresco
        //que lanza el método build que a su vez ejecuta _crearLista()
        //recupera de _listaNumeros[index] el num de imagen para hacer la petición y la muestra
        fetchData(); 
      }
    });
  }// initState

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listview Page"),
      ),
      //stack apila los elementos unos sobre otros, permite la solapación
      body: Stack(
        children: <Widget>[
          _crearLista(),//devuelve un ListView.builder(...)
          _crearLoading(), //devuelve una columna con el widget del circular solo si el flag loading=true
        ],
      ),
    );
  }// build

  @override
  //es como un destructor. Si no se define este método cada vez que se entre en un
  //listview se crearia un nuevo oScrollController sin ser liberado nunca
  void dispose(){
    super.dispose();
    _oScrollController.dispose();
  }//dispose

  Widget _crearLista(){

    //RefreshIndicator es el icono de rueda que aparece en twitter al refrescar el timeline
    return RefreshIndicator(

      onRefresh: obtenerPagina1,//debe devolver un Future

      child: ListView.builder(
        //permite identificar el estado del scroll
        controller: _oScrollController,
        itemCount: _listaNumeros.length,
        //no se como hace flutter para cargar los siguientes al último index y no repetir la
        //carga de todo. Solo se me ocurre que recorra los nuevos items pero donde guarda el estado anterior?
        itemBuilder: (BuildContext context,int index){
          final imagen = _listaNumeros[index];
          return FadeInImage(
            image: NetworkImage("https://picsum.photos/500/300/?image=$imagen"),
            placeholder: AssetImage("assets/jar-loading.gif"),
          );
        },
      ),// child

    );

  }// _crearLista

  Future<Null> obtenerPagina1() async {
    final oDuration = new Duration(seconds: 2);
    new Timer(oDuration, () {
      _listaNumeros.clear(); //borro todo el array
      //_ultimoItem++;
      _agregar10();
    });
    return Future.delayed(oDuration);
  }// obtenerPagina1

  void _agregar10(){
    for(var i=0; i<10; i++){
      _ultimoItem++;
      _listaNumeros.add(_ultimoItem);
    }
    //refresca el componente
    setState(() {
    });
  }// _agregar10

  Future fetchData() async {
    _isLoading = true;
    //con esto se le indica que refresque la pantalla ya que ha cambiado _isLoading y puede que afecte
    //en la visualizacion
    setState(() {});
    final oDuration = new Duration(seconds: 2);
    //respuestaHTTP, llama a _agregar10
    return new Timer(oDuration, respuestaHTTP);
  }// fetchData

  void respuestaHTTP(){
    _isLoading = false;

    _oScrollController.animateTo(
      //mueve el scroll hacia abajo de modo que se pueda ver que hay una siguiente imágen
      _oScrollController.position.pixels + 100,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 250)
    );

    _agregar10();

  }// respuestaHTTP

  Widget _crearLoading(){
    if(_isLoading){
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end, //abajo del todo
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator() //loader
            ],
          ),
          SizedBox(height: 15.0,)
        ],
      );
    }//if is_loading

    return Container();
  }// _crearLoading

}// _ListviewPageState