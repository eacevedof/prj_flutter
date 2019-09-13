//push_notifications_provider.dart
import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider{

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  //listener, siempre es bueno usar broadcast
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get get_mensajes_stream => _mensajesStreamController.stream;

  initNotifications(){
    //FirebaseMessaging.initializeApp(this);
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token){
      print("FCM TOKEN");
      print(token);
    });

    //tratando los estados para la recepcion de la notificacion
    _firebaseMessaging.configure(

      //cuando la app está abierta
      onMessage: (info){
        print("======= On Message =============");
        print(info);
        //la info entre android e ios puede ser diferente cuando llega en push 
        String argumento = 'no-data';
        if(Platform.isAndroid ){
          argumento = info["data"]["comida"] ?? "no-data";      
        }
        //ios
        else{
          argumento = info["data"]["comida"] ?? "no-data-ios";
        }   
        //se agrega al stream
        _mensajesStreamController.sink.add(argumento);
        //_mensajesStreamController.sink.add(event);
      },//onMessage

      //terminada, cerrada
      onLaunch: (info){
        print("======= On Launch =============");
        print(info);

        final noti = info["data"]["comida"];
        print(noti);
      },//onLaunch

      //al hacer click en el "botón" push y con la app en segundo plano entra aqui
      onResume: (info){
        print("======= On Resume =============");
        print(info);

        String argumento = 'no-data';
        if(Platform.isAndroid ){
          argumento = info["data"]["comida"] ?? "no-data";
        }  
        //ios
        else{
          argumento = info["data"]["comida"] ?? "no-data-ios";
        }
        //se agrega al stream, y esto desencadena en main.dart que se navegue a mensaje_page.dart
        _mensajesStreamController.sink.add(argumento);            
        //print(noti);        
      }//onResume

    );//_firebaseMessaging.configure
  }//initNotifications

  dispose(){
    _mensajesStreamController?.close();
  }//dispose

}//class PushNotificationsProvider