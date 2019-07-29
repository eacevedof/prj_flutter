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