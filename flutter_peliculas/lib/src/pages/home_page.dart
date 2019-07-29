
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {

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
            _swiperTarjetas()
          ],
        )
      )

    );

  }// build

  Widget _swiperTarjetas() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: 300.0,
      
      child: Swiper(
              layout: SwiperLayout.STACK,
              itemBuilder: (BuildContext context,int index){
                return new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
              },
              itemCount: 5,
              itemWidth: 200.0,
              pagination: new SwiperPagination(), //los ... puntos
              control: new SwiperControl(),// pestañas de navegacion
            ),
    );
  }// _swiperTarjetas

}// HomePage