import 'package:flutter/material.dart';
import 'package:push_local/src/pages/home_page.dart';
import 'package:push_local/src/pages/mensaje_page.dart';
import 'package:push_local/src/providers/push_notifications_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> oGlobalNavkey = new GlobalKey<NavigatorState>();

  @override
  void initState(){
    print("========= _MyappState.initState() ============");
    super.initState();

    final pushProvider = new PushNotificationsProvider();
    pushProvider.initNotifications();
    pushProvider.get_mensajes_stream.listen( (strdata){
      //aqui no se puede llamar a pushNamed porque no tengo el objeto Navigator creado
      //tengo que relacionar el build.materialapp y el pusprovider.argumento
      //Navigator.pushNamed(context,"mensaje");
      print("Argumento del push:");
      print(strdata);

      oGlobalNavkey.currentState.pushNamed("mensaje",arguments:strdata);
    });

  }//initState

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //esta variable me permitirá controlar el estado de MaterialApp a lo largo de toda esta clase
      navigatorKey: oGlobalNavkey,
      title: "Push Local",
      initialRoute: "home",
      routes: {
        "home"      :(BuildContext context) => HomePage(),
        "mensaje"   :(BuildContext context) => MensajePage(),
      },
    );
  }

}//class _MyAppState 

