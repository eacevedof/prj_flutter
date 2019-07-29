
import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/widgets/card_swiper_widget.dart';


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
    //return Container();
    return CardSwiper(
      peliculas: [1,2,3,4,5],
    );
  }// _swiperTarjetas

}// HomePage