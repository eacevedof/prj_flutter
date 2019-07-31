//@file card_swiper_widget
import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Pelicula> peliculas; 

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,          
        itemBuilder: (BuildContext context, int index){
          //crea un rectangulo redondeado
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            //child: Image.network("http://via.placeholder.com/350x150",fit: BoxFit.cover),
            child: FadeInImage(
              //como alcanza la variable interna posterPath?
              image: NetworkImage(peliculas[index].getPosterImg()),
              placeholder: AssetImage("assets/img/no-image.jpg"),
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: peliculas.length,
        //pagination: new SwiperPagination(), //los ... puntos
        //control: new SwiperControl(),// pestañas de navegacion
      ),

    );

  }// build

}// CardSwiper