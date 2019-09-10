//push_notifications_provider.dart
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider{

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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
      },//onMessage

      //en background
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
        //final noti = info["data"]["comida"];
        //print(noti);        
      }//onResume

    );//_firebaseMessaging.configure

  }//initNotifications

}//class PushNotificationsProvider