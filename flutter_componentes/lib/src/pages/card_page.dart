//@file: card_page.dart
import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards"),
      ),

      body: ListView(
        padding: EdgeInsets.all(10.0), //..symetric(horizontal:50.0),
        children: <Widget>[
          _cardTipo1()
        ],
      ),
    );
  }// build

  Widget _cardTipo1() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_album, color: Colors.blue),
            title: Text("Soy el titulo de esta tarjeta"),
            subtitle: Text("Aqui estamos con la descripción de la tarjeta que quiero que ustedes vean para tener una idea de lo que quiero"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: (){},
              ),
              FlatButton(
                child: Text("Ok"),
                onPressed: (){},
              ),              
            ],
          )
        ],
      ),
    );
  }// _cardTipo1

}// CardPage