import 'package:flutter/material.dart';
import 'package:flutter_qrreader/src/bloc/scans_bloc.dart';
import 'package:flutter_qrreader/src/providers/db_provider.dart';
import 'package:flutter_qrreader/src/utils/utils.dart' as u;

class MapasPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    //ya no necesito un futurebuilder sino un streambuilder
    //return FutureBuilder<List<ScanModel>>(
    return StreamBuilder<List<ScanModel>>(
      //no debemos usar el dbprovider ya que ahora se gestiona por el stream
      //future: DbProvider.oDb.getScanAll(),
      stream: scansBloc.scansStream,
      
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
              //DbProvider.oDb.deleteScan(scans[i].id), con stream ya no se usa
              scansBloc.borrarScan(scans[i].id),
            //esto es el item en forma de "row" o mejor dicho, "tarjeta row"
            child: ListTile(
              leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor),
              title: Text(scans[i].valor),
              subtitle: Text("ID: ${scans[i].id}"),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: (){
                u.abrir_scan(context, scans[i]);
              },
            ),
          ),
        );
      },
    );
    
  }//build 

}//class MapasPage