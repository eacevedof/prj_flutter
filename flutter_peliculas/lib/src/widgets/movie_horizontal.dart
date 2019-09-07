import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Pelicula> peliculas;
  final Function siguientePagina; //funcion callback 

  //este constructor se llama desde home_page.dart -> _footer
  MovieHorizontal({ @required this.peliculas, @required  this.siguientePagina});

  final _pageController = new PageController(          
          initialPage: 1,
          viewportFraction: 0.3 //items por pantalla
        );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    //listener para detectar fin de pagina
    _pageController.addListener((){
      //detectar fin de página horizontal
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        //siguientePagina será el método: oProvPeliculas.getPopulares que recarga los datos de la sig
        //pagina en el stream
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      //slider del footer. El pageview va a renderizar todos los items que se hayan cargado al mismo tiempo
      //Pageview.builder los va creando bajo demanda
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        //children: _tarjetas(context), //no va para pv.builder
        itemBuilder: (context, i) => _tarjeta(context, peliculas[i]),
      ),
      
    );
  }// build

  Widget _tarjeta(BuildContext context, Pelicula oModelPelicula){

    oModelPelicula.uniqueId = '${oModelPelicula.id}-poster';
    final tarjeta = Container(
        margin: EdgeInsets.only(right:1.8),
        child: Column(
          children: <Widget>[
            Hero(
              //tag: oModelPelicula.id,//id único que debe identificar la tarjeta
              tag: oModelPelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  //modelpelicula devuelve una url
                  image: NetworkImage(oModelPelicula.getPosterImg()),
                  placeholder: AssetImage("assets/img/no-image.jpg"),
                  fit: BoxFit.cover,
                  height: 100.0,//si pongo más se sale de la pantalla
                ),
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
      return GestureDetector(
        child: tarjeta,
        onTap: (){
          print("ID de la pelicula ${oModelPelicula.title} es ${oModelPelicula.id}");
          //necesitamos decirle al pushnamed que reciba como argumento una variable.
          //se usa arguments
          Navigator.pushNamed(context, "detalle", arguments: oModelPelicula);
        },
      );
  }// _tarjeta

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