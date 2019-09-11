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

  @override
  void initState(){
    print("========= _MyappState.initState() ============");
    super.initState();

    final pushProvider = new PushNotificationsProvider();
    pushProvider.initNotifications();
    pushProvider.get_mensajes_stream.listen( (argumento){
       //Navigator.pushNamed(context,"mensaje");
       print("Argumento del push:");
       print(argumento);
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Push Local",
      initialRoute: "home",
      routes: {
        "home"      :(BuildContext context) => HomePage(),
        "mensaje"   :(BuildContext context) => MensajePage(),
      },
    );
  }

}//class _MyAppState 

