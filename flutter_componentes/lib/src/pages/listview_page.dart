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

  @override
  void initState() {
    super.initState();
    _agregar10();
    //se disparará cada vez que se haga el scroll
    _oScrollController.addListener((){
      //si la pos actual es de x pixeles y lo máximo permitido por el scroll es x se agregan 10
      if(_oScrollController.position.pixels == _oScrollController.position.maxScrollExtent){
        _agregar10();
      }
    });
  }// initState

  @override
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
      controller: _oScrollController,
      itemCount: _listaNumeros.length,
      //no se porque se define como una función anónima
      itemBuilder: (BuildContext context,int index){
        final imagen = _listaNumeros[index];
        return FadeInImage(
          image: NetworkImage("https://picsum.photos/500/300/?image=${imagen}"),
          placeholder: AssetImage("assets/jar-loading.gif"),
        );
      },
    );
  }// _crearLista

  void _agregar10(){
    for(var i=0; i<10; i++){
      _ultimoItem++;
      _listaNumeros.add(_ultimoItem);
    }
    //refresca el componente
    setState(() {
    });
  }// _agregar10
}// _ListviewPageState