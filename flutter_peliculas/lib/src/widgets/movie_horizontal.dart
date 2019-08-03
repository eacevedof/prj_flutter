import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Pelicula> peliculas;

  MovieHorizontal({ @required this.peliculas });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3, //cuantas se ven en pantalla
        ),
        children: _tarjetas(context),
      ),
      
    );
  }// build

  List<Widget> _tarjetas(BuildContext context){
    return peliculas.map((oModelPelicula) {
      return Container(
        margin: EdgeInsets.only(right:1.8),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                //modelpelicula devuelve una url
                image: NetworkImage(oModelPelicula.getPosterImg()),
                placeholder: AssetImage("assets/img/no-image.jpg"),
                fit: BoxFit.cover,
                height: 100.0,//si pongo más se sale de la pantalla
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              oModelPelicula.title, 
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();//peliculas.map.tolist
  }// _tarjetas

}// MovieHorizontal