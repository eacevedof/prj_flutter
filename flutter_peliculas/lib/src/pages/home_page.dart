//@file: home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/providers/peliculas_provider.dart';
import 'package:flutter_peliculas/src/widgets/card_swiper_widget.dart';
import 'package:flutter_peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Películas en cines"),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), //icono lupa
            onPressed: () {

            },
          )
        ],
      ),
      //safearea salva el nodge (el hueco en la pantalla, pestaña negra)
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        )
      )

    );

  }// build

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            peliculas: snapshot.data
          );
        }
        //entra aqui cuando el future se está resolviendo o no se tiene información
        else
        {
          //devuelve un loading
          return  Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      },
    );

  }// _swiperTarjetas

  Widget _footer(BuildContext context){

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left:20.0),
            child: Text("Populares",style: Theme.of(context).textTheme.subhead)),
          SizedBox(height: 5.0,),
          FutureBuilder(
            future: peliculasProvider.getPopulares(),
            builder: (BuildContext context,AsyncSnapshot<List> snapshot){
              if(snapshot.hasData)
                return MovieHorizontal(peliculas:snapshot.data);
              return CircularProgressIndicator();
            }//builder
          ),
        ],
      ),
    );

  }// _footer

}// HomePage