import 'package:flutter/material.dart';
import 'package:flutter_qrreader/src/providers/db_provider.dart';

class MapasPage extends StatelessWidget {

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
    
  }//build 

}//class MapasPage