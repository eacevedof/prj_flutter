# CAP 7 - flutter_peliculas
### [Código fuente original](https://github.com/jalfonsosuarez/peliculas)

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
- 7.12 Nota posible problema en la siguiente clase
<h4><strong>Nota (opcional):</strong></h4><p>En la siguiente clase, no probé la vista en todos los dispositivos, y unos que tienen pantalla muy pequeña se apreciará este error:</p><figure><img src="https://udemy-images.s3.amazonaws.com:443/redactor/raw/2019-05-24_03-14-51-6086d05ce4757c8429d47282a8561cae.png"></figure><p>Lo que significa que hay más contenido de puede desplegar la pantalla.. entonces hay varias formas de resolver esto, una de ellas es hacer las tarjetas más pequeñas y darles proporciones más acertadas, o bien hacer las tarjetas principales más pequeñas también, para que tengamos suficiente espacio...</p>
<p><strong>Solución en video:</strong></p>
<p>Esto lo corregí en este video, pueden verlo y luego regresar a la clase.</p>
<p><a href="https://www.udemy.com/flutter-ios-android-fernando-herrera/learn/lecture/14708408#overview" rel="noopener noreferrer" target="_blank">https://www.udemy.com/flutter-ios-android-fernando-herrera/learn/lecture/14708408#overview</a></p>
<p>Disculpen el inconveniente.</p>

- 7.13 Widget personalizado - Horizontal PageView
    - crea pie slider con fotos de peliculas populares
    ```dart
    //movie_horizontal.dart
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
        return peliculas.map((pelicula) {
        return Container(
            margin: EdgeInsets.only(right:1.8),
            child: Column(
            children: <Widget>[
                ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                    image: NetworkImage(pelicula.getPosterImg()),
                    placeholder: AssetImage("assets/img/no-image.jpg"),
                    fit: BoxFit.cover,
                    height: 100.0,//si pongo más se sale de la pantalla

                ),
                ),
                SizedBox(height: 5.0,),
                Text(
                pelicula.title, 
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
                ),
            ],
            ),
        );
        }).toList();//peliculas.map.tolist
    }// _tarjetas    

    //home_page.dart
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
    ```
- 7.14 Problema con los futures
    - Introducción a **Stream**
    - Cuando se llega al final del PageView se debería cargar la siguiente página con los populares
    - En **movie_horizontal.dart** podríamos hacer la llamada a la siguiente página usando el listado peliculas, pero es un stateless widget.
    - Si se transforma en un StatefulWidget se perdería la posibilidad de que sea un estandar reutilizable.
    - La intención es que movie_horizontal solo se encargue de pintar los datos recibidos.
    - La solución pasa por hacer la petición en el **home_page.dart**
    - Existe un Widget especializado para eso. Se llama **Stream**
- 7.15 Introducción a los Streams
    - Stream, flujo de información en un solo sentido.
    - En **react** se llaman **observables**
    - **StreamTransformer** aplica cambios al stream
    - **StreamController** gestiona las transformaciones del stream
        - **Sink** objeto dentro de SController, añade información al stream
        - **Stream** obtener el stram final
    - En lo que nos corresponde. Tendremos una entrada de nuevas peliculas y la salida sera la lista completa de las películas.
