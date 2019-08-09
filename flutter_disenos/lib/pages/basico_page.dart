//file: basico_page.dart
import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight:FontWeight.bold);
  final estiloSubtitulo = TextStyle(fontSize: 18.0, color: Colors.grey );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //filas
        children: <Widget>[
          //imagen landsacpe
          Image(image: NetworkImage("https://www.xtravelperu.com/wp-content/uploads/2016/12/machupicchu-santa-teresa.jpg"),),
          
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Row(
              //columnas
              children: <Widget>[
                //expanded: dice que ocupe todo el espacio posible sin solaparse con Icon.star y Text:41
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, //alineado a la izq 
                    //filas
                    children: <Widget>[
                      Text("Lago con un puente",style:estiloTitulo),
                      SizedBox(height: 6.0,),
                      Text("Un lago que en Alemania",style: estiloSubtitulo,),
                    ],
                  ),
                ),

                Icon(Icons.star, color:Colors.red, size:30.0),
                Text("41", style: TextStyle(fontSize: 20.0),)

              ],
            ),
          ),


        ]
      ),
    );
  }// build

}// class BasicoPage