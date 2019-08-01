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
- 7.7 TheMovieDB - ApiKey y documentación
    - [https://www.themoviedb.org/ (crear apikey )](https://www.themoviedb.org/)
        - Hasta 10000 peticiones gratuitas
    - [https://www.themoviedb.org/u/eduardoaf](https://www.themoviedb.org/u/eduardoaf)
    - [https://www.themoviedb.org/settings/api](https://www.themoviedb.org/settings/api)
    - [https://developers.themoviedb.org/3/movies/get-movie-details](https://developers.themoviedb.org/3/movies/get-movie-details)
    - [https://image.tmdb.org/t/p/w500/](https://image.tmdb.org/t/p/w500/)
- 7.8 Modelo de Película
    - Extension Paste Json as code
    - Modelo: pelicula_model.dart
    - El modelo cuenta con dos clases, una el modelo y otra el repositorio de modelos
- 7.9 Películas provider
    - peliculas_provider.dart
    - Paquete http 0.12.0+2 instalación (http: ^0.12.0+2)
    - El provider hace una peticion asincrona en forma de Future
    - El provider usa el repositiorio Peliculas para transformar el await json en un array de objetos pelicula
- 7.10 Mostrar póster de películas en el Swiper   
    - Configurar asset
    ```dart
    assets:
        - assets/img/    
    ```
    ```dart
    //home_page.dart
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

    //card_swiper_widget.dart
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
    ```
- 7.11 Obtener películas populares
    ```dart
    // peliculas_provider.dart
    Future<List<Pelicula>> getPopulares() async {
        print("provider.getPopulares");
        final url = Uri.https(_url,"3/movie/popular",{
        "api_key": _apikey, "language":_language
        });

        //espera la solitud
        final respuesta = await http.get(url);
        final decodedData = json.decode(respuesta.body);

        //carga en peliculas.items los resultados en forma de objetos pelicula
        final peliculas = new Peliculas.fromJsonList(decodedData["results"]);
        print(peliculas.items);
        return peliculas.items;
    }// getPopulares

    //@file: home_page.dart
    Widget _footer(BuildContext context){
        return Container(
            width: double.infinity,
            child: Column(
                children: <Widget>[
                Text("Populares",style: Theme.of(context).textTheme.subhead),
                FutureBuilder(
                    future: peliculasProvider.getPopulares(),
                    builder: (BuildContext context,AsyncSnapshot<List> snapshot){
                        snapshot.data.forEach((p) => print(p.title));
                        return Container();
                    }//builder
                ),
                ],
            ),
        );
    }// _footer
    ```


