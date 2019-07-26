//@file: avatar_page.dart

import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avatar Page"),
        actions: <Widget>[
          //icono de imágen de stanlee
          Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://americanlibrariesmagazine.org/wp-content/uploads/2015/01/StanLee.png"),
              radius: 20.0,
            ),
          ),

          //icono con SL arriba a la derecha
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text("SL"),
              backgroundColor: Colors.brown,
            ),
          ),
        ],
      ),

      body:Center(
        //Carga imágen grande de stanlee
        child: FadeInImage(
          image: NetworkImage("https://americanlibrariesmagazine.org/wp-content/uploads/2015/01/StanLee.png"),
          placeholder: AssetImage("assets/jar-loading.gif"),
          fadeInDuration: Duration(milliseconds: 200),
        ),
      )
    ); //Scaffold
  } // build
} // AvatarPage