- 7.16 Introducción al patrón Bloc y al manejo de estado de la aplicación
    - Bloc: business logic component
    - Permite la comunicación entre distintos widget del arbol de widget sin tener que hacer una propagación por todos los nodos del camino.
    - Es importante cerrar el stream
    - En el proceso de comunicación de dos widgets:
        - A emite un sink a Bloc
        - Bloc hace el tratamiento correspondiente con el stream, ya sea utilizando un provider o un http, data, API call
        - Finalmente devuelve un resultado (con steram) al widget B
    - Dos streamscontroller:
        - SingleSubscription
            - Por defecto
            - Si hay un stream y el streamcontroller esta escuchando tendra la exclusividad y hasta que no deje de escuchar ningun otro controller podra hacerlo.

        - Broadcast
            - 
    - Métodos sink y stream
        ```dart
        class MiBloc {
            StreamController<String> _oStreamCtrl = new StreamController<String>();
            //Qué clase de información entrará al sink
            Sink<String> get inputSink => _oStreamCtrl.sink;
            //Que clase de info saldrá?
            Stream<String> get outputStream => _oStreamCtrl.stream;

            //cerrar el stream
            void dispose(){
                //?: si existe lo cierra sino no hace nada
                _oStreamCtrl?.close();
            }
        }
        ```
    - El StreamBuilder renderizará un widget cada vez que recibe información de un Stream
    - El **sb** en su propiedad builder (es una func anonima) recibe dos parámetros:
        - context: Información del arbol de widgets y más...
        - snapshot: Información referente al estado del Stream y la información que sale del Stream
            - estado del stream: cargando, error, etc.
    - Se implementará parcialmente el patrón **Bloc**
- 7.17 Creando un Stream de películas
    ```dart
    //peliculas_provider.dart
    int _popularesPage = 0;
    List<Pelicula> _populares = new List();

    //si no llevara broadcast solo podria escuchar uno solo el stream
    final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();
    //agrega al stream el listado de peliculas
    Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
    Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

    //cada vez que se entra a la pantalla se abriria un stream por eso hay que cerrarlo
    void disposeStreams(){
        _popularesStreamController?.close();
    }

    Future<List<Pelicula>> getPopulares() async {
        print("provider.getPopulares");
        _popularesPage++;
        final url = Uri.https(_url,"3/movie/popular",{
            "api_key": _apikey, "language":_language, "page": _popularesPage.toString(),
        });

        final resp = await _procesarRespuesta(url);
        //agrego todas las peliculas en mi lista populares
        _populares.addAll(resp);
        //se coloca en el inicio del stream de datos para que puedan ser escuchados
        popularesSink(_populares);
        //devuelvo la lista de peliculas
        return resp;
    }// getPopulares    
    ```
- 7.18 Streambuilder
    - con estas modificaciones el footer ya pagina!
    ```dart
    //movie_horizontal.dart
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
        height: _screenSize.height * 0.2,
        //slider del footer
        child: PageView(
            pageSnapping: false,
            controller: _pageController,
            children: _tarjetas(context),
        ),
        
        );
    }// build    

    //home_page.dart
    @override
    Widget build(BuildContext context) {
        //añade datos al stream con popularesSink(_populares);->_popularesStreamController.sink.add
        oProvPeliculas.getPopulares();
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
                    
                    //cambiamos de future a stream. Ahora estamos a la escucha del stream
                    StreamBuilder(
                        //el stream que se va a escuchar
                        stream: oProvPeliculas.popularesStream, //_popularesStreamController.stream;
                        builder: (BuildContext context,AsyncSnapshot<List> snapshot){
                            if(snapshot.hasData)
                                return MovieHorizontal(
                                    peliculas:snapshot.data,
                                    //pasar una funcion como argumento. getPopulares incrementa _popularesPage++; y hace la 
                                    //llamada asincrona e inscribe el resultado en el stream
                                    siguientePagina: oProvPeliculas.getPopulares,
                                );
                            return CircularProgressIndicator();
                        }//builder
                    ),
                ],// children
            ),// column
        );// contaier
    }// _footer    
    ```
- 7.19 Optimizaciones para nuestra aplicación
    - Se piden más datos de los necesarios
    - En ningún momento se le dice que espere a que llegue al final del scroll para que haga la siguiente carga
    - Esto se soluciona con un booleano 
    - PageView y PageView.builder
    - pv.builder es más optimo ya que carga bajo demanda
    ```dart
    //peliculas_provider.dart
    Future<List<Pelicula>> getPopulares() async {
        print("provider.getPopulares");

        if( _cargando ) 
        {
            print("get_populares is cargando me salgo");
            return [];
        }
        _cargando = true;

        _popularesPage++;
        print("Cargando siguientes...");

        final url = Uri.https(_url,"3/movie/popular",{
            "api_key": _apikey, "language":_language, "page": _popularesPage.toString(),
        });

        final resp = await _procesarRespuesta(url);
        //agrego todas las peliculas en mi lista populares
        _populares.addAll(resp);
        //se coloca en el inicio del stream de datos para que puedan ser escuchados
        popularesSink(_populares);
        _cargando = false;
        //devuelvo la lista de peliculas
        return resp;
    }// getPopulares

    //movie_horizontal.dart
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
            height: _screenSize.height * 0.2,
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
    ```    
