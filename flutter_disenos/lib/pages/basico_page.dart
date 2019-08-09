//file: basico_page.dart
import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight:FontWeight.bold);
  final estiloSubtitulo = TextStyle(fontSize: 18.0, color: Colors.grey );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //imagen landsacpe
            _get_image_widget(),

            _get_titulo_widget(),

            _get_acciones_widget(),

            _get_lorem_ipsum(),
            _get_lorem_ipsum(),
            _get_lorem_ipsum(),
            _get_lorem_ipsum(),

          ]
        ),
      ),
    );
  }// build

  Widget _get_image_widget(){
    return Image(
      width: double.infinity,
      image: NetworkImage("https://www.xtravelperu.com/wp-content/uploads/2016/12/machupicchu-santa-teresa.jpg"),
      height: 180.0,
      fit: BoxFit.cover  
    );

  }// _get_image_widget

  Widget _get_titulo_widget(){
    return SafeArea(
        child: Container(
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
          ),//Row
        ),
      ); //Container
  }// get_titulo_widget

  Widget _get_acciones_widget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _get_action_widget(Icons.call, "CALL"),
        _get_action_widget(Icons.near_me, "ROUTE"),
        _get_action_widget(Icons.share, "Share"),
      ],
    );
  }// _get_acciones_widget

  Widget _get_action_widget(IconData icon, String texto){
    return Column(
      children: <Widget>[
        Icon(icon, color:Colors.blue, size:40.0),
        SizedBox(height: 5.0,),
        Text(texto, style: TextStyle(fontSize: 15.0, color: Colors.blue))
      ],
    );
  }

  Widget _get_lorem_ipsum(){
    //al Text no le puedo aplicar un padding
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Text(
          "Sunt sint nulla aliquip in aliqua voluptate excepteur velit velit non fugiat. Veniam amet laboris ea nostrud adipisicing eiusmod deserunt culpa. Eiusmod labore aliquip consectetur reprehenderit commodo ipsum tempor sunt irure fugiat aliquip amet. Quis enim ea elit reprehenderit aute qui fugiat ea id. Qui ad deserunt culpa nostrud nisi dolor nostrud. Exercitation et laboris tempor pariatur nostrud ipsum officia magna in sunt duis. Sit nulla officia anim eiusmod pariatur aliquip dolore tempor deserunt ullamco.",
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

}// class BasicoPage