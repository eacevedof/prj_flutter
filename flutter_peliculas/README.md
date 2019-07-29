# CAP 7 - flutter_peliculas
### [Código fuente original]()

- 7.4 Inicio del proyecto - Películas
    ```dart
    //safearea salva el nodge (el hueco en la pantalla, pestaña negra)
    body: SafeArea(
        child: Text("Hola Mundo!!!"),
    )    
    ```
- 7.5 Crear un swiper de tarjetas
    - https://pub.dartlang.org/packages/flutter_swiper
    - flutter_swiper: ^1.1.6
    - import 'package:flutter_swiper/flutter_swiper.dart';
    ```dart
    home_page.dart
    children: <Widget>[
        _swiperTarjetas()
    ], 
    ... 
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
    ```
- 7.6 Widget personalizado - CardSwiper
    - desacoplando el widget Swiper en una clase separada
    - creacion carpeta widgets
    - archivo: card_swiper_widget.dart
    ```dart
    child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,          
        itemBuilder: (BuildContext context, int index){
        return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network("http://via.placeholder.com/350x150",fit: BoxFit.cover),
        );
        },
        itemCount: peliculas.length,
        pagination: new SwiperPagination(), //los ... puntos
        control: new SwiperControl(),// pestañas de navegacion
    ),   
    ```    
