import 'package:flutter/material.dart';

class ListviewPage extends StatefulWidget {
  @override
  _ListviewPageState createState() => _ListviewPageState();
}// ListviewPage

class _ListviewPageState extends State<ListviewPage> {
  
  List<int> _listaNumeros = [10,20,30,40,50,60];

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

}// _ListviewPageState