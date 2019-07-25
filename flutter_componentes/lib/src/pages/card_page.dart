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
          _cardTipo1(),
          SizedBox(height: 30.0,),
          _cardTipo2()
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

  Widget _cardTipo2() {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage("https://static.photocdn.pt/images/articles/2017_1/iStock-545347988.jpg"),
            placeholder: AssetImage("assets/jar-loading.gif"),
            fadeInDuration: Duration( milliseconds: 200),
            height: 250.0,
            fit: BoxFit.cover,
          ),

          //Image(
            //image: NetworkImage("https://static.photocdn.pt/images/articles/2017_1/iStock-545347988.jpg"),
          //),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text("No tengo idea de que poner")
          )
        ], // <Widget> []
      )
    ); // Card
  }// _cardTipo2

}// CardPage