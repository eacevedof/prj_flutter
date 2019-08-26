//file:home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_formvalidation/src/bloc/provider.dart';
import 'package:flutter_formvalidation/src/models/producto_model.dart';
import 'package:flutter_formvalidation/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
  
  final prodProv = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);    

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: _get_listado_wg(),

      floatingActionButton: _get_boton_wg(context),

    );

  }//build

  FloatingActionButton _get_boton_wg(BuildContext context){
    
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, "producto"),
    );

  }//_get_boton_wg

  Widget _get_listado_wg(){
    return FutureBuilder(
      future: prodProv.getasync_list(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if(snapshot.hasData){
          return Container();
        }
        else{
          return Center(
            child:CircularProgressIndicator(),
          );
        }
      },
    );
  }//_get_listado_wg

}//class HomePage