//@file: home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/providers/peliculas_provider.dart';
import 'package:flutter_peliculas/src/widgets/card_swiper_widget.dart';
import 'package:flutter_peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  
  //El provider usa internamente el modelo para generar un
  //listado de modelos a partir del json que le llega
  final oProvPeliculas = new PeliculasProvider();

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
            //realiza la llamada al endpoint usando un Fut builder. 
            //devuelve un widget que se ha formado en el fut builder
            _swiperTarjetas(),
            //devuelve un widget container con otros widgets dentro 
            //usa context para cambiar el estilo de la palabra Populares
            _footer(context)
          ],
        )
      )

    );

  }// build

  Widget _swiperTarjetas() {

    return FutureBuilder(
      //llamada asincrona a: 3/movie/now_playing
      //devuelve un Future<List<pelicula>>
      future: oProvPeliculas.getEnCines(),

      //supongo que el builder se está ejecutando constantemente mientras no se
      //ha resuelto el "future list"
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
            //llamada asincrona a: 3/movie/popular
            future: oProvPeliculas.getPopulares(),
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