- 7.20 Pasar argumentos de una página a otra usando el PushNamed
    - detectar click o tap en tarjeta
    - GestureDetector: Aplica eventos a un widget
    - La página que envía se apoya en el enrutador:
    ```dart
    //main.dart
    routes: {
        "/" : (BuildContext context) => HomePage(),
        "detalle" : (BuildContext context) => PeliculaDetalle(),
    },

    //movie_horizontal.dart
    Navigator.pushNamed(context, "detalle", arguments: oModelPelicula);

    //pelicula_detalle_page.dart
    //La página que recibe recupera la variable con:
    final Pelicula oModelPelicula = ModalRoute.of(context).settings.arguments;
    ```
- 7.21 Diseño de la pantalla de detalle
    - Pasan dos cosas.
    - El widget SliverAppBar se pinta pero no se comporta como tal
    - Puede que tenga que ver la versión del Android 
    - El método: getBackgroundImg genera una excepción
    ```dart
    //pelicula_detalle_page.dart
    Widget build(BuildContext context) {
        final Pelicula oModelPelicula = ModalRoute.of(context).settings.arguments;

        return Scaffold(
            body: CustomScrollView( //es como una lista 
                //los slivers son widgets que escuchan los eventos del scroll
                slivers: <Widget>[  //sería como los children
                    _createAppbar(oModelPelicula),
                ],
            ),
        );
    }// build

    Widget _createAppbar(Pelicula oPelicula){
        return SliverAppBar(
            elevation: 2.0,
            backgroundColor: Colors.indigoAccent,
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
                oPelicula.title,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            background: FadeInImage(
                //con este me da error de carga la primera vez
                //image: NetworkImage(oPelicula.getBackgroundImg()),
                image: NetworkImage(oPelicula.getPosterImg()),
                placeholder: AssetImage("assets/img/loading.gif"),
                //fadeInDuration: Duration(microseconds: 150),
                fit: BoxFit.cover,
            ),
            ),      
        );
    }// _createAppbar
    ```
- 7.22 Diseño de la pantalla de detalle - Parte 2
    - Con mucho texto ya funciona el sliver
    ```dart
    //pelicula_detalle_page.dart
    SliverList(
    delegate: SliverChildListDelegate(
            [
            SizedBox(height:10.0),
            _posterTitulo(context,oModelPelicula),
            _descripcion(oModelPelicula),
            _descripcion(oModelPelicula),
            _descripcion(oModelPelicula),
            ]
        )
    ),    
    ...
    //crea tarjeta con imagen miniatura y el titulo con estrellas
    Widget _posterTitulo(BuildContext context,Pelicula oPelicula){
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
                children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                    image: NetworkImage(oPelicula.getPosterImg()),
                    height: 150.0,
                    ),
                ),
                SizedBox(width: 20.0,),
                Flexible(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Text(oPelicula.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis,),
                        Text(oPelicula.originalTitle,style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis,),
                        Row(children: <Widget>[
                        Icon(Icons.star_border),
                        Text(oPelicula.voteAverage.toString(),style: Theme.of(context).textTheme.subhead,)
                        ],)
                    ],
                    ),
                )
            ],)
        );
    }// _posterTitulo

    
    Widget _descripcion(Pelicula oPelicula){
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Text(oPelicula.overview,textAlign: TextAlign.justify,),
        );
    }    
    ```
- 7.23 Modelo para manejar los actores de la película
    - crear modelo actores_model.dart
    - seleccionamos el json y en el nuevo fichero ejecutamos el comando 
    - de vscode: paste json as code
    - se crea loader de Actor
    - se crea clase de apoyo para listado de actores `class Cast`


    

