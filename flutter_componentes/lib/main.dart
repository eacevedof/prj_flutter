//@file: main.dart
import 'package:flutter/material.dart';
import 'package:flutter_componentes/src/pages/alert_page.dart';
import 'package:flutter_componentes/src/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Componentes App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],

      supportedLocales: [
        const Locale("en","US"),
        const Locale("es","ES"),
      ],

      initialRoute: "/",

      routes: getApplicationRoutes(),

      onGenerateRoute: ( RouteSettings settings) {
        print("Ruta llamada: ${ settings.name }");
        //página por defecto para rutas
        return MaterialPageRoute(
          builder: ( BuildContext context ) => AlertPage()
        );
      },

    ); // MaterialApp
  }// build
}// MyApp