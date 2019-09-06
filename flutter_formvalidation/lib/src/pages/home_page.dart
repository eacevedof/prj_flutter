//file:home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_formvalidation/src/bloc/provider.dart';
import 'package:flutter_formvalidation/src/models/producto_model.dart';
import 'package:flutter_formvalidation/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final prodBloc = Provider.get_prod_bloc(context);
    prodBloc.cargar_productos_async();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),

      body: _get_listado_wg(prodBloc),
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

  Widget _get_item_wg(BuildContext context,ProductosBloc oProdBloc, ProductoModel oProd){
    //dismissible permite el borrado
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),

      //cuando se ejecuta el dismissible (desaparece de pantalla) lanza este evento
      // onDismissed: (direccion){
      //   oProdBloc.borrar_producto_async(oProd.id);
      // },
      onDismissed: (direccion) => oProdBloc.borrar_producto_async(oProd.id),

      child: Card(
        child: Column(
          children: <Widget>[
            (oProd.fotoUrl == null) 
            ? Image(image: AssetImage("assets/no-image.png"))
            : FadeInImage(
                image: NetworkImage(oProd.fotoUrl),
                placeholder: AssetImage("assets/jar-loading.gif"),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover
            ),
            
            ListTile(
              title: Text("${oProd.titulo} - ${oProd.valor}"),
              subtitle: Text(oProd.id),
              onTap: () => Navigator.pushNamed(context,"producto", arguments:oProd),
            ),    
          ],
        ),
      ),
    );

  }//_get_item_wg

  Widget _get_listado_wg(ProductosBloc oProdBloc){
    return StreamBuilder(
      stream: oProdBloc.get_productos_stream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if(snapshot.hasData){
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _get_item_wg(context, oProdBloc, productos[i]),
          );
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